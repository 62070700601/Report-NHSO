CREATE DEFINER=`dev`@`%` PROCEDURE `30agentbusytime`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `start_time_param` TIME, IN `end_time_param` TIME, IN `business_units_param` TEXT, IN `team_param` TEXT, IN `agent_param` TEXT)
BEGIN
WITH
    allbreak(num,user_uuid,team_uuid,daily,sum_break,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
	date(`agent-statuses`.started_at) as daily,
	sum(duration_sec) as sum_break,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
            LEFT JOIN
    `business-units` ON `agent-statuses`.business_unit_uuid = `business-units`.uuid
        LEFT JOIN
    teams ON `agent-statuses`.team_uuid = teams.uuid
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.reason = 'break'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	allwork(num,sum_working, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid) as num,
	SUM(duration_sec) as sum_working,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'work'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alljobassign(num,sum_jobassign, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_jobassign,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'job_assign'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	allcoaching(num,sum_coaching, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_coaching,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'coaching'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alltyping(num,sum_typing, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_typing,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'typing_doc'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	allprivate(num,sum_private, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_private,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'private'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alltraning(num,sum_traning, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_traning,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'traning'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alllunch(num,sum_lunch, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_lunch,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'lunch'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	allsick(num,sum_sick, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_sick,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'sick'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alloutbound(num,sum_outbound, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_outbound,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'outbound'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
    allcomplain(num,sum_complain, user_uuid,team_uuid,daily,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_complain,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily,
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'complain'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    ),
    
	alltotal(business_unit_uuid,business_units,team_uuid,teams,user_uuid,agent,daily,sum_total,num,Slot,New_Slot,Slot_count)
    AS (
    SELECT 
    	`agent-statuses`.business_unit_uuid,
	`business-units`.name AS business_units,
	`agent-statuses`.team_uuid,
	teams.name AS teams,
	`agent-statuses`.user_uuid,
    CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent,
	date(`agent-statuses`.started_at) as daily,
	SUM(duration_sec) as sum_total,
    count(`agent-statuses`.uuid),
    	CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `Slot`,
    CONCAT(LPAD(HOUR(`agent-statuses`.started_at),2,0),':',LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0)) AS `New_Slot`,
	COUNT(CONCAT('t',LPAD(HOUR(`agent-statuses`.started_at),2,0),
	LPAD((FLOOR((MINUTE(`agent-statuses`.started_at) / 30)) * 30),2,0))) AS `Slot_count`
	FROM `agent-statuses`
                LEFT JOIN
    `business-units` ON `agent-statuses`.business_unit_uuid = `business-units`.uuid
        LEFT JOIN
    teams ON `agent-statuses`.team_uuid = teams.uuid
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.status = 'unavailable'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and time(`agent-statuses`.started_at) between start_time_param and end_time_param
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at),`Slot`
    )
    
    select 
    alltotal.business_unit_uuid,
    alltotal.business_units,
    alltotal.team_uuid,
    alltotal.teams,
    alltotal.user_uuid,
    alltotal.agent,
	alltotal.daily,
    alltotal.Slot,
    alltotal.New_Slot,
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
    ifnull(allcomplain.sum_complain,0) as sum_complain,
    ifnull(alltotal.sum_total,0) as sum_total,
	ifnull(allbreak.num,0) as num_break,
	ifnull(allwork.num,0) as num_working,
    ifnull(alljobassign.num,0) as num_jobassign,
    ifnull(allcoaching.num,0) as num_coaching,
    ifnull(alltyping.num,0) as num_typing,
    ifnull(allprivate.num,0) as num_private,
    ifnull(alltraning.num,0) as num_traning,
    ifnull(alllunch.num,0) as num_lunch,
    ifnull(allsick.num,0) as num_sick,
    ifnull(alloutbound.num,0) as num_outbound,
    ifnull(allcomplain.num,0) as num_complain,
    ifnull(alltotal.num,0) as num_total
    from alltotal
	left join allwork on alltotal.user_uuid = allwork.user_uuid and alltotal.daily = allwork.daily and alltotal.Slot=allwork.Slot  and alltotal.team_uuid = allwork.team_uuid
    left join alljobassign on alltotal.user_uuid = alljobassign.user_uuid and alltotal.daily = alljobassign.daily and alltotal.Slot=alljobassign.Slot and alltotal.team_uuid = alljobassign.team_uuid
    left join allcoaching on alltotal.user_uuid = allcoaching.user_uuid and alltotal.daily = allcoaching.daily and alltotal.Slot=allcoaching.Slot and alltotal.team_uuid = allcoaching.team_uuid
    left join alltyping on alltotal.user_uuid = alltyping.user_uuid and alltotal.daily = alltyping.daily and alltotal.Slot=alltyping.Slot and alltotal.team_uuid = alltyping.team_uuid
    left join allprivate on alltotal.user_uuid = allprivate.user_uuid and alltotal.daily = allprivate.daily and alltotal.Slot=allprivate.Slot and alltotal.team_uuid = allprivate.team_uuid
    left join alltraning on alltotal.user_uuid = alltraning.user_uuid and alltotal.daily = alltraning.daily and alltotal.Slot=alltraning.Slot and alltotal.team_uuid = alltraning.team_uuid
    left join alllunch on alltotal.user_uuid = alllunch.user_uuid and alltotal.daily = alllunch.daily and alltotal.Slot=alllunch.Slot and alltotal.team_uuid = alllunch.team_uuid
    left join allsick on alltotal.user_uuid = allsick.user_uuid and alltotal.daily = allsick.daily and alltotal.Slot=allsick.Slot and alltotal.team_uuid = allsick.team_uuid
    left join alloutbound on alltotal.user_uuid = alloutbound.user_uuid and alltotal.daily = alloutbound.daily and alltotal.Slot=alloutbound.Slot and alltotal.team_uuid = alloutbound.team_uuid
    left join allbreak on alltotal.user_uuid = allbreak.user_uuid and alltotal.daily = allbreak.daily and alltotal.Slot=allbreak.Slot and alltotal.team_uuid = allbreak.team_uuid
    left join allcomplain on alltotal.user_uuid = allcomplain.user_uuid and alltotal.daily = allcomplain.daily and alltotal.Slot=allcomplain.Slot and alltotal.team_uuid = allcomplain.team_uuid
    ORDER BY alltotal.business_units, alltotal.teams, alltotal.agent, alltotal.daily, alltotal.Slot
    ;
    
END