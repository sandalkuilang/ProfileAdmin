SELECT CONFIGID,
		PARAMETERNAME,
		TYPEV Type,
		VALUE,
		ADDITIONAL_VALUE AdditionalValue
FROM CONFIG_TABLE 
WHERE (
		(
		ISNULL(@ParameterName, '') = ''
		OR (
			ISNULL(@ParameterName, '') <> ''
			AND PARAMETERNAME = @ParameterName
			)
		)
	)
ORDER BY PARAMETERNAME