CREATE DEFINER=`dev`@`%` PROCEDURE `agentsumbychannel`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `start_time_param` TIME, IN `end_time_param` TIME, IN `channel_param` TEXT, IN `agent_param` TEXT)
BEGIN
WITH 
	allincomingbychannel(uuid, channels, incoming)
    AS (
        SELECT 
        `channels`.uuid,
        concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
        COUNT(`task-records`.`uuid`) AS `incoming`
    FROM 
        (`task-records`
        LEFT JOIN `channels` ON ((`task-records`.`channel_uuid` = `channels`.`uuid`)))
        where date(`task-records`.started_at) between start_date_param and end_date_param
        and time(`task-records`.started_at) between start_time_param and end_time_param
        and `task-records`.user_uuid is not null
    GROUP BY `channels`.uuid
)
    
SELECT `task-records`.uuid,
`task-records`.started_at,
concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
tr.allincoming,
`allincomingbychannel`.incoming as totalincomingbychannel,
CONCAT(`users`.first_name, ' ' , `users`.last_name) as agent,
 COUNT(`task-records`.uuid) as incoming,
COUNT(IF(`task-records`.direction = 'inbound', 1 , NULL)) 'inbound_incoming',
COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'inbound', 1 , NULL)) 'answer',
COUNT(IF(`task-records`.type = 'abandon' and  `task-records`.direction = 'inbound', 1 , NULL)) 'miss',
 COUNT(IF(`task-records`.type = 'uninterest' and `task-records`.direction = 'inbound', 1 , NULL)) 'uninterest',
 COUNT(IF(`task-records`.direction = 'outbound', 1 , NULL)) 'outbound_incoming',
 COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'answer_out',
  COUNT(IF(`task-records`.type = 'no_answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'no_answer',
  COUNT(IF(`task-records`.type = 'answer', 1 , NULL)) 'answer_all',
sec_to_time(SUM(`task-records`.inservice_duration_sec)) as sum_handled,
sec_to_time(MIN(`task-records`.inservice_duration_sec)) as min_handled,
sec_to_time(MAX(`task-records`.inservice_duration_sec)) as max_handled,
sec_to_time(AVG(`task-records`.inservice_duration_sec)) as avg_handled,
AVG(`task-records`.inservice_duration_sec) as avg_handled_sec,
AVG(`task-records`.wait_duration_sec) as avg_queue_sec,
sec_to_time(SUM(`task-records`.wait_duration_sec)) as sum_queue,
sec_to_time(AVG(`task-records`.wait_duration_sec)) as avg_queue,
sec_to_time(MIN(`task-records`.wait_duration_sec)) as min_queue,
sec_to_time(MAX(`task-records`.wait_duration_sec)) as max_queue
FROM `task-records`
left join `channels` on `task-records`.channel_uuid = `channels`.uuid
left join `users` on `task-records`.user_uuid = `users`.uuid
cross join (select count(uuid) AS allincoming from `task-records` where date(`task-records`.started_at) between start_date_param and end_date_param
        and time(`task-records`.started_at) between start_time_param and end_time_param
        and `task-records`.user_uuid is not null) tr
left join allincomingbychannel on `task-records`.channel_uuid = allincomingbychannel.uuid
where date(`task-records`.started_at) between start_date_param and end_date_param
and time(`task-records`.started_at) between start_time_param and end_time_param
and `task-records`.user_uuid is not null
and find_in_set(`task-records`.channel_uuid, channel_param)
and find_in_set(`task-records`.user_uuid, agent_param)
group by `channels`.uuid,
user_uuid
order by `task-records`.channel_type,
agent;
END