SELECT `task-records`.uuid,
`task-records`.started_at,
`categories`.name as categories,
tr.alltotal,
 COUNT(`task-records`.uuid) as incoming,
  COUNT(IF(`task-records`.direction = 'inbound', 1 , NULL)) 'inbound_incoming',
 COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'inbound', 1 , NULL)) 'answer',
 COUNT(IF(`task-records`.type = 'abandon' and `task-records`.direction = 'inbound', 1 , NULL)) 'abandon',
 COUNT(IF(`task-records`.type = 'uninterest' and `task-records`.direction = 'inbound', 1 , NULL)) 'uninterest',
   COUNT(IF(`task-records`.direction = 'outbound', 1 , NULL)) 'outbound_incoming',
  COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'answer_out',
    COUNT(IF(`task-records`.type = 'no_answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'no_answer',
     COUNT(IF(`task-records`.type = 'answer' , 1 , NULL)) 'answer_total',
sec_to_time(SUM(`task-records`.inservice_duration_sec)) as sum_incoming,
sec_to_time(MIN(`task-records`.inservice_duration_sec)) as min_incoming,
sec_to_time(MAX(`task-records`.inservice_duration_sec)) as max_incoming,
sec_to_time(AVG(`task-records`.inservice_duration_sec)) as avg_incoming,
AVG(`task-records`.inservice_duration_sec) as avg_incoming_sec,
sec_to_time(SUM(`task-records`.wait_duration_sec)) as total_queue,
sec_to_time(AVG(`task-records`.wait_duration_sec)) as avg_queue,
AVG(`task-records`.wait_duration_sec) as avg_queue_sec,
sec_to_time(MIN(`task-records`.wait_duration_sec)) as min_queue,
sec_to_time(MAX(`task-records`.wait_duration_sec)) as max_queue
FROM `task-records`
left join `categories` on `task-records`.category_uuid = `categories`.uuid
left join `task-holds` on `task-records`.reference_uuid = `task-holds`.reference_uuid
cross join (select count(uuid) AS alltotal from `task-records` where  date(`task-records`.started_at) between $P{start_date} and $P{end_date}
			and time(`task-records`.started_at) between $P{start_time} and $P{end_time} 
			) tr
where  
			 date(`task-records`.started_at) between $P{start_date} and $P{end_date}
			and time(`task-records`.started_at) between $P{start_time} and $P{end_time}
group by `categories`.name