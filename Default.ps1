#################################################################################################
# HP WAP Web Service build script
# Created by Wil Taylor from Vigilant IT.
# for HPE
#################################################################################################
Properties {
	$build_dir = Split-Path $psake.build_script_file
	$build_artifacts_dir = "$build_dir\Release\"
	$build_unittest_dir = "$build_dir\UnitTest\"
	$packageFolder_dir = "$build_dir\Package\"
	$MSBuildPath = 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe'
	$MSDeployPath = 'C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe'
	$InstallUtilPath = 'C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe'
	$MSTestPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio 14.0\Common7\IDE\MSTest.exe"
	$SolutionName = 'WAP_WebService\WAP_WebService.sln'
	$PackagePath = "$build_dir\PackageRelease"
	$RitSimInstallDir = 'C:\Program Files\HPE Rit Sim'
	$HPGateWayInstallDir = 'c:\Program Files\SQLaaSHPGateway'
}

Task Default

Task CleanRelease {
	Remove-Item -Path $build_artifacts_dir -Force -Recurse -ErrorAction SilentlyContinue
}

Task CleanUnitTest {
	Remove-Item -Path $build_unittest_dir -Force -Recurse -ErrorAction SilentlyContinue
}

Task CleanPackage {
	Remove-Item -Path $packageFolder_dir -Force -Recurse -ErrorAction SilentlyContinue
}

Task CreateFolderRelease {
	New-Item -Path $build_artifacts_dir -ItemType Directory
	New-Item -Path "$build_artifacts_dir\Gateway" -ItemType Directory
	New-Item -Path "$build_artifacts_dir\WAP_WebService" -ItemType Directory
	New-Item -Path "$build_artifacts_dir\WAP_WSI" -ItemType Directory
}

Task CreateUnitTestFolders {
	New-Item -Path $build_unittest_dir -ItemType Directory
}

Task CreatePackageFolders {
	New-Item -Path $packageFolder_dir -ItemType Directory
}

Task Build -depends CleanRelease, CreateFolderRelease, BuildHPGateway, BuildWebService, BuildRitSim

Task BuildHPGateway -depends CleanRelease, CreateFolderRelease {
	Exec { &$MSBuildPath $SolutionName /t:Gateway /p:Configuration=Debug "/p:OutDir=`"$build_artifacts_dir\Gateway`"" }
}

Task BuildWebService -depends CleanRelease, CreateFolderRelease {
	Exec { &$MSBuildPath "$build_dir\WAP_WebService\WAP_WebService\WAP_WebService.csproj" /t:Package "/p:Configuration=Debug;PackageLocation=`"$build_artifacts_dir\WAP_WebService`"" }
}

Task BuildRitSim -depends CleanRelease, CreateFolderRelease {
	Exec { &$MSBuildPath $SolutionName /t:WAP_WSI /p:Configuration=Debug "/p:OutDir=`"$build_artifacts_dir\WAP_WSI`"" }
}

Task Package -depends CleanPackage, CreatePackageFolders, PackageBin, PackageSource, PackageScripts, PackageDB, PackageDocs, PackageConfig, PackageTools, BuildPackage

Task PackageBin -depends Build {
	Copy-Item -Path $build_artifacts_dir -Destination "$packageFolder_dir\Bin" -Recurse -Force
}

Task PackageSource {
	Copy-Item -Path "$build_dir\WAP_WebService" -Destination "$packageFolder_dir\Src" -Recurse -Force
	Get-ChildItem "$packageFolder_dir\Src" -Include @('bin', 'obj', '*.IsolatorCache.user', '*.suo', '.vs') -Recurse | Remove-Item -Recurse -Force
}

Task PackageDocs {
	Copy-Item -Path "$build_dir\Docs" -Destination "$packageFolder_dir\Docs" -Recurse -Force
}

Task PackageTools {
	Copy-Item -Path "$build_dir\Tools" -Destination "$packageFolder_dir\Tools" -Recurse -Force
}

Task PackageScripts {
	Copy-Item "$build_dir\scripts\*.*" $packageFolder_dir
}

Task PackageConfig {
	Copy-Item "$build_dir\config\*.*" $packageFolder_dir
}

Task PackageDB {
	Copy-Item "$build_dir\Database" $packageFolder_dir -Recurse
}

Task BuildPackage {
	$filecontent = Get-Content "$build_dir\WAP_WebService\Gateway\Properties\AssemblyInfo.cs"
	$majorversion = 0
	$minorversion = 0
	$configNumber = (Get-Content "$build_dir\Config\BuildConfig.psd1" -Raw | Invoke-Expression).HotFix.Tostring()
	$hotfix = ""
	
	if (-not([string]::IsNullOrEmpty($configNumber)) -and -not($configNumber -eq "0"))
	{
		
		$hotfix = "-HF$configNumber"
	}
	
	for ($i = 0; $i -lt $filecontent.Length; $i++)
	{
		if ($filecontent[$i] -match "\[assembly: AssemblyVersion\(`"([0-9]{1,10})\.([0-9]{1,10})\.\*`"\)\]")
		{
			$majorversion = [int]::Parse($Matches[1])
			$minorversion = [int]::Parse($Matches[2])
		}
	}
	
	if (-not (Test-Path  $PackagePath)) { New-Item $PackagePath -ErrorAction SilentlyContinue -ItemType Directory }
	
	$PKG = "$PackagePath\HPWAPGW-$majorversion.$minorversion$($hotfix).zip"
	
	if (Test-Path $PKG) { Remove-Item $PKG -Force }
	
	Get-ChildItem $packageFolder_dir | Compress-Archive -DestinationPath $PKG -CompressionLevel Optimal
}

