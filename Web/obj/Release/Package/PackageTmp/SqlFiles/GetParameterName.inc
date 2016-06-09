SELECT * FROM 
(
	SELECT '' AS VALUE,
				'Any Value' AS TEXT
	UNION ALL
	SELECT PIParameterId Value, 
			ParameterName Text
	FROM PIParameter
	WHERE (
			ISNULL(@ParameterName, '') = ''
			OR (
				ISNULL(@ParameterName, '') <> ''
				AND ParameterName = @ParameterName
				)
			)
)
ORDER BY PIParameter