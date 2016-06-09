SELECT [PIParameterId]
      ,[ParameterName]
      ,[Unit]
      ,[IsParent]
      ,[ParentId]
      ,[IsInput]
      ,[IsT9Check]
      ,[IsActive]
      ,[ModifiedBy]
      ,[ModifiedDate]
FROM [PIParameter]
WHERE (
		ISNULL(@ParameterName, '') = ''
		OR (
			ISNULL(@ParameterName, '') <> ''
			AND ParameterName = @ParameterName
			)
		)
	AND (
		ISNULL(@Unit, '') = ''
		OR (
			ISNULL(@Unit, '') <> ''
			AND Unit = @Unit
			)
		)