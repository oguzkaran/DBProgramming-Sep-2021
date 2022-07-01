using CSD.WikiSearchApp.Data.DAL;
using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Contexts;
using NUnit.Framework;
using System.Threading.Tasks;

namespace WikiSearchGeoNUnitTest
{
    [TestFixture]
    [Author("Muhammed Oğur")]
    class Test_FindWikiSearchQAsync
    {        
        private WikiSearchAppDataHelper m_wikiSearchAppDataHelper;
        

        [SetUp]
        public void SetUp()
        {            
           m_wikiSearchAppDataHelper = new WikiSearchAppDataHelper(new WikiSearchRepository(new WikiSearchAppDbContext()));
        }

        [Test]
        [TestCase("ankara", 1000)]        
        public async Task Test(string q, int expected)
        {
            var ws = await m_wikiSearchAppDataHelper.FindWikiSearchByQAsync(q, expected);

            if (ws != null)
                Assert.AreEqual(expected, ws.Geonames.Count);            
        }       
    }
}
