CREATE DEFINER=`dev`@`%` PROCEDURE `agent_performance_login`(IN `start_date_param` DATE, IN `end_date_param` DATE,IN `business_units_param` TEXT, IN `team_param` TEXT, IN `agent_param` TEXT)
BEGIN
WITH
    
    allvoice(user_uuid,business_units,teams,agent,daily,handled_voice, handledtime_voice, handledtime_voice_min, handledtime_voice_max)
    AS (
		SELECT 
    `agent-task-records`.user_uuid,
        `business-units`.name AS business_units,
		teams.name AS teams,
        CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent,
    date(`agent-task-records`.started_at) as daily,
	count(`agent-task-records`.uuid) as handled_voice,
	sum(`agent-task-records`.duration_sec) as handledtime_voice,
	min(`agent-task-records`.duration_sec) as handledtime_voice_min,
	max(`agent-task-records`.duration_sec) as handledtime_voice_max
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
    
    allchat(daily,handled_chat, handledtime_chat, handledtime_chat_min, handledtime_chat_max, user_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	count(uuid) as handled_chat,
	sum(duration_sec) as handledtime_chat,
	min(duration_sec) as handledtime_chat_min,
	max(duration_sec) as handledtime_chat_max,
    `agent-task-records`.user_uuid
	FROM `agent-task-records`
	where channel_type = 'chat'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    
    allemail(daily,handled_email, handledtime_email, handledtime_email_min, handledtime_email_max, user_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	count(uuid) as handled_email,
	sum(duration_sec) as handledtime_email,
	min(duration_sec) as handledtime_email_min,
	max(duration_sec) as handledtime_email_max,
    `agent-task-records`.user_uuid
	FROM `agent-task-records`
	where channel_type = 'email'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    
    allsocial(daily,handled_social, handledtime_social, handledtime_social_min, handledtime_social_max, user_uuid)
    AS (
	SELECT 
    date(`agent-task-records`.started_at) as daily,
	count(uuid) as handled_social,
	sum(duration_sec) as handledtime_social,
	min(duration_sec) as handledtime_social_min,
	max(duration_sec) as handledtime_social_max,
    `agent-task-records`.user_uuid
	FROM `agent-task-records`
	where channel_type = 'social'
	and type = 'answer'
    and date(`agent-task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
    and find_in_set(`agent-task-records`.team_uuid, team_param)
    and find_in_set(`agent-task-records`.user_uuid, agent_param)
	group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    
    ),
    
    allanswer (daily,answer, user_uuid)
    AS (
		SELECT
        date(`agent-task-records`.started_at) as daily,
		count(uuid) as answer,
        `agent-task-records`.user_uuid
		FROM `agent-task-records`
		where type ='answer'
        and date(`agent-task-records`.started_at) between start_date_param and end_date_param
		and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
		and find_in_set(`agent-task-records`.team_uuid, team_param)
        and find_in_set(`agent-task-records`.user_uuid, agent_param)
        group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    ),
    
    allmiss (daily,miss, user_uuid)
    AS (
		SELECT
        date(`agent-task-records`.started_at) as daily,
		count(uuid) as miss,
        `agent-task-records`.user_uuid
		FROM `agent-task-records`
		where type ='miss'
        and date(`agent-task-records`.started_at) between start_date_param and end_date_param
		and find_in_set(`agent-task-records`.business_unit_uuid, business_units_param)
		and find_in_set(`agent-task-records`.team_uuid, team_param)
        and find_in_set(`agent-task-records`.user_uuid, agent_param)
        group by `agent-task-records`.business_unit_uuid, `agent-task-records`.team_uuid, `agent-task-records`.user_uuid,date(`agent-task-records`.started_at)
    ),
    
    alloffer (daily,offer, user_uuid)
    AS (
		SELECT
        date(`task-records`.started_at) as daily,
		count(uuid) as miss,
        `task-records`.user_uuid
		FROM `task-records`
        where date(`task-records`.started_at) between start_date_param and end_date_param
        and `task-records`.user_uuid is not null
		and find_in_set(`task-records`.business_unit_uuid, business_units_param)
		and find_in_set(`task-records`.team_uuid, team_param)
        and find_in_set(`task-records`.user_uuid, agent_param)
        group by `task-records`.business_unit_uuid, `task-records`.team_uuid, `task-records`.user_uuid,date(`task-records`.started_at)
    ),
    logout_time(business_unit, user_uuid, agent, status, team, started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
		`business-units`.name as business_unit,
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
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

login_time(business_unit, user_uuid, agent, status, team, started_at, ended_at, rank_no)
    AS (SELECT 
	*
FROM (
	SELECT 	
		`business-units`.name as business_unit,
        `agent-statuses`.user_uuid,
		CONCAT(`users`.first_name, ' ' ,`users`.last_name) as agent,
		`agent-statuses`.status,
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
)

    select 
    allvoice.business_units,
    allvoice.teams,
    allvoice.agent,
    allvoice.daily,
	login_time.started_at as log_in,
	logout_time.ended_at as log_out,
    ifnull(alloffer.offer,0) as offered,
    ifnull(allanswer.answer,0) as answer,
    ifnull(allmiss.miss,0) as miss,
    ifnull((ifnull(allanswer.answer,0)*100)/ifnull(alloffer.offer,0),0) as handled_per,
    ifnull(allvoice.handled_voice,0) as handled_voice,
    ifnull(allvoice.handledtime_voice,0) as handledtime_voice,
    ifnull(allvoice.handledtime_voice_min,0) as handledtime_voice_min,
    ifnull(allvoice.handledtime_voice_max,0) as handledtime_voice_max,
    ifnull(allchat.handled_chat,0) as handled_chat,
    ifnull(allchat.handledtime_chat,0) as handledtime_chat,
    ifnull(allchat.handledtime_chat_min,0) as handledtime_chat_min,
    ifnull(allchat.handledtime_chat_max,0) as handledtime_chat_max,
	ifnull(allemail.handled_email,0) as handled_email,
    ifnull( allemail.handledtime_email,0) as handledtime_email,
    ifnull(allemail.handledtime_email_min,0) as handledtime_email_min,
    ifnull(allemail.handledtime_email_max,0) as handledtime_email_max,
    ifnull(allsocial.handled_social,0) as handled_social,
    ifnull(allsocial.handledtime_social,0) as handledtime_social,
    ifnull(allsocial.handledtime_social_min,0) as handledtime_social_min,
    ifnull(allsocial.handledtime_social_max,0) as handledtime_social_max,
    ifnull((ifnull(allvoice.handled_voice,0)*100)/ifnull(answer,0),0) as handled_voice_per,
    ifnull((ifnull(allchat.handled_chat,0)*100)/ifnull(answer,0),0) as handled_chat_per,
   ifnull((ifnull(allemail.handled_email,0)*100)/ifnull(answer,0),0) as handled_email_per,
   ifnull((ifnull(allsocial.handled_social,0)*100)/ifnull(answer,0),0) as handled_social_per
    from allvoice
    left join allchat on allvoice.user_uuid = allchat.user_uuid and allvoice.daily = allchat.daily
    left join allemail on allvoice.user_uuid = allemail.user_uuid and allvoice.daily = allemail.daily
    left join allsocial on allvoice.user_uuid = allsocial.user_uuid and allvoice.daily = allsocial.daily
    left join alloffer on allvoice.user_uuid = alloffer.user_uuid and allvoice.daily = alloffer.daily
    left join allanswer on allvoice.user_uuid = allanswer.user_uuid and allvoice.daily = allanswer.daily
    left join allmiss on allvoice.user_uuid = allmiss.user_uuid and allvoice.daily = allmiss.daily
    left join login_time on allvoice.user_uuid = login_time.user_uuid and allvoice.daily = date(login_time.started_at)
    left join logout_time on allvoice.user_uuid = logout_time.user_uuid and allvoice.daily = date(logout_time.started_at)
    where alloffer.offer is not null
    order by allvoice.business_units,allvoice.teams,allvoice.agent,allvoice.daily
    ;
    
END