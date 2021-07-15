SELECT row_number() over (order by count(tk.knowledge_base_article_id) desc) as series 
,kb.k_b_no,kb.name,count(tk.knowledge_base_article_id) FROM knowledge_base_article kb
left join ticket_knowledge_base_article tk
on kb.id = tk.knowledge_base_article_id 
left join ticket t
on tk.ticket_id  = t.id
where t.created_at between  $P{start_date_time} and  $P{end_date_time}
group by tk.knowledge_base_article_id
order by count(tk.knowledge_base_article_id) desc
LIMIT 10