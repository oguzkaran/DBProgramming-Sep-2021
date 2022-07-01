using CSD.Util.Mappers.Mapster;
using CSD.WikiSearchApp.Geonames;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

using WGeoname = CSD.WikiSearchApp.Geonames.Geoname;
using EGeoname = CSD.WikiSearchApp.Data.Repositories.Entities.Geoname;
using CSD.WikiSearchApp.Data.DAL;
using CSD.WikiSearchApp.Data.Repositories.Contexts;
using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Entities;

namespace WikiSearchGeoNUnitTest
{
    [TestFixture]
    [Author("Muhammed Oğur")]
    class Test_ExistsByQAsync
    {        
        private WikiSearchAppDataHelper m_wikiSearchAppDataHelper;
        
        

        [SetUp]
        public void SetUp()
        {
            m_wikiSearchAppDataHelper = new WikiSearchAppDataHelper(new WikiSearchRepository(new WikiSearchAppDbContext()));
        }

        [Test]
        [TestCase("ankara", 10)]
        [TestCase("istanbul", 20)]
        [TestCase("izmir", 10)]        
        public async Task Test(string q, int expected)
        {
            Assert.IsTrue(await m_wikiSearchAppDataHelper.ExistsByIdAsync(q));            
        }       
    }
}
