using CSD.WikiSearchApp.Geonames;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace WikiSearchGeoNUnitTest
{
    [TestFixture]
    [Author("Muhammed Oğur")]
    class Test_WikiSearchGeoFound
    {
        private WikiSearchClient m_wikiSearch;

        [SetUp]
        public void SetUp()
        {
           m_wikiSearch = new WikiSearchClient(new HttpClient());
        }

        [Test]
        [TestCase("sweden", 1000)]                
        public async Task Test(string q, int expected)
        {
            var data = await m_wikiSearch.FindGeonames(q);
            
            Assert.AreEqual(expected, data.ToList().Count);            
        }       
    }
}
