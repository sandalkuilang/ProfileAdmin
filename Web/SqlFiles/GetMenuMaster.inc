SELECT ID,
	NAME, 
	DESCRIPTION, 
	REMARK,
	PARENT_ID ParentId,
	URL,
	LASTUPDATE,
	UPDATEBY
FROM MENU
WHERE (
		(
		ISNULL(@Name, '') = ''
		OR (
			ISNULL(@Name, '') <> ''
			AND NAME = @Name
			)
		)
	)
	AND 
	(
		(
		ISNULL(@Description, '') = ''
		OR (
			ISNULL(@Description, '') <> ''
			AND DESCRIPTION LIKE '%' + @Description + '%'
			)
		)
	)
	AND APPLICATION = @Application
ORDER BY ID