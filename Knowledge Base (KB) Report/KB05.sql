select row_number() over (order by k_b_no) as series,kb.k_b_no,kb.name,note.post,count(note.id),user.id
from knowledge_base_article kb
left join user
on kb.created_by_id = user.id
left join note
on kb.knowledge_base_article_parent_id = note.parent_id
left join team_user tu
on tu.user_id = user.id 
where  note.type = 'Post' and note.parent_type = 'KnowledgeBaseArticle'
and tu.team_id = '5faf92d6ef1513f4e'
and  kb.created_at between  $P{start_date_time} and  $P{end_date_time}
group by kb.k_b_no
order by kb.k_b_no