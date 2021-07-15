CREATE DEFINER=`devcrm`@`%` PROCEDURE `rep_covid_h_bot`(in i_date VARCHAR(255))
begin
	
select 'สะสม' as list , count(1) cnt from ticket_clean tc where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้'
union
select if(tc.symptom_level != '', tc.symptom_level, 'na') as list, count(1) cnt from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' group by tc.symptom_level
union 
select 'ขอเตียง ในชั่วโมง',count(1) as cnt from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and 
DATE_FORMAT(DATE_ADD(tc.created_at , INTERVAL 7 HOUR),'%Y-%m-%d %H') = i_date
union 
select 'ได้เตียง ในชั่วโมง',count(1) as cnt from ticket_clean tc 
where tc.`result` = 'หาเตียงได้' and 
DATE_FORMAT(DATE_ADD(tc.modified_at , INTERVAL 7 HOUR),'%Y-%m-%d %H') = i_date;

END