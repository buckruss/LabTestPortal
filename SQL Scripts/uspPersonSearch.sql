USE [LabTestPortal]
GO
/****** Object:  StoredProcedure [dbo].[uspPersonSearch]    Script Date: 1/26/2019 4:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[uspPersonSearch] 
	@id int = null,
	@first_name varchar(50) = null,
	@last_name varchar(50) = null,
	@state_id int = null,
	@gender char(1) = null,
	@dob datetime = null

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SQL nvarchar(4000)
	DECLARE @Where nvarchar(500)
	DECLARE @Params nvarchar(2000)

	SET @SQL = 'SELECT  [person_id],[first_name],[last_name],[state_code],[gender],[dob] FROM [LabTestPortal].[dbo].[person] inner join states on person.state_id = states.state_id'
	Set @Where = ' Where person_id IS NOT NULL'

	if @id is not null
		SET @Where = @Where + ' and (person_id = @id)'
	
	if @first_name is not null
		SET @Where = @Where + ' and (first_name LIKE @first_name + ''%'')'	 

	if @last_name is not null
		SET @Where = @Where + ' and (last_name LIKE @last_name + ''%'')'	 

	 if @state_id is not null
		SET @Where = @Where + ' and (person.state_id = @state_id)'

	 if @gender is not null
		SET @Where = @Where + ' and (gender = @gender)'

	 if @dob is not null
		SET @Where = @Where + ' and (dob = @dob)'

	
		
		 
    Set @SQL = @SQL + @Where
	
	SET @Params = '	@id int = null,
					@first_name varchar(50) = null,
					@last_name varchar(50) = null,
					@state_id int = null,
					@gender char(1) = null,
					@dob datetime = null'

	EXECUTE sp_Executesql @Sql,
							@Params,
							@id,
							@first_name,
							@last_name,
							@state_id,
							@gender,
							@dob

END
