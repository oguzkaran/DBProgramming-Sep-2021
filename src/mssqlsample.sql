/*----------------------------------------------------------------------------------------------------------------------
	Sınıf Çalışması: Aşağıda belirtilen tablolara göre soruları yanıtlayınız:

	- sensors
		sensor_id
		name
		host
		port
	- sensor_data
		sensor_data_id
		sensor_id
		data
		read_date_time
		
	- Parametresi ile aldığı name, host, port ve data bilgilerine göre sensor'ü ve sensor'ün verisini ekleyen procedure'ü
	yazınız

	- Paremetresi ile aldığı sensor_id, data ve okuma zamanı bilgisine göre sensor verisini ekleyen procedure'ü yazınız
----------------------------------------------------------------------------------------------------------------------*/
create table sensors (
	sensor_id int primary key identity(1, 1),
	name nvarchar(100) not null,
	host char(15) not null,
	port int check(1023 < port and port < 65536) not null
)

go

create table sensor_data (
	sensor_data_id bigint primary key identity(1, 1),
	sensor_id int foreign key references sensors(sensor_id) not null,
	data real not null,
	read_date_time datetime
)

go

create procedure sp_insert_sensor_with_port(@name nvarchar(100), @host char(15), @port int, @data real)
as
begin
	-- ileride transaction eklenecek
	insert into sensors (name, host, port) values (@name, @host, @port)
	declare @sensor_id int = @@IDENTITY

	insert into sensor_data (sensor_id, data, read_date_time) values (@sensor_id, @data, SYSDATETIME())
end

go

exec sp_insert_sensor_with_port 'Test sensor', '134.67.90.286', 34000, 123

select * from sensor_data

go 

create procedure sp_insert_sensor_data(@sensor_id int, @data real, @read_date_time datetime)
as
begin
	insert into sensor_data (sensor_id, data, read_date_time) values (@sensor_id, @data, @read_date_time)
end


exec sp_insert_sensor_data 1, 56, '2021-08-08 12:34:59'

 
