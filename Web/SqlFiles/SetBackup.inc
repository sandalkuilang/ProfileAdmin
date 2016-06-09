DECLARE @@count INT 
SELECT @@count = ISNULL(MAX(BACKUP_ID), 0) + 1 FROM USER_BACKUP
	
INSERT INTO USER_BACKUP
SELECT @@count,
		@BackupFor,
		@AssignedBackup,
		1, --IsActive
		GETDATE(),
		@ModifiedBy