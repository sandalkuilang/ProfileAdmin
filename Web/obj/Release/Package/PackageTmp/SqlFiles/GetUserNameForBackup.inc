SELECT Value, Text
FROM 
	(
	SELECT DISTINCT(userProfile.NETWORK_ID) AS Value,
		Name AS Text
	FROM USER_PROFILE userProfile
		INNER JOIN USER_ROLE role ON userProfile.NETWORK_ID = role.NETWORK_ID 
			AND userProfile.APPLICATiON = role.APPLICATION
			AND userProfile.ISACTIVE = 1 
			AND userProfile.ISBACKUP = 1
	WHERE role.ROLE_ID <> 90	
		AND userProfile.APPLICATiON = @Application
	EXCEPT
	SELECT DISTINCT(userProfile.NETWORK_ID) AS Value,
		Name AS Text
	FROM USER_PROFILE userProfile
		INNER JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.BACKUP_NETWORKID 
				AND userProfile.NETWORK_ID = userBackup.BACKUP_NETWORKID
				AND userBackup.ISACTIVE = 1 
				AND userProfile.ISACTIVE = 1
				AND userProfile.ISBACKUP = 1
	WHERE userProfile.APPLICATiON = @Application 
	) X
ORDER BY TEXT	