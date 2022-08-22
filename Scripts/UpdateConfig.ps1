param ([string]$Environment = "Lab")

$HPGatewayPath = Resolve-Path ".\Bin\Gateway\Gateway.exe.config"
$WebServicePath = Resolve-Path ".\Bin\WAP_WebService\WAP_WebService.SetParameters.xml"
$RitSimPath = Resolve-Path ".\Bin\WAP_WSI\WAP_WSI.exe.config"
#load environment config
$config = (Get-Content ".\Environments.psd1" -Raw | Invoke-Expression)[$Environment]

if ($config -eq $null) { throw "Can't find environment $Environment in config. Please look at Environments.psd1 and try again."}

#Gateway settings
$HPGateway = [xml](Get-Content $HPGatewayPath)
$settingsnode = $HPGateway.configuration.applicationSettings."Gateway.Properties.Settings"

foreach ($node in $settingsnode.ChildNodes)
{
	if ($node.Name -eq "dbconn") { $node.Value = $config.ConnectionString }
	if ($node.Name -eq "loglevel") { $node.Value = $config.LogLevel }
	if ($node.Name -eq "logfile") { $node.Value = $config.LogFile }
	if ($node.Name -eq "authserver") { $node.Value = $config.AuthServer }
	if ($node.Name -eq "adminserver") { $node.Value = $config.AdminServer }
	if ($node.Name -eq "adfs") { $node.Value = $config.ADFS }
	if ($node.Name -eq "tenantserver") { $node.Value = $config.TenantServer }
	if ($node.Name -eq "prodshare") { $node.Value = $config.Prodshare }
	if ($node.Name -eq "nonprodshare") { $node.Value = $config.NonProdShare }
	if ($node.Name -eq "checkinterval") { $node.Value = $config.CheckInterval }
	if ($node.Name -eq "securitygrpshareaccess") { $node.Value = $config.SecurityShareAccess }
	if ($node.Name -eq "signedcert") { $node.Value = $config.SignedCert }
	if ($node.Name -eq "timerlogfile") { $node.Value = $config.TimerLogFile }
	if ($node.Name -eq "GWSQLSRV") { $node.Value = $config.DBServer }
	if ($node.Name -eq "GWDBNAME") { $node.Value = $config.DBName }
}

$settingsnode = $null
$HPGateway.Save($HPGatewayPath)

#WebService settings
$WebService = [xml](Get-Content $WebServicePath)

foreach ($node in $WebService.parameters.ChildNodes)
{
	if ($node.Name -eq "IIS Web Application Name") { $node.value = $config.IISApplicationName }
	if ($node.Name -eq "GWDB") { $node.value = $config.DBName }
	if ($node.Name -eq "GWSQLServer") { $node.value = $config.DBServer }
	if ($node.Name -eq "VerboseLogging") { $node.value = $config.WebServiceVerboseLogging }
	if ($node.Name -eq "LogPath") { $node.value = $config.LogFile }
	if ($node.Name -eq "CreateGroup") { $node.value = $config.CreateGroup }
	if ($node.Name -eq "StatusGroup") { $node.value = $config.StatusGroup }
	if ($node.Name -eq "DeleteGroup") { $node.value = $config.DeleteGroup }
	if ($node.Name -eq "CreateGroupDomain") { $node.value = $config.CreateGroupDomain }
	if ($node.Name -eq "StatusGroupDomain") { $node.value = $config.StatusGroupDomain }
	if ($node.Name -eq "DeleteGroupDomain") { $node.value = $config.DeleteGroupDomain }
}

$WebService.Save($WebServicePath)

#Ritsim settings
$RitSim = [xml](Get-Content $RitSimPath)
$settingsnode = $RitSim.configuration.applicationSettings."WAP_WSI.Properties.Settings"

foreach ($node in $settingsnode.ChildNodes)
{
	if ($node.Name -eq "WAP_WSI_SQLaaS_WS_SQLaaS_WS") { $node.value = $config.WebServiceURL }
}

foreach ($node in $RitSim.configuration."system.serviceModel".client.ChildNodes)
{
	$node.address = $config.WebServiceURL
}

$RitSim.Save($RitSimPath)