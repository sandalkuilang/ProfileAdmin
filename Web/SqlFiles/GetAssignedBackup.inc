﻿SELECT BACKUP_NETWORKID VALUE, pr.NAME TEXT
FROM USER_BACKUP b 
	INNER JOIN USER_PROFILE pr ON b.BACKUP_NETWORKID = pr.NETWORK_ID AND pr.APPLICATION = @Application
WHERE b.NETWORKID = @NetworkId
	AND b.ISACTIVE = 1