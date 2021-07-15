CREATE DEFINER=`dev`@`%` PROCEDURE `daily_IVR_Transfer`(IN `start_date_param` DATE, IN `end_date_param` DATE)
BEGIN
WITH RECURSIVE date_list (n,d) 
	AS (
		  SELECT 0, CAST(date_add(start_date_param, INTERVAL 0 day) AS DATE)
		  UNION ALL
		  SELECT n + 1, CAST(date_add(start_date_param, INTERVAL n+1 day) AS DATE)
		  FROM date_list 
		  WHERE n < datediff(end_date_param,start_date_param)
		),
	total_incoming(incoming,daily)
AS(
select 
count(num.incoming) as incoming,
num.daily
from
(
select count(uuid) as incoming,
date(created_at) as daily
from ivr_journeys
where date(created_at) between start_date_param and end_date_param
group by date(created_at), uuid) as num
group by num.daily
),

total_transfer(daily,transfer_agent,transfer_oto,transfer_dist)
AS (
	select
	date(created_at) as daily,
	COUNT(IF(module_name = 'Transfer to agent', 1 , NULL)) + COUNT(IF(module_name = 'Transfer_to_agent', 1 , NULL))+COUNT(IF(module_name = 'Transfer to agent pid', 1 , NULL)) as transfer_agent,
	COUNT(IF(module_name = 'Transfer to OTO', 1 , NULL))+COUNT(IF(module_name = 'Transfer to OTO pid' and digits = '8888', 1 , NULL)) as transfer_oto,
    COUNT(IF(module_name = 'Transfer to District' and digits = '8888', 1 , NULL)) as transfer_dist
	from ivr_journeys
    where  date(created_at) between start_date_param and end_date_param
    group by date(created_at)
)


        select 
        date_list.d as daily,
        total_incoming.incoming,
		total_incoming.incoming-(total_transfer.transfer_agent+total_transfer.transfer_oto+total_transfer.transfer_dist) as end_ivr,
		total_transfer.transfer_agent,
		total_transfer.transfer_oto,
        total_transfer.transfer_dist
        from date_list
        left join total_transfer on date_list.d=total_transfer.daily
        left join total_incoming on date_list.d=total_incoming.daily
        order by date_list.d;
END