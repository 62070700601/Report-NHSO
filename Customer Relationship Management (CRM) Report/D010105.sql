SELECT nhz.name,nhz.id,pr.nhso_zone_id,pr.name as pr_name,t.incidprovin,t.right_u_c_e_p,month(t.created_at),t.topic,t.sub_topic,
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') ,1,NULL)) 'UC',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' ,1,NULL)) 'LGO',
count(if( t.right_u_c_e_p  = 'สิทธิข้าราชการ' ,1,NULL)) 'KARADCHAKARN',
count(if( t.right_u_c_e_p  = 'สิทธิประกันสังคม' ,1,NULL)) 'SSS',
count(if( t.right_u_c_e_p  not in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น','สิทธิข้าราชการ','สิทธิประกันสังคม') ,1,NULL)) 'notmain',
count(if( t.right_u_c_e_p  = '' ,1,NULL)) 'Notspecified'
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
t.topic in ('ร้องทุกข์','ร้องเรียน')
and month(t.created_at) between Month($P{start_date}) and  Month($P{end_date}) 
and $X{IN,nhz.name,zone_name}
group by nhz.name
order by nhz.name