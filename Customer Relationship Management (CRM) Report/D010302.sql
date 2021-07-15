select t.right_u_c_e_p,t.sub_topic,t.subco_topic,t.subject,t.created_at, date_format(t.created_at,'%b %y') as monthyear,date_format(t.created_at,'%y') as year,month(t.created_at) AS month,
CASE
    WHEN month(t.created_at) = '01' THEN 'ม.ค.'
    WHEN month(t.created_at) = '02' THEN 'ก.พ.'
    WHEN month(t.created_at) = '03' THEN 'มี.ค.'
    WHEN month(t.created_at) = '04' THEN 'เม.ย'
    WHEN month(t.created_at) = '05' THEN 'พ.ค.'
    WHEN month(t.created_at) = '06' THEN 'มิ.ย.'
    WHEN month(t.created_at) = '07' THEN 'ก.ค.'
    WHEN month(t.created_at) = '08' THEN 'ส.ค.'
    WHEN month(t.created_at) = '09' THEN 'ก.ย.'
    WHEN month(t.created_at) = '10' THEN 'ต.ค.'
    WHEN month(t.created_at) = '11' THEN 'พ.ย.'
	WHEN month(t.created_at) = '12' THEN 'ธ.ค.'
    ELSE ""
    
    
END as monthfontthai ,
count(if(t.subco_topic = 'รพ.ปฏิเสธการใช้สิทธิ' and t.subject = 'รพ.ไม่เบิก' ,1,NULL)) 'hospitaldeny.hospitalmaiberk',
count(if(t.subco_topic = 'รพ.ปฏิเสธการใช้สิทธิ' and t.subject = 'รพ.เบิกให้ร่วมจ่าย' ,1,NULL)) 'hospitaldeny.hospitalhairuamjaey',
count(if(t.subco_topic = 'รพ.ปฏิเสธการใช้สิทธิ' and t.subject = 'อื่นๆ' ,1,NULL)) 'hospitaldeny.etc',
count(if(t.subco_topic = 'รพ.ปฏิเสธการใช้สิทธิ' and t.subject in ('รพ.ไม่เบิก','รพ.เบิกให้ร่วมจ่าย','อื่นๆ') ,1,NULL)) 'hospitaldeny.all',
count(if(t.subco_topic = 'ผลการพิจารณาโปรแกรมชดเชยค่าบริการ' and t.subject = 'ทบทวนการจ่าย' ,1,NULL)) 'chodchery.tobtuankhanjaey',
count(if(t.subco_topic = 'ผลการพิจารณาโปรแกรมชดเชยค่าบริการ' and t.subject = 'ไม่เข้าเกณฑ์นโยบายบูรณาการเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'chodchery.maikaowkengt',
count(if(t.subco_topic = 'ผลการพิจารณาโปรแกรมชดเชยค่าบริการ' and t.subject = 'อื่นๆ' ,1,NULL)) 'chodchery.etc',
count(if(t.subco_topic = 'ผลการพิจารณาโปรแกรมชดเชยค่าบริการ' and t.subject in ('ทบทวนการจ่าย', 'ไม่เข้าเกณฑ์นโยบายบูรณาการเจ็บป่วยฉุกเฉิน','อื่นๆ') ,1,NULL)) 'chodchery.all',
count(if(t.subco_topic = 'ผลการพิจารณาคณะกรรมการฯ' and t.subject = 'ไม่เข้าเกณฑ์นโยบายบูรณาการเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'resultconsider.maikaowkengt',
count(if(t.subco_topic = 'ผลการพิจารณาคณะกรรมการฯ' and t.subject = 'อื่นๆ' ,1,NULL)) 'resultconsider.etc',
count(if(t.subco_topic = 'ผลการพิจารณาคณะกรรมการฯ' and t.subject in ('ไม่เข้าเกณฑ์นโยบายบูรณาการเจ็บป่วยฉุกเฉิน','อื่นๆ') ,1,NULL)) 'resultconsider.all',
count(if(t.subco_topic = 'อื่นๆ' and t.subject = 'อื่นๆ' ,1,NULL)) 'etc.etc',
count(if(t.subco_topic = '' ,1,NULL)) 'subcotopic.null',
count(if(t.subco_topic in ('รพ.ปฏิเสธการใช้สิทธิ','ผลการพิจารณาโปรแกรมชดเชยค่าบริการ','ผลการพิจารณาคณะกรรมการฯ','อื่นๆ') and t.subject = '' ,1,NULL)) 'subject.null'
from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
left join contact c
on t.contact_id = c.id
where
t.created_at between $P{start_date_time} and  $P{end_date_time}
and $X{IN,nhz.name,zone_name}
and topic = 'ร้องทุกข์' and right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน'
group by monthyear
order by monthyear