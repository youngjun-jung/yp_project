$PBExportHeader$w_bar.srw
forward
global type w_bar from window
end type
type dw_4 from datawindow within w_bar
end type
type dw_3 from datawindow within w_bar
end type
type dw_2 from datawindow within w_bar
end type
type cb_2 from commandbutton within w_bar
end type
type st_3 from statictext within w_bar
end type
type cb_1 from commandbutton within w_bar
end type
type dw_1 from datawindow within w_bar
end type
type hpb_upgrade from hprogressbar within w_bar
end type
type st_1 from statictext within w_bar
end type
type p_1 from picture within w_bar
end type
end forward

global type w_bar from window
integer width = 1499
integer height = 272
boolean enabled = false
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
event ue_open ( string as_code )
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
cb_2 cb_2
st_3 st_3
cb_1 cb_1
dw_1 dw_1
hpb_upgrade hpb_upgrade
st_1 st_1
p_1 p_1
end type
global w_bar w_bar

forward prototypes
public function boolean wf_erp_map (string as_frdate, string as_todate)
public function boolean wf_erp_map_full (string as_frdate, string as_todate)
public function boolean wf_erp_code_full ()
public function boolean wf_erp_code ()
public function boolean wf_erp_code_mng ()
public function boolean wf_erp_code_mng_full ()
public function boolean wf_erp_docu_map (string as_frdate, string as_todate, string as_card_num)
public function boolean wf_erp_docu_map_full (string as_frdate, string as_todate, string as_card_num)
end prototypes

event ue_open(string as_code);String ls_dts_indert
Long ll_rowcnt_source, i
str_popup	lstr_popup

lstr_popup = Message.PowerObjectParm

if as_code = '1' then
	
	dw_1.settransobject(EBSQL)

	dw_1.SetRedraw(FALSE)
	
	dw_1.retrieve()
	
	dw_1.SetRedraw(TRUE)

	wf_erp_map(ls_erp_frdate, ls_erp_todate)

elseif as_code = '2' then
	
	dw_1.settransobject(EBSQL)

	dw_1.SetRedraw(FALSE)
	
	dw_1.retrieve()
	
	dw_1.SetRedraw(TRUE)

	wf_erp_map_full(ls_erp_frdate, ls_erp_todate)	
	
elseif as_code = '5' then
	
	dw_2.settransobject(EBSQL)

	dw_2.SetRedraw(FALSE)
	
	dw_2.retrieve()
	
	dw_2.SetRedraw(TRUE)

	wf_erp_code()	
	
	dw_3.settransobject(EBSQL)

	dw_3.SetRedraw(FALSE)
	
	dw_3.retrieve()
	
	dw_3.SetRedraw(TRUE)

	wf_erp_code_mng()	
	
elseif as_code = '6' then
	
	dw_2.settransobject(EBSQL)

	dw_2.SetRedraw(FALSE)
	
	dw_2.retrieve()
	
	dw_2.SetRedraw(TRUE)

	wf_erp_code_full()	
	
	dw_3.settransobject(EBSQL)

	dw_3.SetRedraw(FALSE)
	
	dw_3.retrieve()
	
	dw_3.SetRedraw(TRUE)
	
	wf_erp_code_mng_full()	
	
elseif as_code = '8' then
	
	dw_4.settransobject(EBSQL)

	dw_4.SetRedraw(FALSE)
	
	dw_4.retrieve(lstr_popup.rvalue[2], lstr_popup.rvalue[3])
	
	dw_4.SetRedraw(TRUE)
	
	wf_erp_docu_map_full(lstr_popup.rvalue[2], lstr_popup.rvalue[3], '')	
	
elseif as_code = '9' then
	
	dw_4.settransobject(EBSQL)

	dw_4.SetRedraw(FALSE)
	
	dw_4.retrieve(lstr_popup.rvalue[2], lstr_popup.rvalue[3])
	
	dw_4.SetRedraw(TRUE)
	
	wf_erp_docu_map_full(lstr_popup.rvalue[2], lstr_popup.rvalue[3], '')				
	
end if

close(w_bar)
end event

public function boolean wf_erp_map (string as_frdate, string as_todate);Long   ll_rowcount, i
String ls_imsi[20], ls_regtime, ls_dts_indert  
/*
SELECT SUBSTR(MAX(DTS_INSERT), 1, 8)
INTO :ls_dts_indert
FROM ADM_FI_PARTNO
USING SQLCA;
*/
dw_1.SetFilter("dts_insert > '" + ls_dts_indert + "000000'" + ' or ' + "dts_update > '" + ls_dts_indert + "000000'")
dw_1.Filter()
dw_1.SetFilter("")

