using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using static System.String;

namespace CSD.WikiSearchApp.Geonames
{
    public class WikiSearchClient
    {
        private readonly HttpClient m_httpClient;

        public WikiSearchClient(HttpClient httpClient)
        {
            m_httpClient = httpClient;        
        }

        public async Task<IEnumerable<Geoname>> FindGeonames(string q)
        {
            var response = await m_httpClient.GetStringAsync(Format(Global.WikiUrlTemplate, q, 1000));

            var geo = JsonConvert.DeserializeObject<WikiSearchInfo>(response);
            
            var result = geo.Geonames;

            return result;
        }
    }
}
