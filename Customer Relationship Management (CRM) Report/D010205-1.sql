SELECT ROW_NUMBER() OVER (
		ORDER BY t.created_at
	) row_num,
t.topic,t.name,t.result,t.sub_topic,t.subco_topic,t.subject,t.open_date_time,t.close_date_time,t.problemid,
t.first_check,t.incidprovin,t.service_unit,t.problems,t.created_at,month(t.created_at),nhz.name
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
t.created_at between $P{start_date_time} and  $P{end_date_time} and 
(service_unit is null or service_unit = '')  and topic = 'ร้องเรียน'
and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
and t.work_status = 'ยุติ' 
AND t.pass_to_new = '[]'
order by t.created_at