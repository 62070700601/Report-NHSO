SELECT nhz.name,nhz.id,pr.nhso_zone_id,pr.name,t.incidprovin,t.right_u_c_e_p,month(t.created_at),t.topic,t.sub_topic,
count(if(t.topic = 'ร้องทุกข์' and t.sub_topic = 'การลงทะเบียน' and t.subco_topic = 'ถูกเปลี่ยนหน่วยบริการ',1,NULL)) 'ALL',
count(if(work_status = 'ดำเนินการ',1,NULL)) 'Damnernkan',
count(if(work_status = 'ยุติ' and result_check = 'พลการ' ,1,NULL)) 'Ponglakarn',
count(if(work_status = 'ยุติ' and result_check = 'ไม่พลการ' ,1,NULL)) 'MaiPonglakarn',
count(if(work_status = 'ยุติ' and result_check = '' ,1,NULL)) 'ETC'
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where t.topic = 'ร้องทุกข์' and t.sub_topic = 'การลงทะเบียน' and t.subco_topic = 'ถูกเปลี่ยนหน่วยบริการ'
and $X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and  $P{end_date_time}

group by nhz.name
order by cast(substr(nhz.name,5) AS UNSIGNED)