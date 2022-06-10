/*----------------------------------------------------------------------------------------------------------------------
    GameDb ve view'lar
----------------------------------------------------------------------------------------------------------------------*/

create database dbps21_gamedb;

create table players (
    player_id serial primary key,
    name varchar(256) not null,
    username varchar(256) unique not null,
    register_date timestamp default(current_timestamp) not null
);

create table operating_systems (
    operating_system_id serial primary key,
    description varchar(100) not null
);

insert into operating_systems (description)
values
('Windows'),
('Mac OS'),
('Linux'),
('Android'),
('IOS');

create table games (
    game_id serial primary key,
    name varchar(200) not null
);

create table game_to_operating_system (
    game_to_operating_system_id serial primary key,
    game_id int references games(game_id),
    operating_system_id int references operating_systems(operating_system_id)
);


create table scores (
    score_id bigserial primary key,
    game_id int references games(game_id),
    player_id int references players(player_id),
    datetime timestamp default(current_timestamp) not null,
    data real not null
);


create or replace view v_get_players_game
as
select
    g.name as game_name, p.name as player_name
from games g inner join scores s on g.game_id = s.game_id
inner join players p on s.player_id = p.player_id;


create or replace view v_get_players_game_pos_data
as
select
    g.name as game_name, p.name as player_name
from games g inner join scores s on g.game_id = s.game_id
inner join players p on s.player_id = p.player_id where s.data > 0
with check option;


create or replace view v_get_players_game_neg_data
as
select
    g.name as game_name, p.name as player_name
from games g inner join scores s on g.game_id = s.game_id
inner join players p on s.player_id = p.player_id where s.data <= 0
with check option;


select * from v_get_players_game;
