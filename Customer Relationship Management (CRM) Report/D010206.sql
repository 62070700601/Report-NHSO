select t.right_u_c_e_p,t.subco_topic,t.subject,

-- แผนการรักษาUC
count(if(t.subco_topic = 'แผนการรักษา' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'ไม่มั่นใจการรักษา' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment1_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'วินิจฉัย/รักษาล่าช้า' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment2_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'อุปกรณ์ไม่พร้อมทำงาน/ท่อช่วยหายใจหลุด' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment3_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'เกิดผลข้างเคียงจากการรักษา/ติดเชื้อระหว่างเข้ารับบริการ' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment4_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'การคลอดและทารกแรกเกิด'and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment5_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'ส่งต่อล่าช้า/ไม่รับส่งต่อ' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment6_UC,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'อื่นๆ' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) treatment7_UC,

-- แผนการรักษา LGO
count(if(t.subco_topic = 'แผนการรักษา' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'ไม่มั่นใจการรักษา' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment1_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'วินิจฉัย/รักษาล่าช้า' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment2_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'อุปกรณ์ไม่พร้อมทำงาน/ท่อช่วยหายใจหลุด' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment3_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'เกิดผลข้างเคียงจากการรักษา/ติดเชื้อระหว่างเข้ารับบริการ' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment4_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'การคลอดและทารกแรกเกิด'and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment5_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'ส่งต่อล่าช้า/ไม่รับส่งต่อ' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment6_LGO,
count(if(t.subco_topic = 'แผนการรักษา' and  t.subject = 'อื่นๆ' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) treatment7_LGO,

-- การให้ยา UC 
count(if(t.subco_topic = 'การให้ยา' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) givemedicine_UC,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'จ่ายยาหมดอายุ/จ่ายยาผิด' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) givemedicine1_UC,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'จ่ายยาแล้วมีผลข้างเคียง/แพ้ยา' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) givemedicine2_UC,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'ให้ยาไม่ถูกวิธี' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) givemedicine3_UC,

-- การให้ยา LGO
count(if(t.subco_topic = 'การให้ยา' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) givemedicine_LGO,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'จ่ายยาหมดอายุ/จ่ายยาผิด' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) givemedicine1_LGO,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'จ่ายยาแล้วมีผลข้างเคียง/แพ้ยา' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) givemedicine2_LGO,
count(if(t.subco_topic = 'การให้ยา' and  t.subject = 'ให้ยาไม่ถูกวิธี' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) givemedicine3_LGO


from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
where  t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and t.topic = 'ร้องเรียน'
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข'
and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
and t.work_status = 'ยุติ' 
AND t.pass_to_new = '[]'
and $X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and  $P{end_date_time}