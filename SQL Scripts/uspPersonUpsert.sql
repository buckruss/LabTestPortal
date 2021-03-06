USE [LabTestPortal]
GO
/****** Object:  StoredProcedure [dbo].[uspPersonUpsert]    Script Date: 1/26/2019 4:29:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[uspPersonUpsert] 
	@id int =null,
	@first_name varchar(50) = null,
	@last_name varchar(50) = null,
	@state_id int,
	@gender char(1) = null,
	@dob datetime = null

AS
BEGIN
	SET NOCOUNT ON;

	If @id is null
		Insert into dbo.person (first_name, last_name, state_id,gender, dob) Values
				(@first_name, @last_name,@state_id,@gender,@dob)
	ELSE
		Update dbo.person set
			first_name = @first_name,
			last_name = @last_name,
			state_id=@state_id,
			gender = @gender,
			dob=@dob
		Where person_id = @id


	Select @ID = SCOPE_IDENTITY()
			
END
