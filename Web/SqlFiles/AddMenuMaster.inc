DECLARE @@Id INT

SELECT @@Id = MAX(ID) + 1 FROM MENU

INSERT INTO MENU
SELECT @@Id,
		@Name, 
		@Description, 
		@Application,
		NULL,
		@ParentId,
		@Url,
		GETDATE(),
		@UpdateBy