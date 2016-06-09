SELECT userProfile.NETWORK_ID NetworkId,
		userRole.ROLE_ID, 
		masterRole.NAME RoleAlias,
		userBackup.BACKUP_NETWORKID,
		(SELECT NAME FROM USER_PROFILE WHERE NETWORK_ID = userBackup.BACKUP_NETWORKID) AS BackupAlias,
		userProfile.DIVISION,
		userProfile.DEPARTMENT
FROM USER_PROFILE userProfile
	INNER JOIN USER_ROLE userRole ON userRole.NETWORK_ID = userProfile.NETWORK_ID AND userProfile.APPLICATION = userRole.APPLICATION
	INNER JOIN USER_BACKUP userBackup ON userBackup.NETWORKID = userProfile.NETWORK_ID
	LEFT JOIN ROLE masterRole ON userRole.ROLE_ID = masterRole.ID
WHERE userProfile.NETWORK_ID = @NetworkId
	AND userProfile.APPLICATION = @Application