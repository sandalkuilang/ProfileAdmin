DECLARE @@DirectReportBadge VARCHAR(10)

SELECT chare.hr.GET_AB_NBR(emp_id) formattedBadge, *
INTO #temp 
FROM chare.hr.V_IBU_CB_PERSON_CPI 
 
SELECT @@DirectReportBadge = chare.AN8 
FROM chare.hr.V_CHARE_LOOKUP_TABLE_MARS chare 
	LEFT JOIN #temp cpi ON cpi.formattedBadge = chare.AN8
WHERE chare.network_id IS NOT NULL AND chare.NETWORK_ID = @DirectReport
  
DROP TABLE #temp
 
DELETE FROM USER_PROFILE
WHERE NETWORK_ID = @NetworkId
	AND Application = @Application

DELETE FROM USER_ROLE
WHERE NETWORK_ID = @NetworkId
	AND APPLICATION = @Application 

INSERT INTO USER_PROFILE
SELECT @NetworkId
	,@Application
	,@Badge
	, @@DirectReportBadge
	,@CAI
	,@Name
	,@Email
	,1 Status
	,1 IsBackUp
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
	@MVCTemplateProfile,
	@AuthorizedUser,
	GETDATE()

SELECT 1