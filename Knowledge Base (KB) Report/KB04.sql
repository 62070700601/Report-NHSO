SELECT row_number() OVER (ORDER by kb.k_b_no) as series,
kb.name,kb.k_b_no,count(kb.modified_by_id),concat(user.first_name," ",user.last_name) as full_name,
case
	when kb.modified_by_id IS NULL then 'เลขที่ความรู้สร้างใหม่'
    when n.type = 'Post' then 'สตรีม'
    else 'เลขที่ความรู้ Update'
    end TYPE,
n.type
FROM team_user tu
left join user
on tu.user_id = user.id 
left join knowledge_base_article kb
on tu.user_id = kb.created_by_id
left join note n
on kb.id = n.parent_id

where tu.team_id = '5faf92d6ef1513f4e'  and 
kb.deleted = '0' 
and  kb.created_at between  $P{start_date_time} and  $P{end_date_time}
AND $X{IN,tu.user_id,user_kb}
group by kb.k_b_no
order by k_b_no