/*----------------------------------------------------------------------------------------------------------------------
	Bir xml içerisinden bilgiler ayrıştırılabilir. Aşağıdaki örnekte

	<book id="1" name="Cin Ali Lunaparkta">
		<chapters> 
			<chapter id="1" name="Hazırlanma"/>
			<chapter id="2" name="Evden çıkış"/>
			<chapter id="3" name="Lunaparka varış"/>
		</chapters>
	</book>

	XML datasından id ve name attribut'larına ilişkin değerler chapter_id ve chapter_name olarak
	ayrıştırılmış ve adeta tablo biçimine getirilmiştir
----------------------------------------------------------------------------------------------------------------------*/

create procedure sp_get_details_from_chapters(@book_id int)
as 
begin
	-- TODO: transaction ekleyiniz
	declare @xml_doc xml
	declare @h_doc int

	select @xml_doc= (select chapter_summary from books where book_id=@book_id)
	exec sp_xml_preparedocument @h_doc output, @xml_doc

	select chapter_id as 'ID', chapter_name as 'NAME' from openxml(@h_doc, '/book/chapters/chapter') 
	with (chapter_id int '@id', chapter_name nvarchar(100) '@name')

	exec sp_xml_removedocument @h_doc
end

go 

select * from books

exec sp_get_details_from_chapters @book_id=1
