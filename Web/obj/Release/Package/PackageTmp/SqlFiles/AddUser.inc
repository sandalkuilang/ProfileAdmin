SELECT chare.hr.GET_AB_NBR(emp_id) formattedBadge, *
INTO #temp 
FROM chare.hr.V_IBU_CB_PERSON_CPI 

DELETE USER_PROFILE
WHERE NETWORK_ID = @NetworkId
	AND APPLICATION = @Application

DELETE USER_ROLE
WHERE NETWORK_ID = @NetworkId
	AND APPLICATION = @Application

IF EXISTS(SELECT 1 FROM chare.hr.V_CHARE_LOOKUP_TABLE_MARS chare 
	LEFT JOIN #temp cpi ON cpi.formattedBadge = chare.AN8
WHERE cpi.network_id IS NOT NULL
	AND cpi.network_id = @NetworkId)
BEGIN  
	INSERT INTO USER_PROFILE  
	SELECT chare.NETWORK_ID
		,@Application
		,cpi.formattedBadge Badge 
		,chare.hr.GET_AB_NBR(DIRECT_REPORT_BADGE) DirectReport
		,cpi.cai
		,chare.full_name
		,chare.EMAIL
		,1 Status
		,1 ISBACKUP
		,chare.CCN
		,chare.OPG
		,NULL Division
		,NULL SUBDIVISION
		,NULL DEPARTMENT
		,NULL SUBDEPARTMENT
		,1 ISACTIVE
		,GETDATE() ModifiedDate
		,'System' ModifiedBy
	FROM chare.hr.V_CHARE_LOOKUP_TABLE_MARS chare 
		LEFT JOIN #temp cpi ON cpi.formattedBadge = chare.AN8
	WHERE chare.network_id IS NOT NULL AND chare.NETWORK_ID = @NetworkId
	
	INSERT INTO USER_ROLE
	SELECT @NetworkId
		,@Application
		,@RoleId
		,@AuthorizedUser
		,GETDATE()	

	SELECT 1
END
ELSE
BEGIN 
	INSERT INTO USER_PROFILE
	SELECT @NetworkId
		,@Application
		,@Badge
		,@DirectReportBadge
		,@CAI
		,@Name
		,@Email
		,1
		,@IsBackUp
		,NULL Company
		,NULL OPG
		,NULL Division
		,NULL SubDivision
		,NULL Department
		,NULL SubDepartment
		,1 IsActive
		,GETDATE() ModifiedDate
		,@AuthorizedUser ModifiedBy 

	INSERT INTO USER_ROLE
	SELECT @NetworkId,
		@Application,
		@RoleId,
		@AuthorizedUser,
		GETDATE() 
END	
  
DROP TABLE #temp