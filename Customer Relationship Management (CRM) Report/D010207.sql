SELECT t.right_u_c_e_p,t.topic,t.sub_topic,t.subco_topic,t.subject,t.created_at, month(t.created_at),
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'แพทย์' ,1,NULL)) 'physician.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'แพทย์' ,1,NULL)) 'physician.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'พยาบาล' ,1,NULL)) 'nurse.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'พยาบาล' ,1,NULL)) 'nurse.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'เภสัชกร' ,1,NULL)) 'pharmacist.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'เภสัชกร' ,1,NULL)) 'pharmacist.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'เจ้าหน้าที่อื่นๆ' ,1,NULL)) 'etc.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'เจ้าหน้าที่อื่นๆ' ,1,NULL)) 'etc.LGO',  
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'การให้ข้อมูลสื่อสารไม่ชัดเจน' ,1,NULL)) 'karnsernsanmaichadjean.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'การให้ข้อมูลสื่อสารไม่ชัดเจน' ,1,NULL)) 'karnsernsanmaichadjean.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'การเดินทางไปรับบริการไม่สะดวก' ,1,NULL)) 'karndentangmaisadueak.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'การเดินทางไปรับบริการไม่สะดวก' ,1,NULL)) 'karndentangmaisadueak.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'ถูกเลื่อนนัด/การรักษา',1,NULL)) 'tuklerannud.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'ถูกเลื่อนนัด/การรักษา',1,NULL)) 'tuklerannud.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'บริการไม่ดี /ไม่อำนวยความสะดวก',1,NULL)) 'borikarnmaide.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'บริการไม่ดี /ไม่อำนวยความสะดวก',1,NULL)) 'borikarnmaide.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'รอคิว/ตรวจนาน',1,NULL)) 'rorqueue.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'รอคิว/ตรวจนาน',1,NULL)) 'rorqueue.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'สถานที่ไม่เหมาะสม',1,NULL)) 'satantemaimor.UC',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'สถานที่ไม่เหมาะสม',1,NULL)) 'satantemaimor.LGO',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'ออกหนังสือส่งตัวล่าช้า',1,NULL)) 'oaknungserlacha.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'ออกหนังสือส่งตัวล่าช้า',1,NULL)) 'oaknungserlacha.LGO',
count(if(t.right_u_c_e_p =  'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'ออกหนังสือส่งตัวให้ครั้งต่อครั้ง',1,NULL)) 'oaknungserkungtokung.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'ออกหนังสือส่งตัวให้ครั้งต่อครั้ง',1,NULL)) 'oaknungserkungtokung.LGO',
count(if(t.right_u_c_e_p =  'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'เปิดให้บริการไม่ตรงกับเวลาที่ประชาสัมพันธ์',1,NULL)) 'perdservicemaitung.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'เปิดให้บริการไม่ตรงกับเวลาที่ประชาสัมพันธ์',1,NULL)) 'perdservicemaitung.LGO',
count(if(t.right_u_c_e_p =  'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subject = 'ไม่มีแพทย์หรือเจ้าหน้าที่ให้บริการ',1,NULL)) 'maimeepaed.UC',
count(if(t.subject = 'แพทย์' ,1,NULL)) 'physician.sum',
count(if(t.subject = 'พยาบาล' ,1,NULL)) 'nurse.sum',
count(if(t.subject = 'เภสัชกร' ,1,NULL)) 'pharmacist.sum',
count(if(t.subject = 'เจ้าหน้าที่อื่นๆ' ,1,NULL)) 'etc.sum', 
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subco_topic = 'พฤติกรรมการให้บริการ',1,NULL)) '1UC.sum',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subco_topic = 'พฤติกรรมการให้บริการ',1,NULL)) '1LGO.sum',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' AND t.subco_topic = 'ด้านระบบการให้บริการ',1,NULL)) '2UC.sum',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subco_topic = 'ด้านระบบการให้บริการ',1,NULL)) '2LGO.sum',
count(if(t.right_u_c_e_p = 'สิทธิหลักประกันสุขภาพแห่งชาติ' ,1,NULL)) 'UC.sum',
count(if(t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' ,1,NULL)) 'LGO.sum',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.subject = 'ไม่มีแพทย์หรือเจ้าหน้าที่ให้บริการ',1,NULL)) 'maimeepaed.LGO'
from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 


where
t.created_at between $P{start_date_time} and  $P{end_date_time} and 
t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น')
and t.subco_topic in ('ด้านระบบการให้บริการ','พฤติกรรมการให้บริการ')
and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
and t.work_status = 'ยุติ' 
AND t.pass_to_new = '[]'
group by t.subco_topic,subject,t.right_u_c_e_p
order by t.subco_topic