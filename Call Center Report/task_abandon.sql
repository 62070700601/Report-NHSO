CREATE DEFINER=`dev`@`%` PROCEDURE `task_abandon`()
BEGIN
WITH
	all_incoming(uuid,caller_id_number,module_name,digits,created_at,module_id,rank_no,new_digits)
    AS (
    	SELECT uuid,
	caller_id_number,
	module_name,
	digits,
	created_at,
	module_id,
	rank_no,
	new_digits
	from (
	SELECT 
	uuid,
	module_name,
	caller_id_number,
	digits,
	CASE 
	WHEN module_name='Menu 3' and digits !='0' THEN ''
	WHEN module_name='Transfer to OTO pid' THEN ''
	WHEN module_name='Transfer to agent pid' THEN ''
    WHEN module_name='Transfer to District' THEN ''
	else digits
	END as new_digits,
	created_at,
	updated_at,
	module_id,
	row_number() over (partition by uuid order by created_at DESC) as rank_no
	FROM callcenter.ivr_journeys
    where date(created_at) between '2021-05-07' and '2021-05-07'
	order by created_at, rank_no) as rank_num
	where rank_no=1
	order by uuid, rank_no
    ),
    	all_incoming2(uuid2,caller_id_number2,module_name2,digits2,created_at2,module_id2,rank_no2,new_digits2)
    AS (
    	SELECT uuid,
	caller_id_number,
	module_name,
	digits,
	created_at,
	module_id,
	rank_no,
	new_digits
	from (
	SELECT 
	uuid,
	module_name,
	caller_id_number,
	digits,
	CASE 
	WHEN module_name='Menu 3' and digits !='0' THEN ''
	WHEN module_name='Transfer to OTO pid' THEN ''
	WHEN module_name='Transfer to agent pid' THEN ''
    WHEN module_name='Transfer to District' THEN ''
	else digits
	END as new_digits,
	created_at,
	updated_at,
	module_id,
	row_number() over (partition by uuid order by created_at) as rank_no
	FROM callcenter.ivr_journeys
    where date(created_at) between '2021-05-07' and '2021-05-07'
	order by created_at, rank_no) as rank_num
	where rank_no=1
	order by uuid, rank_no
    ),
    incoming(uuid,module_name,digits,created_at,module_id,rank_no,new_digits)
    AS(
	SELECT uuid,
	module_name,
	digits,
	created_at,
	module_id,
	rank_no,
	new_digits
	from (
	SELECT 
	uuid,
	module_name,
	caller_id_number,
	digits,
	CASE 
	WHEN module_name='Menu 3' and digits !='0' THEN ''
	WHEN module_name='Transfer to OTO pid' THEN ''
	WHEN module_name='Transfer to agent pid' THEN ''
    WHEN module_name='Transfer to District' THEN ''
	else digits
	END as new_digits,
	created_at,
	updated_at,
	module_id,
	row_number() over (partition by uuid order by created_at DESC) as rank_no
	FROM callcenter.ivr_journeys
	where module_name IN ('Main_Menu','Menu 1','Menu 1-1','Menu 1-1-1','Menu 1-1-2','Menu 1-1-2-1','Menu 1-1-2-2','Menu 1-1','Menu 1-1-3','Menu 1-1-4','Menu 1',
	'Menu 1-2','Menu 1-2-1','Menu 1-2-2','Menu 1-2-2-1','Menu 1-2-2-2','Menu 1-2-2-3','Menu 1-2-2-4','Menu 1-2-2-5','Menu 1-2-2-6','Menu 1-2-2-7','Menu 1-2-2-8','Menu 1-2-2-9','Menu 1-2-2-10',
	'Menu 1-2-3','Menu 1-3','Short_Menu','Transfer to agent pid','Transfer to OTO pid','Menu 3','Menu 5','Transfer to District')
	and digits !='*'
	order by created_at, rank_no) as rank_num
	where rank_no=1
	and date(created_at) between '2021-05-07' and '2021-05-07'
	order by uuid, rank_no
    ),
    all_list(module_id, id, name,digit,des)
    AS (
	select module_id, id, name, digit,
        CONCAT(menu_number,' ',description) AS des
	from `ivr-module-details`
	order by id+0
    ),
    IVR_detail(daily,uuid,caller_id_number,start_time,end_time,duration,des,id,new_des)
    AS(
    select 
    date(abc.start_time) as daily,
	abc.uuid,
    abc.caller_id_number,
    abc.start_time,
    abc.end_time,
    abc.duration,
    all_list.des,
    all_list.id,
    CASE 
    WHEN all_list.des is null THEN 'อื่นๆ'
    ELSE all_list.des
    END as new_des
    from(
    select 
    all_incoming.uuid,
    all_incoming.caller_id_number,
    all_incoming2.created_at2 as start_time,
    all_incoming.created_at as end_time,
    SEC_TO_TIME(all_incoming.created_at-all_incoming2.created_at2) as duration,
	incoming.module_name,
	incoming.digits,
	incoming.new_digits
    from all_incoming
    left join all_incoming2 on all_incoming.uuid = all_incoming2.uuid2
    left join incoming on all_incoming.uuid = incoming.uuid) as abc
    left join all_list on abc.module_name=all_list.name and abc.new_digits=all_list.digit
    group by date(abc.start_time), uuid
    order by abc.start_time
    ),
    
    task_record(uuid,business_unit_uuid,channel_uuid,category_uuid,source,channels,daily,started_at,ended_at,waiting,duration,type,sla_sec,sla_result,categories,direction,business_units,reference_uuid)
    AS (
    SELECT 	
	`task-records`.uuid,
	`task-records`.business_unit_uuid,
    `task-records`.channel_uuid,
    `task-records`.category_uuid,
	`task-records`.source,
	concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
    DATE(`task-records`.started_at) as daily,
    `task-records`.started_at,
    `task-records`.ended_at,
    sec_to_time(`task-records`.wait_duration_sec) as waiting,
    sec_to_time(`task-records`.duration_sec) as duration,
    `task-records`.type,
    `task-records`.sla_sec,
	`task-records`.sla_result,
    `categories`.name as categories,
    `task-records`.direction,
    `business-units`.name as business_units,
    `task-records`.reference_uuid
FROM `task-records`
	left join `business-units` on `task-records`.business_unit_uuid = `business-units`.uuid
	left join `categories` on `task-records`.category_uuid = `categories`.uuid
	left join `channels` on `task-records`.channel_uuid = `channels`.uuid
WHERE 
		`business-units`.uuid is not null 
		and `task-records`.type = 'abandon'
		and  date(`task-records`.started_at) between '2021-05-07' and '2021-05-07'
    ),
    
    main(uuid,business_unit_uuid,channel_uuid,category_uuid,source,channels,daily,started_at,ended_at,waiting,duration,type,categories,direction,business_units,reference_uuid,ivr_id,caller_id_number,id,new_des,main_des)
    AS(
    select 
    task_record.uuid,
	task_record.business_unit_uuid,
    task_record.channel_uuid,
    task_record.category_uuid,
    task_record.source,
    task_record.channels,
     task_record.daily,
     task_record.started_at,
     task_record.ended_at,
     task_record.waiting,
     task_record.duration,
     task_record.type,
     task_record.categories,
     task_record.direction,
     task_record.business_units,
     task_record.reference_uuid,
     IVR_detail.uuid as ivr_id,
     IVR_detail.caller_id_number,
     IVR_detail.id,
     IVR_detail.new_des,
	CASE
    WHEN  IVR_detail.id between 2 and 65  THEN '1. รับฟังข้อมูลทั่วไป'
    WHEN  IVR_detail.id between 66 and 69 THEN '2. ตรวจสอบสิทธิอัตโนมัติ'
    WHEN  IVR_detail.id between 70 and 72 THEN '3. ตรวจสอบสิทธิอัตโนมัติหน่วยห้าสิบวงเล็บห้า'
	WHEN  IVR_detail.id between 75 and 78 THEN '5. ข้อมูลสำหรับหน่วยบริการ'
    WHEN IVR_detail.id is null THEN 'สายนี้ไม่ได้มาจากระบบ IVR'
    ELSE IVR_detail.new_des
    END as main_des
    from task_record
    left join IVR_detail on task_record.reference_uuid = IVR_detail.uuid
    )
    
    select * from main
    ;
    
END