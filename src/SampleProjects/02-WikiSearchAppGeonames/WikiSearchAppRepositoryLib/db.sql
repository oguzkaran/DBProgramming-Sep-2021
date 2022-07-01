create database DCJSWPA21_WikiSearchAppDb

go

use DCJSWPA21_WikiSearchAppDb

go 

create table WikiSearch (
	Id int primary key identity(1, 1),
	Q varchar(250) unique not null,	
	SearchTime datetime default(sysdatetime()) not null
)

go

create table Geoname (
	Id bigint primary key identity(1, 1),
	WikiSearchId int references WikiSearch(Id),
	Summary varchar(max),
	Elevation int,
	GeoNameId int,
	Feature varchar(500),
	Lng real,
	CountryCode varchar(250),
	Rank int,
	ThumbnailImg varchar(max),
	Lang varchar(32),
	Title varchar(100),
	Lat real,
	WikipediaUrl varchar(max)
)



