SELECT nhz.name,nhz.id,pr.nhso_zone_id,pr.name as pr_name,t.incidprovin,t.right_u_c_e_p,month(t.created_at),t.topic,t.sub_topic,
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องเรียน' 
and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'UC.KEPPMONEY',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องเรียน' 
and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' ,1,NULL)) 'UC.STANDARD',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องเรียน' 
and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'UC.CANNOTEASE',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องเรียน' 
and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'UC.CANNOTSERVICE',
-- ร้องทุกข์
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องทุกข์' 
and t.sub_topic = 'การลงทะเบียน' ,1,NULL)) 'UC.Register',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องทุกข์' 
and t.sub_topic = 'ขอความช่วยเหลือ' ,1,NULL)) 'UC.Help',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องทุกข์' 
and t.sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'UC.Emergency',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องทุกข์' 
and t.sub_topic = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'UC.rightnottrue',
count(if(t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)') and t.topic = 'ร้องทุกข์' 
and t.sub_topic = 'อื่นๆ' ,1,NULL)) 'UC.etc',

-- ปรึกษา
count(if(t.topic = 'ปรึกษา' ,1,NULL)) 'UC.Consult',
-- เสนอแนะ
count(if(t.topic = 'เสนอแนะ' ,1,NULL)) 'UC.Present',
-- การบริการ
count(if(t.topic = 'การบริการ' ,1,NULL)) 'UC.Service',
-- บัตรสนเท่ห์
count(if(t.topic = 'บัตรสนเท่ห์' ,1,NULL)) 'UC.budsontey',
-- ร้องเรียนเจ้าหน้าที่
count(if(t.topic = 'ร้องเรียนบุคลากร สปสช.' ,1,NULL)) 'UC.Rongrenygjaonatee',
-- ชมเชย
count(if(t.topic = 'ชมเชย' ,1,NULL)) 'UC.Chomchey'

FROM nhso_zone nhz																			
left join province pr
on nhz.id = pr.nhso_zone_id
left join ticket t
on pr.name = t.incidprovin
where t.right_u_c_e_p in ('สิทธิหลักประกันสุขภาพแห่งชาติ','สิทธิหลักประกันสุขภาพแห่งชาติ (ผู้ประกันตนคนพิการ)')
and $X{IN,nhz.name,zone_name}
and t.created_at between $P{start_date} and $P{end_date} 

group by nhz.name
order by nhz.name