using System.Text;

namespace Gateway.DataLayer.Utility
{
    public static class ObjectStringUtility
    {
        public static string GetDataObjectString(this object instance)
        {
            var returndata = new StringBuilder(string.Format("[{0}]:",instance.GetType().Name));

            foreach (var property in instance.GetType().GetProperties())
            {
                returndata.Append(string.Format("({0}) = ({1}) ", property.Name, property.GetValue(instance)));
            }

            return returndata.ToString();
        }

        public static void ReplaceNullWithEmtpyString(this object instance)
        {
            foreach (var property in instance.GetType().GetProperties())
            {
                if(property.GetValue(instance) == null)
                    property.SetValue(instance, string.Empty);
            }

        }
    }
}
