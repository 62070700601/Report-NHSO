SELECT  date_format(t.created_at, '%m-%y') as monthyear,date_format(t.created_at,'%y') as year,month(t.created_at) AS month,t.contact_id,c.id,c.typecont,t.right_u_c_e_p,
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
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and c.typecont = 'ประชาชน' ,1,NULL)) 'people.UC',
count(if(t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and c.typecont = 'ประชาชน',1,NULL)) 'people.LGO',
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and c.typecont = 'ประชาชน' ,1,NULL)) 'people.OFC',
count(if(t.right_u_c_e_p  = 'สิทธิประกันสังคม' and c.typecont = 'ประชาชน',1,NULL)) 'people.SSS',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' and c.typecont != 'ประชาชน' ,1,NULL)) 'service.UC',
count(if(t.right_u_c_e_p  = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and c.typecont != 'ประชาชน',1,NULL)) 'service.LGO',
count(if(t.right_u_c_e_p = 'สิทธิข้าราชการ' and c.typecont != 'ประชาชน' ,1,NULL)) 'service.OFC',
count(if(t.right_u_c_e_p  = 'สิทธิประกันสังคม' and c.typecont != 'ประชาชน',1,NULL)) 'service.SSS'

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
and c.id is not null 
group by monthyear
order by monthyear