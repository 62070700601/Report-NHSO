select 
CASE 
	WHEN DATE_FORMAT(social_date, "%H:%i") between '00:00' and '00:59' then 'รอบ1 00.00-00.59'
	WHEN DATE_FORMAT(social_date, "%H:%i") between '01:00' and '01:59' then 'รอบ2 01.00-01.59'
	WHEN DATE_FORMAT(social_date, "%H:%i") between '02:00' and '02:59' then 'รอบ3 02.00-02.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '03:00' and '03:59' then 'รอบ4 03.00-03.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '04:00' and '04:59' then 'รอบ5 04.00-04.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '05:00' and '05:59' then 'รอบ6 05.00-05.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '06:00' and '06:59' then 'รอบ7 06.00-06.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '07:00' and '07:59' then 'รอบ8 07.00-07.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '08:00' and '08:59' then 'รอบ9 08.00-08.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '09:00' and '09:59' then 'รอบ10 09.00-09.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '10:00' and '10:59' then 'รอบ11 10.00-10.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '11:00' and '11:59' then 'รอบ12 11.00-11.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '12:00' and '12:59' then 'รอบ13 12.00-12.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '13:00' and '13:59' then 'รอบ14 13.00-13.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '14:00' and '14:59' then 'รอบ15 14.00-14.59'
	WHEN DATE_FORMAT(social_date, "%H:%i") between '15:00' and '15:59' then 'รอบ16 15.00-15.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '16:00' and '16:59' then 'รอบ17 16.00-16.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '17:00' and '17:59' then 'รอบ18 17.00-17.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '18:00' and '18:59' then 'รอบ19 18.00-18.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '19:00' and '19:59' then 'รอบ20 19.00-19.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '20:00' and '20:59' then 'รอบ21 20.00-20.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '21:00' and '21:59' then 'รอบ22 21.00-21.59'
	WHEN DATE_FORMAT(social_date, "%H:%i") between '22:00' and '22:59' then 'รอบ23 22.00-22.59'
    WHEN DATE_FORMAT(social_date, "%H:%i") between '23:00' and '23:59' then 'รอบ24 23.00-23.59'
end as round_time_post,count(distinct sm.social_date),
(select count(sm.social_date)
from social_monitoring .social_monitoring sm
left join social_monitoring .social_reply sr
on sm.social_id = sr.social_id
where sm.social_channel_id = '2'
and sm.social_date between $P{start_date_time} and  $P{end_date_time}
group by sm.social_channel_id
)as totol_post,

count(distinct sr.social_reply_id),
(select count(sr.social_reply_id)
from social_monitoring.social_monitoring sm
left join social_monitoring.social_reply sr
on sm.social_id = sr.social_id
where sm.social_channel_id = '2'
and sm.social_date between $P{start_date_time} and  $P{end_date_time}
group by sm.social_channel_id
)as total_answer


from social_monitoring.social_monitoring sm
left join social_monitoring.social_reply sr
on sm.social_id = sr.social_id

where sm.social_channel_id = '2'
and sm.social_date between  $P{start_date_time} and  $P{end_date_time}
group by round_time_post
order by CAST(SUBSTR(round_time_post FROM 4) AS UNSIGNED)