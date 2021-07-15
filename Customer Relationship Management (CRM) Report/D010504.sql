Select t.created_at,t.topic,t.right_u_c_e_p,t.sub_topic,t.subco_topic,t.subject,

-- ประสานหาเตียง สิทธิหลักประกันสุขภาพแห่งชาติ และ ผู้พิการ
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'UCEP' ,1,NULL)) 'UC.UCEP',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'NON UCEP' ,1,NULL)) 'UC.NONUCEP',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'หน่วยบริการ' and subco_topic = 'เตียงเต็ม' ,1,NULL)) 'UC.BEDFULL',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'หน่วยบริการ' and subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'UC.LIMIT',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'หน่วยบริการ' and subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'UC.CONTACTBACK',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'หน่วยบริการ' and subco_topic = '' ,1,NULL)) 'UC.ETCSERVICE',
count(if(right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = '' ,1,NULL)) 'UC.ETCHOSPITAL',

-- ประสานหาเตียง สิทธิสวัสดิการพนักงานส่วนท้องถิ่น
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'UCEP' ,1,NULL)) 'LGO.UCEP',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'NON UCEP' ,1,NULL)) 'LGO.NONUCEP',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เตียงเต็ม' ,1,NULL)) 'LGO.BEDFULL',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'LGO.LIMIT',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'หน่วยบริการ' and subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'LGO.CONTACTBACK',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'หน่วยบริการ' and subco_topic = '' ,1,NULL)) 'LGO.ETCSERVICE',
count(if(right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = '' ,1,NULL)) 'LGO.ETCHOSPITAL',

-- 'สิทธิข้าราชการ' (OFC)
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'UCEP' ,1,NULL)) 'OFC.UCEP',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'NON UCEP' ,1,NULL)) 'OFC.NONUCEP',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เตียงเต็ม' ,1,NULL)) 'OFC.BEDFULL',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'OFC.LIMIT',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'หน่วยบริการ' and subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'OFC.CONTACTBACK',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'หน่วยบริการ' and subco_topic = '' ,1,NULL)) 'OFC.ETCSERVICE',
count(if(right_u_c_e_p = 'สิทธิข้าราชการ' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = '' ,1,NULL)) 'OFC.ETCHOSPITAL',

-- 'สิทธิประกันสังคม'
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'UCEP' ,1,NULL)) 'SSS.UCEP',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'NON UCEP' ,1,NULL)) 'SSS.NONUCEP',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เตียงเต็ม' ,1,NULL)) 'SSS.BEDFULL',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'หน่วยบริการ' and subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'SSS.LIMIT',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'หน่วยบริการ' and subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'SSS.CONTACTBACK',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'หน่วยบริการ' and subco_topic = '' ,1,NULL)) 'SSS.ETCSERVICE',
count(if(right_u_c_e_p = 'สิทธิประกันสังคม' and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = '' ,1,NULL)) 'SSS.ETCHOSPITAL',

-- สิทธิอื่นๆ 
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'UCEP' ,1,NULL)) 'ALLETC.UCEP',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = 'NON UCEP' ,1,NULL)) 'ALLETC.NONUCEP',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'หน่วยบริการ' and subco_topic = 'เตียงเต็ม' ,1,NULL)) 'ALLETC.BEDFULL',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'หน่วยบริการ' and subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'ALLETC.LIMIT',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'หน่วยบริการ' and subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'ALLETC.CONTACTBACK',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'หน่วยบริการ' and subco_topic = '' ,1,NULL)) 'ALLETC.ETCSERVICE',
count(if(right_u_c_e_p  not in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)','สิทธิประกันสังคม','สิทธิข้าราชการ','สิทธิสวัสดิการพนักงานส่วนท้องถิ่น') and sub_topic = 'รพ.ไม่เข้าร่วมโครงการ' and subco_topic = '' ,1,NULL)) 'ALLETC.ETCHOSPITAL'



FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where
t.created_at between $P{start_date_time} and  $P{end_date_time} 
and t.topic = 'ประสานหาเตียง' and t.sub_topic in ('หน่วยบริการ','รพ.ไม่เข้าร่วมโครงการ')
and $X{IN,nhz.name,zone_name}