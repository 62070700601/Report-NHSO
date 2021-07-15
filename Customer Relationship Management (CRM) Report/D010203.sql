SELECT t.topic,t.right_u_c_e_p,t.sub_topic,t.work_status,t.first_check,t.pass_to_new,count(t.work_status) as sum_workstatus,
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.UC1',
count(if(t.right_u_c_e_p  in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.UC2',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic = 'ถูกเรียกเก็บเงิน'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.UC3',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.UC4',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.LGO1',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.LGO2',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic = 'ถูกเรียกเก็บเงิน'
AND t.work_status = 'ยุติ' AND t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.LGO3',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND t.work_status = 'ยุติ' and t.first_check = 'ผู้ร้องเข้าใจผิด'
AND t.pass_to_new = '[]',1,NULL)) 'checkfalse.LGO4',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.UC1',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.UC2',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.UC3',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.UC4',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.LGO1',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.LGO2',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.LGO3',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND t.work_status = 'ยุติ' AND t.first_check = 'ตรวจสอบเบื้องต้นมีมูลความจริง'
AND t.pass_to_new = '[]',1,NULL)) 'checktrue.LGO4',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult1.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult2.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult3.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult4.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult1.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult2.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult3.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status = 'ยุติ' AND t.first_check = ''
AND t.pass_to_new = '[]',1,NULL)) 'Noresult4.LGO',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard1.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard2.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard3.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard4.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard1.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard2.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard3.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status = 'ยุติ'  AND t.pass_to_new = '["คณะกรรมการควบคุม"]',1,NULL)) 'Sendboard4.LGO',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')   AND t.sub_topic =  'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn1.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')  AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn2.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')   AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn3.UC',
count(if(t.right_u_c_e_p in  ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')   AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn4.UC',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  AND t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn1.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  AND t.sub_topic =  'ไม่ได้รับความสะดวกตามสมควร'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn2.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  AND t.sub_topic =  'ถูกเรียกเก็บเงิน'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn3.LGO',
count(if(t.right_u_c_e_p =  'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น'  AND t.sub_topic =  'ไม่ได้รับบริการตามสิทธิที่กำหนด'
AND  t.work_status in ('ดำเนินการ','โอนงาน') ,1,NULL)) 'dumnernkarn4.LGO'
FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
WHERE 
t.created_at between $P{start_date} and  $P{end_date}  and
t.topic = 'ร้องเรียน' and t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and t.sub_topic in ('ไม่ได้รับความสะดวกตามสมควร','ถูกเรียกเก็บเงิน','ไม่ได้รับบริการตามสิทธิที่กำหนด','มาตรฐานการให้บริการสาธารณสุข') 
and t.work_status in ('ยุติ','ดำเนินการ','โอนงาน')
and $X{IN,nhz.name,zone_name}
GROUP BY t.right_u_c_e_p,t.sub_topic,t.work_status
order by t.right_u_c_e_p,t.work_status