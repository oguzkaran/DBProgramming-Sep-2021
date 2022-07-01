using CSD.WikiSearchApp.Data.DAL;
using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Contexts;
using CSD.WikiSearchApp.Data.Services;
using CSD.WikiSearchApp.Geonames;
using NUnit.Framework;
using System.Threading.Tasks;

using System.Linq;
using CSD.Util.Mappers.Mapster;

namespace WikiSearchGeoNUnitTest
{
    [TestFixture]
    [Author("Muhammed Oğur")]
    class Test_FindWikiSearchQAsync
    {
        private WikiSearchAppService m_wikiSearchAppDataHelper;
        

        [SetUp]
        public void SetUp()
        {
            var mapper = new Mapper();
            var httpClient = new WikiSearchClient(new());
            m_wikiSearchAppDataHelper = new WikiSearchAppService(new WikiSearchAppDataHelper(new WikiSearchRepository(new WikiSearchAppDbContext())), mapper, httpClient);
        }

        [Test]
        [TestCase("sydney", 5, 5)]
        [TestCase("ankara", 10, 10)]
        [TestCase("istanbul", 10, 10)]
        [TestCase("izmir", 10, 10)]
        [TestCase("jjjjjjjjjjjjjjjjjjjj", 10, 0)]
        [TestCase("ankara", 10, 10)]
        public async Task Test(string q, int maxRows, int expected)
        {
            Assert.IsTrue((await m_wikiSearchAppDataHelper.FindWikiSearchByQAsync(q, maxRows)).Count() == expected);
        }       
    }
}
