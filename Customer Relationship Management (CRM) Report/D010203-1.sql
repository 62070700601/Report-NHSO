SELECT ROW_NUMBER() OVER (
		ORDER BY t.name
	) row_num,
t.topic,t.name,t.result,t.sub_topic,t.subco_topic,t.subject,t.open_date_time,
t.close_date_time,t.problemid,t.first_check,t.incidprovin,t.created_at,month(t.created_at)
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
t.created_at between $P{start_date} and  $P{end_date}  and 
$X{IN,nhz.name,zone_name}
and t.topic = 'ร้องเรียน' and t.result = ''
order by t.name