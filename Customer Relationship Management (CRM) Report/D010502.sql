Select t.topic,t.right_u_c_e_p,t.sub_topic,t.subco_topic,t.subject,
-- ร้องเรียน ไม่มี UCEP
count(if(t.topic = 'ร้องเรียน' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as PP_RONGRERNG,
count(if(t.topic = 'ร้องเรียน' and t.subco_topic= 'กรณีกองทุนไต',1,null)) as TAI_RONGRERNG,
count(if(t.topic = 'ร้องเรียน' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค' and t.subject = 'HIV/AIDS (เอดส์)',1,null)) as HIV_RONGRERNG,
count(if(t.topic = 'ร้องเรียน' and t.subco_topic= 'กองทุนพัฒนาระบบบริการตติยภูมิเฉพาะด้าน' and t.subject = 'โรคมะเร็ง',1,null)) as CANCER_RONGRERNG,

-- ร้องทุกข์
count(if(t.topic = 'ร้องทุกข์' and t.sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน',1,null)) UCEP_RONGTUK,
count(if(t.topic = 'ร้องทุกข์' and t.subject = 'กรณีกองทุนไต',1,null)) TAI_RONGTUK,
count(if(t.topic = 'ร้องทุกข์' and t.subject = 'HIV/AIDS (เอดส์)',1,null)) HIV_RONGTUK,
count(if(t.topic = 'ร้องทุกข์' and t.subject = 'โรคมะเร็ง',1,null)) CANCER_RONGTUK

FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where
t.created_at between $P{start_date_time} and  $P{end_date_time} 
and $X{IN,nhz.name,zone_name}
and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')