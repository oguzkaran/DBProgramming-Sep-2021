using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Entities;
using System.Threading.Tasks;
using static CSD.Data.DatabaseUtil;

namespace CSD.WikiSearchApp.Data.DAL
{
    public class WikiSearchAppDataHelper
    {
        private readonly IWikiSearchRepository m_wikiSearchRepository;

        public WikiSearchAppDataHelper(IWikiSearchRepository wikiSearchRepository)
        {
            m_wikiSearchRepository = wikiSearchRepository;
        }

        public Task<WikiSearch> FindWikiSearchByQAsync(string q, int maxRows)
        {
            return SubscribeRepositoryAsync(() => m_wikiSearchRepository.FindByQAsync(q, maxRows), "WikiSearchAppDataHelper.FindWikiSearchByQ");
        }

        public Task<WikiSearch> SaveWikiSearchAsync(WikiSearch wikiSearch)
        { 
            return SubscribeRepositoryAsync(() => m_wikiSearchRepository.SaveAsync(wikiSearch), "WikiSearchAppDataHelper.SaveWikiSearchAsync");
        }

        public Task<bool> ExistsByIdAsync(string q)
        {
            return SubscribeRepositoryAsync(() => m_wikiSearchRepository.ExistsByQAsync(q), "WikiSearchAppDataHelper.ExistsByIdAsync");
        }

        //...
    }
}
