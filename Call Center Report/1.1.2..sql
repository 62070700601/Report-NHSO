SELECT 	
	`task-records`.uuid,
	`task-records`.source,
	`task-records`.direction,
	concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
    `task-records`.started_at,
    `task-records`.answered_at,
    `task-records`.ended_at,
    sec_to_time(`task-records`.wait_duration_sec) as waiting,
    sec_to_time(`task-records`.duration_sec) as duration,
    sec_to_time(`task-records`.inservice_duration_sec) as inservice,
    `task-records`.type,
    `task-records`.sla_sec,
	`task-records`.sla_result,
    `categories`.name as categories,
    CONCAT(`users`.first_name, ' ' , `users`.last_name) as agent,
    `teams`.name as teams,
    `task-records`.type,
    `business-units`.name as business_units
FROM `task-records`
	left join `business-units` on `task-records`.business_unit_uuid = `business-units`.uuid
	left join `teams` on `task-records`.team_uuid = `teams`.uuid
	left join `categories` on `task-records`.category_uuid = `categories`.uuid
	left join `channels` on `task-records`.channel_uuid = `channels`.uuid
	left join `users` on `task-records`.user_uuid = `users`.uuid
WHERE 
		 `users`.uuid is not null
		and  date(`task-records`.started_at) between $P{start_date} and $P{end_date}
		and time(`task-records`.started_at) between $P{start_time} and $P{end_time}
    	and $X{IN,`task-records`.business_unit_uuid,business_units}
    	and $X{IN,`task-records`.team_uuid,team}
		and $X{IN,`task-records`.channel_uuid,channels}
		and $X{IN,`task-records`.category_uuid,category_id} 
		and $X{IN,`task-records`.user_uuid, agents_id}
		and $X{IN,`task-records`.direction,Direction}
    	and $X{IN,`task-records`.type,type}
GROUP BY
	`business-units`.uuid,
    `teams`.uuid,
    `users`.uuid,
    `task-records`.started_at
   --  `task-records`.uuid
ORDER BY
	`business-units`.name,
	`teams`.name,
    agent,
	`task-records`.started_at,
    `channels`.name