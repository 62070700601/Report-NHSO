CREATE DEFINER=`dev`@`%` PROCEDURE `agentbusytime`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `start_time_param` TIME, IN `end_time_param` TIME, IN `business_units_param` TEXT, IN `team_param` TEXT, IN `agent_param` TEXT)
BEGIN
WITH
	all_list(business_unit_uuid, business_units, team_uuid, teams, user_uuid, agent )
    AS (
		SELECT 
    `agent-statuses`.business_unit_uuid,
    `business-units`.name AS business_units,
    `agent-statuses`.team_uuid,
    teams.name AS teams,
    `agent-statuses`.user_uuid,
    CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent
FROM
    `agent-statuses`
        LEFT JOIN
    `business-units` ON `agent-statuses`.business_unit_uuid = `business-units`.uuid
        LEFT JOIN
    teams ON `agent-statuses`.team_uuid = teams.uuid
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
    where find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
GROUP BY `agent-statuses`.business_unit_uuid , `agent-statuses`.team_uuid , `agent-statuses`.user_uuid
    ),
    
    allbreak(sum_break, user_uuid)
    AS (
    SELECT 
	sum(duration_sec) as sum_break,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'break'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	allwork(sum_working, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_working,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'work'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alljobassign(sum_jobassign, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_jobassign,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'job_assign'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	allcoaching(sum_coaching, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_coaching,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'coaching'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alltyping(sum_typing, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_typing,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'typing_doc'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	allprivate(sum_private, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_private,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'private'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alltraning(sum_traning, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_traning,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'traning'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alllunch(sum_lunch, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_lunch,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'lunch'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	allsick(sum_sick, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_sick,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'sick'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alloutbound(sum_outbound, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_outbound,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'outbound'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    ),
    
	alltotal(sum_total, user_uuid)
    AS (
    SELECT 
	SUM(duration_sec) as sum_total,
	`agent-statuses`.user_uuid
	FROM `agent-statuses`
	where `agent-statuses`.status = 'unavailable'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid
    )
    
    select 
    all_list.business_unit_uuid,
    all_list.business_units,
    all_list.team_uuid,
    all_list.teams,
    all_list.user_uuid,
    all_list.agent,
    ifnull(allbreak.sum_break,0) as sum_break,
	ifnull(allwork.sum_working,0) as sum_working,
    ifnull(alljobassign.sum_jobassign,0) as sum_jobassign,
    ifnull(allcoaching.sum_coaching,0) as sum_coaching,
    ifnull(alltyping.sum_typing,0) as sum_typing,
    ifnull(allprivate.sum_private,0) as sum_private,
    ifnull(alltraning.sum_traning,0) as sum_traning,
    ifnull(alllunch.sum_lunch,0) as sum_lunch,
    ifnull(allsick.sum_sick,0) as sum_sick,
    ifnull(alloutbound.sum_outbound,0) as sum_outbound,
    ifnull(alltotal.sum_total,0) as sum_total
    
    from all_list
	left join allwork on all_list.user_uuid = allwork.user_uuid
    left join allbreak on all_list.user_uuid = allbreak.user_uuid
    left join alljobassign on all_list.user_uuid = alljobassign.user_uuid
    left join allcoaching on all_list.user_uuid = allcoaching.user_uuid
    left join alltyping on all_list.user_uuid = alltyping.user_uuid
    left join allprivate on all_list.user_uuid = allprivate.user_uuid
    left join alltraning on all_list.user_uuid = alltraning.user_uuid
    left join alllunch on all_list.user_uuid = alllunch.user_uuid
    left join allsick on all_list.user_uuid = allsick.user_uuid
    left join alloutbound on all_list.user_uuid = alloutbound.user_uuid
    left join alltotal on all_list.user_uuid = alltotal.user_uuid
    ORDER BY all_list.business_units, all_list.teams, all_list.agent
    ;
    

END