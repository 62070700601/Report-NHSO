SELECT tu.team_id,tu.user_id,concat(user.first_name," ",user.last_name) as full_name,
count(kb.created_at),count(kb.modified_by_id),result.countnote
FROM team_user tu
left join user
on tu.user_id = user.id 
left join knowledge_base_article kb
on tu.user_id = kb.created_by_id
left JOIN 
    (
	SELECT n.created_by_id as gg,n.parent_id as pp,count(n.id) as countnote
	FROM note n
	left join team_user tu
	on n.created_by_id = tu.user_id
	left join user
	on tu.user_id = user.id 
	where n.parent_type = 'KnowledgeBaseArticle' and n.type = 'Post' and n.deleted = '0' 
	group by n.created_by_id
    ) result on kb.created_by_id = result.gg


where tu.team_id = '5faf92d6ef1513f4e'  and kb.deleted = '0'
and  kb.created_at between  $P{start_date_time} and  $P{end_date_time}
AND $X{IN,user.id,user_kb}
group by tu.user_id