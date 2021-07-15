SELECT 
	`agent-statuses`.uuid,
	`agent-statuses`.reason as reason,
	`users`.uuid as user,
    `teams`.name as teams,
    CONCAT(`users`.first_name,' ',`users`.last_name) as agent_name,
    `agent-statuses`.status,
    `business-units`.name as business_unit,
    date(`agent-statuses`.started_at) as daily,
    time(`agent-statuses`.started_at) as start_time,
    time(`agent-statuses`.ended_at) as end_time,
    sec_to_time(duration_sec) as duration
FROM `agent-statuses`
	left join `teams` on `agent-statuses`.team_uuid = `teams`.uuid
    left join `users` on `agent-statuses`.user_uuid = `users`.uuid
    left join `business-units` on `agent-statuses`.business_unit_uuid = `business-units`.uuid
WHERE
	time(`agent-statuses`.started_at) is not null
    and time(`agent-statuses`.ended_at) is not null
    and  date(`agent-statuses`.started_at) between $P{start_date} and $P{end_date}
	and time(`agent-statuses`.started_at) between $P{start_time} and $P{end_time}
    and $X{IN,`agent-statuses`.team_uuid,team}
    and $X{IN,`agent-statuses`.user_uuid, agents_id}
	and $X{IN,`agent-statuses`.status, status_id}
GROUP BY
 `agent-statuses`.business_unit_uuid,`agent-statuses`.team_uuid,`agent-statuses`.user_uuid,`agent-statuses`.id
ORDER BY 
business_unit,
teams,
agent_name, daily, start_time, end_time