USE [LabTestPortal]
GO

/****** Object:  Table [dbo].[person]    Script Date: 1/26/2019 4:31:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[person](
	[person_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[state_id] [int] NOT NULL,
	[gender] [char](1) NULL,
	[dob] [datetime] NULL,
 CONSTRAINT [PK_person] PRIMARY KEY CLUSTERED 
(
	[person_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[person]  WITH CHECK ADD  CONSTRAINT [FK_states_state_ID] FOREIGN KEY([state_id])
REFERENCES [dbo].[states] ([state_id])
GO

ALTER TABLE [dbo].[person] CHECK CONSTRAINT [FK_states_state_ID]
GO

