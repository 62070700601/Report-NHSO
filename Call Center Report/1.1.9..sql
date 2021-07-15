SELECT 
date(`task-records`.started_at) as daily,
hour(`task-records`.started_at) as hourly,
count(`task-records`.uuid) as incoming,
COUNT(IF(`task-records`.direction = 'inbound', 1 , NULL)) 'inbound_incoming',
COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'inbound', 1 , NULL)) 'answer',
COUNT(IF(`task-records`.type = 'abandon' and  `task-records`.direction = 'inbound', 1 , NULL)) 'abandon',
 COUNT(IF(`task-records`.type = 'uninterest' and `task-records`.direction = 'inbound', 1 , NULL)) 'uninterest',
 COUNT(IF(`task-records`.direction = 'outbound', 1 , NULL)) 'outbound_incoming',
 COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'answer_out',
  COUNT(IF(`task-records`.type = 'no_answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'no_answer',
MAX(wait_duration_sec) as longest_queue,
AVG(inservice_duration_sec) as avg_inservice,
AVG(IFNULL(`task-holds`.duration_sec,0)) as avg_hold,
AVG(wait_duration_sec) as avg_queue
FROM `task-records`
left join `task-holds` on `task-records`.reference_uuid = `task-holds`.reference_uuid 
where date(`task-records`.started_at) between $P{start_date} and $P{end_date} 
and hour(`task-records`.started_at) between $P{start_time} and $P{end_time}
group by  daily, hourly
order by daily, hourly
;