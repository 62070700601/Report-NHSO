select date(t.created_at),t.problemid,t.identification_no,t.topic,t.infor,t.channel,date(t.open_date_time) as open_date,time(t.open_date_time) as open_time,t.created_by_id,
concat(user.first_name," ",user.last_name) as assignedusername,t.sub_topic,t.subco_topic,
GROUP_CONCAT(kb.name) as all_ticket_kb,t.created_at
from ticket t
left join user
on t.created_by_id = user.id
left join ticket_knowledge_base_article tk
on t.id = tk.ticket_id  
left join knowledge_base_article kb
on tk.knowledge_base_article_id = kb.id 
where t.created_at between $P{start_date_time} and  $P{end_date_time}
group by date(t.created_at),t.problemid
order by t.created_at