Task IncrementVersion -depends IncrementVersionHPGateway, IncrementVersionWebService, IncrementVersionRitSim, IncrementVersionDataLayer

Task IncrementVersionHPGateway {
    $filecontent = Get-Content "$build_dir\WAP_WebService\Gateway\Properties\AssemblyInfo.cs"
    
    for($i =0; $i -lt $filecontent.Length; $i++) {
        if($filecontent[$i] -match "\[assembly: AssemblyVersion\(`"([0-9]{1,10})\.([0-9]{1,10})\.\*`"\)\]") {
            $majorversion = [int]::Parse($Matches[1])
            $minorversion = [int]::Parse($Matches[2])
            $minorversion++
            $filecontent[$i] = "[assembly: AssemblyVersion(`"$majorversion.$minorversion.*`")]"
        }
    }

    $filecontent | Set-Content "$build_dir\WAP_WebService\Gateway\Properties\AssemblyInfo.cs" -Encoding UTF8    
}

Task IncrementVersionWebService {
    $filecontent = Get-Content "$build_dir\WAP_WebService\WAP_WebService\Properties\AssemblyInfo.cs"
    
    for($i =0; $i -lt $filecontent.Length; $i++) {
        if($filecontent[$i] -match "\[assembly: AssemblyVersion\(`"([0-9]{1,10})\.([0-9]{1,10})\.\*`"\)\]") {
            $majorversion = [int]::Parse($Matches[1])
            $minorversion = [int]::Parse($Matches[2])
            $minorversion++
            $filecontent[$i] = "[assembly: AssemblyVersion(`"$majorversion.$minorversion.*`")]"
        }
    }

    $filecontent | Set-Content "$build_dir\WAP_WebService\WAP_WebService\Properties\AssemblyInfo.cs" -Encoding UTF8    
}

Task IncrementVersionRitSim {
    $filecontent = Get-Content "$build_dir\WAP_WebService\WAP_WSI\Properties\AssemblyInfo.cs"
    
    for($i =0; $i -lt $filecontent.Length; $i++) {
        if($filecontent[$i] -match "\[assembly: AssemblyVersion\(`"([0-9]{1,10})\.([0-9]{1,10})\.\*`"\)\]") {
            $majorversion = [int]::Parse($Matches[1])
            $minorversion = [int]::Parse($Matches[2])
            $minorversion++
            $filecontent[$i] = "[assembly: AssemblyVersion(`"$majorversion.$minorversion.*`")]"
        }
    }

    $filecontent | Set-Content "$build_dir\WAP_WebService\WAP_WSI\Properties\AssemblyInfo.cs" -Encoding UTF8    
}

Task IncrementVersionDataLayer {
    $filecontent = Get-Content "$build_dir\WAP_WebService\Gateway.DataLayer\Properties\AssemblyInfo.cs"
    
    for($i =0; $i -lt $filecontent.Length; $i++) {
        if($filecontent[$i] -match "\[assembly: AssemblyVersion\(`"([0-9]{1,10})\.([0-9]{1,10})\.\*`"\)\]") {
            $majorversion = [int]::Parse($Matches[1])
            $minorversion = [int]::Parse($Matches[2])
            $minorversion++
            $filecontent[$i] = "[assembly: AssemblyVersion(`"$majorversion.$minorversion.*`")]"
        }
    }

    $filecontent | Set-Content "$build_dir\WAP_WebService\Gateway.DataLayer\Properties\AssemblyInfo.cs" -Encoding UTF8    
}