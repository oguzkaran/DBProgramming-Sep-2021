using CSD.Util.Mappers.Mapster;
using CSD.WikiSearchApp.Data.DAL;
using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Contexts;
using CSD.WikiSearchApp.Data.Repositories.Entities;
using CSD.WikiSearchApp.Geonames;
using NUnit.Framework;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using EGeoname = CSD.WikiSearchApp.Data.Repositories.Entities.Geoname;
using WGeoname = CSD.WikiSearchApp.Geonames.Geoname;

namespace WikiSearchGeoNUnitTest
{
    [TestFixture]
    [Author("Muhammed Oğur")]
    class Test_SaveWikiSearchAsync
    {
        private WikiSearchClient m_wikiSearch;
        private WikiSearchAppDataHelper m_wikiSearchAppDataHelper;
        private Mapper m_mapper = new();
        

        [SetUp]
        public void SetUp()
        {
            m_wikiSearch = new WikiSearchClient(new HttpClient());
            m_wikiSearchAppDataHelper = new WikiSearchAppDataHelper(new WikiSearchRepository(new WikiSearchAppDbContext()));
        }

        [Test]
        [TestCase("london")]
        [TestCase("tokyo")]
        [TestCase("berlin")]
        public async Task Test(string q)
        {
            var data = await m_wikiSearch.FindGeonames(q);

            var geonames = data.Select(g => m_mapper.Map<EGeoname, WGeoname>(g)).ToList();
            var wikiSearch = new WikiSearch() { Q = q, Geonames = geonames };

            await m_wikiSearchAppDataHelper.SaveWikiSearchAsync(wikiSearch);            
        }       
    }
}
