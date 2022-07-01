using System.Collections.Generic;

namespace CSD.WikiSearchApp.Geonames
{
    public class WikiSearchInfo
    {
        public IList<Geoname> Geonames { get; set; }
    }

    public class Geoname
    {
        public string Summary { get; set; }
        public int Elevation { get; set; }
        public int GeoNameId { get; set; }
        public string Feature { get; set; }
        public double Lng { get; set; }
        public string CountryCode { get; set; }
        public int Rank { get; set; }
        public string ThumbnailImg { get; set; }
        public string Lang { get; set; }
        public string Title { get; set; }
        public double Lat { get; set; }
        public string WikipediaUrl { get; set; }
    }
}

