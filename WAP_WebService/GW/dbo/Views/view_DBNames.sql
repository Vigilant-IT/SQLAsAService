CREATE VIEW [dbo].[view_DBNames]
AS
	SELECT	DBName AS 'Database Name'
	FROM	dbo.Audit
	WHERE	(State = 'completed')