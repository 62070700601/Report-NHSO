CREATE DEFINER=`dev`@`%` PROCEDURE `agent_sign_no_team`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `agent_param` TEXT)
BEGIN

WITH
logout_time(user_uuid, agent, status,started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
		`agent-statuses`.started_at,
		`agent-statuses`.ended_at,
    row_number() over (partition by `users`.uuid, date(`agent-statuses`.started_at) order by `users`.uuid, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) DESC, `agent-statuses`.started_at DESC) as rank_no
	FROM `agent-statuses`
		left join `users` on `agent-statuses`.user_uuid = `users`.uuid
	WHERE 
		`agent-statuses`.user_uuid is not null 
	GROUP BY  `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY agent, date(`agent-statuses`.started_at) ASC, time(`agent-statuses`.started_at) DESC, `agent-statuses`.started_at DESC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
),

login_time(user_uuid, agent, status,started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
		`agent-statuses`.started_at,
		`agent-statuses`.ended_at,
    row_number() over (partition by `users`.uuid, date(`agent-statuses`.started_at) order by `users`.uuid, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC) as rank_no
	FROM `agent-statuses`
		left join `users` on `agent-statuses`.user_uuid = `users`.uuid
	WHERE 
		`agent-statuses`.user_uuid is not null 
	GROUP BY `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY agent, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
)

select 
logout_time.user_uuid, 
logout_time.agent, 
logout_time.status, 
login_time.started_at as log_in,
logout_time.ended_at as log_out
from 
logout_time
left join login_time on logout_time.user_uuid = login_time.user_uuid and date(login_time.started_at) = date(logout_time.started_at)
where login_time.started_at is not null
;

END