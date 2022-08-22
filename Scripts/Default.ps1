#################################################################################################
# HP WAP Web Service build script - cut down package install version.
# Created by Wil Taylor from Vigilant IT.
# for HPE
#################################################################################################
Properties {
	$pkg_root = Split-Path $psake.build_script_file
	$RitSimInstallDir = "C:\Program Files\HPE Rit Sim"
	$HPGateWayInstallDir = "c:\Program Files\SQLaaSHPGateway"
	$Environment = "LAB"
	$DevEnvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
	$InstallUtilPath = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe'
}
Task InstallAll -depends InstallWebService, InstallHPGateway, InstallRitSim

Task InstallDB {
	#SQLPS will change location to it's PSdrive location. Restoring current location to work around this (pop-location doesn't work in this instance).
	$loc = Get-Location
	Import-Module SQLPS -WarningAction SilentlyContinue
	Set-Location $loc
	
	Invoke-SqlCmd -Inputfile .\Database\HPGW.sql
}

Task InstallWebService {
	Exec { &cmd.exe /c "$pkg_root\Bin\WAP_WebService\WAP_WebService.deploy.cmd" /Y }
}

Task InstallHPGateway {
	Stop-Service -Name "HP SQL" -Force -ErrorAction SilentlyContinue
	Start-Sleep -Seconds 10
	New-Item -Path $HPGateWayInstallDir -ItemType Directory -ErrorAction SilentlyContinue
	Copy-Item -Path "$pkg_root\Bin\Gateway\*.*" -Destination $HPGateWayInstallDir -Force
	
	$service = Get-Service -Name "HP SQL" -ErrorAction SilentlyContinue
	
	if ($service -eq $null)
	{
		Exec { &$InstallUtilPath "$HPGateWayInstallDir\Gateway.exe" }
	}
	
	Start-Service "HP SQL"
}

Task InstallRitSim {
	Stop-Process -Name WAP_WSI -ErrorAction SilentlyContinue
	New-Item -Path $RitSimInstallDir -ItemType Directory -ErrorAction SilentlyContinue
	Copy-Item -Path "$pkg_root\Bin\WAP_WSI\*.*" -Destination $RitSimInstallDir -Force
	
	# Create a shortcut on the desktop
	$WshShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:PUBLIC\Desktop\RIT Sim.lnk")
	$Shortcut.TargetPath = "$RitSimInstallDir\WAP_WSI.exe"
	$shortcut.IconLocation = "$RitSimInstallDir\ritsim.ico"
	$Shortcut.Save()
}

Task UpdateConfig {
	&"$pkg_root\UpdateConfig.ps1" -Environment $Environment
}

Task OpenWebService {
	$config = (Get-Content ".\Environments.psd1" -Raw | Invoke-Expression)[$Environment]
	Start-Process -FilePath iexplore.exe -ArgumentList $config.WebServiceURL
}

Task OpenVS {
	&$DevEnvPath "$pkg_root\Src\WAP_WebService.sln"
}