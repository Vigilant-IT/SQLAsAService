param([Parameter(ParameterSetName='All')][switch]$All,
	[Parameter(ParameterSetName='Selection')][switch]$RitSim,
	[Parameter(ParameterSetName='Selection')][switch]$WebService,
	[Parameter(ParameterSetName = 'Selection')][switch]$HPGateway,
	[Parameter(ParameterSetName = 'Selection')][switch]$Database,
	[string]$Environment='LAB')

Import-Module ( Resolve-Path 'src\packages\psake.4.6.0\tools\psake.psd1') -ErrorAction stop

Push-Location $PSScriptRoot

Invoke-psake UpdateConfig -properties @{ Environment = $Environment}

if ($Database) { Invoke-psake InstallDB }

if ($All) { Invoke-psake InstallAll }

if ($RitSim) { Invoke-psake InstallRitSim }

if ($WebService) { Invoke-psake InstallWebService }

if ($HPGateway) { Invoke-psake InstallHPGateway }

try { Pop-Location $PSScriptRoot -ErrorAction Stop } catch { <# Do nothing eat error #> }