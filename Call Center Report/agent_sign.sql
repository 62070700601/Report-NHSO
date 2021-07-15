CREATE DEFINER=`dev`@`%` PROCEDURE `agent_sign`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `business_units_param` TEXT, IN `team_param` TEXT, IN `agent_param` TEXT)
BEGIN

WITH
logout_time(business_unit, user_uuid, agent, status,team_uuid, team, started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
		`business-units`.name as business_unit,
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
        `agent-statuses`.team_uuid,
		`teams`.name as team,
		`agent-statuses`.started_at,
		`agent-statuses`.ended_at,
    row_number() over (partition by `business-units`.uuid,`teams`.uuid, `users`.uuid, date(`agent-statuses`.started_at) order by `business-units`.uuid, `teams`.uuid, `users`.uuid, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) DESC, `agent-statuses`.started_at DESC) as rank_no
	FROM `agent-statuses`
		left join `business-units` on `agent-statuses`.business_unit_uuid = `business-units`.uuid
		left join `users` on `agent-statuses`.user_uuid = `users`.uuid
		left join `teams` on `agent-statuses`.team_uuid = `teams`.uuid
	WHERE 
		`business-units`.uuid is not null 
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
	GROUP BY  `business-units`.uuid, `teams`.uuid, `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY business_unit, team, agent, date(`agent-statuses`.started_at) ASC, time(`agent-statuses`.started_at) DESC, `agent-statuses`.started_at DESC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
),

login_time(business_unit, user_uuid, agent, status,team_uuid, team, started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
		`business-units`.name as business_unit,
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
        `agent-statuses`.team_uuid,
		`teams`.name as team,
		`agent-statuses`.started_at,
		`agent-statuses`.ended_at,
    row_number() over (partition by `business-units`.uuid,`teams`.uuid, `users`.uuid, date(`agent-statuses`.started_at) order by `business-units`.uuid, `teams`.uuid, `users`.uuid, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC) as rank_no
	FROM `agent-statuses`
		left join `business-units` on `agent-statuses`.business_unit_uuid = `business-units`.uuid
		left join `users` on `agent-statuses`.user_uuid = `users`.uuid
		left join `teams` on `agent-statuses`.team_uuid = `teams`.uuid
	WHERE 
		`business-units`.uuid is not null 
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
	GROUP BY  `business-units`.uuid, `teams`.uuid, `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY business_unit, team, agent, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
)

select 
logout_time.business_unit, 
logout_time.user_uuid, 
logout_time.agent, 
logout_time.status, 
logout_time.team, 
login_time.started_at as log_in,
logout_time.ended_at as log_out
from 
logout_time
left join login_time on logout_time.user_uuid = login_time.user_uuid and date(login_time.started_at) = date(logout_time.started_at) and logout_time.team_uuid = login_time.team_uuid
;

END