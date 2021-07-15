CREATE DEFINER=`dev`@`%` PROCEDURE `agent_performance_login_time`(IN `start_date_param` DATE, IN `end_date_param` DATE,IN `business_units_param` TEXT, IN `team_param` TEXT, IN `agent_param` TEXT)
BEGIN
WITH
	allagent(daily,business_unit_uuid,business_units,team_uuid,teams,user_uuid,agent)
    AS(
		SELECT 
        date(`task-records`.started_at) as daily,
    `task-records`.business_unit_uuid,
    `business-units`.name AS business_units,
    `task-records`.team_uuid,
    teams.name AS teams,
    `task-records`.user_uuid,
    CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent
FROM
    `task-records`
        LEFT JOIN
    `business-units` ON `task-records`.business_unit_uuid = `business-units`.uuid
        LEFT JOIN
    teams ON `task-records`.team_uuid = teams.uuid
        LEFT JOIN
    users ON `task-records`.user_uuid = users.uuid
    where date(`task-records`.started_at) between start_date_param and end_date_param
	and find_in_set(`task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`task-records`.team_uuid, team_param)
    and find_in_set(`task-records`.user_uuid, agent_param)
GROUP BY date(`task-records`.started_at), `task-records`.business_unit_uuid , `task-records`.team_uuid , `task-records`.user_uuid
order by date(`task-records`.started_at), business_units, teams, agent
    ),
    
    allvoice(user_uuid,business_units,team_uuid,teams,agent,daily,handledtime_voice)
    AS (
		SELECT 
    `agent-task-records`.user_uuid,
        `business-units`.name AS business_units,
        `agent-task-records`.team_uuid,
		teams.name AS teams,
        CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent,
    date(`agent-task-records`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-task-records`.ended_at,`agent-task-records`.answered_at))) as handledtime_voice
	FROM `agent-task-records`
	left join users ON `agent-task-records`.user_uuid = users.uuid
	LEFT JOIN `business-units` ON `agent-task-records`.business_unit_uuid = `business-units`.uuid
	LEFT JOIN teams ON `agent-task-records`.team_uuid = teams.uuid
	where channel_type = 'voice'
	and type = 'answer'
	and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid, date(`agent-task-records`.started_at)
    order by business_units, teams, agent, daily
    ),
    
    allchat(daily, handledtime_chat, user_uuid,team_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-task-records`.ended_at,`agent-task-records`.answered_at))) as handledtime_chat,
    `agent-task-records`.user_uuid,
    `agent-task-records`.team_uuid
	FROM `agent-task-records`
	where channel_type = 'chat'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    
    allemail(daily, handledtime_email,user_uuid,team_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-task-records`.ended_at,`agent-task-records`.answered_at))) as handledtime_email,
    `agent-task-records`.user_uuid,
    `agent-task-records`.team_uuid
	FROM `agent-task-records`
	where channel_type = 'email'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    
    allsocial(daily, handledtime_social, user_uuid,team_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-task-records`.ended_at,`agent-task-records`.answered_at))) as handledtime_social,
    `agent-task-records`.user_uuid,
    `agent-task-records`.team_uuid
	FROM `agent-task-records`
	where channel_type = 'social'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    alloffer (daily,offer, user_uuid,team_uuid)
    AS (
		SELECT
        date(`task-records`.started_at) as daily,
		count(uuid) as miss,
        `task-records`.user_uuid,
        `task-records`.team_uuid
		FROM `task-records`
        where date(`task-records`.started_at) between start_date_param and end_date_param
        and `task-records`.user_uuid is not null
		and find_in_set(`task-records`.business_unit_uuid, business_units_param)
		and find_in_set(`task-records`.team_uuid, team_param)
        and find_in_set(`task-records`.user_uuid, agent_param)
        group by `task-records`.business_unit_uuid, `task-records`.team_uuid, `task-records`.user_uuid,date(`task-records`.started_at)
    ),
    logout_time(business_unit, user_uuid, agent, status, team_uuid, team, started_at, ended_at, rank_no)
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
        and `agent-statuses`.status = 'logged_out' or `agent-statuses`.status = 'unavailable'
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
        and `agent-statuses`.status = 'logged_in' or `agent-statuses`.status = 'available'
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
	GROUP BY  `business-units`.uuid, `teams`.uuid, `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY business_unit, team, agent, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
),
alltraning(sum_traning, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_traning,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'traning'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allwork(sum_working, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_working,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'work'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alloutbound(sum_outbound, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_outbound,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'outbound'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    allbreak(user_uuid,team_uuid,daily,sum_break)
    AS (
    SELECT 
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
	date(`agent-statuses`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_break
	FROM `agent-statuses`
            LEFT JOIN
    `business-units` ON `agent-statuses`.business_unit_uuid = `business-units`.uuid
        LEFT JOIN
    teams ON `agent-statuses`.team_uuid = teams.uuid
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.reason = 'break'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-statuses`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-statuses`.team_uuid, team_param)
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alllunch(sum_lunch, user_uuid,team_uuid,daily)
    AS (
    SELECT
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_lunch,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'lunch'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alltyping(sum_typing, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_typing,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'typing_doc'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),    
	allprivate(sum_private, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_private,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'private'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allcoaching(sum_coaching, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_coaching,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'coaching'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alljobassign(sum_jobassign, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_jobassign,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'job_assign'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allsick(sum_sick, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_sick,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'sick'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allcomplain(sum_complain, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_complain,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'complain'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allidle(sum_idle, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_idle,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = ''
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allreceive(sum_receive, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_receive,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'RECEIVING'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alltalking(sum_talking, user_uuid,team_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_talking,
	`agent-statuses`.user_uuid,
    `agent-statuses`.team_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'TALKING'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(business_unit_uuid, business_units_param)
    and find_in_set(team_uuid, team_param)
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.business_unit_uuid, `agent-statuses`.team_uuid, `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
main(daily,business_units,teams,agent,log_in,log_out,logon_time,log_out_new,
handledtime_voice,handledtime_chat,handledtime_email,handledtime_social,
sum_receive,sum_talking,sum_traning,sum_working,sum_outbound,sum_break,sum_lunch,
sum_typing,sum_private,sum_coaching,sum_jobassign,sum_sick,sum_complain,sum_idle,sum_total
)
AS (
select 
    daily,
    business_units,
    teams,
    agent,
	log_in,
	log_out,
    logon_time,
	CASE 
	WHEN logon_time>sum_total THEN log_out
	WHEN logon_time<sum_total THEN (sum_total-logon_time)+log_out
	END as log_out_new,
    handledtime_voice,
    handledtime_chat,
    handledtime_email,
    handledtime_social,
	sum_receive,
	sum_talking,
    sum_traning,
    sum_working,
    sum_outbound,
    sum_break,
    sum_lunch,
    sum_typing,
    sum_private,
    sum_coaching,
    sum_jobassign,
    sum_sick,
    sum_complain,
    sum_idle,
    sum_total
	from(
    select 
    allagent.daily,
    allagent.business_units,
    allagent.teams,
    allagent.agent,
	TIME(login_time.started_at) as log_in,
	time_to_sec(TIME(logout_time.ended_at)) as log_out,
    time_to_sec(timediff(logout_time.ended_at,login_time.started_at)) as logon_time,
    ifnull(allvoice.handledtime_voice,0) as handledtime_voice,
    ifnull(allchat.handledtime_chat,0) as handledtime_chat,
    ifnull( allemail.handledtime_email,0) as handledtime_email,
    ifnull(allsocial.handledtime_social,0) as handledtime_social,
	ifnull(allreceive.sum_receive,0) as sum_receive,
	ifnull(alltalking.sum_talking,0) as sum_talking,
    ifnull(alltraning.sum_traning,0) as sum_traning,
    ifnull(allwork.sum_working,0) as sum_working,
    ifnull(alloutbound.sum_outbound,0) as sum_outbound,
    ifnull(allbreak.sum_break,0) as sum_break,
    ifnull(alllunch.sum_lunch,0) as sum_lunch,
    ifnull(alltyping.sum_typing,0) as sum_typing,
    ifnull(allprivate.sum_private,0) as sum_private,
    ifnull(allcoaching.sum_coaching,0) as sum_coaching,
    ifnull(alljobassign.sum_jobassign,0) as sum_jobassign,
    ifnull(allsick.sum_sick,0) as sum_sick,
    ifnull(allcomplain.sum_complain,0) as sum_complain,
    ifnull(allidle.sum_idle,0) as sum_idle,
	ifnull(alltalking.sum_talking,0)+
    ifnull(allreceive.sum_receive,0)+
    ifnull(alltraning.sum_traning,0)+
    ifnull(allwork.sum_working,0)+
    ifnull(alloutbound.sum_outbound,0)+
    ifnull(allbreak.sum_break,0)+
    ifnull(alllunch.sum_lunch,0)+
    ifnull(alltyping.sum_typing,0)+
    ifnull(allprivate.sum_private,0)+
    ifnull(allcoaching.sum_coaching,0)+
    ifnull(alljobassign.sum_jobassign,0)+
    ifnull(allsick.sum_sick,0)+
    ifnull(allcomplain.sum_complain,0) +
    ifnull(allidle.sum_idle,0) as sum_total
    from allagent 
    left join allvoice on allagent.user_uuid = allvoice.user_uuid and allagent.daily = allvoice.daily and allagent.team_uuid = allvoice.team_uuid
    left join allchat on allagent.user_uuid = allchat.user_uuid and allagent.daily = allchat.daily and allagent.team_uuid = allchat.team_uuid
    left join allemail on allagent.user_uuid = allemail.user_uuid and allagent.daily = allemail.daily and allagent.team_uuid = allemail.team_uuid
    left join allsocial on allagent.user_uuid = allsocial.user_uuid and allagent.daily = allsocial.daily and allagent.team_uuid = allsocial.team_uuid
    left join alloffer on allagent.user_uuid = alloffer.user_uuid and allagent.daily = alloffer.daily and allagent.team_uuid = alloffer.team_uuid
    left join login_time on allagent.user_uuid = login_time.user_uuid and allagent.daily = date(login_time.started_at) and allagent.team_uuid = login_time.team_uuid
    left join logout_time on allagent.user_uuid = logout_time.user_uuid and allagent.daily = date(logout_time.started_at) and allagent.team_uuid = logout_time.team_uuid
    left join alltraning on allagent.user_uuid = alltraning.user_uuid and allagent.daily = alltraning.daily and allagent.team_uuid = alltraning.team_uuid
    left join allwork on allagent.user_uuid = allwork.user_uuid and allagent.daily = allwork.daily and allagent.team_uuid = allwork.team_uuid
    left join alloutbound on allagent.user_uuid = alloutbound.user_uuid and allagent.daily = alloutbound.daily and allagent.team_uuid = alloutbound.team_uuid
    left join allbreak on allagent.user_uuid = allbreak.user_uuid and allagent.daily = allbreak.daily and allagent.team_uuid = allbreak.team_uuid
    left join alllunch on allagent.user_uuid = alllunch.user_uuid and allagent.daily = alllunch.daily and allagent.team_uuid = alllunch.team_uuid
    left join alltyping on allagent.user_uuid = alltyping.user_uuid and allagent.daily = alltyping.daily and allagent.team_uuid = alltyping.team_uuid
    left join allprivate on allagent.user_uuid = allprivate.user_uuid and allagent.daily = allprivate.daily and allagent.team_uuid = allprivate.team_uuid
    left join allcoaching on allagent.user_uuid = allcoaching.user_uuid and allagent.daily = allcoaching.daily and allagent.team_uuid = allcoaching.team_uuid
    left join alljobassign on allagent.user_uuid = alljobassign.user_uuid and allagent.daily = alljobassign.daily and allagent.team_uuid = alljobassign.team_uuid
    left join allsick on allagent.user_uuid = allsick.user_uuid and allagent.daily = allsick.daily and allagent.team_uuid = allsick.team_uuid
    left join allcomplain on allagent.user_uuid = allcomplain.user_uuid and allagent.daily = allcomplain.daily and allagent.team_uuid = allcomplain.team_uuid
    left join allidle on allagent.user_uuid = allidle.user_uuid and allagent.daily = allidle.daily and allagent.team_uuid = allidle.team_uuid
    left join allreceive on allagent.user_uuid = allreceive.user_uuid and allagent.daily = allreceive.daily and allagent.team_uuid = allreceive.team_uuid
    left join alltalking on allagent.user_uuid = alltalking.user_uuid and allagent.daily = alltalking.daily and allagent.team_uuid = alltalking.team_uuid
    where alloffer.offer is not null
    order by allagent.business_units,allagent.teams,allagent.agent,allagent.daily
    ) as all_time)
    
    select *
from (
    select 
    daily,
    business_units,
    teams,
    agent,
	log_in,
    sec_to_time(log_out_new),
	time_to_sec(timediff(sec_to_time(log_out_new),log_in)) as logon_new,
    handledtime_voice,
    handledtime_chat,
    handledtime_email,
    handledtime_social,
	sum_receive,
	sum_talking,
    sum_traning,
    sum_working,
    sum_outbound,
    sum_break,
    sum_lunch,
    sum_typing,
    sum_private,
    sum_coaching,
    sum_jobassign,
    sum_sick,
    sum_complain,
    sum_idle,
    sum_total
    from main) all_main
    ;
    
END