[getList]
SELECT * 
FROM user_organization

[getEtracsUser]
SELECT *
FROM sys_user
WHERE (username LIKE $P{searchtext} 
OR name LIKE $P{searchtext})
${filter} 
ORDER BY lastname

[getOrgById]
SELECT * FROM "references"."tblOrganizationUnit"
WHERE "OrgUnitId" = ${orgid} 

[findById]
SELECT * FROM user_organization WHERE objid = $P{objid}

[approve]
UPDATE user_organization SET state = 'APPROVED' WHERE objid = $P{objid}

[getUserByOrg]
SELECT * 
FROM user_organization
WHERE organizationid = $P{orgid}
