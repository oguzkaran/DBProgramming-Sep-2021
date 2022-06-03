create database chesstournamentdb

go

use chesstournamentdb

go

create table rankings (
	ranking_code int primary key,
	description nvarchar(max) not null
)

go

create table clubs (
	club_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	address nvarchar(max) not null,
	details nvarchar(max)
)

go

create table organizers (
	organizer_id int primary key identity(1, 1),
	club_id int foreign key references clubs(club_id) not null,
	name nvarchar(100) not null,
	details nvarchar(max)
)

go

create table communications (
	communication_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	surname nvarchar(100) not null,
	address nvarchar(max) not null,
	phone char(14) not null
)

go

create table players (
	player_id int primary key identity(1, 1),
	club_id int foreign key references clubs(club_id) not null,
	ranking_code int foreign key references rankings(ranking_code) not null,
	communication_id int foreign key references communications(communication_id) not null,
	details nvarchar(max)
)

go

create table tournaments (
	tournament_id int primary key identity(1, 1),
	organizer_id int foreign key references organizers(organizer_id) not null,
	start_date date,
	end_date date,
	name nvarchar(100) not null,
	details nvarchar(max)
)

go

create table player_participants (
	player_participant_id int primary key identity(1, 1),
	player_id int foreign key references players(player_id) not null,
	tournament_id int foreign key references tournaments(tournament_id),
	final_result int
)

go

create table sponsors (
	sponsor_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	phone char(14) not null,
	details nvarchar(max)
)

go

create table tournament_sponsors (
	tournament_sponsor_id int primary key identity(1, 1),
	tournament_id int foreign key references tournaments(tournament_id) not null,
	sponsor_id int foreign key references sponsors(sponsor_id) not null
)

go

create table results (
	result_id int primary key identity(1, 1),
	description nvarchar(max)
)

go



go

create table matches (
	match_id int primary key identity(1, 1),
	player1_id int foreign key references players(player_id) not null,
	player2_id int foreign key references players(player_id) not null,
	result_id int foreign key references results(result_id) not null,
	start_datetime datetime not null,
	end_datetime datetime,
	constraint chk_players check(player1_id <> player2_id)
)






