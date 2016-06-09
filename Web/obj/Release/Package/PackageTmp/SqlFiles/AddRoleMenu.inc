INSERT INTO ROLE_MENU
SELECT @RoleId,
		@MenuId,
		@Application,
		@ModifiedBy,
		GETDATE()