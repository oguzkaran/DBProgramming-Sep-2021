create table devices (
   device_id serial primary key,
   name varchar(100) not null, --character varying
   host varchar(15) not null, --character varying
   register_date date not null,
   is_active boolean default(false) not null
);

create table ports (
    port_id bigserial primary key,
    device_id integer references devices(device_id) not null,
    num integer check(1023 < num and num < 65536) not null
);

