#nullable disable

namespace CSD.WikiSearchApp.Data.Repositories.Entities
{
    public partial class Geoname
    {
        public long Id { get; set; }
        public int? WikiSearchId { get; set; }
        public string Summary { get; set; }
        public int? Elevation { get; set; }
        public int? GeoNameId { get; set; }
        public string Feature { get; set; }
        public float? Lng { get; set; }
        public string CountryCode { get; set; }
        public int? Rank { get; set; }
        public string ThumbnailImg { get; set; }
        public string Lang { get; set; }
        public string Title { get; set; }
        public float? Lat { get; set; }
        public string WikipediaUrl { get; set; }

        public virtual WikiSearch WikiSearch { get; set; }
    }
}
