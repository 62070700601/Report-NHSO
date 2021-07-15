select t.right_u_c_e_p,t.topic,t.sub_topic,t.subco_topic,t.created_at, date_format(t.created_at,'%b %y') as monthyear,date_format(t.created_at,'%y') as year,month(t.created_at) AS month,
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
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,NULL)) 'UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' ,1,NULL)) 'LGO',
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' ,1,NULL)) 'OFC',
count(if(t.right_u_c_e_p = 'สิทธิประกันสังคม' ,1,NULL)) 'SSS',
count(if(t.right_u_c_e_p NOT IN ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น','สิทธิข้าราชการ','สิทธิประกันสังคม' ),1,NULL)) 'ETC'
from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
where 
t.created_at between $P{start_date_time} and  $P{end_date_time}
and $X{IN,nhz.name,zone_name} and
t.topic = 'ประสานหาเตียง' and t.sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and t.subco_topic = 'UCEP'
group by monthyear
order by monthyear