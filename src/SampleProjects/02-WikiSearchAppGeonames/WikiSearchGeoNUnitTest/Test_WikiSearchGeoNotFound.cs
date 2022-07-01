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
    class Test_WikiSearchGeoNotFound
    {
        private WikiSearchClient m_wikiSearch;

        [SetUp]
        public void SetUp()
        {
            m_wikiSearch = new WikiSearchClient(new HttpClient());
        }

        [Test]
        [TestCase("ddddddddd")]
        [TestCase("jjjjjjjjjjjjjjjjjjjj")]
        [TestCase("ccccccccccc")]
        public async Task Test(string q)
        {
            var data = await m_wikiSearch.FindGeonames(q);

            Assert.IsFalse(data.Any());
        }       
    }
}
