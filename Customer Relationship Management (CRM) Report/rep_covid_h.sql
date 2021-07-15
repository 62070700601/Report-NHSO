CREATE DEFINER=`devcrm`@`%` PROCEDURE `rep_covid_h`(in i_date VARCHAR(255))
begin
	
select i_date as 'date',
(select count(1) from ticket_clean tc where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้') as 'total', /*'มีคนไข้รวมรอเตียง (สะสม)',*/
(select count(1) from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and 
DATE_FORMAT(DATE_ADD(tc.created_at , INTERVAL 7 HOUR),'%Y-%m-%d %H') = i_date) as 'new_bed', /*'มีคนขอเตียงเข้ามาใหม่',*/
(select count(1) from ticket_clean tc 
where tc.`result` = 'หาเตียงได้' and 
DATE_FORMAT(DATE_ADD(tc.modified_at , INTERVAL 7 HOUR),'%Y-%m-%d %H') = i_date) as 'ok_bed', /*'สามารถได้เตียงในชั่วโมงนี้',*/
(select count(1) from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and tc.symptom_level = 'สีแดง') as 'red', /*'สีแดง',*/
(select count(1) from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and tc.symptom_level = 'สีเหลือง') as 'yellow', /*'สีเหลือง',*/
(select count(1) from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and tc.symptom_level = 'สีเขียว') as 'green', /*'สีเขียว',*/
(select count(1) from ticket_clean tc 
where tc.work_status <> 'ยุติ' and tc.`result` <> 'หาเตียงได้' and tc.symptom_level not in ('สีเขียว','สีเหลือง','สีแดง')) as 'na'
from dual;

END