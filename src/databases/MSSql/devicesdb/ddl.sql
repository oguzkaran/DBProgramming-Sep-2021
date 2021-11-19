create database devicesdb

go

use devicesdb

go

create table devices (
   device_id int primary key identity(1, 1),
   name nvarchar(100) not null, 
   host varchar(15) not null,
   register_date date not null,
   is_active bit default(0) not null
);

create table ports (
    port_id bigint primary key identity(1, 1),
    device_id integer references devices(device_id) not null,
    num integer check(1023 < num and num < 65536) not null
);

