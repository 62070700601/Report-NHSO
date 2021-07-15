SELECT nhz.name,nhz.id,pr.nhso_zone_id,pr.name as pr_name,t.incidprovin,t.right_u_c_e_p,month(t.created_at),t.topic,t.sub_topic,t.first_check,
count(t.sub_topic),
count(if( t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'UC.Standardservice',
count(if( t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'LGO.Standardservice',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'UC.Cannotease',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'LGO.Cannotease',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'UC.Keepmoney',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'LGO.Keepmoney',
count(if( t.right_u_c_e_p  in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'UC.RightCannotSerivce',
count(if( t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'LGO.RightCannotSerivce',
(select count(t.right_u_c_e_p) FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin where t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น')
and t.sub_topic in ('มาตรฐานการให้บริการสาธารณสุข','ไม่ได้รับความสะดวกตามสมควร', 'ถูกเรียกเก็บเงิน','ไม่ได้รับบริการตามสิทธิที่กำหนด') and topic = 'ร้องเรียน' and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง') as Percentage
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and topic = 'ร้องเรียน' 
and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง' AND t.work_status = 'ยุติ' 
and $X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and  $P{end_date_time}
AND t.pass_to_new = '[]'
group by nhz.name
order by cast(substr(nhz.name,5) AS UNSIGNED)