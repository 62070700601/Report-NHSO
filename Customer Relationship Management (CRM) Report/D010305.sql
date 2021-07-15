SELECT  date_format(t.created_at, '%m-%y') as monthyear,month(t.created_at),t.contact_id,c.id,c.typecont,t.right_u_c_e_p,t.topic,t.sub_topic,t.subco_topic,t.subject,t.infor,
-- สอบถามผู้รับริการ
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' ,1,NULL)) 'Question.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'การชดเชยค่าบริการ' ,1,NULL)) 'Questionchocheykaborikarn.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยงาน' ,1,NULL)) 'Questionkoermunennuanngn.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลและโครงสร้างองค์กร' ,1,NULL)) 'Questioninformationongkorn.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยบริการ/สถานบริการ' ,1,NULL)) 'Questioninformationservice.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ขึ้นทะเบียน/ออกจากการเป็นหน่วยบริการ' ,1,NULL)) 'Questionkeungtabuean.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ตรวจสอบข้อมูลสิทธิ' ,1,NULL)) 'Questioncheckinformation.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ตามเรื่อง' ,1,NULL)) 'Questionfollowsubject.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ลงทะเบียน' ,1,NULL)) 'QusetionRegister.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'ระบบ/โปรแกรม' ,1,NULL)) 'Qusetionsystem/program.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'สิทธิประโยชน์และวิธีการใช้สิทธิ' ,1,NULL)) 'Qusetionsybenefitsandmethodright.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Qusetionsrightnouttrue.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'โอนสาย' ,1,NULL)) 'Qusetiontransfer.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'สอบถาม' and t.infor = 'อื่นๆ' ,1,NULL)) 'Qusetionetc.Service',
-- สอบถาม โรงพยาบาล
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' ,1,NULL)) 'Question.hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'การชดเชยค่าบริการ' ,1,NULL)) 'Questionchocheykaborikarn.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยงาน' ,1,NULL)) 'Questionkoermunennuanngn.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลและโครงสร้างองค์กร' ,1,NULL)) 'Questioninformationongkorn.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยบริการ/สถานบริการ' ,1,NULL)) 'Questioninformationservice.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ขึ้นทะเบียน/ออกจากการเป็นหน่วยบริการ' ,1,NULL)) 'Questionkeungtabuean.Hospital',
count(if(c.typecont = 'โรงพยาบาล'and  t.topic = 'สอบถาม' and t.infor = 'ตรวจสอบข้อมูลสิทธิ' ,1,NULL)) 'Questioncheckinformation.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ตามเรื่อง' ,1,NULL)) 'Questionfollowsubject.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ลงทะเบียน' ,1,NULL)) 'QusetionRegister.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'ระบบ/โปรแกรม' ,1,NULL)) 'Qusetionsystem/program.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'สิทธิประโยชน์และวิธีการใช้สิทธิ' ,1,NULL)) 'Qusetionsybenefitsandmethodright.Hospital',
count(if(c.typecont = 'โรงพยาบาล'and  t.topic = 'สอบถาม' and t.infor = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Qusetionsrightnouttrue.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'โอนสาย' ,1,NULL)) 'Qusetiontransfer.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'สอบถาม' and t.infor = 'อื่นๆ' ,1,NULL)) 'Qusetionetc.Hospital',
-- สอบถามอปท.
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' ,1,NULL)) 'Question.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'การชดเชยค่าบริการ' ,1,NULL)) 'Questionchocheykaborikarn.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยงาน' ,1,NULL)) 'Questionkoermunennuanngn.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลและโครงสร้างองค์กร' ,1,NULL)) 'Questioninformationongkorn.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ข้อมูลหน่วยบริการ/สถานบริการ' ,1,NULL)) 'Questioninformationongservice.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ขึ้นทะเบียน/ออกจากการเป็นหน่วยบริการ' ,1,NULL)) 'Questionkeungtabuean.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ตรวจสอบข้อมูลสิทธิ' ,1,NULL)) 'Questioncheckinformation.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ตามเรื่อง' ,1,NULL)) 'Questionfollowsubject.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ลงทะเบียน' ,1,NULL)) 'QusetionRegister.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'ระบบ/โปรแกรม' ,1,NULL)) 'Qusetionsystem/program.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'สิทธิประโยชน์และวิธีการใช้สิทธิ' ,1,NULL)) 'Qusetionsybenefitsandmethodright.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Qusetionsrightnouttrue.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'โอนสาย' ,1,NULL)) 'Qusetiontransfer.Oportor',
count(if(c.typecont = 'อปท.' and  t.topic = 'สอบถาม' and t.infor = 'อื่นๆ' ,1,NULL)) 'Qusetionetc.Oportor',
-- ร้องเรียนมาตรา 57,59 ผู้รับบริการ
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียน'  ,1,NULL)) 'Appeal.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'Appealmaidairubkwabsadueak.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'Appealmaidairubborikarn.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียน' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' ,1,NULL)) 'Appealstandard.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'AppealTukreakkebmoney.Service',
-- ร้องเรียนมาตรา 57,59 ผู้โรงพยาบาล
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียน'  ,1,NULL)) 'Appeal.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'Appealmaidairubkwabsadueak.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'Appealmaidairubborikarn.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียน' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' ,1,NULL)) 'Appealstandard.Hospital',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'AppealTukreakkebmoney.Hospital',
-- ร้องเรียนมาตรา 57,59 อปท.
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียน'  ,1,NULL)) 'Appeal.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับความสะดวกตามสมควร' ,1,NULL)) 'Appealmaidairubkwabsadueak.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ไม่ได้รับบริการตามสิทธิที่กำหนด' ,1,NULL)) 'Appealmaidairubborikarn.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียน' and t.sub_topic = 'มาตรฐานการให้บริการสาธารณสุข' ,1,NULL)) 'Appealstandard.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียน' and t.sub_topic = 'ถูกเรียกเก็บเงิน' ,1,NULL)) 'AppealTukreakkebmoney.Oportor',
-- ร้องทุกข์ผู้รับบริการ
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  ,1,NULL)) 'Complain.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'Complaindenyright.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'การลงทะเบียน' ,1,NULL)) 'ComplainRegister.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Complainrightnottrue.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'ขอความช่วยเหลือ' ,1,NULL)) 'Complainhelp.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'อื่นๆ' ,1,NULL)) 'ComplainetcService',
-- ร้องทุกข์โรงพยาบาล
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  ,1,NULL)) 'Complain.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'Complaindenyright.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'การลงทะเบียน' ,1,NULL)) 'ComplainRegister.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Complainrightnottrue.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'ขอความช่วยเหลือ' ,1,NULL)) 'Complainhelp.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'อื่นๆ' ,1,NULL)) 'Complainetc.Hospital',
-- ร้องทุกข์อปท.
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องทุกข์'  ,1,NULL)) 'Complain.Oportor',
count(if(c.typecont = 'อปท.'   and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สถานบริการอื่นปฏิเสธให้สิทธิเจ็บป่วยฉุกเฉิน' ,1,NULL)) 'Complaindenyright.Oportor',
count(if(c.typecont = 'อปท.'   and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'การลงทะเบียน' ,1,NULL)) 'ComplainRegister.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'สิทธิไม่ตรงตามจริง' ,1,NULL)) 'Complainrightnottrue.Oportor',
count(if(c.typecont = 'อปท.'   and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'ขอความช่วยเหลือ' ,1,NULL)) 'Complainhelp.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องทุกข์'  and t.sub_topic = 'อื่นๆ' ,1,NULL)) 'Complainetc.Oportor',
-- ร้องเรียนเจ้าหน้าที่
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย') and  t.topic = 'ร้องเรียนบุคลากร สปสช.',1,NULL)) 'Appealperson.Service',
count(if(c.typecont = 'โรงพยาบาล' and  t.topic = 'ร้องเรียนบุคลากร สปสช.' ,1,NULL)) 'Appealperson.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ร้องเรียนบุคลากร สปสช.' ,1,NULL)) 'Appealperson.Oportor',
-- บัตรสนเท่ห์
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'บัตรสนเท่ห์' ,1,NULL)) 'budsontey.Service',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'บัตรสนเท่ห์' ,1,NULL)) 'budsontey.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'บัตรสนเท่ห์' ,1,NULL)) 'budsontey.Oportor',
-- การบริการทั่วไป
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'การบริการ' ,1,NULL)) 'Service.Service',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'การบริการ' ,1,NULL)) 'Service.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'การบริการ'  ,1,NULL)) 'Service.Oportor',
-- เสนอแนะ
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'เสนอแนะ' ,1,NULL)) 'Suggestion.Service',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'เสนอแนะ' ,1,NULL)) 'Suggestion.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'เสนอแนะ'  ,1,NULL)) 'Suggestion.Oportor',
-- ปรึกษา
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ปรึกษา' ,1,NULL)) 'Consult.Service',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ปรึกษา' ,1,NULL)) 'Consult.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ปรึกษา'  ,1,NULL)) 'Consult.Oportor',
-- ชมเชย
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ชมเชย' ,1,NULL)) 'Commend.Service',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ชมเชย' ,1,NULL)) 'Commend.Hospital',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ชมเชย'  ,1,NULL)) 'Commend.Oportor',
-- ประสานหาเตียง  ผู้รับบริการ
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' ,1,NULL)) 'Parsarnhabed.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เตียงเต็ม' ,1,NULL)) 'Parsarnhabedbedfull.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'Parsarnhabedoverperformance.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'Parsarnhabedtonsankud.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'รพ.ไม่เข้าร่วมโครงการ',1,NULL)) 'Parsarnhabedhospitalnotentrance.Service',
count(if(c.typecont in ('ประชาชน','ภาคีเครือข่าย')  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = '',1,NULL)) 'Parsarnhabedetc.Service',
-- ประสานหาเตียง โรงพยาบาล
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' ,1,NULL)) 'Parsarnhabed.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เตียงเต็ม' ,1,NULL)) 'Parsarnhabedbedfull.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'Parsarnhabedoverperformance.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'Parsarnhabedtonsankud.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'รพ.ไม่เข้าร่วมโครงการ',1,NULL)) 'Parsarnhabedhospitalnotentrance.Hospital',
count(if(c.typecont = 'โรงพยาบาล'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = '',1,NULL)) 'Parsarnhabedetc.Hospital',
-- ประสานหาเตียง อปท
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' ,1,NULL)) 'Parsarnhabed.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เตียงเต็ม' ,1,NULL)) 'Parsarnhabedbedfull.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'เกินศักยภาพ' ,1,NULL)) 'Parsarnhabedoverperformance.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'หน่วยบริการ' and t.subco_topic = 'ประสานกลับต้นสังกัด' ,1,NULL)) 'Parsarnhabedtonsankud.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = 'รพ.ไม่เข้าร่วมโครงการ',1,NULL)) 'Parsarnhabedhospitalnotentrance.Oportor',
count(if(c.typecont = 'อปท.'  and  t.topic = 'ประสานหาเตียง' and t.sub_topic = '',1,NULL)) 'Parsarnhabedetc.Oportor'

from ticket t 
left join province pr
on t.incidprovin = pr.name
left join nhso_zone nhz			
on pr.nhso_zone_id  = nhz.id 
left join contact c
on t.contact_id = c.id
where
t.right_u_c_e_p = 'สิทธิสวัสดิการพนักงานส่วนท้องถิ่น' and
t.created_at between $P{start_date_time} and  $P{end_date_time}
and $X{IN,nhz.name,zone_name} and
c.id is not null 
group by t.topic,t.sub_topic,t.right_u_c_e_p,t.infor,c.typecont,monthyear
order by monthyear