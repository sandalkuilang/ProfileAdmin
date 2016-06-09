/*SELECT Value, Text
FROM 
	(
	SELECT DISTINCT(userProfile.NAME) AS Value,
		Name AS Text
	FROM USER_PROFILE userProfile
		INNER JOIN USER_ROLE role ON userProfile.NETWORK_ID = role.NETWORK_ID 
			AND userProfile.ISACTIVE = 1  
			AND userProfile.APPLICATiON = role.APPLICATION 
	WHERE role.ROLE_ID <> 90
		AND userProfile.APPLICATiON = @Application	
	EXCEPT
	SELECT DISTINCT(userProfile.NAME) AS Value,
		Name AS Text
	FROM USER_PROFILE userProfile
		INNER JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.NETWORKID 
				AND userBackup.ISACTIVE = 1 
				AND userProfile.ISACTIVE = 1 
	WHERE userProfile.APPLICATiON = @Application
	) X
ORDER BY TEXT*/
SELECT DISTINCT(userProfile.NAME) AS Value,
	userProfile.Name AS Text
FROM [USER_PROFILE] userProfile
	LEFT JOIN USER_BACKUP userBackup ON userProfile.NETWORK_ID = userBackup.NETWORKID AND userBackup.ISACTIVE = 1
	LEFT JOIN MVCTemplate_DIVISION division ON userProfile.DIVISION = division.DivisionCode
	LEFT JOIN MVCTemplate_SUBDIV subDivision ON userProfile.SUBDIVISION = subDivision.SubDivCode
	LEFT JOIN MVCTemplate_DEPT department ON userProfile.DEPARTMENT = department.DeptCode
	LEFT JOIN MVCTemplate_SUBDEPT subDepartment ON userProfile.SUBDEPARTMENT = subDepartment.SubDeptCode
	LEFT JOIN MVCTemplate_COMPANY company ON userProfile.OPG = company.[OPG] AND userProfile.COMPANY = company.CompanyCode	
	LEFT JOIN USER_ROLE userRole ON userProfile.NETWORK_ID = userRole.NETWORK_ID AND userProfile.APPLICATION = userRole.APPLICATION
	LEFT JOIN ROLE masterRole ON userRole.ROLE_ID = masterRole.ID AND userProfile.APPLICATION = masterRole.APPLICATION
WHERE  
	userProfile.APPLICATION = 100 
ORDER BY userProfile.[NAME] 

SELECT DISTINCT(userProfile.NAME) AS Value,
	Name AS Text
FROM USER_PROFILE userProfile
	INNER JOIN USER_ROLE role ON userProfile.NETWORK_ID = role.NETWORK_ID 
		AND userProfile.ISACTIVE = 1  
		AND userProfile.APPLICATiON = role.APPLICATION 
WHERE role.ROLE_ID <> 90
	AND userProfile.APPLICATiON = 100