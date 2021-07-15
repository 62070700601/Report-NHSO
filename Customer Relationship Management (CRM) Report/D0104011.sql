select t.topic,t.sub_topic,t.subco_topic,t.right_u_c_e_p,t.subject,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as UC1,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'กลุ่มเด็กโตและวัยรุ่น 6-24 ปี',1,null)) as UC1_1,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'กลุ่มเด็กเล็ก 0-5 ปี',1,null)) as UC1_2,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'กลุ่มผู้สูงอายุ 60 ปีขึ้นไป' ,1,null)) as UC1_3,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'กลุ่มผู้ใหญ่ 25-59 ปี' ,1,null)) as UC1_4,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'กลุ่มหญิงตั้งครรภ์' ,1,null)) as UC1_5,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'การตรวจคัดกรอง Covid-19' ,1,null)) as UC1_6,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'โครงการฝากท้องทุกที่ฟรีทุกสิทธิ',1,null)) as UC1_7,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'โครงการฟันเทียมพระราชทาน',1,null)) as UC1_8,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'โครงการร้านยาคุณภาพ' ,1,null)) as UC1_9,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'โครงการหมอครอบครัว' ,1,null)) as UC1_10,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = 'วัคซีนป้องกันไข้หวัดใหญ่ตามฤดูกาล' ,1,null)) as UC1_11,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' and t.subject = '' ,1,null)) as UC1_12,

count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' ,1,null)) as UC2,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,null)) as UC3,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as UC4,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'กลุ่มเด็กโตและวัยรุ่น 6-24 ปี',1,null)) as UC4_1,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'กลุ่มเด็กเล็ก 0-5 ปี',1,null)) as UC4_2,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'กลุ่มผู้สูงอายุ 60 ปีขึ้นไป' ,1,null)) as UC4_3,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'กลุ่มผู้ใหญ่ 25-59 ปี' ,1,null)) as UC4_4,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'กลุ่มหญิงตั้งครรภ์' ,1,null)) as UC4_5,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'การตรวจคัดกรอง Covid-19' ,1,null)) as UC4_6,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'โครงการฝากท้องทุกที่ฟรีทุกสิทธิ',1,null)) as UC4_7,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'โครงการฟันเทียมพระราชทาน',1,null)) as UC4_8,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'โครงการร้านยาคุณภาพ' ,1,null)) as UC4_9,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'โครงการหมอครอบครัว' ,1,null)) as UC4_10,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = 'วัคซีนป้องกันไข้หวัดใหญ่ตามฤดูกาล' ,1,null)) as UC4_11,
count(if( t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' and t.subject = '' ,1,null)) as UC4_12,
count(if( t.topic = 'ร้องทุกข์' and t.sub_topic = 'ขอความช่วยเหลือ' ,1,null)) as UC5
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where 
t.subco_topic = 'ส่งเสริมสุขภาพและป้องกันโรค (PP)' and
$X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and  $P{end_date_time}