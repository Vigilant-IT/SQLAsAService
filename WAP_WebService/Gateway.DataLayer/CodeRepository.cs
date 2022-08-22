using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Gateway.DataLayer
{
    public interface ICodeRepository
    {
        bool CheckCode(string name, string value);
        IEnumerable<string> GetCode(string name);
        IEnumerable<string> GetSkuCode();
    }

    public class CodeRepository : ICodeRepository
    {
        private readonly string _connectionstring;

        public CodeRepository(string sqlserver, string database)
        {
            _connectionstring = string.Format("Data Source = {0}; Initial Catalog={1};Integrated Security=true;",
                sqlserver, database);
        }

        public bool CheckCode(string name, string value)
        {
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "Select Id from Codes WHERE Code = @code and Value = @codevalue";
                cmd.Parameters.Add(new SqlParameter {ParameterName = "code", DbType = DbType.String, Value = name});
                cmd.Parameters.Add(new SqlParameter {ParameterName = "codevalue", DbType = DbType.String, Value = value});
                var result = cmd.ExecuteScalar();
                connection.Close();

                int id;

                if (!int.TryParse(result.ToString(), out id))
                    return false;

                return id != 0;
            }
        }

        public IEnumerable<string> GetCode(string name)
        {
            var returndata = new List<string>();
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "SELECT Value FROM Codes WHERE Code = @code";
                cmd.Parameters.Add(new SqlParameter {ParameterName = "code", DbType = DbType.String, Value = name});
                var result = cmd.ExecuteReader();

                while (result.Read())
                {
                    returndata.Add(result["Value"].ToString());
                }

                connection.Close();
            }

            return returndata;
        }

        public IEnumerable<string> GetSkuCode()
        {
            var returndata = new List<string>();
            using (var connection = new SqlConnection(_connectionstring))
            {
                connection.Open();
                var cmd = connection.CreateCommand();
                cmd.CommandText = "select name from SKUConfig";
                var result = cmd.ExecuteReader();
                while (result.Read())
                {
                    returndata.Add(result["Name"].ToString().Trim());
                }
                connection.Close();
            }
            return returndata;
        }
    }
}
