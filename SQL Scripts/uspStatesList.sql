USE [LabTestPortal]
GO
/****** Object:  StoredProcedure [dbo].[uspStatesList]    Script Date: 1/26/2019 4:29:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[uspStatesList] 
	
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT state_id, state_code FROM states 
END
