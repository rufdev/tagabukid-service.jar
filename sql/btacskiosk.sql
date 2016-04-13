[getOfficeList]
SELECT * FROM departments order by deptname

[getEmployeeList]
SELECT
dbo.USERINFO.USERID,
dbo.USERINFO.NAME,
dbo.USERINFO.TITLE,
dbo.USERINFO.DEFAULTDEPTID,
dbo.USERINFO.BADGENUMBER
FROM
dbo.USERINFO
WHERE dbo.USERINFO.DEFAULTDEPTID = $P{deptid}
ORDER BY
dbo.USERINFO.NAME ASC

[getSignatoryList]
SELECT *,NAME + ':' + [POSITION] AS x FROM Signatory ORDER BY NAME