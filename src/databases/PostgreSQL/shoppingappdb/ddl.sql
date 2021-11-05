/*----------------------------------------------------------------------------------------------------------------------
    shoppingappdb
----------------------------------------------------------------------------------------------------------------------*/

create database shoppingappdb;

create table customers (
    customer_id serial primary key,
    citizen_number char(11) check (length(citizen_number) = 11) unique not null,
    first_name varchar(100) not null,
    middle_name varchar(100),
    family_name varchar(100) not null,
    phone char(14) not null
);

create table vendors (
    vendor_id serial primary key,
    title varchar(100) unique not null,
    description varchar(250)
);

create table products (
    product_code char(7) primary key,
    vendor_id int references vendors(vendor_id),
    name varchar(100) not null,
    stock int not null,
    cost money not null,
    unit_price money not null
);

create or replace function insert_customer(char(11), varchar(100), varchar(100), varchar(100), char(14))
returns void as $$
    begin
        -- ...
        insert into customers (citizen_number, first_name, middle_name, family_name, phone) values ($1, $2, $3, $4, $5);
    end;
$$ language plpgsql;

do $$
    begin
        raise notice '%', insert_customer('12345678912', 'Siemens', 'Siemens', 'Siemens', '+901233456789');
    end
$$;

-- Ürünün stoktaki miktarını güncelleyen fonksiyonlar
create or replace function decrement_product_stock(char(7), int)
returns void as $$
    begin
        update products set stock = stock - $2 where product_code = $1;
    end;
$$ language plpgsql;

create or replace function increment_product_stock(char(7), int)
returns void as $$
    begin
        update products set stock = stock + $2 where product_code = $1;
    end;
$$ language plpgsql;

create or replace function update_product_stock(char(7), int)
returns void as $$
    begin
        update products set stock = $2 where product_code = $1;
    end;
$$ language plpgsql;

create or replace function update_product_cost(char(7), money)
returns void as $$
    begin
        update products set cost = $2 where product_code = $1;
    end;
$$ language plpgsql;

create or replace function update_product_unit_price(char(7), money)
returns void as $$
    begin
        update products set unit_price = $2 where product_code = $1;
    end;
$$ language plpgsql;