SELECT date(scm.social_date) as datesocial,source,
count(if(scm.social_channel_id = '1' and scm.social_channel_type = 'tweet',1,null)) as post_twitter,
count(if(scm.social_channel_id = '2' and scm.social_channel_type = 'post',1,null)) as post_pantip,
count(if(scm.social_channel_id = '3' and scm.social_channel_type = 'post',1,null)) as post_facebook

FROM social_monitoring.social_monitoring scm

where scm.social_date between $P{start_date_time} and  $P{end_date_time}
and scm.is_deleted != '1'
group by date(scm.social_date)
order by date(scm.social_date)