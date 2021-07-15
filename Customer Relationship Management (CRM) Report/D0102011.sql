select t.name,t.right_d,t.right_e,t.right_g,t.work_status,pass_to_new from ticket t
where 
t.created_at between $P{start_date_time} and  $P{end_date_time}
and $X{IN,nhz.name,zone_name}
and pass_to_new  in ('["คณะกรรมการควบคุม"]','[]')