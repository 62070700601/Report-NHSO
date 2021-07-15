SELECT 
	`business-units`.name as business_unit,
	`categories`.name as category,
    `task-records`.started_at,
    `task-records`.ended_at,
    COUNT(`task-records`.uuid) as incoming,
        COUNT(IF(`task-records`.direction ='inbound', 1 , NULL)) 'inbound_incoming',
    COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction ='inbound', 1 , NULL)) 'answer',
    COUNT(IF(`task-records`.type = 'abandon' and `task-records`.direction ='inbound', 1 , NULL)) 'abandon',
    COUNT(IF(`task-records`.type = 'uninterest' and `task-records`.direction ='inbound', 1 , NULL)) 'uninterest',
    COUNT(IF(`task-records`.direction ='outbound', 1 , NULL)) 'outbound_incoming',
    COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction ='outbound', 1 , NULL)) 'answer_out',
    COUNT(IF(`task-records`.type = 'no_answer' and `task-records`.direction ='outbound', 1 , NULL)) 'no_answer'
FROM `task-records`
	left join `business-units` on `task-records`.business_unit_uuid = `business-units`.uuid
    left join `users` on `task-records`.user_uuid = `users`.uuid
    left join `categories` on `task-records`.category_uuid = `categories`.uuid
WHERE
		`business-units`.uuid is not null
    			and  date(`task-records`.started_at) between $P{start_date} and $P{end_date}
		and time(`task-records`.started_at) between $P{start_time} and $P{end_time}
        and $X{IN,`task-records`.business_unit_uuid, business_units}
    GROUP BY 
    `categories`.uuid
	ORDER BY 
	`business-units`.name, category