<#
	My Function
#>
function Get-SQLaaSHyperVStatus {
	<#
	.SYNOPSIS

	This Cmdlet will confirm if the server(s) or Cluster has been setup in accordance with the guidlines for HP's SQLaaS Platform

	.DESCRIPTION

	If the Cmdlet is ran without any parameters it will assume that you are only wanting to check the current machine.


	#>
	param(
	[Parameter(Mandatory=$false)][string]$host,
	[Parameter(Mandatory=$false)][switch]$CheckCluster
	)

	#region code for Cluster Hotfixes 
	$Hotfixes = @() 
	$Result = @() 
	$Rlog = @() 
	$patchlist = @()
	$comps = @()
	if ($host -notlike "")
	{
		$comps += get-compdets -computer $host
		if ($comps.FailOverCluster -eq "Installed" -and $CheckCluster)
		{
			$ClusName = (get-cluster).name 
			$Computers = (get-clusternode).name 
			ForEach ($computer in (get-clusternode).name) 
			{ 
				$comps += get-compdets -computer $computer
				# Get the Hotfixes using Get-Hotfix 
				ForEach ($hotfix in (get-hotfix -computer $computer | select HotfixId)) 
				{ 
					# Filter out returned Hotfixes named "File 1" - mainly happens on WS03 
					# Store system names and hotfixes in the $Hotfixes HashTable 
					If ($Hotfix -notlike "*File 1*") 
					{ 
						$h = New-Object System.Object 
						$h | Add-Member -type NoteProperty -name "Server" -value $computer 
						$h | Add-Member -type NoteProperty -name "Hotfix" -value $hotfix.HotfixId 
						$hotfixes += $h 
					} 
				}
				
			} 

			# Goes through the HashTable and ensures there are only Unique Computer Names 
			$ComputerList = $hotfixes | Select-Object -unique Server | Sort-Object Server 
			# Loop Thru all the sorted unique Hotfixes 
			ForEach ($hotfix in $hotfixes | Select-Object -unique Hotfix | Sort-Object Hotfix) 
			{ 
				$h = New-Object System.Object 
				$h | Add-Member -type NoteProperty -name "Hotfix" -value $hotfix.Hotfix 
				# Loop through the Computers to match up the Hotfixes to the Computer 
				ForEach ($computer in $ComputerList) 
				{ 
					# Check to see if Hotfixes are present or missing. If hotfix is present on computer add a "*" to the NodeName 
					# If Computer is missing Hotfix add Hotfix and Computer to additional HashTable $RL, and add a "---" the $h HashTable 
					If ($hotfixes | Select-Object |Where-Object {($computer.server -eq $_.server) -and ($hotfix.Hotfix -eq $_.Hotfix)}) 
					{ 
						$h | Add-Member -type NoteProperty -name $computer.server -value "Installed" 
					} 
					else 
					{ 
						$h | Add-Member -type NoteProperty -name $computer.server -value "Missing" 
						$RL = New-Object System.Object 
						$RL | Add-Member -type NoteProperty -name "Server" -value $computer.server 
						$RL | Add-Member -type NoteProperty -name "Hotfix" -value $hotfix.Hotfix 
						$RLog += $RL 
					} 
				} 
				# Adds the either the "*" or "---" to the server name 
				if (($h | Get-Member -MemberType NoteProperty).Definition -like "*Missing*")
				{
					$result += $h 
				}
			}
			$updates = $Result 
		}
	
	}
	else
	{
	
	}
	
	
	
	$comps | ft *
	$updates | ft *

}
function get-compdets{
param(
	[Parameter(Mandatory=$true)][string]$computer
	)
	$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $computer)
	$c = New-Object System.Object
	$c | Add-Member -MemberType NoteProperty -Name "Server" -Value $Computer
	$c | Add-Member -MemberType NoteProperty -Name "Windows Version" -Value ((gwmi win32_operatingsystem -ComputerName $computer).version)
	$ram =((gwmi Win32_MemoryArray -ComputerName $computer).endingaddress)
	$c | Add-Member -MemberType NoteProperty -Name "RAM" -Value ([string]::format("{0:N0} Gb", ($ram[($ram.Count -1)] / 1024 / 1024)))
	$cpu = gwmi win32_processor -ComputerName $computer
	$c | Add-Member -MemberType NoteProperty -Name "CPUCount" -Value $cpu.count
	if ($cpu.count -eq 1)
	{
		if($cpu.SocketDesignation -eq "None"){$cputype = "vCPU"}else{$cputype = $cpu.SocketDesignation}
		$c | Add-Member -MemberType NoteProperty -Name "CPU Type" -Value $cputype
		$c | Add-Member -MemberType NoteProperty -Name "CPU ClockSpeed" -Value $cpu.MaxClockSpeed
		$c | Add-Member -MemberType NoteProperty -Name "CPU Socket" -Value $cpu.DeviceID
	}
	else
	{
		$scpu = 1
		foreach ($proc in $CPU)
		{
			if($proc.SocketDesignation -eq "None"){$cputype = "vCPU"}else{$cputype = $proc.SocketDesignation}
			$c | Add-Member -MemberType NoteProperty -Name "CPU$scpu Type" -Value $cputype
			$c | Add-Member -MemberType NoteProperty -Name "CPU$scpu ClockSpeed" -Value $proc.MaxClockSpeed
			$c | Add-Member -MemberType NoteProperty -Name "CPU$scpu Socket" -Value $proc.DeviceID
			$scpu += 1
		}
	}
	$c | Add-Member -MemberType NoteProperty -Name "Domain" -Value ((gwmi win32_computersystem -ComputerName $computer).domain)
	$c | Add-Member -MemberType NoteProperty -Name "Hyper-V" -Value ((Get-WindowsFeature -Name Hyper-V -ComputerName $computer).installstate)
	$c | Add-Member -MemberType NoteProperty -Name "FailOverCluster" -Value ((Get-WindowsFeature -Name Failover-Clustering -ComputerName $computer).installstate)
	$c | Add-Member -MemberType NoteProperty -Name "TimeServer" -Value ($Reg.OpenSubKey("SYSTEM\\CurrentControlSet\\services\W32Time\\Parameters").GetValue("NtpServer"))
	$mcafeereg = $reg.OpenSubKey("Software\\McAfee\\desktopprotection")
	if ($mcafeereg)
	{
		$c | Add-Member -MemberType NoteProperty -Name "McAfeeInstalled" -Value "True"
		$c | Add-Member -MemberType NoteProperty -Name "McAfeeVersion" -Value ($mcafeereg.getvalue("szProductVer"))
		$c | Add-Member -MemberType NoteProperty -Name "McAfeeEngineVersion" -Value ($reg.OpenSubKey("Software\\McAfee\\AVEngine").getvalue("EngineVersionMajor"))
		$c | Add-Member -MemberType NoteProperty -Name "McAfeeDATVersion" -Value ($reg.OpenSubKey("Software\\McAfee\\AVEngine").getvalue("AVDatVersion"))
	}
	else
	{
		$c | Add-Member -MemberType NoteProperty -Name "McAfeeInstalled" -Value "False"
	}
	if (gwmi -Class "__Namespace" -Namespace root -ComputerName $computer -Filter "name='ccm'")
	{
		$c | Add-Member -MemberType NoteProperty -Name "SCCMInstalled" -Value "True"
		$c | Add-Member -MemberType NoteProperty -Name "SCCMClientVersion" -Value ((gwmi -Namespace root\ccm -Class SMS_Client -ComputerName $computer).ClientVersion)
	}
	else
	{
		$c | Add-Member -MemberType NoteProperty -Name "SCCMInstalled" -Value "False"
	}
	$nics = get-nicdrivers -computer $computer
	$n = 1
	if ($nics.count -eq 1)
	{
		$c | Add-Member -MemberType NoteProperty -Name "NICAdapter" -Value $nics.ProductName
		$c | Add-Member -MemberType NoteProperty -Name "NICManufacturer" -Value $nics.Manufacturer
		$c | Add-Member -MemberType NoteProperty -Name "NICFileVer" -Value $nics.FileVer
		$c | Add-Member -MemberType NoteProperty -Name "NICFile" -Value $nics.file
	}
	else
	{
	foreach($nic in $nics)
	{
		$c | Add-Member -MemberType NoteProperty -Name "NICAdapter$n" -Value $nic.ProductName
		$c | Add-Member -MemberType NoteProperty -Name "NICManufacturer$n" -Value $nic.Manufacturer
		$c | Add-Member -MemberType NoteProperty -Name "NICFileVer$n" -Value $nic.FileVer
		$c | Add-Member -MemberType NoteProperty -Name "NICFile$n" -Value $nic.file
		$n += 1
	}
	}

	$c
}
function get-nicdrivers
{
param(
	[Parameter(Mandatory=$true)][string]$computer
	)
    #Get the network adapters
    $NetworkAdapters = gwmi -computer $computer -query "select * from  win32_networkadapter where PhysicalAdapter = 'True'"
    
    $arrBinary = @()
    $nic = 0
    #Go through each adapter and pull the SystemDriver Info
    foreach ($Adapter in $NetworkAdapters)
    {
        if($Adapter.Name -notlike "*Hyper-V*")
        {    
            if ($nic -eq 0)
            {
                $Binary = New-Object System.Object
                $Reg = Get-ItemProperty -path "HKLM:\System\CurrentControlSet\Services\$($Adapter.servicename)" -ErrorAction SilentlyContinue
                if($reg.ImagePath)
                {
                    $FileVers = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("\\" + $computer + "\c$\Windows" + ($Reg.ImagePath.Replace("\SystemRoot","")))
                    $Binary | add-Member -MemberType NoteProperty -Name file -Value ($FileVers.FileName.Split("\")[-1])
                    $Binary | add-Member -MemberType NoteProperty -Name FileVer -Value $FileVers.fileversion
                    $binary | Add-Member -MemberType NoteProperty -Name Manufacturer -Value $Adapter.Manufacturer
                    $binary | Add-Member -MemberType NoteProperty -Name ProductName -Value $Adapter.ProductName
                    $arrBinary += $Binary
                    $nic += 1
                }
            }
            else
            {
                if ($arrBinary | Select-Object | Where-Object {($Adapter.ProductName -eq $_.ProductName) -and ($Adapter.Manufacturer -eq $_.Manufacturer)})
                {
                }
                else
                {
                
                    $Binary = New-Object System.Object
                    $Reg = Get-ItemProperty -path "HKLM:\System\CurrentControlSet\Services\$($Adapter.servicename)" -ErrorAction SilentlyContinue
                    if($reg.ImagePath)
                    {
                        $FileVers = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("\\" + $computer + "\c$\Windows" + ($Reg.ImagePath.Replace("\SystemRoot","")))
                        $binary | Add-Member -MemberType NoteProperty -Name ProductName -Value $Adapter.ProductName
                        $Binary | add-Member -MemberType NoteProperty -Name file -Value ($FileVers.FileName.Split("\")[-1])
                        $Binary | add-Member -MemberType NoteProperty -Name FileVer -Value $FileVers.fileversion
                        $binary | Add-Member -MemberType NoteProperty -Name Manufacturer -Value $Adapter.Manufacturer
                        $arrBinary += $Binary
                    }
                }
               
            }
        }
   }
$arrBinary
}