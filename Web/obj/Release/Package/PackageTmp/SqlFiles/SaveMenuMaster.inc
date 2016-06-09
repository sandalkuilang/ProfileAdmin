UPDATE MENU
SET NAME = ISNULL(@Name, ''),
	DESCRIPTION = ISNULL(@Description, ''), 
	APPLICATION = @Application,
	PARENT_ID = @ParentId,
	URL = ISNULL(@Url, ''),
	LASTUPDATE = GETDATE(),
	UPDATEBY = @UpdateBy
WHERE ID = @Id	