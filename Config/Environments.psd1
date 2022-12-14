@{
	LAB = @{
		WebServiceURL = "https://hpgateway.domain.local/SQLaaS_WS.ASMX"
		IISApplicationName = "HPGW"
		DBName = "GW"
		DBServer = "hpgateway.domain.local"
		ConnectionString = "Server=hpgateway.domain.local;Integrated Security = True"
		WebServiceVerboseLogging = "true"
		LogLevel = "Standard"
		LogFile = "c:\temp"
		AuthServer = ""
		AdminServer = ""
		TenantServer = ""
		ADFS = "false"
		Prodshare = ""
		NonProdShare = ""
		CheckInterval = "10"
		SecurityShareAccess = "AU\ACOE_SCOM_SQLMonitor;AUT01\ACOE_SCOM_SQLMonitor"
		SignedCert = "True"
		TimerLogFile = "C:\temp\SQLaaSLog_Timer.log"
		CreateGroup = "RitCreate"
		StatusGroup = "RitStatus"
		DeleteGroup = "RitDelete"
		CreateGroupDomain = "Domain.local"
		StatusGroupDomain = "Domain.local"
		DeleteGroupDomain = "Domain.local"
	}
		
	SettingsTest = @{
		WebServiceURL = "{WebServiceURL}"
		IISApplicationName = "{IISApplicationName}"
		DBName = "{DBName}"
		DBServer = "{DBServer}"
		ConnectionString = "{ConnectionString}"
		WebServiceVerboseLogging = "{WebServiceVerboseLogging}"
		LogLevel = "{LogLevel}"
		LogFile = "{LogFile}"
		AuthServer = "{AuthServer}"
		AdminServer = "{AdminServer}"
		TenantServer = "{TenantServer}"
		ADFS = "{ADFS}"
		Prodshare = "{Prodshare}"
		NonProdShare = "{NonProdShare}"
		CheckInterval = "{CheckInterval}"
		SecurityShareAccess = "{SecurityShareAccess}"
		SignedCert = "{SignedCert}"
		TimerLogFile = "{TimerLogFile}"
		CreateGroup = "{CreateGroup}"
		StatusGroup = "{StatusGroup}"
		DeleteGroup = "{DeleteGroup}"
		CreateGroupDomain = "{CreateGroupDomain}"
		StatusGroupDomain = "{StatusGroupDomain}"
		DeleteGroupDomain = "{DeleteGroupDomain}"
	}
}