namespace Gateway.DataLayer
{
    public interface IRgReq
    {
        string RgId { get; set; }
        string RgName { get; set; }
        string Zone { get; set; }
        string Avail { get; set; }
        string SqlVer { get; set; }
        string Dc { get; set; }
        string Env { get; set; }
        string Tde { get; set; }
        string SkuName { get; set; }
        string Email { get; set; }
        string PassPhrase { get; set; }
        string Notes { get; set; }
        string State { get; set; }
        string ReqTime { get; set; }
    }
    public class RgReq : IRgReq
    {
        public string RgId { get; set; }
        public string RgName { get; set; }
        public string Zone { get; set; }
        public string Avail { get; set; }
        public string SqlVer { get; set; }
        public string Dc { get; set; }
        public string Env { get; set; }
        public string Tde { get; set; }
        public string SkuName { get; set; }
        public string Email { get; set; }
        public string PassPhrase { get; set; }
        public string Notes { get; set; }
        public string State { get; set; }
        public string ReqTime { get; set; }
    }
}
