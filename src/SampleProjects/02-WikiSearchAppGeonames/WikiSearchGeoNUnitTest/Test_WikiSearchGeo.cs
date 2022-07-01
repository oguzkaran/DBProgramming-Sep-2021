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
    class Test_WikiSearchGeod
    {
        private WikiSearchClient m_wikiSearch;

        [SetUp]
        public void SetUp()
        {
           m_wikiSearch = new WikiSearchClient(new HttpClient());
        }

        [Test]
        [TestCase("ddddddddd", 1000)]
        [TestCase("jjjjjjjjjjjjjjjjjjjj", 10)]
        [TestCase("ccccccccccc", 10)]
        [TestCase("sydney", 1000)]
        [TestCase("paris", 1000)]        
        public async Task Test(string q, int expected)
        {
            var data = await m_wikiSearch.FindGeonames(q);

            var count = data.ToList().Count;

            if (data.Any())
                Assert.AreEqual(expected, count);
            else
                Assert.IsTrue(count == 0);            
        }       
    }
}
