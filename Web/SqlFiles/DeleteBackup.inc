﻿DELETE USER_BACKUP
WHERE NETWORKID = @BackupFor
	AND BACKUP_NETWORKID = @AssignedBackup