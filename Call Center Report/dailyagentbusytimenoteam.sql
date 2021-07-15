CREATE DEFINER=`dev`@`%` PROCEDURE `dailyagentbusytimenoteam`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `agent_param` TEXT)
BEGIN
WITH

    allbreak(num,user_uuid,daily,sum_break)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	`agent-statuses`.user_uuid,
	date(`agent-statuses`.started_at) as daily,
	sum(duration_sec) as sum_break
	FROM `agent-statuses`
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.reason = 'break'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allwork(num,sum_working, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid) as num,
	SUM(duration_sec) as sum_working,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'work'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alljobassign(num,sum_jobassign, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_jobassign,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'job_assign'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allcoaching(num,sum_coaching, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_coaching,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'coaching'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alltyping(num,sum_typing, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_typing,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'typing_doc'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allprivate(num,sum_private, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_private,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'private'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alltraning(num,sum_traning, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_traning,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'traning'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alllunch(num,sum_lunch, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_lunch,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'lunch'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allsick(num,sum_sick, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_sick,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'sick'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alloutbound(num,sum_outbound, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_outbound,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'outbound'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allcomplain(num,sum_complain, user_uuid,daily)
    AS (
    SELECT 
    count(`agent-statuses`.uuid),
	SUM(duration_sec) as sum_complain,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'complain'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alltotal(user_uuid,agent,daily,sum_total,num)
    AS (
    SELECT 
	`agent-statuses`.user_uuid,
    CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent,
	date(`agent-statuses`.started_at) as daily,
	SUM(duration_sec) as sum_total,
    count(`agent-statuses`.uuid)
	FROM `agent-statuses`
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.status = 'unavailable'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    )
    
    select 
    alltotal.user_uuid,
    alltotal.agent,
	alltotal.daily,
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
	left join allwork on alltotal.user_uuid = allwork.user_uuid and alltotal.daily = allwork.daily 
    left join alljobassign on alltotal.user_uuid = alljobassign.user_uuid and alltotal.daily = alljobassign.daily 
    left join allcoaching on alltotal.user_uuid = allcoaching.user_uuid and alltotal.daily = allcoaching.daily 
    left join alltyping on alltotal.user_uuid = alltyping.user_uuid and alltotal.daily = alltyping.daily 
    left join allprivate on alltotal.user_uuid = allprivate.user_uuid and alltotal.daily = allprivate.daily
    left join alltraning on alltotal.user_uuid = alltraning.user_uuid and alltotal.daily = alltraning.daily 
    left join alllunch on alltotal.user_uuid = alllunch.user_uuid and alltotal.daily = alllunch.daily 
    left join allsick on alltotal.user_uuid = allsick.user_uuid and alltotal.daily = allsick.daily 
    left join alloutbound on alltotal.user_uuid = alloutbound.user_uuid and alltotal.daily = alloutbound.daily 
    left join allbreak on alltotal.user_uuid = allbreak.user_uuid and alltotal.daily = allbreak.daily 
    left join allcomplain on alltotal.user_uuid = allcomplain.user_uuid and alltotal.daily = allcomplain.daily 
    ORDER BY alltotal.agent, alltotal.daily
    ;
    
END