create database chesstournamentdb



create table rankings (
	ranking_code serial primary key,
	description text not null
);



create table clubs (
	club_id serial primary key,
	name varchar(100) not null,
	address text not null,
	details text
);



create table organizers (
	organizer_id serial primary key,
	club_id int references clubs(club_id) not null,
	name varchar(100) not null,
	details text
);



create table communications (
	communication_id serial primary key,
	name varchar(100) not null,
	surname varchar(100) not null,
	address text not null,
	phone char(14) not null
);



create table players (
	player_id serial primary key,
	club_id int references clubs(club_id) not null,
	ranking_code int references rankings(ranking_code) not null,
	communication_id int references communications(communication_id) not null,
	details text 
);



create table tournaments (
	tournament_id serial primary key,
	organizer_id int references organizers(organizer_id) not null,
	start_date date,
	end_date date,
	name varchar(100) not null,
	details text
);



create table player_participants (
	player_participant_id serial primary key,
	player_id int references players(player_id) not null,
	tournament_id int references tournaments(tournament_id),
	final_result int
);



create table sponsors (
	sponsor_id serial primary key,
	name varchar(100) not null,
	phone char(14) not null,
	details text
);



create table tournament_sponsors (
	tournament_sponsor_id serial primary key,
	tournament_id int references tournaments(tournament_id) not null,
	sponsor_id int references sponsors(sponsor_id) not null
);



create table results (
	result_id serial primary key,
	description text
);



create table matches (
	match_id serial primary key,
	player1_id int references players(player_id) not null,
	player2_id int references players(player_id) not null,
	result_id int references results(result_id) not null,
	start_datetime  timestamp not null,
	end_datetime  timestamp,
	constraint chk_players check(player1_id <> player2_id)
);



