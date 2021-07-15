SELECT nhz.name,nhz.id,pr.nhso_zone_id,pr.name as pr_name,t.incidprovin,t.right_u_c_e_p,month(t.created_at),t.topic,t.sub_topic,count(t.sub_topic) as tt,ALLRESULT.allproduct,
count(if( t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'UC.Standardservice',
count(if( t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'LGO.Standardservice',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'UC.Cannotease',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'LGO.Cannotease',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'UC.Keepmoney',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'LGO.Keepmoney',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'UC.RightCannotSerivce',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'LGO.RightCannotSerivce'


FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
cross join (select sumall as allproduct from fff) as ALLRESULT
where 
t.created_at between $P{start_date} and  $P{end_date} 
and $X{IN,nhz.name,zone_name}
and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') 
and topic = 'ร้องเรียน'

group by nhz.name
order by CAST(SUBSTR(nhz.name FROM 5) AS UNSIGNED)