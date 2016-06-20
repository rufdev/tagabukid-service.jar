[closePrevTask]
UPDATE document_task dt
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
SET dt.enddate = $P{enddate}
WHERE dt.refid = $P{refid} AND dt.enddate IS NULL ${filter}

[getTaskListByRef2]
SELECT dt.*,dto.*
FROM ${taskTablename} dt
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
WHERE dt.refid=$P{refid} 
ORDER BY dt.startdate

[getTaskListByRef]
SELECT xx.*, dto.* 
FROM (SELECT dtp.*
FROM document_task dt, document_task dtp
WHERE dt.lft BETWEEN dtp.lft AND dtp.rgt
AND dt.objid = $P{taskid} 
AND dtp.refid = $P{refid} 
ORDER BY dtp.lft)xx
INNER JOIN document_task_org dto ON dto.`taskid` = xx.`objid`;

[attachChildTask]
UPDATE document_task 
SET enddate = $P{enddate},
state = $P{state},
message = $P{message},
parentprocessid = $P{parentprocessid}
WHERE refid = $P{refid} AND enddate IS NULL AND state = 'processing'

[findPrevTask]
SELECT * FROM document_task dt
INNER JOIN document_task_org dto ON dto.`taskid` = dt.`objid`
WHERE dt.refid = $P{refid} AND dt.enddate IS NULL ${filter}

[changeRight]
UPDATE document_task SET rgt = rgt + 2 WHERE rgt > $P{myleft} AND refid = $P{refid}

[changeLeft]
UPDATE document_task SET lft = lft + 2 WHERE lft > $P{myleft} AND refid = $P{refid}