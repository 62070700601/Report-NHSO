SELECT ROW_NUMBER() OVER (
		ORDER BY t.created_at
	) row_num,
t.topic,t.name,t.result,t.sub_topic,t.subco_topic,t.subject,t.open_date_time,t.close_date_time,
t.problemid,t.first_check,t.incidprovin,t.created_at,team.name as problem_owner,t.invoice_amount
from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
left join user
on t.created_by_id = user.id
left join team
on user.default_team_id = team.id 
where  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' 
and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง' and t.work_status = 'ยุติ'
and t.pass_to_new in ('[]','NULL')
and $X{IN,nhz.name,zone_name} 
and t.created_at between $P{start_date_time} and  $P{end_date_time}
order by t.created_at