DECLARE @@RoleId VARCHAR(10)

SELECT @@RoleId = ROLE_ID
FROM USER_ROLE 
WHERE NETWORK_ID = @NetworkId  

SELECT ISNULL(userBackup.NETWORKID, @NetworkId) FROM USER_PROFILE userProfile
LEFT JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.BACKUP_NETWORKID 
AND userBackup.ISACTIVE = 1
WHERE userProfile.ISACTIVE = 1  
	AND userProfile.NETWORK_ID = @NetworkId 
	AND userProfile.APPLICATION = @Application	