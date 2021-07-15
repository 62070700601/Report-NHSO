CREATE DEFINER=`dev`@`%` PROCEDURE `agent_performance_login_time_final_no_team`(IN `start_date_param` DATE, IN `end_date_param` DATE, IN `agent_param` TEXT)
BEGIN
WITH
	allagent(daily,user_uuid,agent)
    AS(
		SELECT 
        date(`task-records`.started_at) as daily,
    `task-records`.user_uuid,
    CONCAT(`users`.first_name,
            ' ',
            `users`.last_name) AS agent
FROM
    `task-records`
        LEFT JOIN
    users ON `task-records`.user_uuid = users.uuid
    where date(`task-records`.started_at) between start_date_param and end_date_param
    and find_in_set(`task-records`.user_uuid, agent_param)
GROUP BY date(`task-records`.started_at), `task-records`.user_uuid
order by date(`task-records`.started_at),agent
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
        and find_in_set(`task-records`.user_uuid, agent_param)
        group by `task-records`.user_uuid,date(`task-records`.started_at)
    ),
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
		`agent-statuses`.business_unit_uuid is not null 
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
		`agent-statuses`.business_unit_uuid is not null 
	GROUP BY  `agent-statuses`.user_uuid, `agent-statuses`.started_at
	ORDER BY agent, date(`agent-statuses`.started_at), time(`agent-statuses`.started_at) ASC, `agent-statuses`.started_at ASC
    ) AS user
    where rank_no=1
    and date(started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
),
alltraning(sum_traning, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_traning,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'traning'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	allwork(sum_working, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_working,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'work'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alloutbound(sum_outbound, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_outbound,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'outbound'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    allbreak(user_uuid,daily,sum_break)
    AS (
    SELECT 
	`agent-statuses`.user_uuid,
	date(`agent-statuses`.started_at) as daily,
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_break
	FROM `agent-statuses`
        LEFT JOIN
    users ON `agent-statuses`.user_uuid = users.uuid
	where `agent-statuses`.reason = 'break'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(`agent-statuses`.user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alllunch(sum_lunch, user_uuid,daily)
    AS (
    SELECT
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_lunch,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'lunch'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
    
	alltyping(sum_typing, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_typing,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'typing_doc'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),    
	allprivate(sum_private, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_private,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'private'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allcoaching(sum_coaching, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_coaching,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'coaching'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alljobassign(sum_jobassign, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_jobassign,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'job_assign'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allsick(sum_sick, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_sick,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'sick'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allcomplain(sum_complain, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_complain,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'complain'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allidle(sum_idle, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_idle,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = ''
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	allreceive(sum_receive, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_receive,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'RECEIVING'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
	alltalking(sum_talking, user_uuid,daily)
    AS (
    SELECT 
	SUM(time_to_sec(timediff(`agent-statuses`.ended_at,`agent-statuses`.started_at))) as sum_talking,
	`agent-statuses`.user_uuid,
    date(`agent-statuses`.started_at) as daily
	FROM `agent-statuses`
	where `agent-statuses`.reason = 'TALKING'
    and date(`agent-statuses`.started_at) between start_date_param and end_date_param
    and find_in_set(user_uuid, agent_param)
	group by `agent-statuses`.user_uuid,date(`agent-statuses`.started_at)
    ),
main(daily,agent,log_in,log_out,logon_time,logon_time_sec,offwork_time,
sum_receive,sum_talking,sum_traning,sum_working,sum_outbound,sum_break,sum_lunch,
sum_typing,sum_private,sum_coaching,sum_jobassign,sum_sick,sum_complain,sum_idle,sum_total
)
AS (
select 
    daily,
    agent,
	log_in,
	log_out,
    sec_to_time(logon_time) as logon_time,
    logon_time as logon_time_sec,
   logon_time-sum_total as offwork_time,
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
    allagent.agent,
	TIME(login_time.started_at) as log_in,
	TIME(logout_time.ended_at) as log_out,
    time_to_sec(timediff(logout_time.ended_at,login_time.started_at)) as logon_time,
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
	left join alloffer on allagent.user_uuid = alloffer.user_uuid and allagent.daily = alloffer.daily 
    left join login_time on allagent.user_uuid = login_time.user_uuid and allagent.daily = date(login_time.started_at) 
    left join logout_time on allagent.user_uuid = logout_time.user_uuid and allagent.daily = date(logout_time.started_at) 
    left join alltraning on allagent.user_uuid = alltraning.user_uuid and allagent.daily = alltraning.daily 
    left join allwork on allagent.user_uuid = allwork.user_uuid and allagent.daily = allwork.daily 
    left join alloutbound on allagent.user_uuid = alloutbound.user_uuid and allagent.daily = alloutbound.daily
    left join allbreak on allagent.user_uuid = allbreak.user_uuid and allagent.daily = allbreak.daily 
    left join alllunch on allagent.user_uuid = alllunch.user_uuid and allagent.daily = alllunch.daily 
    left join alltyping on allagent.user_uuid = alltyping.user_uuid and allagent.daily = alltyping.daily 
    left join allprivate on allagent.user_uuid = allprivate.user_uuid and allagent.daily = allprivate.daily 
    left join allcoaching on allagent.user_uuid = allcoaching.user_uuid and allagent.daily = allcoaching.daily 
    left join alljobassign on allagent.user_uuid = alljobassign.user_uuid and allagent.daily = alljobassign.daily 
    left join allsick on allagent.user_uuid = allsick.user_uuid and allagent.daily = allsick.daily
    left join allcomplain on allagent.user_uuid = allcomplain.user_uuid and allagent.daily = allcomplain.daily
    left join allidle on allagent.user_uuid = allidle.user_uuid and allagent.daily = allidle.daily 
    left join allreceive on allagent.user_uuid = allreceive.user_uuid and allagent.daily = allreceive.daily 
    left join alltalking on allagent.user_uuid = alltalking.user_uuid and allagent.daily = alltalking.daily 
    where alloffer.offer is not null
    order by allagent.agent,allagent.daily
    ) as all_time)
    
    select *
from main
    ;
    
END