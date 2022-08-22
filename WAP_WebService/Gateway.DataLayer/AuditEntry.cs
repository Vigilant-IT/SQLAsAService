namespace Gateway.DataLayer
{
    /// <summary>
    /// Audit entry interface for unit test. Reference this instead of AuditEntry directly.
    /// </summary>
    public interface IAuditEntry
    {
        string Id { get; set; }
        string State { get; set; }
        string DC { get; set; }
        string Username { get; set; }
        string DBName { get; set; }
        string SQLVer { get; set; }
        string InitialSizeMB { get; set; }
        string Colation { get; set; }
        string Network { get; set; }
        string Availability { get; set; }
        string Zone { get; set; }
        string Sku { get; set; }
        string StorPerfData { get; set; }
        string StorPerfLogs { get; set; }
        string Retention { get; set; }
        string BUDI { get; set; }
        string DBoGroup { get; set; }
        string Recovery { get; set; }
        string TDE { get; set; }
        string Connection { get; set; }
        string Notes { get; set; }
        string Logged { get; set; }
        string Expire { get; set; }
        string PwrUGroup { get; set; }
        string StdUGroup { get; set; }
        string RequestITID { get; set; }
    }

    /// <summary>
    /// Concreate instance of IAuditEntry.
    /// Data class so do not delcare methods in it.
    /// </summary>
    public class AuditEntry : IAuditEntry
    {
        public string Id { get; set; }
        public string State { get; set; }
        public string DC { get; set; }
        public string Username { get; set; }
        public string DBName { get; set; }
        public string SQLVer { get; set; }
        public string InitialSizeMB { get; set; }
        public string Colation { get; set; }
        public string Network { get; set; }
        public string Availability { get; set; }
        public string Zone { get; set; }
        public string Sku { get; set; }
        public string StorPerfData { get; set; }
        public string StorPerfLogs { get; set; }
        public string Retention { get; set; }
        public string BUDI { get; set; }
        public string DBoGroup { get; set; }
        public string Recovery { get; set; }
        public string TDE { get; set; }
        public string Connection { get; set; }
        public string Notes { get; set; }
        public string Logged { get; set; }
        public string Expire { get; set; }
        public string PwrUGroup { get; set; }
        public string StdUGroup { get; set; }
        public string RequestITID { get; set; }
    }
}
