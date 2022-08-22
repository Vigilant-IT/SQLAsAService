// Create by Steven Hosking from Vigilant.IT
// for HP Inc
// on 27/12/2015
// 
// as part of the Gateway Project

using System;
using System.IdentityModel.Protocols.WSTrust;
using System.IdentityModel.Tokens;
using System.ServiceModel;
using System.ServiceModel.Security;
using System.Text;
using RequestTypes = Microsoft.IdentityModel.SecurityTokenService.RequestTypes;

namespace Gateway
{
    /// <summary>
    /// </summary>
    public class ClsAuthentication
    {
        /// <summary>
        /// </summary>
        /// <param name="windowsAuthSiteEndPoint"></param>
        /// <returns></returns>
        public static string GetWindowsToken(string windowsAuthSiteEndPoint)
        {
            var identityProviderEndpoint =
                new EndpointAddress(new Uri(windowsAuthSiteEndPoint + "/wstrust/issue/windowstransport"));
            var identityProviderBinding = new WS2007HttpBinding(SecurityMode.Transport);
            identityProviderBinding.Security.Message.EstablishSecurityContext = false;
            identityProviderBinding.Security.Message.ClientCredentialType = MessageCredentialType.None;
            identityProviderBinding.Security.Transport.ClientCredentialType = HttpClientCredentialType.Windows;

            var trustChannelFactory = new WSTrustChannelFactory(identityProviderBinding, identityProviderEndpoint)
            {
                TrustVersion = TrustVersion.WSTrust13
            };

            if (trustChannelFactory.Credentials != null)
                trustChannelFactory.Credentials.ServiceCertificate.SslCertificateAuthentication =
                    new X509ServiceCertificateAuthentication
                    {
                        CertificateValidationMode = X509CertificateValidationMode.None
                    };
            var channel = trustChannelFactory.CreateChannel();

            var rst = new RequestSecurityToken(RequestTypes.Issue)
            {
                AppliesTo = new EndpointReference("http://azureservices/AdminSite"),
                KeyType = KeyTypes.Bearer
            };

            RequestSecurityTokenResponse rstr;

            var token = channel.Issue(rst, out rstr);
            var tokenString = ((GenericXmlSecurityToken) token).TokenXml.InnerText;
            var jwtString = Encoding.UTF8.GetString(Convert.FromBase64String(tokenString));

            return jwtString;
        }
    }
}