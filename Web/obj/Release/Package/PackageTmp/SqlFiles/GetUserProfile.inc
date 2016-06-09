
SELECT userProfile.[NETWORK_ID] AS NetworkId 
      ,[BADGE] 
      ,[CAI_ID] AS CAIId
      ,userProfile.[NAME] 
      ,masterRole.ID AS Role
      ,masterRole.NAME AS RoleAlias
      ,userProfile.DIRECT_REPORT AS DirectReport
      ,[EMAIL]
      ,[STATUS]
      ,(SELECT Value FROM CONFIG_TABLE WHERE PARAMETERNAME = 'Status' AND TYPEV = ISNULL([STATUS], 0)) StatusAlias
      ,[ISBACKUP]
      ,(SELECT Value FROM CONFIG_TABLE WHERE PARAMETERNAME = 'Status' AND TYPEV = ISNULL([ISBACKUP], 0)) AS IsBackUpAlias
      ,[COMPANY]
      ,company.CompanyName CompanyAlias
      ,company.OPG
      ,ISNULL([DIVISION], '') Division
      ,division.DivisionName DivisionAlias
      ,ISNULL([SUBDIVISION], '') SubDivision
      ,subDivision.SubDivName SubDivisionAlias
      ,[DEPARTMENT]
      ,department.DeptName DepartmentAlias
      ,[SUBDEPARTMENT]
      ,subDepartment.SubDeptName SubDepartmentAlias
      ,(SELECT NAME FROM USER_PROFILE WHERE NETWORK_ID = userBackup.BACKUP_NETWORKID AND APPLICATION = @Application) AS BackUpName
	  ,userBackup.BACKUP_NETWORKID BackUpId
      ,userProfile.[ISACTIVE]
      ,(SELECT Value FROM CONFIG_TABLE WHERE PARAMETERNAME = 'Status' AND TYPEV = ISNULL(userProfile.[ISACTIVE], 0)) AS IsActiveAlias
      ,userProfile.[MODIFIEDDATE]
      ,userProfile.[MODIFIEDBY]
FROM [USER_PROFILE] userProfile
	LEFT JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.NETWORKID AND userBackup.ISACTIVE = 1
	LEFT JOIN MVCTemplate_DIVISION division ON userProfile.DIVISION = division.DivisionCode
	LEFT JOIN MVCTemplate_SUBDIV subDivision ON userProfile.SUBDIVISION = subDivision.SubDivCode
	LEFT JOIN MVCTemplate_DEPT department ON userProfile.DEPARTMENT = department.DeptCode
	LEFT JOIN MVCTemplate_SUBDEPT subDepartment ON userProfile.SUBDEPARTMENT = subDepartment.SubDeptCode
	LEFT JOIN MVCTemplate_COMPANY company ON userProfile.OPG = company.[OPG] AND userProfile.COMPANY = company.CompanyCode	
	LEFT JOIN USER_ROLE userRole ON userProfile.NETWORK_ID = userRole.NETWORK_ID AND userProfile.APPLICATION = userRole.APPLICATION
	LEFT JOIN ROLE masterRole ON userRole.ROLE_ID = masterRole.ID AND userProfile.APPLICATION = masterRole.APPLICATION
WHERE (
		ISNULL(@CAI, '') = ''
		OR (
			ISNULL(@CAI, '') <> ''
			AND userProfile.CAI_ID = @CAI
			)
		)
	AND (
		ISNULL(@NetworkId, '') = ''
		OR (
			ISNULL(@NetworkId, '') <> ''
			AND userProfile.NETWORK_ID = @NetworkId
			)
		)
	AND (
		ISNULL(@Name, '') = ''
		OR (
			ISNULL(@Name, '') <> ''
			AND userProfile.NAME LIKE '%' + @Name + '%'
			)
		)
	AND (
		ISNULL(@Profile, '') = ''
		OR (
			ISNULL(@Profile, '') <> ''
			AND masterRole.ID = @Profile
			)
		) 
	AND userProfile.APPLICATION = @Application
	--AND userRole.APPLICATION = @Application
ORDER BY userProfile.[NAME] 