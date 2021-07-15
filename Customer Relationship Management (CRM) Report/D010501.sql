Select t.topic,t.right_u_c_e_p,t.sub_topic,t.subco_topic,t.subject,
-- สิทธิ UC
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as UC_PP,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and t.subco_topic= 'UCEP',1,null)) as UC_UCEP,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and t.subco_topic= 'กรณีกองทุนไต',1,null)) as UC_KIDNEY,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as UC_HIV,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and t.subject = 'โรคมะเร็ง',1,null)) as UC_CANCER,

-- สิทธิ DIS
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as DIS_PP,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)' and t.subco_topic= 'UCEP',1,null)) as DIS_UCEP,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'  and t.subco_topic= 'กรณีกองทุนไต',1,null)) as DIS_KIDNEY,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as DIS_HIV,
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)' and t.subject = 'โรคมะเร็ง',1,null)) as DIS_CANCER,

-- สิทธิ OFC
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as OFC_PP,
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and t.subco_topic= 'UCEP',1,null)) as OFC_UCEP,
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and t.subco_topic= 'กรณีกองทุนไต',1,null)) as OFC_KIDNEY,
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as OFC_HIV,
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and t.subject = 'โรคมะเร็ง',1,null)) as OFC_CANCER,

-- สิทธิ SSS
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as SSS_PP,
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' and t.subco_topic= 'UCEP',1,null)) as SSS_UCEP,
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' and t.subco_topic= 'กรณีกองทุนไต',1,null)) as SSS_KIDNEY,
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as SSS_HIV,
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' and t.subject = 'โรคมะเร็ง',1,null)) as SSS_CANCER,

-- สิทธิ LGO
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as LGO_PP,
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.subco_topic= 'UCEP',1,null)) as LGO_UCEP,
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.subco_topic= 'กรณีกองทุนไต',1,null)) as LGO_KIDNEY,
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as LGO_HIV,
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and t.subject = 'โรคมะเร็ง',1,null)) as LGO_CANCER,


-- สิทธิอื่นๆ
count(if(t.right_u_c_e_p not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิข้าราชการ','สิทธิประกันสังคม','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น')  and t.subco_topic= 'ส่งเสริมสุขภาพและป้องกันโรค (PP)',1,null)) as ETC_PP,
count(if(t.right_u_c_e_p not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิข้าราชการ','สิทธิประกันสังคม','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and t.subco_topic= 'UCEP',1,null)) as ETC_UCEP,
count(if(t.right_u_c_e_p not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิข้าราชการ','สิทธิประกันสังคม','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น')  and t.subco_topic= 'กรณีกองทุนไต',1,null)) as ETC_KIDNEY,
count(if(t.right_u_c_e_p not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิข้าราชการ','สิทธิประกันสังคม','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and t.subco_topic= 'กองทุนผู้ติดเชื้อ HIV ผู้ป่วยเอดส์และผู้ป่วยวัณโรค',1,null)) as ETC_HIV,
count(if(t.right_u_c_e_p not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิข้าราชการ','สิทธิประกันสังคม','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and t.subject = 'โรคมะเร็ง',1,null)) as ETC_CANCER 


FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where
t.created_at between $P{start_date_time} and  $P{end_date_time} 
 and $X{IN,nhz.name,zone_name}