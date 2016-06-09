SELECT  role.ID RoleId,
		role.DESCRIPTION RoleAlias,
		menu.ID MenuId,
		menu.NAME,
		menu.DESCRIPTION,
		menu.URL,
		roleMenu.MODIFIED_BY ModifiedBy,
		roleMenu.MODIFIED_DATE ModifiedDate
FROM ROLE role
	INNER JOIN ROLE_MENU roleMenu ON roleMenu.ROLE_ID = role.ID AND role.APPLICATION = roleMenu.APPLICATION
	INNER JOIN MENU menu ON menu.ID = roleMenu.MENU_ID AND menu.APPLICATION = roleMenu.APPLICATION
WHERE (
		ISNULL(@RoleId, '') = ''
		OR (
			ISNULL(@RoleId, '') <> ''
			AND role.ID = @RoleId
			)
	) 
	AND role.APPLICATION = @Application
ORDER BY menu.ID