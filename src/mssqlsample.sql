/*----------------------------------------------------------------------------------------------------------------------
	Yukarıdaki örnek fonksiyon ile aşağıdaki gibi yapılabilir. Burada fonksiyon içerisinde yan etkisi olan başka
	bir fonksiyon çağrılamayacağı için v_get_random view'unun kullanıldığını anımsayınız
----------------------------------------------------------------------------------------------------------------------*/
create view v_get_random
as
select rand() as random

go


create function get_random_person_citizen_id()
returns char(11)
as
begin
	declare @bound int = (select count(*) from people) + 1
	declare @min int = 1
	declare @index int = (select random from v_get_random) * (@bound - @min) + @min -- [min, bound)

	declare crs_people cursor scroll for select citizen_id from people
	open crs_people	
	declare @citizen_id char(11) = ''
	
	fetch absolute @index from crs_people into @citizen_id	

	close crs_people
	deallocate crs_people

	return @citizen_id
end

go

declare @citizen_id char(11) = dbo.get_random_person_citizen_id()

select * from people where citizen_id = @citizen_id
-- ...


