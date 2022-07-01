using CSD.WikiSearchApp.Data.Repositories.Contexts;
using CSD.WikiSearchApp.Data.Repositories.Entities;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static CSD.Util.TPL.TaskUtil;
using Microsoft.EntityFrameworkCore;
using System;

namespace CSD.WikiSearchApp.Data.Repositories
{
    public class WikiSearchRepository : IWikiSearchRepository
    {
        private readonly WikiSearchAppDbContext m_wikiSearchAppDbContext;

        private bool existsByQ(string q)
        {
            return m_wikiSearchAppDbContext.WikiSearches.Any(w => w.Q == q);               
        }

        private WikiSearch findByQCallback(string q, int maxRows)
        {            
            return m_wikiSearchAppDbContext.WikiSearches 
                .Include(w => w.Geonames)
                .Where(ws => ws.Q == q)                
                .FirstOrDefault();
        }

        private WikiSearch savecallback(WikiSearch wikiSearch)
        {
            m_wikiSearchAppDbContext.WikiSearches.Add(wikiSearch);
            m_wikiSearchAppDbContext.SaveChanges();

            return wikiSearch;
        }

        public WikiSearchRepository(WikiSearchAppDbContext wikiSearchAppDbContext)
        {            
            m_wikiSearchAppDbContext = wikiSearchAppDbContext;
        }

        public Task<WikiSearch> FindByQAsync(string q, int maxRows)
        {
            return Create(() => findByQCallback(q, maxRows));            
        }

        public Task<WikiSearch> SaveAsync(WikiSearch wikiSearch)
        {
            return Create(() => savecallback(wikiSearch));
        }

        public Task<bool> ExistsByQAsync(string q)
        {
            return Create(() => existsByQ(q));
        }
    }
}
