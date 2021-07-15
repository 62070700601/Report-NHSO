select t.topic,t.sub_topic,t.subco_topic,t.right_u_c_e_p,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subco_topic = 'กรณีกองทุนไต' 
,1,null)) as UC1,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'CAPD (ล้างไตผ่านช่องท้อง)',1,null)) as UC1_1,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'Hemodialysis HD (ฟอกเลือดล้างไต)',1,null)) as UC1_2,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'Kidney Transplantation KT (ปลูกถ่ายไต)',1,null)) as UC1_3,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'อื่นๆ',1,null)) as UC1_4,

count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' and t.subco_topic = 'กรณีกองทุนไต' ,1,null)) as UC2,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' and t.subco_topic = 'กรณีกองทุนไต' ,1,null)) as UC3,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subco_topic = 'กรณีกองทุนไต' ,1,null)) as UC4,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'CAPD (ล้างไตผ่านช่องท้อง)',1,null)) as UC4_1,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'Hemodialysis HD (ฟอกเลือดล้างไต)',1,null)) as UC4_2,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'Kidney Transplantation KT (ปลูกถ่ายไต)',1,null)) as UC4_3,
count(if(t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subco_topic = 'กรณีกองทุนไต' 
and t.subject = 'อื่นๆ',1,null)) as UC4_4,

count(if(t.topic = 'ร้องทุกข์' and t.sub_topic = 'ขอความช่วยเหลือ' 
and t.subject = 'กรณีกองทุนไต' ,1,null)) as UC5
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
$X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and  $P{end_date_time}