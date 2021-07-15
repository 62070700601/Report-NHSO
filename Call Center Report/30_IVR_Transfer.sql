CREATE DEFINER=`dev`@`%` PROCEDURE `30_IVR_Transfer`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `start_time_param` TIME, IN `end_time_param` TIME, IN `setInterval` INT)
BEGIN
	set @startDate = start_date_param;
	set @endDate = end_date_param;
	set @startTime = concat("2019-07-01 ",start_time_param);
	set @endTime = concat("2019-07-01 ",end_time_param);
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
            where slot_list.n >0
			ORDER BY date_list.d, slot_list.slot
		),
        total_transfer(daily,Slot,Slot_count,transfer_agent,transfer_oto,transfer_dist)
	AS (
	select
	date(created_at) as daily,
    CONCAT('t',LPAD(HOUR(created_at),2,0),LPAD((FLOOR((MINUTE(created_at) / @setInterval)) * @setInterval),2,0)) AS `Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(created_at),2,0),LPAD((FLOOR((MINUTE(created_at) / @setInterval)) * @setInterval),2,0))) AS `Slot_count`,
	COUNT(IF(module_name = 'Transfer to agent', 1 , NULL)) + COUNT(IF(module_name = 'Transfer_to_agent', 1 , NULL))+COUNT(IF(module_name = 'Transfer to agent pid', 1 , NULL)) as transfer_agent,
	COUNT(IF(module_name = 'Transfer to OTO', 1 , NULL))+COUNT(IF(module_name = 'Transfer to OTO pid' and digits = '8888', 1 , NULL)) as transfer_oto,
    COUNT(IF(module_name = 'Transfer to District' and digits = '8888', 1 , NULL)) as transfer_dist
	from ivr_journeys
    where  date(created_at) between start_date_param and end_date_param
    and time(created_at) between start_time_param and end_time_param
    group by date(created_at),Slot
	),
    total_incoming(incoming,daily,Slot)
	AS(
	select 
    COUNT(CONCAT('t',LPAD(HOUR(num.created_at),2,0),LPAD((FLOOR((MINUTE(num.created_at) / @setInterval)) * @setInterval),2,0))) AS `Slot_count`,
	date(num.created_at) as daily,
	CONCAT('t',LPAD(HOUR(num.created_at),2,0),LPAD((FLOOR((MINUTE(num.created_at) / @setInterval)) * @setInterval),2,0)) AS `Slot`
	from
	(select uuid,
	created_at
	from ivr_journeys
	where date(created_at) between start_date_param and end_date_param
	and time(created_at) between start_time_param and end_time_param
	group by uuid) as num
	group by date(num.created_at),Slot
	)

        select all_list.d as daily,
        all_list.label as label,
        total_incoming.incoming,
        total_incoming.incoming-(total_transfer.transfer_agent+total_transfer.transfer_oto+total_transfer.transfer_dist) as end_ivr,
        total_transfer.transfer_agent,
        total_transfer.transfer_oto,
        total_transfer.transfer_dist
        from all_list
        left join total_transfer on all_list.d=total_transfer.daily and all_list.slot=total_transfer.slot
        left join total_incoming on all_list.d=total_incoming.daily and all_list.slot=total_incoming.slot
        order by all_list.d,all_list.slot;
END