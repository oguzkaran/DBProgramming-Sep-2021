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
		data real
		read_date_time
		
	- Parametresi ile aldığı name, host, port ve data bilgilerine göre sensor'ü ve sensor'ün verisini ekleyen procedure'ü
	yazınız

	- Paremetresi ile aldığı sensor_id, data ve okuma zamanı bilgisine göre sensor verisini ekleyen procedure'ü yazınız
----------------------------------------------------------------------------------------------------------------------*/


insert into devices (ip_address, name) values ('192.168.1.223', 'test')

select @@IDENTITY

select * from devices