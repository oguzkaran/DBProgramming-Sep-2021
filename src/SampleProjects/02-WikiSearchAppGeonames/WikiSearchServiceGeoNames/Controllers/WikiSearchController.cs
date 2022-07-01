
using CSD.WikiSearchApp.Data.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

using static CSD.Util.Error.ExceptionUtil;

namespace CSD.WikiSearchApp.Controllers
{
    [Route("api/[controller]")]
    public class WikiSearchController : ControllerBase
    {
        private readonly WikiSearchAppService m_wikiSearchAppService;

        public WikiSearchController(WikiSearchAppService wikiSearchAppService)
        {
            m_wikiSearchAppService = wikiSearchAppService;
        }

        
        [HttpGet("place")]
        public async Task<IEnumerable<WikiSearchDTO>> FindPlaceInfo(string q, int maxRows)
        {
            return await m_wikiSearchAppService.FindWikiSearchByQAsync(q, maxRows);
        }
    }
}
