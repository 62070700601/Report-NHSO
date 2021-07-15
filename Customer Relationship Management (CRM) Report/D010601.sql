select concat(month(t.created_at),"-",year(t.created_at)),t.problemid,t.name,t.identification_no,t.gender,t.age,
t.right_a,t.right_b,t.right_e,h.service_right_e.password_right_e,t.right_f,service_unit.password_service,t.right_g,
service_right_g.password_right_g,t.right_d,if(t.right_d = 'กรุงเทพฯ','1000',service_right_d.password_right_d) as passwordright_d
,t.channel,t.right_u_c_e_p,t.topic,sub_topic,t.subco_topic,t.subject,t.urgent,if(h.province_id = pr.id,pr.name,null) as province_service,h.name,h.h_code
,h.type_name,h.sub_type_name,t.incidprovin,pr.province_code,nhz.name,date(t.happend_date_time) as happen_date,time(t.happend_date_time) as happen_time,t.patient_type,t.disease,t.conclusion,t.summary,
t.first_check,t.result,t.another,date(t.open_date_time) as open_date,time(t.open_date_time) as open_time,date(t.close_date_time) as close_date,time(t.close_date_time) as close_time,timestampdiff(day,t.created_at,t.close_date_time),
problemer.creatbyfullname,user.user_type,problemer.nhso_zone__name,problemer.province__name,problemer.hospital__name,
assigneduser.assignedusername,gruopassigned.groupname,owner.owner_zone,owner.owner_province,owner.owner_hospital,
concat(c.first_name," ",c.last_name) as informer,t.relation,call.source as phone_number,t.invoice_list,t.service_detail,t.rejected_unit,rejected_result,
t.invoice_amount,earn_amount,t.problem,t.apply_person,t.cause,t.problem_drug,t.problem_naming,t.healing_unit,result_check_ticket.resultticket,
result_check_ticket.causeticket,t.return_right,t.return_cause,t.require_topic,
t.work_status,t.meeting_date,t.book_date,t.description,t.how_to_fix,t.created_at


from ticket t
left join hospital h
on t.hospital_id = h.id
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
left join user
on t.created_by_id = user.id
left join team
on user.default_team_id = team.id
left join contact c
on t.contact_id = c.id
left join unixcapecrm.call
on t.id  = call.ticket_id

-- right_e
left join(
	select hospital.h_code as password_right_e,ticket.id as tid_right_e
	FROM ticket
	left join hospital
	on ticket.right_e = hospital.name	   
    )service_right_e  ON service_right_e.tid_right_e = t.id


-- right_f
left join(
	select hospital.h_code as password_service,ticket.id as tt
	FROM ticket
	left join hospital
	on ticket.right_f = hospital.name	   
    )service_unit  ON service_unit.tt = t.id
    
-- right_g
left join(
	select hospital.h_code as password_right_g,ticket.id as tid_right_g
	FROM ticket
	left join hospital
	on ticket.right_g = hospital.name	   
    )service_right_g  ON service_right_g.tid_right_g = t.id
    
-- right_d
left join(
	select province.province_code as password_right_d,ticket.id as tid_right_d
	FROM ticket
	left join province
	on ticket.right_d = province.name	   
    )service_right_d  ON service_right_d.tid_right_d = t.id
    
-- assigneduser
left join(
	select concat(user.first_name," ",user.last_name) as assignedusername,ticket.id as tid_assigneduser
	FROM ticket
	left join user
	on ticket.assigned_user_id = user.id	   
    )assigneduser  ON assigneduser.tid_assigneduser = t.id
    
-- gruopassigned
left join(
	select u.user_type as groupname,ticket.id as tid_gruopassigned
	FROM ticket
	left join user u
	on ticket.assigned_user_id = u.id
	left join team te
	on u.default_team_id = te.id
    )gruopassigned  ON gruopassigned.tid_gruopassigned = t.id

-- result_check
left join(
	select ticket.result_check as resultticket,ticket.id as tid_resultcheck,ticket.result_cause as causeticket
	FROM ticket
    where ticket.result_check = 'พลการ'
    )result_check_ticket  ON result_check_ticket.tid_resultcheck = t.id
    


-- เขต,จังหวัดสังกัด ชื่อผู้รับปัญหา
left join(
	select  concat(user.first_name," ",user.last_name) as creatbyfullname,
	nhso_zone.name as nhso_zone__name,province.name as province__name,hospital.name as hospital__name,
    ticket.id as tid_created_by_id
	FROM ticket
	left join user
	on ticket.created_by_id = user.id
    left join province
    on user.province_id = province.id
    left join nhso_zone
    on user.nhso_zone_id = nhso_zone.id
    left join hospital
    on ticket.hospital_id = hospital.id

    )problemer ON problemer.tid_created_by_id = t.id
    
-- เขตจังหวัดเจ้าของปัญหา
left join(
	select concat(user.first_name," ",user.last_name) as assignedusername,ticket.id as tid_assigneduser,
    province.name as owner_province,nhso_zone.name as owner_zone,hospital.name as owner_hospital
	FROM ticket
	left join user
	on ticket.assigned_user_id = user.id
    left join province
    on user.province_id = province.id
    left join nhso_zone
    on user.nhso_zone_id = nhso_zone.id
    left join hospital
    on ticket.hospital_id = hospital.id
    )owner ON owner.tid_assigneduser = t.id

    
where  
t.created_at between $P{start_date_time} and  $P{end_date_time}
and $X{IN,nhz.name,zone_name}
and $X{IN,t.topic,topic}
and t.topic != 'สอบถาม'  and t.topic != 'null'
group by t.problemid
order by concat(month(t.created_at),"-",year(t.created_at))