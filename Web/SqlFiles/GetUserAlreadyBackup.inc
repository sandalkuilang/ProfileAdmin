SELECT DISTINCT(userProfile.NETWORK_ID) AS Value,
		Name AS Text
FROM USER_PROFILE userProfile
	INNER JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.NETWORKID 
			AND userBackup.ISACTIVE = 1 
			AND userProfile.ISACTIVE = 1
WHERE userProfile.APPLICATION = @Application