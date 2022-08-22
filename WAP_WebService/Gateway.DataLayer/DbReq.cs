namespace Gateway.DataLayer
{
    public interface IDbReq
    {
        string RgId { get; set; }
        string DbName { get; set; }
        string Collation { get; set; }
        string ListenerName { get; set; }
        string DboGrp { get; set; }
        string PwrGrp { get; set; }
        string StdGrp { get; set; }
        string Size { get; set; }
        string AogName { get; set; }
        string Ip { get; set; }
        string State { get; set; }
        string Notes { get; set; }
        string ConnectionString { get; set; }
    }
    public class DbReq : IDbReq
    {
        public string RgId { get; set; }
        public string DbName { get; set; }
        public string Collation { get; set; }
        public string ListenerName { get; set; }
        public string DboGrp { get; set; }
        public string PwrGrp { get; set; }
        public string StdGrp { get; set; }
        public string Size { get; set; }
        public string AogName { get; set; }
        public string Ip { get; set; }
        public string State { get; set; }
        public string Notes { get; set; }
        public string ConnectionString { get; set; }
    }
}
