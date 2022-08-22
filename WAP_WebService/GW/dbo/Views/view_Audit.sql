CREATE VIEW [dbo].[view_Audit]
AS
	SELECT	ID, State, DBName AS 'Database Name', SQLVer AS 'SQL Version', InitialSizeMB AS 'Initial Size in MB', 
			DC AS 'Site', Network AS 'Prod\Test', Availability, Zone, SKU, Recovery, Colation, TDE, 
			StorPerfData AS 'Data file Storage Type', StorPerfLogs AS 'Log file Storage type', Retention, 
			BUDI, DBoGroup AS 'Database Owner', PwrUGroup AS 'Power Users', StdUGroup AS 'Standard Users', Connection
	FROM	dbo.Audit
	WHERE	(State NOT LIKE 'completed %')