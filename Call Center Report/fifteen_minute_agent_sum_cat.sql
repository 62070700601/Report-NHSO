CREATE DEFINER=`dev`@`%` PROCEDURE `fifteen_minute_agent_sum_cat`(IN `startDate` DATE, IN `endDate` DATE, IN `startTime` TIME, IN `endTime` TIME, IN `setInterval` INT, IN `bu_param` TEXT, IN `team_param` TEXT, IN `cat_param` TEXT, IN `agent_param` TEXT)
BEGIN
-- 	SET GLOBAL time_zone = 'Asia/Bangkok';
	set @startDate = startDate;
	set @endDate = endDate;
	set @startTime = concat("2019-07-01 ",startTime);
    
	set @endTime = concat("2019-07-01 ",endTime);
	set @setInterval = setInterval;
	set @numberOfSlot = time_to_sec(timediff(@endTime,@startTime))/60/@setInterval;
	WITH RECURSIVE date_list (n,d) 
	AS (
		  SELECT 0, CAST(date_add(@startDate, INTERVAL 0 day) AS DATE)
		  UNION ALL
		  SELECT n + 1, CAST(date_add(@startDate, INTERVAL n+1 day) AS DATE)
		  FROM date_list 
		  WHERE n < datediff(@endDate,@startDate)
		),
	slot_list (n,slot,label) AS
		(
		  SELECT 0, 
			concat("t",lpad(hour(@startTime),2,0),lpad(minute(@startTime),2,0)) as slot,
			concat(lpad(hour(@startTime),2,0),":",lpad(minute(@startTime),2,0)) as label
		  UNION ALL
		  SELECT n + 1, 
			concat("t",lpad(hour(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0),lpad(minute(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0)) as slot,
			concat(lpad(hour(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0),":",lpad(minute(TIMESTAMPADD(MINUTE,(n+1)*@setInterval,@startTime)),2,0)) as label
		  FROM slot_list 
		  WHERE n < @numberOfSlot 
		),
	cat_records (bu_uuid,Business_units,team_uuid,team) AS
		(
						SELECT 
                        `business-units`.uuid,
                        `business-units`.name,
                        `teams`.uuid,
						`teams`.name
					from callcenter.`task-records`
						LEFT OUTER JOIN `teams` ON
						`task-records`.`team_uuid` = `teams`.`uuid`
						LEFT OUTER JOIN `business-units` ON
					`task-records`.`business_unit_uuid` = `business-units`.uuid
        ),
	cat_list (b_id,b,c_id,c) AS
		(
			SELECT 
            bu_uuid,Business_units,team_uuid,team from cat_records
            where find_in_set(bu_uuid, bu_param)
			and find_in_set(team_uuid, team_param)
            group by bu_uuid, team
		),
	all_list (b,c,d,slot,label) AS
		(
			SELECT cat_list.b, cat_list.c, date_list.d, slot_list.slot, slot_list.label FROM date_list cross join slot_list cross join cat_list
			ORDER BY cat_list.b, cat_list.c, date_list.d, slot_list.slot
		),
	tasks (Date,Business_units,team,categories,agent,Slot,Count,inbound_incoming,answer,abandon,uninterest,outbound_incoming,answer_out,no_answer,inservice,hold,waiting,no_of_hold,avg_inservice,avg_hold,avg_queue) AS
		(
			SELECT 
				`task-records`.`started_at` AS `Date`,
                `business-units`.`name` AS `Business_units`,
				`teams`.`name` AS `team`,
                `categories`.name as categories,
                CONCAT(`users`.first_name, ' ' , `users`.last_name) as agent,
				CONCAT('t',
					LPAD(HOUR(`task-records`.`started_at`),
							2,
							0),
					LPAD((FLOOR((MINUTE(`task-records`.`started_at`) / @setInterval)) * @setInterval),
							2,
							0)) AS `Slot`,
				COUNT(CONCAT('t',
					LPAD(HOUR(`task-records`.`started_at`),
							2,
							0),
					LPAD((FLOOR((MINUTE(`task-records`.`started_at`) / @setInterval)) * @setInterval),
							2,
							0))) AS `Slot_count`,
			COUNT(IF(`task-records`.direction = 'inbound', 1 , NULL)) 'inbound_incoming',
			COUNT(IF(`task-records`.`type` = 'answer' and `task-records`.direction = 'inbound', 1 , NULL)) 'answer',
			COUNT(IF(`task-records`.`type` = 'abandon' and `task-records`.direction = 'inbound', 1 , NULL)) 'abandon',
             COUNT(IF(`task-records`.type = 'uninterest' and `task-records`.direction = 'inbound', 1 , NULL)) 'uninterest',
		COUNT(IF(`task-records`.direction = 'outbound', 1 , NULL)) 'outbound_incoming',
		COUNT(IF(`task-records`.type = 'answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'answer_out',
		COUNT(IF(`task-records`.type = 'no_answer' and `task-records`.direction = 'outbound', 1 , NULL)) 'no_answer',
			sum(inservice_duration_sec) as inservice,
            IFNULL(sum(`task-holds`.duration_sec),0) as hold,
            sum(wait_duration_sec) as waiting,
            COUNT(`task-holds`.duration_sec) as no_of_hold,
			AVG(inservice_duration_sec) as avg_inservice,
			IFNULL(AVG(`task-holds`.duration_sec),0) as avg_hold,
			AVG(wait_duration_sec) as avg_queue
			FROM
				(`task-records`
                LEFT JOIN `business-units` ON ((`business-units`.`uuid` = `task-records`.`business_unit_uuid`))
				LEFT JOIN `teams` ON ((`teams`.`uuid` = `task-records`.`team_uuid`))
                left join `task-holds` on `task-records`.reference_uuid = `task-holds`.reference_uuid
                left join `users` on `task-records`.user_uuid = `users`.uuid
                left join `categories` on `task-records`.category_uuid = `categories`.uuid
                )
			WHERE
					((date(`task-records`.`started_at`)) BETWEEN @startDate AND @endDate)
                and find_in_set(`task-records`.`business_unit_uuid`, bu_param)
				and find_in_set(`teams`.`uuid`, team_param)
                and find_in_set(`categories`.uuid, cat_param)
                and find_in_set(`task-records`.user_uuid, agent_param)
                and `users`.uuid is not null
			GROUP BY `task-records`.`business_unit_uuid`, `teams`.`uuid` ,`task-records`.user_uuid, `categories`.uuid,`Date` , `Slot`
			ORDER BY `business-units`.`name`, `teams`.`name`, agent, categories, `Date`
		)
        
		SELECT all_list.b,all_list.c,all_list.d,all_list.slot,all_list.label,tasks.agent,tasks.categories,
        SUM(tasks.Count) AS task_count, 
		SUM(IFNULL(tasks.inbound_incoming,0)) AS inbound_incoming, 
        SUM(IFNULL(tasks.answer,0)) AS answer_count, 
        SUM(IFNULL(tasks.abandon,0)) AS abandon_count,
        SUM(IFNULL(tasks.uninterest,0)) AS uninterest,
        SUM(IFNULL(tasks.outbound_incoming,0)) AS outbound_incoming,
        SUM(IFNULL(tasks.answer_out,0)) AS answer_out,
        SUM(IFNULL(tasks.no_answer,0)) AS no_answer,
		SUM(tasks.inservice) as inservice,
        SUM(IFNULL(tasks.hold,0)) as hold,
        SUM(tasks.waiting) as waiting,
		SUM(tasks.no_of_hold) as no_of_hold,
        AVG(tasks.avg_inservice) as avg_inservice,
        AVG(IFNULL(tasks.avg_hold,0)) as avg_hold,
        AVG(tasks.avg_queue) as avg_queue
        from all_list
		LEFT JOIN tasks		    ON date(all_list.d)=date(tasks.Date)         AND all_list.slot=tasks.slot         AND all_list.c=tasks.team         AND all_list.b=tasks.Business_units
		WHERE tasks.Count is not null
        group by all_list.b,all_list.c,tasks.agent, tasks.categories, all_list.d, all_list.slot
        ORDER BY all_list.b,all_list.c,tasks.agent, tasks.categories, all_list.d, all_list.slot;
END