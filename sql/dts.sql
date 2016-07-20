[getListForVerification]
SELECT objid,docstate,title,description,tags,author
FROM document 
WHERE title LIKE $P{title}
ORDER BY title

[getDocumentbyDIN]
SELECT d.objid,
d.docstate,
d.din,
d.parentid,
d.documenttypeid,
d.title,
d.description,
d.tags,
d.author,
d.recordlog_datecreated,
d.recordlog_createdbyuserid,
d.recordlog_createdbyuser,
d.recordlog_dateoflastupdate,
d.recordlog_lastupdatedbyuserid,
d.recordlog_lastupdatedbyuser,
dt.objid AS taskid,
dt.refid,
dt.parentprocessid,
dt.state,
dt.startdate,
dt.assignee_objid,
dt.assignee_name,
dt.assignee_title,
dt.enddate,
dt.actor_objid,
dt.actor_name,
dt.actor_title,
dt.signature,
dt.lft,
dt.rgt,
dto.orgid,
dto.macaddress,
dto.name,
dto.address
FROM document d
INNER JOIN document_task dt ON dt.`refid` = d.`objid`
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
WHERE ${filter}
ORDER BY d.title

[getEtracsUser]
SELECT * FROM sys_user
WHERE name LIKE $P{searchtext} 
ORDER BY lastname

[getHrisOrg]
SELECT * FROM "references"."tblOrganizationUnit"
WHERE UPPER("Entity_Name") LIKE $P{searchtext} 
OR UPPER("Entity_AcronymAbbreviation") LIKE $P{searchtext} 
ORDER BY "Entity_Name"

[getList]
SELECT d.objid,
d.docstate,
d.din,
d.parentid,
d.documenttypeid,
d.title,
d.description,
d.tags,
d.author,
d.recordlog_datecreated,
d.recordlog_createdbyuserid,
d.recordlog_createdbyuser,
d.recordlog_dateoflastupdate,
d.recordlog_lastupdatedbyuserid,
d.recordlog_lastupdatedbyuser,
dt.objid AS taskid,
dt.refid,
dt.parentprocessid,
dt.state,
dt.startdate,
dt.assignee_objid,
dt.assignee_name,
dt.assignee_title,
dt.enddate,
dt.actor_objid,
dt.actor_name,
dt.actor_title,
dt.message,
dt.signature,
dt.lft,
dt.rgt,
dto.orgid,
dto.macaddress,
dto.name,
dto.address,
dtyp.code AS documenttype_code,
dtyp.name AS documenttype_name,
dtyp.description AS documenttype_description,
dtyp.haschild AS documenttype_haschild
FROM document d
INNER JOIN document_task dt ON dt.`refid` = d.`objid`
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
INNER JOIN document_type dtyp ON dtyp.`objid` = d.`documenttypeid`
WHERE (d.din LIKE $P{searchtext}
OR d.title LIKE $P{searchtext}
OR d.description LIKE $P{searchtext}
OR d.tags LIKE $P{searchtext})
${filter}
ORDER BY d.title, dt.startdate

[findDocumentbyBarcode]
SELECT d.objid,
d.docstate,
d.din,
d.parentid,
d.documenttypeid,
d.title,
d.description,
d.tags,
d.author,
d.recordlog_datecreated,
d.recordlog_createdbyuserid,
d.recordlog_createdbyuser,
d.recordlog_dateoflastupdate,
d.recordlog_lastupdatedbyuserid,
d.recordlog_lastupdatedbyuser,
dt.objid AS taskid,
dt.refid,
dt.parentprocessid,
dt.state,
dt.startdate,
dt.assignee_objid,
dt.assignee_name,
dt.assignee_title,
dt.enddate,
dt.actor_objid,
dt.actor_name,
dt.actor_title,
dt.message,
dt.signature,
dt.lft,
dt.rgt,
dto.orgid,
dto.macaddress,
dto.name,
dto.address,
dtyp.code AS documenttype_code,
dtyp.name AS documenttype_name,
dtyp.description AS documenttype_description,
dtyp.haschild AS documenttype_haschild
FROM document d
INNER JOIN document_task dt ON dt.`refid` = d.`objid`
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
INNER JOIN document_type dtyp ON dtyp.`objid` = d.`documenttypeid`
WHERE ${filter}
AND (dt.enddate IS NULL OR dt.state IN ('archive','attached'))
ORDER BY d.title

[getDocumentbyBarcode]
SELECT d.objid,
d.docstate,
d.din,
d.parentid,
d.documenttypeid,
d.title,
d.description,
d.tags,
d.author,
d.recordlog_datecreated,
d.recordlog_createdbyuserid,
d.recordlog_createdbyuser,
d.recordlog_dateoflastupdate,
d.recordlog_lastupdatedbyuserid,
d.recordlog_lastupdatedbyuser,
dt.objid AS taskid,
dt.refid,
dt.parentprocessid,
dt.state,
dt.startdate,
dt.assignee_objid,
dt.assignee_name,
dt.assignee_title,
dt.enddate,
dt.actor_objid,
dt.actor_name,
dt.actor_title,
dt.message,
dt.signature,
dt.lft,
dt.rgt,
dto.orgid,
dto.macaddress,
dto.name,
dto.address,
dtyp.code AS documenttype_code,
dtyp.name AS documenttype_name,
dtyp.description AS documenttype_description,
dtyp.haschild AS documenttype_haschild
FROM document d
INNER JOIN document_task dt ON dt.`refid` = d.`objid`
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
INNER JOIN document_type dtyp ON dtyp.`objid` = d.`documenttypeid`
WHERE ${filter}
AND (dt.enddate IS NULL OR dt.state IN ('archive','attached'))
ORDER BY d.title, dt.startdate

[updateparent]
UPDATE document SET parentid = $P{parentid} WHERE objid = $P{objid}

[getChild]
SELECT * FROM document WHERE parentid = $P{objid}

[findDocumentInv]
SELECT * FROM din_inventory 
WHERE prefix = $P{prefix} 
AND $P{sequence} BETWEEN startseries AND endseries
AND orgid = $P{orgid}

