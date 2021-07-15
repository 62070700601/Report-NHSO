select
`business-units`.name as business_units,
`teams`.name as teams,
CONCAT(`users`.first_name, ' ' , `users`.last_name) as agent,
`task-records`.source,
date(`task-records`.started_at) as daily,
`task-records`.started_at as started_at,
`task-records`.answered_at as answered_at,
`task-records`.ended_at,
`task-records`.type,
concat(`channels`.type, ' (' ,`channels`.name, ')') as channels,
count(`task-records`.uuid) as incoming,
COUNT(IF(`task-records`.type = 'answer', 1 , NULL)) 'answer',
COUNT(IF(`task-records`.type = 'abandon', 1 , NULL)) 'abandon',
COUNT(IF(`task-records`.sla_result= 'under', 1 , NULL)) 'under',
COUNT(IF(`task-records`.sla_result = 'over', 1 , NULL)) 'over',
`task-records`.sla_result,
sec_to_time(`task-records`.duration_sec) as duration,
sec_to_time(`task-records`.wait_duration_sec) waiting,
sec_to_time(`task-records`.inservice_duration_sec) inservice,
sec_to_time(`task-records`.sla_sec) as sla,
`categories`.name as category
from `task-records`
left join `agent-task-records` on `task-records`.uuid=`agent-task-records`.task_uuid
left join `business-units` on `task-records`.business_unit_uuid = `business-units`.uuid
left join `teams` on `task-records`.team_uuid = `teams`.uuid
left join `categories` on `task-records`.category_uuid = `categories`.uuid
left join `channels` on `task-records`.channel_uuid = `channels`.uuid
left join `users` on `task-records`.user_uuid = `users`.uuid
where date(`task-records`.started_at) between $P{start_date} and $P{end_date}
and hour(`task-records`.started_at) between $P{start_time} and $P{end_time}
and `task-records`.user_uuid is not null
and $X{IN,`task-records`.business_unit_uuid,business_units}
and $X{IN,`task-records`.team_uuid,team}
and $X{IN,`task-records`.channel_uuid,channels}
and $X{IN,`task-records`.category_uuid,category_id} 
and $X{IN,`task-records`.user_uuid, agents_id}
and $X{IN,`task-records`.type,answer_abandon}
group by 	`business-units`.uuid,
    `teams`.uuid,
    `task-records`.started_at
order by `business-units`.name, teams, agent, `task-records`.started_at