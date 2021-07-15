SELECT t.right_u_c_e_p,t.topic,t.first_check,t.sub_topic,
-- รัฐ หลักประกันสุขภาพแห่งชาติ
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) as government_UCC,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as RUDSTADARND_UCC,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as RUDEASE_UCC,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as RUDKEEPMONEY_UCC,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as RUDSERVICE_UCC,

-- รัฐ หลักประสุขภาพส่วนท้องถื่น
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) as government_LGO,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as RUDSTADARND_LGO,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as RUDEASE_LGO,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as RUDKEEPMONEY_LGO,
count(if(h.type_name like '%รัฐ%' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as RUDSERVICE_LGO,

-- โรงพยาบาลเอกชน หลักประกันสุขภาพแห่งชาติ
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) as hospital_UCC,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as HOSPITALSTADARND_UCC,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as HOSPITALRUDEASE_UCC,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as HOSPITALRUDKEEPMONEY_UCC,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as HOSPITALRUDSERVICE_UCC,

-- โรงพยาบาลเอกชน สวัสดิการส่วนท้องถื่น
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) as hospital_LGO,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as HOSPITALSTADARND_LGO,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as HOSPITALRUDEASE_LGO,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as HOSPITALRUDKEEPMONEY_LGO,
count(if(h.sub_type_name = 'โรงพยาบาล (เอกชน)' and t.right_u_c_e_p= 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as HOSPITALRUDSERVICE_LGO,

-- คลินิกเอกชน หลักประกันสุขภาพแห่งชาติ
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)'),1,null)) as clinic_UCC,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as CLINICSTADARND_UCC,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as CLINICEASE_UCC,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as CLINICKEEPMONEY_UCC,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as CLINICSERVICE_UCC,

-- คลินิกเอกชน ส่วนท้องถิ่น
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น',1,null)) as clinic_LGO,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข',1,null)) as CLINICSTADARND_LGO,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร',1,null)) as CLINICEASE_LGO,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,null)) as CLINICKEEPMONEY_LGO,
count(if(h.sub_type_name in ('โรงพยาบาล (เอกชน)','ร้านขายยาแผนปัจจุบัน','ศูนย์บริการผู้พิการ') and t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,null)) as CLINICSERVICE_LGO

FROM ticket t
left join hospital h
on t.hospital_id = h.id
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
where t.topic = 'ร้องเรียน' and t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.work_status = 'ยุติ' 
AND t.pass_to_new = '[]'
and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น')
and $X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date_time} and $P{end_date_time}