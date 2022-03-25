/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıdaki tabloları oluştutunuz istenenleri yazınız
	- customers
		- id
		- citizen_id
		- name
		- surname
		- address
	- phones
		- id
		- customer_id
		- number
	phone_invoices
		- id
		- phone_id
		- invoice_date
		- paid_date
		- total
	Bu tablolara göre 
	- Fatura ödeme merkezinin faturaya ilişkin bilgiler ile müşteri bilgilerinin elde edildiği bir view yazınız. 
	Fatura ödenmişse bilgi elde edilmeyecektir. View'da gerekli gizlemeleri yapınız

	- Fatura ödenmemişse fatura ödeme merkezinin ödeme tamamlandığında view içerisinde update edebileceği bir 
	procedure yazınız

	TODO: Telefon numarasına göre müşterinin gizlenmiş ismi, fatura zamanı, fatura tutarı bilgilerini tablo
	biçiminde döndüren get_not_paid_invoices_by_number fonksiyonunu yazınız
----------------------------------------------------------------------------------------------------------------------*/

create database phoneinvoicesdb

go

use phoneinvoicesdb

go

create function hide_text(@text nvarchar(max), @ch char(1))
returns nvarchar(max)
as
begin
	declare @length int = LEN(@text)

	return LEFT(@text, 1) + REPLICATE(@ch, @length - 2) + RIGHT(@text, 1)
end


go

create table customers (
	customer_id int primary key identity(1, 1),
	citizen_id varchar(100) unique not null,
	name nvarchar(100) not null,
	surname nvarchar(100) not null,
	address nvarchar(max) not null
)

go


create table phones (
	phone_id int primary key identity(1, 1),
	customer_id int foreign key references customers(customer_id) not null,
	number char(14) not null
)

go

create table phone_invoices (
	phone_invoice_id int primary key identity(1, 1),
	phone_id int foreign key references phones(phone_id) not null,
	invoice_date date not null,
	paid_date date,
	total money not null
)

go


/*
	Fatura ödeme merkezinin faturaya ilişkin bilgiler ile müşteri bilgilerinin elde edildiği bir view yazınız. 
	Fatura ödenmişse bilgi elde edilmeyecektir. View'da gerekli gizlemeleri yapınız	
*/

create view not_paid_invoices 
as
select pi.phone_invoice_id, p.number,
dbo.hide_text(c.name, '*') + ' ' + dbo.hide_text(c.surname, '*') as fullname,
pi.total, pi.paid_date
from 
phone_invoices pi inner join phones p on pi.phone_id = p.phone_id
inner join customers c on c.customer_id = p.customer_id
where paid_date is null
with check option

go

create view paid_invoices 
as
select pi.phone_invoice_id, p.number,
dbo.hide_text(c.name, '*') + ' ' + dbo.hide_text(c.surname, '*') as fullname,
pi.total, pi.paid_date
from 
phone_invoices pi inner join phones p on pi.phone_id = p.phone_id
inner join customers c on c.customer_id = p.customer_id
where paid_date is not null
with check option

go

/*	
	Fatura ödenmemişse fatura ödeme merkezinin ödeme tamamlandığında view içerisinde update edebileceği bir 
	procedure yazınız
*/

create procedure sp_pay_invoice(@phone_invoice_id int)
as
begin
	declare @today date = GETDATE()

	update not_paid_invoices set paid_date = @today where phone_invoice_id = @phone_invoice_id
end

