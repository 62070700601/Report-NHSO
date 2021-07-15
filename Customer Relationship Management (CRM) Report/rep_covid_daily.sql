CREATE DEFINER=`devcrm`@`%` PROCEDURE `rep_covid_daily`(in i_date VARCHAR(255))
begin
	
	select i_date,
-- all total
-- all total
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date)and topic in ('สอบถาม','ร้องเรียน','ร้องทุกข์','ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย','ประสานหาเตียง') then id else null end) as all_total,
-- daily
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('สอบถาม','ร้องเรียน','ร้องทุกข์','ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย','ประสานหาเตียง') then id else null end) as a,
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('สอบถาม','ร้องเรียน','ร้องทุกข์','ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย','ประสานหาเตียง') then id else null end) as b,
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('สอบถาม') then id else null end ) as "1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('สอบถาม') and urgent in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "1.1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('สอบถาม') and urgent not in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "1.2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ร้องเรียน','ร้องทุกข์') then id else null end ) as "2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ร้องเรียน','ร้องทุกข์') and urgent in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "2.1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ร้องเรียน','ร้องทุกข์') and urgent not in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "2.2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย') then id else null end ) as "3",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย') and urgent in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "3.1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic in ('ปรึกษา','เสนอแนะ','การบริการ','บัตรสนเทศน์','ชมเชย') and urgent not in ('สำรองเตียงCovid-19','Covid-19') then id else null end ) as "3.2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic = 'ประสานหาเตียง'  then id else null end ) as "4.1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') then id else null end ) as "4.2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') = i_date) and topic = 'ประสานหาเตียง' and urgent <> 'สำรองเตียงCovid-19' then id else null end ) as "4.3",
-- all total
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') then id else null end ) as "4.4",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') and work_status = 'ยุติ' and result in ('หาเตียงได้','') then id else null end ) as "5.1",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') and work_status = 'ยุติ' and result = 'หาเตียงไม่ได้'
   and bed_result <> 'เสียชีวิต' then id else null end ) as "5.2",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') and work_status = 'ยุติ' and result = 'หาเตียงไม่ได้' and bed_result = 'เสียชีวิต' then id else null end ) as "5.3",
count(case when (DATE_FORMAT(DATE_ADD(created_at , INTERVAL 7 HOUR),'%Y-%m-%d') between '2021-04-11' and i_date) and topic = 'ประสานหาเตียง' and urgent in ('สำรองเตียงCovid-19') and work_status in ('ดำเนินการ','โอนงาน') then id else null end ) as "5.4"
from ticket t;

END