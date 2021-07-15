Select t.right_u_c_e_p,t.topic,t.infor,nhz.name,
count(if( nhz.name = 'เขต 1 เชียงใหม่',1,null)) as UCEP_CHAINGMAI,
count(if( nhz.name = 'เขต 2 พิษณุโลก',1,null)) as UCEP_PISANULOK,
count(if( nhz.name = 'เขต 3 นครสวรรค์',1,null)) as UCEP_NAKORNSAWAN,
count(if(nhz.name = 'เขต 4 สระบุรี',1,null)) as UCEP_SARABURI,
count(if( nhz.name = 'เขต 5 ราชบุรี',1,null)) as UCEP_RACBURI,
count(if( nhz.name = 'เขต 6 ระยอง',1,null)) as UCEP_RAYONG,
count(if( nhz.name = 'เขต 7 ขอนแก่น',1,null)) as UCEP_KHOENKAEN,
count(if( nhz.name = 'เขต 8 อุดรธานี',1,null)) as UCEP_UDONTANI,
count(if( nhz.name = 'เขต 9 นครราชสีมา',1,null)) as UCEP_NAKORNRASCHASIMA,
count(if( nhz.name = 'เขต 10 อุบลราชธานี',1,null)) as UCEP_UBONRACTHANI,
count(if( nhz.name = 'เขต 11 สุราษฎร์ธานี',1,null)) as UCEP_SURADTHANE,
count(if(nhz.name = 'เขต 12 สงขลา',1,null)) as UCEP_SONGKHA,
count(if( nhz.name = 'เขต 13 กรุงเทพมหานคร',1,null)) as UCEP_BANGKOK,
count(if( nhz.name = '',1,null)) as UCEP_NOTSPECFIY

from ticket t
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz
on nhz.id = pr.nhso_zone_id
left join contact
on t.contact_id = contact.id

 
where
t.created_at between $P{start_date_time} and  $P{end_date_time} 
and $X{IN,nhz.name,zone_name} 
and t.topic = 'สอบถาม' and t.infor != ''
and t.right_u_c_e_p != ''
and contact.typecont = 'ประชาชน'
group by t.right_u_c_e_p,t.infor
order by t.right_u_c_e_p DESC,t.infor DESC