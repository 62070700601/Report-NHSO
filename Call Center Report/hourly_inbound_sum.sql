CREATE DEFINER=`dev`@`%` PROCEDURE `hourly_inbound_sum`(IN `startDate` DATE, IN `endDate` DATE, IN `startTime` TIME, IN `endTime` TIME, IN `setInterval` INT)
BEGIN
	set @startDate = startDate;
	set @endDate = endDate;
	set @startTime = concat("2019-07-01 ",startTime);
	set @endTime = concat("2019-07-01 ",endTime);
	set @setInterval = setInterval;
	set @numberOfSlot = time_to_sec(timediff(@endTime,@startTime))/60/@setInterval;
	WITH RECURSIVE date_list (n,d) 
	AS (
		  SELECT 0, CAST(date_add(@startDate, INTERVAL 0 day) AS DATE)
		  UNION ALL
		  SELECT n + 1, CAST(date_add(@startDate, INTERVAL n+1 day) AS DATE)
		  FROM date_list 
		  WHERE n < datediff(@endDate,@startDate)
		),
	slot_list (n,slot,label) AS
		(
		  SELECT 0, 
			concat("t",lpad(hour(@startTime),2,0),lpad(minute(@startTime),2,0)) as slot,
			concat(lpad(hour(@startTime),2,0),":",lpad(minute(@startTime),2,0)) as label
		  UNION ALL
		  SELECT n + 1, 
			concat("t",lpad(hour(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0),lpad(minute(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0)) as slot,
			concat(lpad(hour(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0),":",lpad(minute(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0)) as label
		  FROM slot_list 
		  WHERE n < @numberOfSlot 
		),
	all_list (d,slot,label) AS
		(
			SELECT date_list.d, slot_list.slot, slot_list.label FROM date_list cross join slot_list
			ORDER BY date_list.d, slot_list.slot
		),
	tasks(daily,hourly,Slot,New_Slot,incoming,answer,abandon,uninterest,inservice,hold,longest_queue,no_of_hold,under,sla_over,avg_inservice,avg_hold,avg_queue) AS
    (
    select 
	date(`task-records`.started_at) as daily,
	hour(`task-records`.started_at) as hourly,
	CONCAT('t',LPAD(HOUR(`task-records`.started_at),2,0),LPAD((FLOOR((MINUTE(`task-records`.started_at) / @setInterval)) * @setInterval),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`task-records`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`task-records`.started_at) / @setInterval)) * @setInterval),2,0)) AS `New_Slot`,
	count(`task-records`.uuid) as incoming,
	COUNT(IF(`task-records`.type = 'answer', 1 , NULL)) 'answer',
	COUNT(IF(`task-records`.type = 'abandon', 1 , NULL)) 'abandon',
	COUNT(IF(`task-records`.type = 'uninterest', 1 , NULL)) 'uninterest',
	sum(inservice_duration_sec) as inservice,
	sum(IFNULL(`task-holds`.duration_sec,0)) as hold,
	MAX(wait_duration_sec) as longest_queue,
	COUNT(`task-holds`.duration_sec) as no_of_hold,
	COUNT(IF(`task-records`.sla_result = 'under', 1 , NULL)) 'under',
	COUNT(IF(`task-records`.sla_result = 'over', 1 , NULL)) 'sla_over',
	AVG(inservice_duration_sec) as avg_inservice,
	AVG(IFNULL(`task-holds`.duration_sec,0)) as avg_hold,
	AVG(wait_duration_sec) as avg_queue
	FROM `task-records`
	left join `task-holds` on `task-records`.reference_uuid = `task-holds`.reference_uuid
	where date(`task-records`.started_at) between @startDate and @endDate
	and `task-records`.direction = 'inbound'
	group by  date(`task-records`.started_at), Slot
	order by date(`task-records`.started_at), Slot
    )
        select 
        all_list.d as daily,
        all_list.label as hourly,
        ifnull(tasks.incoming,0) as incoming,
        ifnull(tasks.answer,0) as answer,
        ifnull(tasks.abandon,0) as abandon,
        ifnull(tasks.uninterest,0) as uninterest,
        ifnull(tasks.inservice,0) as inservice,
        ifnull(tasks.hold,0) as hold,
        ifnull(tasks.longest_queue,0) as longest_queue,
		ifnull(tasks.no_of_hold,0) as no_of_hold,
        ifnull(tasks.under,0) as under,
        ifnull(tasks.sla_over,0) as sla_over,
        ifnull(tasks.avg_inservice,0) as avg_inservice,
		ifnull(tasks.avg_hold,0) as avg_hold,
        ifnull(avg_queue,0) as avg_queue     
        from all_list
        left join tasks on all_list.d=tasks.daily and all_list.slot=tasks.Slot
        group by all_list.d, all_list.label
		order by all_list.d, all_list.slot
        ;
END