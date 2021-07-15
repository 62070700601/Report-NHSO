SELECT t.topic,t.right_u_c_e_p,t.sub_topic,t.created_at, month(t.created_at),
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'standardgiveforpark.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' and month(t.created_at) = month($P{end_date}) ,1,NULL)) 'standardgiveforpark2.UC',

count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ถูกเรียกเก็บเงิน',1,NULL)) 'PRAYGFORMONEY.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ถูกเรียกเก็บเงิน' and month(t.created_at) = month($P{end_date}) ,1,NULL)) 'PRAYGFORMONEY2.UC',


count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,NULL)) 'MAIDAIRUBKWANSADUEAK.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' and month(t.created_at) = month($P{end_date}),1,NULL)) 'MAIDAIRUBKWANSADUEAK2.UC',


count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด',1,NULL)) 'MAIDAIRUBSID.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and month(t.created_at) = month($P{end_date}) ,1,NULL)) 'MAIDAIRUBSID2.UC',


count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,NULL)) 'standardgiveforpark.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' and month(t.created_at) = month($P{end_date}),1,NULL)) 'standardgiveforpark2.LGO',

count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ถูกเรียกเก็บเงิน',1,NULL)) 'PRAYGFORMONEY.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ถูกเรียกเก็บเงิน' and month(t.created_at) = month($P{end_date}),1,NULL)) 'PRAYGFORMONEY2.LGO',


count(if(t.right_u_c_e_p =   'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,NULL)) 'MAIDAIRUBKWANSADUEAK.LGO',
count(if(t.right_u_c_e_p =   'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' and month(t.created_at) = month($P{end_date}),1,NULL)) 'MAIDAIRUBKWANSADUEAK2.LGO',

count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด',1,NULL)) 'MAIDAIRUBSID.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' 
AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and month(t.created_at) = month($P{end_date}),1,NULL)) 'MAIDAIRUBSID2.LGO',


count(if(t.right_u_c_e_p =  'สิทธิหลักประกันสุขภาพแห่งชาติ',1,NULL)) 'ALLUC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,NULL)) 'ALLLGO'
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
t.created_at between $P{start_date} and  $P{end_date} 
AND t.topic = 'ร้องเรียน'
AND t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') 
and t.sub_topic in ('ไม่ได้รับความสะดวกตามสมควร','ไม่ได้รับบริการตามสิทธิที่กำหนด','ถูกเรียกเก็บเงิน','มาตรฐานการให้บริการสาธารณสุข')
-- and $X{IN,nhz.name,zone_name}
group by t.right_u_c_e_p,t.sub_topic
order by t.right_u_c_e_p,t.sub_topic