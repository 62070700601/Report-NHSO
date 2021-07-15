select date(scm.social_date),
case
	when scm.social_channel_id = '2' and scm.social_channel_type = 'post' 
    and scm.is_deleted = 0 then count(DISTINCT scm.social_id)
    end as post_pantip,
count(DISTINCT social_reply_id) as reply_pantip
FROM social_monitoring.social_monitoring scm
left join social_monitoring.social_reply sr
on scm.social_id = sr.social_id
where 
scm.social_channel_id = '2' 
and scm.social_channel_type = 'post'
and scm.is_deleted != 1
and scm.social_date between $P{start_date_time} and  $P{end_date_time}
group by date(scm.social_date)
order by date(scm.social_date)