ll_rowcount = dw_1.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1
	/*
DELETE /*+ NOLOGGING */ FROM ADM_FI_PARTNO
WHERE DTS_INSERT >=  :ls_dts_indert||'000000'
OR DTS_UPDATE >=  :ls_dts_indert||'000000';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("오류", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF

select to_char(sysdate, 'yyyymmddhh24miss')
into :ls_regtime
from dual;
*/
for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_1.object.no_company[i]   
	ls_imsi[2] = dw_1.object.cd_partner[i]  
	ls_imsi[3] = dw_1.object.cd_company[i]   
	ls_imsi[4] = dw_1.object.nm_partner[i]  
	ls_imsi[5] = dw_1.object.nm_master[i]   
	ls_imsi[6] = dw_1.object.tp_job[i]      
	ls_imsi[7] = dw_1.object.cls_job[i]     
	ls_imsi[8] = dw_1.object.ads_hd[i]      
	ls_imsi[9] = dw_1.object.dt_standard[i]  
	ls_imsi[10] = dw_1.object.dt_end[i]       
	ls_imsi[11] = dw_1.object.st_partner[i]   
	ls_imsi[12] = dw_1.object.id_insert[i]   
	ls_imsi[13] = dw_1.object.dts_insert[i]  
	ls_imsi[14] = dw_1.object.id_update[i]   
	ls_imsi[15] = dw_1.object.dts_update[i]  
	ls_imsi[16] = dw_1.object.no_res[i]      
	ls_imsi[17] = dw_1.object.yn_biztax[i]    
	ls_imsi[18] = dw_1.object.no_biztax[i]    
	ls_imsi[19] = dw_1.object.yn_jeonja[i]    
	ls_imsi[20] = dw_1.object.tp_palcoholic[i]
/*
	INSERT INTO ADM_FI_PARTNO
	(
	REGTIME,  NO_COMPANY,  CD_PARTNER, CD_COMPANY,  NM_PARTNER,  NM_MASTER,  TP_JOB,  CLS_JOB,  ADS_HD     
	, DT_STANDARD, DT_END, ST_PARTNER,  ID_INSERT,  DTS_INSERT,  ID_UPDATE,  DTS_UPDATE,  NO_RES     
	, YN_BIZTAX, NO_BIZTAX, YN_JEONJA, TP_PALCOHOLIC
	)
	VALUES
	(
	:ls_regtime, :ls_imsi[1], :ls_imsi[2], :ls_imsi[3], :ls_imsi[4], :ls_imsi[5]
	, :ls_imsi[6], :ls_imsi[7], :ls_imsi[8], :ls_imsi[9], :ls_imsi[10]
	, :ls_imsi[11], :ls_imsi[12], :ls_imsi[13], :ls_imsi[14], :ls_imsi[15]
	, :ls_imsi[16], :ls_imsi[17], :ls_imsi[18], :ls_imsi[19], :ls_imsi[20]
	)
	USING SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("오류", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;		
		RETURN FALSE
	END IF
	*/
next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_map_full (string as_frdate, string as_todate);Long   ll_rowcount, i
String ls_imsi[20], ls_regtime  

ll_rowcount = dw_1.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1
/*
DELETE /*+ NOLOGGING */ FROM ADM_FI_PARTNO USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("오류", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF

select to_char(sysdate, 'yyyymmddhh24miss')
into :ls_regtime
from dual;
*/
for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_1.object.no_company[i]   
	ls_imsi[2] = dw_1.object.cd_partner[i]  
	ls_imsi[3] = dw_1.object.cd_company[i]   
	ls_imsi[4] = dw_1.object.nm_partner[i]  
	ls_imsi[5] = dw_1.object.nm_master[i]   
	ls_imsi[6] = dw_1.object.tp_job[i]      
	ls_imsi[7] = dw_1.object.cls_job[i]     
	ls_imsi[8] = dw_1.object.ads_hd[i]      
	ls_imsi[9] = dw_1.object.dt_standard[i]  
	ls_imsi[10] = dw_1.object.dt_end[i]       
	ls_imsi[11] = dw_1.object.st_partner[i]   
	ls_imsi[12] = dw_1.object.id_insert[i]   
	ls_imsi[13] = dw_1.object.dts_insert[i]  
	ls_imsi[14] = dw_1.object.id_update[i]   
	ls_imsi[15] = dw_1.object.dts_update[i]  
	ls_imsi[16] = dw_1.object.no_res[i]      
	ls_imsi[17] = dw_1.object.yn_biztax[i]    
	ls_imsi[18] = dw_1.object.no_biztax[i]    
	ls_imsi[19] = dw_1.object.yn_jeonja[i]    
	ls_imsi[20] = dw_1.object.tp_palcoholic[i]
/*
	INSERT INTO ADM_FI_PARTNO
	(
	REGTIME,  NO_COMPANY,  CD_PARTNER, CD_COMPANY,  NM_PARTNER,  NM_MASTER,  TP_JOB,  CLS_JOB,  ADS_HD     
	, DT_STANDARD, DT_END, ST_PARTNER,  ID_INSERT,  DTS_INSERT,  ID_UPDATE,  DTS_UPDATE,  NO_RES     
	, YN_BIZTAX, NO_BIZTAX, YN_JEONJA, TP_PALCOHOLIC
	)
	VALUES
	(
	:ls_regtime, :ls_imsi[1], :ls_imsi[2], :ls_imsi[3], :ls_imsi[4], :ls_imsi[5]
	, :ls_imsi[6], :ls_imsi[7], :ls_imsi[8], :ls_imsi[9], :ls_imsi[10]
	, :ls_imsi[11], :ls_imsi[12], :ls_imsi[13], :ls_imsi[14], :ls_imsi[15]
	, :ls_imsi[16], :ls_imsi[17], :ls_imsi[18], :ls_imsi[19], :ls_imsi[20]
	)
	USING SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("오류", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;		
		RETURN FALSE
	END IF
	*/
next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_code_full ();Long   ll_rowcount, i
String ls_imsi[83], ls_regtime  

ll_rowcount = dw_2.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1
/*
DELETE /*+ NOLOGGING */ FROM ADM_FI_ACCTCODE USING SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("오류", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF

select to_char(sysdate, 'yyyymmddhh24miss')
into :ls_regtime
from dual;
*/
for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_2.object.cd_acct[i]         
	ls_imsi[2] = dw_2.object.cd_company[i]      
	ls_imsi[3] = dw_2.object.cd_acgrp[i]        
	ls_imsi[4] = dw_2.object.tp_drcr[i]         
	ls_imsi[5] = dw_2.object.nm_acct[i]         
	ls_imsi[6] = dw_2.object.nm_pacct[i]        
	ls_imsi[7] = dw_2.object.nm_acct2[i]        
	ls_imsi[8] = dw_2.object.nm_acct3[i]        
	ls_imsi[9] = dw_2.object.tp_acstats[i]      
	ls_imsi[10] = dw_2.object.cd_acseq[i]        
	ls_imsi[11] = dw_2.object.tp_aclevel[i]      
	ls_imsi[12] = dw_2.object.cd_acitem[i]       
	ls_imsi[13] = dw_2.object.cd_achtem[i]       
	ls_imsi[14] = dw_2.object.cd_actype[i]       
	ls_imsi[15] = dw_2.object.cd_relation[i]     
	ls_imsi[16] = dw_2.object.yn_relation[i]     
	ls_imsi[17] = dw_2.object.yn_ban[i]          
	ls_imsi[18] = dw_2.object.ban_mng1[i]       
	ls_imsi[19] = dw_2.object.ban_mng2[i]        
	ls_imsi[20] = dw_2.object.yn_cuamt[i]        
	ls_imsi[21] = dw_2.object.yn_expens[i]       
	ls_imsi[22] = dw_2.object.yn_fill[i]         
	ls_imsi[23] = dw_2.object.tp_bglevel[i]      
	ls_imsi[24] = dw_2.object.tp_bunit[i]        
	ls_imsi[25] = dw_2.object.tp_bconterm[i]     
	ls_imsi[26] = dw_2.object.yn_bforwd[i]       
	ls_imsi[27] = dw_2.object.tp_bmsg[i]         
	ls_imsi[28] = dw_2.object.tp_acmain[i]       
	ls_imsi[29] = dw_2.object.yn_fundplan[i]     
	ls_imsi[30] = dw_2.object.cd_drfund[i]       
	ls_imsi[31] = dw_2.object.cd_crfund[i]       
	ls_imsi[32] = dw_2.object.hpjan_prn[i]       
	ls_imsi[33] = dw_2.object.jemu_prn[i]        
	ls_imsi[34] = dw_2.object.ac_prntype[i]      
	ls_imsi[35] = dw_2.object.cd_accost[i]       
	ls_imsi[36] = dw_2.object.cd_mng1[i]         
	ls_imsi[37] = dw_2.object.cd_mng2[i]         
	ls_imsi[38] = dw_2.object.cd_mng3[i]         
	ls_imsi[39] = dw_2.object.cd_mng4[i]         
	ls_imsi[40] = dw_2.object.cd_mng5[i]         
	ls_imsi[41] = dw_2.object.cd_mng6[i]         
	ls_imsi[42] = dw_2.object.cd_mng7[i]         
	ls_imsi[43] = dw_2.object.cd_mng8[i]         
	ls_imsi[44] = dw_2.object.st_mng1[i]         
	ls_imsi[45] = dw_2.object.st_mng2[i]         
	ls_imsi[46] = dw_2.object.st_mng3[i]         
	ls_imsi[47] = dw_2.object.st_mng4[i]         
	ls_imsi[48] = dw_2.object.st_mng5[i]         
	ls_imsi[49] = dw_2.object.st_mng6[i]         
	ls_imsi[50] = dw_2.object.st_mng7[i]         
	ls_imsi[51] = dw_2.object.st_mng8[i]         
	ls_imsi[52] = dw_2.object.id_insert[i]       
	ls_imsi[53] = dw_2.object.dts_insert[i]      
	ls_imsi[54] = dw_2.object.id_update[i]       
	ls_imsi[55] = dw_2.object.dts_update[i]      
	ls_imsi[56] = dw_2.object.cd_tax[i]          
	ls_imsi[57] = dw_2.object.nm_userde1[i]      
	ls_imsi[58] = dw_2.object.nm_userde2[i]      
	ls_imsi[59] = dw_2.object.yn_banpilsu[i]     
	ls_imsi[60] = dw_2.object.plus_mapcode[i]    
	ls_imsi[61] = dw_2.object.nm_userde3[i]      
	ls_imsi[62] = dw_2.object.yn_bgacct[i]       
	ls_imsi[63] = dw_2.object.yn_split[i]        
	ls_imsi[64] = dw_2.object.if_gr_acct_code[i] 
	ls_imsi[65] = dw_2.object.if_tp_arap[i]      
	ls_imsi[66] = dw_2.object.yn_evidence[i]     
	ls_imsi[67] = dw_2.object.nm_acct_l1[i]      
	ls_imsi[68] = dw_2.object.nm_acct_l2[i]      
	ls_imsi[69] = dw_2.object.nm_acct_l3[i]      
	ls_imsi[70] = dw_2.object.nm_acct_l4[i]      
	ls_imsi[71] = dw_2.object.nm_acct_l5[i]      
	ls_imsi[72] = dw_2.object.nm_pacct_l1[i]     
	ls_imsi[73] = dw_2.object.nm_pacct_l2[i]     
	ls_imsi[74] = dw_2.object.nm_pacct_l3[i]     
	ls_imsi[75] = dw_2.object.nm_pacct_l4[i]     
	ls_imsi[76] = dw_2.object.nm_pacct_l5[i]     
	ls_imsi[77] = dw_2.object.yn_use[i]          
	ls_imsi[78] = dw_2.object.yn_bizcar[i]       
	ls_imsi[79] = dw_2.object.tp_gwtax[i]        
	ls_imsi[80] = dw_2.object.txt_user[i]       
	ls_imsi[81] = dw_2.object.no_wehago_key[i]   
	ls_imsi[82] = dw_2.object.cd_userdef1[i]     
	ls_imsi[83] = dw_2.object.nm_input[i]        
/*
	INSERT INTO ADM_FI_ACCTCODE
	(
	regtime
	, cd_acct         
	, cd_company      
	, cd_acgrp        
	, tp_drcr         
	, nm_acct         
	, nm_pacct        
	, nm_acct2        
	, nm_acct3        
	, tp_acstats      
	, cd_acseq        
	, tp_aclevel      
	, cd_acitem       
	, cd_achtem       
	, cd_actype       
	, cd_relation     
	, yn_relation     
	, yn_ban          
	, ban_mng1        
	, ban_mng2        
	, yn_cuamt        
	, yn_expens       
	, yn_fill         
	, tp_bglevel      
	, tp_bunit        
	, tp_bconterm     
	, yn_bforwd       
	, tp_bmsg         
	, tp_acmain       
	, yn_fundplan     
	, cd_drfund       
	, cd_crfund       
	, hpjan_prn       
	, jemu_prn        
	, ac_prntype      
	, cd_accost       
	, cd_mng1         
	, cd_mng2         
	, cd_mng3         
	, cd_mng4         
	, cd_mng5         
	, cd_mng6         
	, cd_mng7         
	, cd_mng8         
	, st_mng1         
	, st_mng2         
	, st_mng3         
	, st_mng4         
	, st_mng5         
	, st_mng6         
	, st_mng7         
	, st_mng8         
	, id_insert       
	, dts_insert      
	, id_update       
	, dts_update      
	, cd_tax          
	, nm_userde1      
	, nm_userde2      
	, yn_banpilsu     
	, plus_mapcode    
	, nm_userde3      
	, yn_bgacct       
	, yn_split        
	, if_gr_acct_code 
	, if_tp_arap      
	, yn_evidence     
	, nm_acct_l1      
	, nm_acct_l2      
	, nm_acct_l3      
	, nm_acct_l4      
	, nm_acct_l5      
	, nm_pacct_l1     
	, nm_pacct_l2     
	, nm_pacct_l3     
	, nm_pacct_l4     
	, nm_pacct_l5     
	, yn_use          
	, yn_bizcar       
	, tp_gwtax        
	, txt_user        
	, no_wehago_key   
	, cd_userdef1     
	, nm_input        
	)
	VALUES
	(
	:ls_regtime
	, :ls_imsi[1]   
	,	:ls_imsi[2] 
	,	:ls_imsi[3] 
	,	:ls_imsi[4] 
	,	:ls_imsi[5] 
	,	:ls_imsi[6] 
	,	:ls_imsi[7] 
	,	:ls_imsi[8] 
	,	:ls_imsi[9] 
	,	:ls_imsi[10]
	,	:ls_imsi[11]
	,	:ls_imsi[12]
	,	:ls_imsi[13]
	,	:ls_imsi[14]
	,	:ls_imsi[15]
	,	:ls_imsi[16]
	,	:ls_imsi[17]
	,	:ls_imsi[18]
	,	:ls_imsi[19]
	,	:ls_imsi[20]
	,	:ls_imsi[21]
	,	:ls_imsi[22]
	,	:ls_imsi[23]
	,	:ls_imsi[24]
	,	:ls_imsi[25]
	,	:ls_imsi[26]
	,	:ls_imsi[27]
	,	:ls_imsi[28]
	,	:ls_imsi[29]
	,	:ls_imsi[30]
	,	:ls_imsi[31]
	,	:ls_imsi[32]
	,	:ls_imsi[33]
	,	:ls_imsi[34]
	,	:ls_imsi[35]
	,	:ls_imsi[36]
	,	:ls_imsi[37]
	,	:ls_imsi[38]
	,	:ls_imsi[39]
	,	:ls_imsi[40]
	,	:ls_imsi[41]
	,	:ls_imsi[42]
	,	:ls_imsi[43]
	,	:ls_imsi[44]
	,	:ls_imsi[45]
	,	:ls_imsi[46]
	,	:ls_imsi[47]
	,	:ls_imsi[48]
	,	:ls_imsi[49]
	,	:ls_imsi[50]
	,	:ls_imsi[51]
	,	:ls_imsi[52]
	,	:ls_imsi[53]
	,	:ls_imsi[54]
	,	:ls_imsi[55]
	,	:ls_imsi[56]
	,	:ls_imsi[57]
	,	:ls_imsi[58]
	,	:ls_imsi[59]
	,	:ls_imsi[60]
	,	:ls_imsi[61]
	,	:ls_imsi[62]
	,	:ls_imsi[63]
	,	:ls_imsi[64]
	,	:ls_imsi[65]
	,	:ls_imsi[66]
	,	:ls_imsi[67]
	,	:ls_imsi[68]
	,	:ls_imsi[69]
	,	:ls_imsi[70]
	,	:ls_imsi[71]
	,	:ls_imsi[72]
	,	:ls_imsi[73]
	,	:ls_imsi[74]
	,	:ls_imsi[75]
	,	:ls_imsi[76]
	,	:ls_imsi[77]
	,	:ls_imsi[78]
	,	:ls_imsi[79]
	,	:ls_imsi[80]
	,	:ls_imsi[81]
	,	:ls_imsi[82]
	,	:ls_imsi[83]
	)
	USING SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("오류", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;		
		RETURN FALSE
	END IF
	*/
next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_code ();Long   ll_rowcount, i
String ls_imsi[83], ls_regtime, ls_dts_indert  
/*
SELECT SUBSTR(MAX(DTS_INSERT), 1, 8)
INTO :ls_dts_indert
FROM ADM_FI_ACCTCODE
USING SQLCA;
*/
dw_2.SetFilter("dts_insert > '" + ls_dts_indert + "000000'" + ' or ' + "dts_update > '" + ls_dts_indert + "000000'")
dw_2.Filter()
dw_2.SetFilter("")

ll_rowcount = dw_2.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1
	/*
DELETE /*+ NOLOGGING */ FROM ADM_FI_ACCTCODE
WHERE DTS_INSERT >=  :ls_dts_indert||'000000'
OR DTS_UPDATE >=  :ls_dts_indert||'000000';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("오류", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF

select to_char(sysdate, 'yyyymmddhh24miss')
into :ls_regtime
from dual;
*/
for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_2.object.cd_acct[i]         
	ls_imsi[2] = dw_2.object.cd_company[i]      
	ls_imsi[3] = dw_2.object.cd_acgrp[i]        
	ls_imsi[4] = dw_2.object.tp_drcr[i]         
	ls_imsi[5] = dw_2.object.nm_acct[i]         
	ls_imsi[6] = dw_2.object.nm_pacct[i]        
	ls_imsi[7] = dw_2.object.nm_acct2[i]        
	ls_imsi[8] = dw_2.object.nm_acct3[i]        
	ls_imsi[9] = dw_2.object.tp_acstats[i]      
	ls_imsi[10] = dw_2.object.cd_acseq[i]        
	ls_imsi[11] = dw_2.object.tp_aclevel[i]      
	ls_imsi[12] = dw_2.object.cd_acitem[i]       
	ls_imsi[13] = dw_2.object.cd_achtem[i]       
	ls_imsi[14] = dw_2.object.cd_actype[i]       
	ls_imsi[15] = dw_2.object.cd_relation[i]     
	ls_imsi[16] = dw_2.object.yn_relation[i]     
	ls_imsi[17] = dw_2.object.yn_ban[i]          
	ls_imsi[18] = dw_2.object.ban_mng1[i]       
	ls_imsi[19] = dw_2.object.ban_mng2[i]        
	ls_imsi[20] = dw_2.object.yn_cuamt[i]        
	ls_imsi[21] = dw_2.object.yn_expens[i]       
	ls_imsi[22] = dw_2.object.yn_fill[i]         
	ls_imsi[23] = dw_2.object.tp_bglevel[i]      
	ls_imsi[24] = dw_2.object.tp_bunit[i]        
	ls_imsi[25] = dw_2.object.tp_bconterm[i]     
	ls_imsi[26] = dw_2.object.yn_bforwd[i]       
	ls_imsi[27] = dw_2.object.tp_bmsg[i]         
	ls_imsi[28] = dw_2.object.tp_acmain[i]       
	ls_imsi[29] = dw_2.object.yn_fundplan[i]     
	ls_imsi[30] = dw_2.object.cd_drfund[i]       
	ls_imsi[31] = dw_2.object.cd_crfund[i]       
	ls_imsi[32] = dw_2.object.hpjan_prn[i]       
	ls_imsi[33] = dw_2.object.jemu_prn[i]        
	ls_imsi[34] = dw_2.object.ac_prntype[i]      
	ls_imsi[35] = dw_2.object.cd_accost[i]       
	ls_imsi[36] = dw_2.object.cd_mng1[i]         
	ls_imsi[37] = dw_2.object.cd_mng2[i]         
	ls_imsi[38] = dw_2.object.cd_mng3[i]         
	ls_imsi[39] = dw_2.object.cd_mng4[i]         
	ls_imsi[40] = dw_2.object.cd_mng5[i]         
	ls_imsi[41] = dw_2.object.cd_mng6[i]         
	ls_imsi[42] = dw_2.object.cd_mng7[i]         
	ls_imsi[43] = dw_2.object.cd_mng8[i]         
	ls_imsi[44] = dw_2.object.st_mng1[i]         
	ls_imsi[45] = dw_2.object.st_mng2[i]         
	ls_imsi[46] = dw_2.object.st_mng3[i]         
	ls_imsi[47] = dw_2.object.st_mng4[i]         
	ls_imsi[48] = dw_2.object.st_mng5[i]         
	ls_imsi[49] = dw_2.object.st_mng6[i]         
	ls_imsi[50] = dw_2.object.st_mng7[i]         
	ls_imsi[51] = dw_2.object.st_mng8[i]         
	ls_imsi[52] = dw_2.object.id_insert[i]       
	ls_imsi[53] = dw_2.object.dts_insert[i]      
	ls_imsi[54] = dw_2.object.id_update[i]       
	ls_imsi[55] = dw_2.object.dts_update[i]      
	ls_imsi[56] = dw_2.object.cd_tax[i]          
	ls_imsi[57] = dw_2.object.nm_userde1[i]      
	ls_imsi[58] = dw_2.object.nm_userde2[i]      
	ls_imsi[59] = dw_2.object.yn_banpilsu[i]     
	ls_imsi[60] = dw_2.object.plus_mapcode[i]    
	ls_imsi[61] = dw_2.object.nm_userde3[i]      
	ls_imsi[62] = dw_2.object.yn_bgacct[i]       
	ls_imsi[63] = dw_2.object.yn_split[i]        
	ls_imsi[64] = dw_2.object.if_gr_acct_code[i] 
	ls_imsi[65] = dw_2.object.if_tp_arap[i]      
	ls_imsi[66] = dw_2.object.yn_evidence[i]     
	ls_imsi[67] = dw_2.object.nm_acct_l1[i]      
	ls_imsi[68] = dw_2.object.nm_acct_l2[i]      
	ls_imsi[69] = dw_2.object.nm_acct_l3[i]      
	ls_imsi[70] = dw_2.object.nm_acct_l4[i]      
	ls_imsi[71] = dw_2.object.nm_acct_l5[i]      
	ls_imsi[72] = dw_2.object.nm_pacct_l1[i]     
	ls_imsi[73] = dw_2.object.nm_pacct_l2[i]     
	ls_imsi[74] = dw_2.object.nm_pacct_l3[i]     
	ls_imsi[75] = dw_2.object.nm_pacct_l4[i]     
	ls_imsi[76] = dw_2.object.nm_pacct_l5[i]     
	ls_imsi[77] = dw_2.object.yn_use[i]          
	ls_imsi[78] = dw_2.object.yn_bizcar[i]       
	ls_imsi[79] = dw_2.object.tp_gwtax[i]        
	ls_imsi[80] = dw_2.object.txt_user[i]       
	ls_imsi[81] = dw_2.object.no_wehago_key[i]   
	ls_imsi[82] = dw_2.object.cd_userdef1[i]     
	ls_imsi[83] = dw_2.object.nm_input[i]        
/*
	INSERT INTO ADM_FI_ACCTCODE
	(
   regtime
	, cd_acct         
	, cd_company      
	, cd_acgrp        
	, tp_drcr         
	, nm_acct         
	, nm_pacct        
	, nm_acct2        
	, nm_acct3        
	, tp_acstats      
	, cd_acseq        
	, tp_aclevel      
	, cd_acitem       
	, cd_achtem       
	, cd_actype       
	, cd_relation     
	, yn_relation     
	, yn_ban          
	, ban_mng1        
	, ban_mng2        
	, yn_cuamt        
	, yn_expens       
	, yn_fill         
	, tp_bglevel      
	, tp_bunit        
	, tp_bconterm     
	, yn_bforwd       
	, tp_bmsg         
	, tp_acmain       
	, yn_fundplan     
	, cd_drfund       
	, cd_crfund       
	, hpjan_prn       
	, jemu_prn        
	, ac_prntype      
	, cd_accost       
	, cd_mng1         
	, cd_mng2         
	, cd_mng3         
	, cd_mng4         
	, cd_mng5         
	, cd_mng6         
	, cd_mng7         
	, cd_mng8         
	, st_mng1         
	, st_mng2         
	, st_mng3         
	, st_mng4         
	, st_mng5         
	, st_mng6         
	, st_mng7         
	, st_mng8         
	, id_insert       
	, dts_insert      
	, id_update       
	, dts_update      
	, cd_tax          
	, nm_userde1      
	, nm_userde2      
	, yn_banpilsu     
	, plus_mapcode    
	, nm_userde3      
	, yn_bgacct       
	, yn_split        
	, if_gr_acct_code 
	, if_tp_arap      
	, yn_evidence     
	, nm_acct_l1      
	, nm_acct_l2      
	, nm_acct_l3      
	, nm_acct_l4      
	, nm_acct_l5      
	, nm_pacct_l1     
	, nm_pacct_l2     
	, nm_pacct_l3     
	, nm_pacct_l4     
	, nm_pacct_l5     
	, yn_use          
	, yn_bizcar       
	, tp_gwtax        
	, txt_user        
	, no_wehago_key   
	, cd_userdef1     
	, nm_input        
	)
	VALUES
	(
	:ls_regtime
	, :ls_imsi[1]   
	,	:ls_imsi[2] 
	,	:ls_imsi[3] 
	,	:ls_imsi[4] 
	,	:ls_imsi[5] 
	,	:ls_imsi[6] 
	,	:ls_imsi[7] 
	,	:ls_imsi[8] 
	,	:ls_imsi[9] 
	,	:ls_imsi[10]
	,	:ls_imsi[11]
	,	:ls_imsi[12]
	,	:ls_imsi[13]
	,	:ls_imsi[14]
	,	:ls_imsi[15]
	,	:ls_imsi[16]
	,	:ls_imsi[17]
	,	:ls_imsi[18]
	,	:ls_imsi[19]
	,	:ls_imsi[20]
	,	:ls_imsi[21]
	,	:ls_imsi[22]
	,	:ls_imsi[23]
	,	:ls_imsi[24]
	,	:ls_imsi[25]
	,	:ls_imsi[26]
	,	:ls_imsi[27]
	,	:ls_imsi[28]
	,	:ls_imsi[29]
	,	:ls_imsi[30]
	,	:ls_imsi[31]
	,	:ls_imsi[32]
	,	:ls_imsi[33]
	,	:ls_imsi[34]
	,	:ls_imsi[35]
	,	:ls_imsi[36]
	,	:ls_imsi[37]
	,	:ls_imsi[38]
	,	:ls_imsi[39]
	,	:ls_imsi[40]
	,	:ls_imsi[41]
	,	:ls_imsi[42]
	,	:ls_imsi[43]
	,	:ls_imsi[44]
	,	:ls_imsi[45]
	,	:ls_imsi[46]
	,	:ls_imsi[47]
	,	:ls_imsi[48]
	,	:ls_imsi[49]
	,	:ls_imsi[50]
	,	:ls_imsi[51]
	,	:ls_imsi[52]
	,	:ls_imsi[53]
	,	:ls_imsi[54]
	,	:ls_imsi[55]
	,	:ls_imsi[56]
	,	:ls_imsi[57]
	,	:ls_imsi[58]
	,	:ls_imsi[59]
	,	:ls_imsi[60]
	,	:ls_imsi[61]
	,	:ls_imsi[62]
	,	:ls_imsi[63]
	,	:ls_imsi[64]
	,	:ls_imsi[65]
	,	:ls_imsi[66]
	,	:ls_imsi[67]
	,	:ls_imsi[68]
	,	:ls_imsi[69]
	,	:ls_imsi[70]
	,	:ls_imsi[71]
	,	:ls_imsi[72]
	,	:ls_imsi[73]
	,	:ls_imsi[74]
	,	:ls_imsi[75]
	,	:ls_imsi[76]
	,	:ls_imsi[77]
	,	:ls_imsi[78]
	,	:ls_imsi[79]
	,	:ls_imsi[80]
	,	:ls_imsi[81]
	,	:ls_imsi[82]
	,	:ls_imsi[83]
	)
	USING SQLCA;
	
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("오류", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;		
		RETURN FALSE
	END IF
	*/
next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_code_mng ();Long   ll_rowcount, i
String ls_imsi[22], ls_regtime, ls_dts_indert  
/*
SELECT SUBSTR(MAX(DTS_INSERT), 1, 8)
INTO :ls_dts_indert
FROM ADM_FI_ACCTCODE
USING SQLCA;
*/
dw_3.SetFilter("dts_insert > '" + ls_dts_indert + "000000'" + ' or ' + "dts_update > '" + ls_dts_indert + "000000'")
dw_3.Filter()
dw_3.SetFilter("")

ll_rowcount = dw_3.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1
	/*
DELETE /*+ NOLOGGING */ FROM ADM_FI_ACCTCODE_MNG
WHERE DTS_INSERT >=  :ls_dts_indert||'000000'
OR DTS_UPDATE >=  :ls_dts_indert||'000000';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("오류", SQLCA.SQLErrText)
	ROLLBACK USING SQLCA;
	RETURN FALSE
END IF

select to_char(sysdate, 'yyyymmddhh24miss')
into :ls_regtime
from dual;
*/
for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_3.object.cd_acct[i]         
	ls_imsi[2] = dw_3.object.cd_company[i]      
	ls_imsi[3] = dw_3.object.cd_mng1[i]        
	ls_imsi[4] = dw_3.object.cd_mng2[i]         
	ls_imsi[5] = dw_3.object.cd_mng3[i]         
	ls_imsi[6] = dw_3.object.cd_mng4[i]        
	ls_imsi[7] = dw_3.object.cd_mng5[i]        
	ls_imsi[8] = dw_3.object.cd_mng6[i]        
	ls_imsi[9] = dw_3.object.cd_mng7[i]      
	ls_imsi[10] = dw_3.object.cd_mng8[i]        
	ls_imsi[11] = dw_3.object.st_mng1[i]      
	ls_imsi[12] = dw_3.object.st_mng2[i]       
	ls_imsi[13] = dw_3.object.st_mng3[i]       
	ls_imsi[14] = dw_3.object.st_mng4[i]       
	ls_imsi[15] = dw_3.object.st_mng5[i]     
	ls_imsi[16] = dw_3.object.st_mng6[i]     
	ls_imsi[17] = dw_3.object.st_mng7[i]          
	ls_imsi[18] = dw_3.object.st_mng8[i]       
	ls_imsi[19] = dw_3.object.id_insert[i]        
	ls_imsi[20] = dw_3.object.dts_insert[i]        
	ls_imsi[21] = dw_3.object.id_update[i]       
	ls_imsi[22] = dw_3.object.dts_update[i]                

next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_code_mng_full ();Long   ll_rowcount, i
String ls_imsi[22], ls_regtime  

ll_rowcount = dw_3.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1

for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_3.object.cd_acct[i]         
	ls_imsi[2] = dw_3.object.cd_company[i]      
	ls_imsi[3] = dw_3.object.cd_mng1[i]        
	ls_imsi[4] = dw_3.object.cd_mng2[i]         
	ls_imsi[5] = dw_3.object.cd_mng3[i]         
	ls_imsi[6] = dw_3.object.cd_mng4[i]        
	ls_imsi[7] = dw_3.object.cd_mng5[i]        
	ls_imsi[8] = dw_3.object.cd_mng6[i]        
	ls_imsi[9] = dw_3.object.cd_mng7[i]      
	ls_imsi[10] = dw_3.object.cd_mng8[i]        
	ls_imsi[11] = dw_3.object.st_mng1[i]      
	ls_imsi[12] = dw_3.object.st_mng2[i]       
	ls_imsi[13] = dw_3.object.st_mng3[i]       
	ls_imsi[14] = dw_3.object.st_mng4[i]       
	ls_imsi[15] = dw_3.object.st_mng5[i]     
	ls_imsi[16] = dw_3.object.st_mng6[i]     
	ls_imsi[17] = dw_3.object.st_mng7[i]          
	ls_imsi[18] = dw_3.object.st_mng8[i]       
	ls_imsi[19] = dw_3.object.id_insert[i]        
	ls_imsi[20] = dw_3.object.dts_insert[i]        
	ls_imsi[21] = dw_3.object.id_update[i]       
	ls_imsi[22] = dw_3.object.dts_update[i]                

next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_docu_map (string as_frdate, string as_todate, string as_card_num);Long   ll_rowcount, i
String ls_imsi[105], ls_regtime, ls_dts_indert  
/*
SELECT SUBSTR(MAX(DTS_INSERT), 1, 8)
INTO :ls_dts_indert
FROM ADM_FI_PARTNO
USING SQLCA;
*/
dw_4.SetFilter("dts_insert > '" + ls_dts_indert + "000000'" + ' or ' + "dts_update > '" + ls_dts_indert + "000000'")
dw_4.Filter()
dw_4.SetFilter("")

ll_rowcount = dw_4.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1


for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	
	ls_imsi[1] = dw_4.object.regtime[i]    
	ls_imsi[2] = dw_4.object.no_docu[i]    
	ls_imsi[3] = dw_4.object.no_doline[i]  
	ls_imsi[4] = dw_4.object.cd_pc[i]      
	ls_imsi[5] = dw_4.object.cd_company[i] 
	ls_imsi[6] = dw_4.object.cd_wdept[i]   
	ls_imsi[7] = dw_4.object.id_write[i]   
	ls_imsi[8] = dw_4.object.dt_acct[i]    
	ls_imsi[9] = dw_4.object.no_acct[i]    
	ls_imsi[10] = dw_4.object.tp_docu[i]    
	ls_imsi[11] = dw_4.object.cd_docu[i]    
	ls_imsi[12] = dw_4.object.st_docu[i]    
	ls_imsi[13] = dw_4.object.id_accept[i]  
	ls_imsi[14] = dw_4.object.tp_drcr[i]    
	ls_imsi[15] = dw_4.object.cd_acct[i]    
	ls_imsi[16] = dw_4.object.nm_note[i]    
	ls_imsi[17] = dw_4.object.am_dr[i]      
	ls_imsi[18] = dw_4.object.am_cr[i]      
	ls_imsi[19] = dw_4.object.tp_acarea[i]  
	ls_imsi[20] = dw_4.object.cd_relation[i]
	ls_imsi[21] = dw_4.object.cd_budget[i]  
	ls_imsi[22] = dw_4.object.cd_fund[i]    
	ls_imsi[23] = dw_4.object.tp_tax[i]     
	ls_imsi[24] = dw_4.object.no_bdocu[i]   
	ls_imsi[25] = dw_4.object.no_bdoline[i] 
	ls_imsi[26] = dw_4.object.tp_etcacct[i] 
	ls_imsi[27] = dw_4.object.cd_bizarea[i] 
	ls_imsi[28] = dw_4.object.cd_cc[i]      
	ls_imsi[29] = dw_4.object.cd_pjt[i]     
	ls_imsi[30] = dw_4.object.cd_dept[i]    
	ls_imsi[31] = dw_4.object.cd_employ[i]  
	ls_imsi[32] = dw_4.object.cd_partner[i] 
	ls_imsi[33] = dw_4.object.cd_deposit[i] 
	ls_imsi[34] = dw_4.object.cd_card[i]    
	ls_imsi[35] = dw_4.object.cd_bank[i]    
	ls_imsi[36] = dw_4.object.no_item[i]    
	ls_imsi[37] = dw_4.object.cd_umng1[i]   
	ls_imsi[38] = dw_4.object.cd_umng2[i]   
	ls_imsi[39] = dw_4.object.cd_umng3[i]   
	ls_imsi[40] = dw_4.object.cd_umng4[i]   
	ls_imsi[41] = dw_4.object.cd_umng5[i]   
	ls_imsi[42] = dw_4.object.cd_mng[i]     
	ls_imsi[43] = dw_4.object.cd_trade[i]   
	ls_imsi[44] = dw_4.object.dt_start[i]   
	ls_imsi[45] = dw_4.object.dt_end[i]     
	ls_imsi[46] = dw_4.object.cd_exch[i]   
	ls_imsi[47] = dw_4.object.rt_exch[i]    
	ls_imsi[48] = dw_4.object.am_exdo[i]    
	ls_imsi[49] = dw_4.object.cd_mng1[i]    
	ls_imsi[50] = dw_4.object.cd_mngd1[i]   
	ls_imsi[51] = dw_4.object.nm_mngd1[i]   
	ls_imsi[52] = dw_4.object.cd_mng2[i]    
	ls_imsi[53] = dw_4.object.cd_mngd2[i]   
	ls_imsi[54] = dw_4.object.nm_mngd2[i]   
	ls_imsi[55] = dw_4.object.cd_mng3[i]    
	ls_imsi[56] = dw_4.object.cd_mngd3[i]   
	ls_imsi[57] = dw_4.object.nm_mngd3[i]   
	ls_imsi[58] = dw_4.object.cd_mng4[i]    
	ls_imsi[59] = dw_4.object.cd_mngd4[i]   
	ls_imsi[60] = dw_4.object.nm_mngd4[i]   
	ls_imsi[61] = dw_4.object.cd_mng5[i]    
	ls_imsi[62] = dw_4.object.cd_mngd5[i]   
	ls_imsi[63] = dw_4.object.nm_mngd5[i]   
	ls_imsi[64] = dw_4.object.cd_mng6[i]    
	ls_imsi[65] = dw_4.object.cd_mngd6[i]   
	ls_imsi[66] = dw_4.object.nm_mngd6[i]   
	ls_imsi[67] = dw_4.object.cd_mng7[i]    
	ls_imsi[68] = dw_4.object.cd_mngd7[i]   
	ls_imsi[69] = dw_4.object.nm_mngd7[i]   
	ls_imsi[70] = dw_4.object.cd_mng8[i]    
	ls_imsi[71] = dw_4.object.cd_mngd8[i]   
	ls_imsi[72] = dw_4.object.nm_mngd8[i]   
	ls_imsi[73] = dw_4.object.no_module[i]  
	ls_imsi[74] = dw_4.object.no_mdocu[i]   
	ls_imsi[75] = dw_4.object.cd_epnote[i]  
	ls_imsi[76] = dw_4.object.id_insert[i]  
	ls_imsi[77] = dw_4.object.dts_insert[i] 
	ls_imsi[78] = dw_4.object.id_update[i]  
	ls_imsi[79] = dw_4.object.dts_update[i] 
	ls_imsi[80] = dw_4.object.cd_bgacct[i]  
	ls_imsi[81] = dw_4.object.tp_epnote[i]  
	ls_imsi[82] = dw_4.object.nm_pumm[i]    
	ls_imsi[83] = dw_4.object.dt_write[i]   
	ls_imsi[84] = dw_4.object.am_actsum[i]  
	ls_imsi[85] = dw_4.object.am_jsum[i]    
	ls_imsi[86] = dw_4.object.yn_gware[i]   
	ls_imsi[87] = dw_4.object.cd_bizplan[i] 
	ls_imsi[88] = dw_4.object.dec_lease[i]  
	ls_imsi[89] = dw_4.object.no_tcost[i]   
	ls_imsi[90] = dw_4.object.st_gware[i]   
	ls_imsi[91] = dw_4.object.tp_input[i]   
	ls_imsi[92] = dw_4.object.id_judge[i]   
	ls_imsi[93] = dw_4.object.qt_attach[i]  
	ls_imsi[94] = dw_4.object.no_gian[i]    
	ls_imsi[95] = dw_4.object.no_giline[i]  
	ls_imsi[96] = dw_4.object.memo_cd[i]    
	ls_imsi[97] = dw_4.object.check_pen[i]  
	ls_imsi[98] = dw_4.object.cd_note[i]    
	ls_imsi[99] = dw_4.object.dt_app[i]     
	ls_imsi[100] = dw_4.object.tp_cash[i]    
	ls_imsi[101] = dw_4.object.cd_mngseq[i]  
	ls_imsi[102] = dw_4.object.tp_evidence[i]
	ls_imsi[103] = dw_4.object.cd_bizcar[i]  
	ls_imsi[104] = dw_4.object.dt_exch[i]    
	ls_imsi[105] = dw_4.object.fg_lang[i]

next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

public function boolean wf_erp_docu_map_full (string as_frdate, string as_todate, string as_card_num);Long   ll_rowcount, i, ll_imsi[10]
String ls_imsi[105], ls_regtime  

ll_rowcount = dw_4.rowcount()

if ll_rowcount = 0 then return false

st_1.text = '총 ' + string(ll_rowcount) + '건 중        건 처리 완료'

hpb_upgrade.MaxPosition = ll_rowcount + 1

for i = 1 to ll_rowcount
	
	Yield()

	hpb_upgrade.StepIt()
	
	st_3.text = string(i)
	  
	ls_imsi[2] = dw_4.object.no_docu[i]    
	ll_imsi[3] = dw_4.object.no_doline[i]  
	ls_imsi[4] = dw_4.object.cd_pc[i]      
	ls_imsi[5] = dw_4.object.cd_company[i] 
	ls_imsi[6] = dw_4.object.cd_wdept[i]   
	ls_imsi[7] = dw_4.object.id_write[i]   
	ls_imsi[8] = dw_4.object.dt_acct[i]    
	ll_imsi[4] = dw_4.object.no_acct[i]    
	ls_imsi[10] = dw_4.object.tp_docu[i]    
	ls_imsi[11] = dw_4.object.cd_docu[i]    
	ls_imsi[12] = dw_4.object.st_docu[i]    
	ls_imsi[13] = dw_4.object.id_accept[i]  
	ls_imsi[14] = dw_4.object.tp_drcr[i]    
	ls_imsi[15] = dw_4.object.cd_acct[i]    
	ls_imsi[16] = dw_4.object.nm_note[i]    
	ll_imsi[1] = dw_4.object.am_dr[i]      
	ll_imsi[2] = dw_4.object.am_cr[i]      
	ls_imsi[19] = dw_4.object.tp_acarea[i]  
	ls_imsi[20] = dw_4.object.cd_relation[i]
	ls_imsi[21] = dw_4.object.cd_budget[i]  
	ls_imsi[22] = dw_4.object.cd_fund[i]    
	ls_imsi[23] = dw_4.object.tp_tax[i]     
	ls_imsi[24] = dw_4.object.no_bdocu[i]   
	ll_imsi[5] = dw_4.object.no_bdoline[i] 
	ls_imsi[26] = dw_4.object.tp_etcacct[i] 
	ls_imsi[27] = dw_4.object.cd_bizarea[i] 
	ls_imsi[28] = dw_4.object.cd_cc[i]      
	ls_imsi[29] = dw_4.object.cd_pjt[i]     
	ls_imsi[30] = dw_4.object.cd_dept[i]    
	ls_imsi[31] = dw_4.object.cd_employ[i]  
	ls_imsi[32] = dw_4.object.cd_partner[i] 
	ls_imsi[33] = dw_4.object.cd_deposit[i] 
	ls_imsi[34] = dw_4.object.cd_card[i]    
	ls_imsi[35] = dw_4.object.cd_bank[i]    
	ls_imsi[36] = dw_4.object.no_item[i]    
	ls_imsi[37] = dw_4.object.cd_umng1[i]   
	ls_imsi[38] = dw_4.object.cd_umng2[i]   
	ls_imsi[39] = dw_4.object.cd_umng3[i]   
	ls_imsi[40] = dw_4.object.cd_umng4[i]   
	ls_imsi[41] = dw_4.object.cd_umng5[i]   
	ls_imsi[42] = dw_4.object.cd_mng[i]     
	ls_imsi[43] = dw_4.object.cd_trade[i]   
	ls_imsi[44] = dw_4.object.dt_start[i]   
	ls_imsi[45] = dw_4.object.dt_end[i]     
	ls_imsi[46] = dw_4.object.cd_exch[i]   
	ll_imsi[9] = dw_4.object.rt_exch[i]    
	ll_imsi[10] = dw_4.object.am_exdo[i]    
	ls_imsi[49] = dw_4.object.cd_mng1[i]    
	ls_imsi[50] = dw_4.object.cd_mngd1[i]   
	ls_imsi[51] = dw_4.object.nm_mngd1[i]   
	ls_imsi[52] = dw_4.object.cd_mng2[i]    
	ls_imsi[53] = dw_4.object.cd_mngd2[i]   
	ls_imsi[54] = dw_4.object.nm_mngd2[i]   
	ls_imsi[55] = dw_4.object.cd_mng3[i]    
	ls_imsi[56] = dw_4.object.cd_mngd3[i]   
	ls_imsi[57] = dw_4.object.nm_mngd3[i]   
	ls_imsi[58] = dw_4.object.cd_mng4[i]    
	ls_imsi[59] = dw_4.object.cd_mngd4[i]   
	ls_imsi[60] = dw_4.object.nm_mngd4[i]   
	ls_imsi[61] = dw_4.object.cd_mng5[i]    
	ls_imsi[62] = dw_4.object.cd_mngd5[i]   
	ls_imsi[63] = dw_4.object.nm_mngd5[i]   
	ls_imsi[64] = dw_4.object.cd_mng6[i]    
	ls_imsi[65] = dw_4.object.cd_mngd6[i]   
	ls_imsi[66] = dw_4.object.nm_mngd6[i]   
	ls_imsi[67] = dw_4.object.cd_mng7[i]    
	ls_imsi[68] = dw_4.object.cd_mngd7[i]   
	ls_imsi[69] = dw_4.object.nm_mngd7[i]   
	ls_imsi[70] = dw_4.object.cd_mng8[i]    
	ls_imsi[71] = dw_4.object.cd_mngd8[i]   
	ls_imsi[72] = dw_4.object.nm_mngd8[i]   
	ls_imsi[73] = dw_4.object.no_module[i]  
	ls_imsi[74] = dw_4.object.no_mdocu[i]   
	ls_imsi[75] = dw_4.object.cd_epnote[i]  
	ls_imsi[76] = dw_4.object.id_insert[i]  
	ls_imsi[77] = dw_4.object.dts_insert[i] 
	ls_imsi[78] = dw_4.object.id_update[i]  
	ls_imsi[79] = dw_4.object.dts_update[i] 
	ls_imsi[80] = dw_4.object.cd_bgacct[i]  
	ls_imsi[81] = dw_4.object.tp_epnote[i]  
	ls_imsi[82] = dw_4.object.nm_pumm[i]    
	ls_imsi[83] = dw_4.object.dt_write[i]   
	ll_imsi[7] = dw_4.object.am_actsum[i]  
	ll_imsi[8] = dw_4.object.am_jsum[i]    
	ls_imsi[86] = dw_4.object.yn_gware[i]   
	ls_imsi[87] = dw_4.object.cd_bizplan[i] 
	ls_imsi[88] = dw_4.object.dec_lease[i]  
	ls_imsi[89] = dw_4.object.no_tcost[i]   
	ls_imsi[90] = dw_4.object.st_gware[i]   
	ls_imsi[91] = dw_4.object.tp_input[i]   
	ls_imsi[92] = dw_4.object.id_judge[i]   
	ls_imsi[93] = dw_4.object.qt_attach[i]  
	ls_imsi[94] = dw_4.object.no_gian[i]    
	ll_imsi[6] = dw_4.object.no_giline[i]  
	ls_imsi[96] = dw_4.object.memo_cd[i]    
	ls_imsi[97] = dw_4.object.check_pen[i]  
	ls_imsi[98] = dw_4.object.cd_note[i]    
	ls_imsi[99] = dw_4.object.dt_app[i]     
	ls_imsi[100] = dw_4.object.tp_cash[i]    
	ls_imsi[101] = dw_4.object.cd_mngseq[i]  
	ls_imsi[102] = dw_4.object.tp_evidence[i]
	ls_imsi[103] = dw_4.object.cd_bizcar[i]  
	ls_imsi[104] = dw_4.object.dt_exch[i]    
	ls_imsi[105] = dw_4.object.fg_lang[i]

next

st_1.text = '집계 시작(몇 분 소요 예정)'
st_3.text = ''

hpb_upgrade.StepIt()

COMMIT USING SQLCA;

return true
		
end function

on w_bar.create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.hpb_upgrade=create hpb_upgrade
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.dw_4,&
this.dw_3,&
this.dw_2,&
this.cb_2,&
this.st_3,&
this.cb_1,&
this.dw_1,&
this.hpb_upgrade,&
this.st_1,&
this.p_1}
end on

on w_bar.destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.hpb_upgrade)
destroy(this.st_1)
destroy(this.p_1)
end on

event open;String ls_code
str_popup	lstr_popup

lstr_popup = Message.PowerObjectParm

ls_code = lstr_popup.rvalue[1]

Post Event ue_open(ls_code)




end event

type dw_4 from datawindow within w_bar
integer x = 2126
integer y = 1744
integer width = 1902
integer height = 572
integer taborder = 20
string title = "none"
string dataobject = "d_40010015"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_bar
integer x = 114
integer y = 1740
integer width = 1902
integer height = 572
integer taborder = 20
string title = "none"
string dataobject = "d_40010009_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_bar
integer x = 2135
integer y = 592
integer width = 1902
integer height = 1088
integer taborder = 20
string title = "none"
string dataobject = "d_40010009"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_bar
integer x = 1033
integer y = 492
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "none"
end type

event clicked;close(w_bar)
end event

type st_3 from statictext within w_bar
integer x = 631
integer y = 140
integer width = 242
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217857
long backcolor = 553648127
string text = "처리중"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_bar
integer x = 1522
integer y = 420
integer width = 283
integer height = 128
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "처리"
end type

event clicked;Long ll_rowcnt_source, i

dw_1.settransobject(EBSQL)

dw_1.SetRedraw(FALSE)

//dw_1.retrieve(ls_eb_frdate, ls_eb_todate)

dw_1.SetRedraw(TRUE)

//wf_income_map(ls_eb_frdate, ls_eb_todate)

close(w_bar)

end event

type dw_1 from datawindow within w_bar
integer x = 110
integer y = 600
integer width = 1902
integer height = 1088
integer taborder = 10
string title = "none"
string dataobject = "d_40010007"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type hpb_upgrade from hprogressbar within w_bar
integer x = 50
integer y = 52
integer width = 1385
integer height = 44
unsignedinteger maxposition = 100
integer setstep = 1
end type

type st_1 from statictext within w_bar
integer x = 55
integer y = 140
integer width = 1367
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217857
long backcolor = 553648127
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_bar
integer width = 6162
integer height = 2896
boolean originalsize = true
string picturename = ".\res\main_bg.jpg"
boolean focusrectangle = false
end type

