SELECT 	
	`task-records`.uuid,
	source,
    concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
    `task-records`.channel_type,
    DATE(`task-records`.started_at) as date,
    `task-records`.started_at,
    `task-records`.answered_at as answered_at,
    `task-records`.ended_at,
    sec_to_time(`task-records`.wait_duration_sec) as waiting,
    sec_to_time(`task-records`.duration_sec) as duration,
    sec_to_time(`task-records`.inservice_duration_sec) as inservice,
    `task-records`.type,
    `task-records`.sla_sec,
	`task-records`.sla_result,
    `categories`.name as categories,
    `task-records`.direction,
    CONCAT(`users`.first_name, ' ' , `users`.last_name) as agent,
    `teams`.name as teams,
    `business-units`.name as business_units
FROM `task-records`
	left join `business-units` on `task-records`.business_unit_uuid = `business-units`.uuid
	left join `teams` on `task-records`.team_uuid = `teams`.uuid
	left join `categories` on `task-records`.category_uuid = `categories`.uuid
	left join `channels` on `task-records`.channel_uuid = `channels`.uuid
	left join `users` on `task-records`.user_uuid = `users`.uuid
WHERE 
		`business-units`.uuid is not null 
		and `categories`.uuid is not null
		and `channels`.uuid is not null
		and `task-records`.channel_type = 'social'
		and date(`task-records`.started_at) between $P{start_date} and $P{end_date}
		and time(`task-records`.started_at) between $P{start_time} and $P{end_time}
    	and $X{IN,`task-records`.business_unit_uuid,business_units}
    	and $X{IN,`task-records`.team_uuid,team}
    	and $X{IN,`task-records`.user_uuid,agents_id}
    	and $X{IN,`channels`.uuid,channels}
		and $X{IN, `categories`.uuid,category_id} 
    	and $X{IN,`task-records`.type,answer_abandon}

GROUP BY
	`business-units`.uuid,
    date,
     `task-records`.uuid
ORDER BY
	`business-units`.name,
	date