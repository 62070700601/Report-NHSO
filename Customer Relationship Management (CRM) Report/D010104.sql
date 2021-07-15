Select t.right_u_c_e_p,t.topic,t.infor,nhz.name,contact.typecont,pr.name as pr_name,count(t.infor)
from ticket t
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz
on nhz.id = pr.nhso_zone_id
left join contact
on t.contact_id = contact.id
where
t.created_at between $P{start_date} and  $P{end_date}
and nhz.name = $P{zone_name2}
and t.topic = 'สอบถาม' and t.infor != ''
and t.right_u_c_e_p != ''
and contact.typecont != 'ประชาชน' and contact.typecont != ''
group by t.right_u_c_e_p,t.infor
order by t.right_u_c_e_p DESC,t.infor DESC