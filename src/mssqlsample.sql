/*----------------------------------------------------------------------------------------------------------------------
	Değişken bildirimi declare anahtar sözcüğü ile herhangi bir yerde yapılabilir. MSSQLServer'ın dili olan T-SQL'de 
	değişken isimlerinin başına bildirimde ve erişimde @ konur. Değişkenlere değerler bildirim noktasında ilkdeğerlenerek
	(initialization) veya herhangi bir noktada set anahtar sözcüğü ve = operatörü ile yapılabilir. Bildirimde değişken
	isimlerinden sonra tür bilgisi yazılır
----------------------------------------------------------------------------------------------------------------------*/
declare @a int = 10
declare @b int = 20
declare @c int

set @c = @a + @b

select @c