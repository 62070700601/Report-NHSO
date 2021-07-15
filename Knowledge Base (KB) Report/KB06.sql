SELECT  row_number() over (order by team.name,count(tk.knowledge_base_article_id) desc) as series ,concat(user.first_name," ",user.last_name) as full_name,
team.name,kb.k_b_no,kb.name as namekb,count(tk.knowledge_base_article_id) as volumekb FROM knowledge_base_article kb
left join ticket_knowledge_base_article tk
on kb.id = tk.knowledge_base_article_id 
left join ticket t
on tk.ticket_id  = t.id
left join user
on kb.created_by_id = user.id
left join team_user tu
on tu.user_id = user.id
left join team
on tu.team_id = team.id
where t.created_at between  $P{start_date_time} and  $P{end_date_time}
AND $X{IN,user_id,user_kb}
group by tk.knowledge_base_article_id
order by team.name,count(tk.knowledge_base_article_id) desc