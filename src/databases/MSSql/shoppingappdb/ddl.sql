/*----------------------------------------------------------------------------------------------------------------------
    shoppingappdb
----------------------------------------------------------------------------------------------------------------------*/

create database shoppingappdb

go

use shoppingappdb

go

create table customers (
    customer_id int primary key identity(1, 1),
    citizen_number char(11) check (len(citizen_number) = 11) unique not null,
    first_name nvarchar(100) not null,
    middle_name nvarchar(100),
    family_name nvarchar(100) not null,
    phone char(14) not null
)

go

create table vendors (
    vendor_id int primary key identity(1, 1),
    title nvarchar(100) unique not null,
    description nvarchar(250)
)

go

create table products (
    product_code char(7) primary key,
    vendor_id int references vendors(vendor_id),
    name nvarchar(100) not null,
    stock int not null,
    cost money not null,
    unit_price money not null
)

go


-- insert_customer

-- Ürünün stoktaki miktarını güncelleyen fonksiyonlar
-- decrement_product_stock

-- increment_product_stock


-- update_product_stock

-- update_product_cost

-- update_product_unit_price
