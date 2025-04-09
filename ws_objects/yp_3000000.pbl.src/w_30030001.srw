$PBExportHeader$w_30030001.srw
forward
global type w_30030001 from w_ancestor_08
end type
type dw_3 from u_dw_freeform within tabpage_1
end type
type dw_1 from u_dw_freeform within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_freeform within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
end forward

global type w_30030001 from w_ancestor_08
end type
global w_30030001 w_30030001

type variables
string il_ghk = 'N'
end variables

forward prototypes
public subroutine wf_resize ()
public function boolean wf_retrieve_1 (string as_year)
public function boolean wf_delete_proc (string as_backup_id, string as_gubun)
public function boolean wf_recovery_proc (string as_backup_id, string as_gubun)
public function boolean wf_proc (string as_year)
public function boolean wf_update_proc ()
public function boolean wf_indicator_update (string as_bind)
public function boolean wf_basicdata_proc (string as_bind)
end prototypes

public subroutine wf_resize ();

				
end subroutine

public function boolean wf_retrieve_1 (string as_year);String ls_body, ls_result, ls_error, ls_toyear
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row, ll_zincnt, ll_in, ll_out
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_toyear = dw_cdt.object.toyear[1]

// DataWindow 초기화
tab_1.tabpage_1.dw_1.Reset()
tab_1.tabpage_1.dw_3.Reset()

ls_body = 'year=' + ls_toyear

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/refindicator", 'GET', ls_body)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN false

lnv_json = CREATE JSONParser

ls_error = lnv_json.LoadString(ls_result)

if Len(ls_error) > 0 then
    MessageBox("Error", "JSON 파싱 실패: " + ls_error)
    Destroy lnv_json
    RETURN false
end if

ll_root = lnv_json.getrootitem( )  

if ll_root <= 0 then
    MessageBox("Error", "루트 노드를 가져오지 못했습니다.")
    Destroy lnv_json
    RETURN false
end if

// 'data' 배열 가져오기
ll_data_array = lnv_json.GetItemArray(ll_root, "data")

if ll_data_array < 0 then
    MessageBox("Error", "'data' 배열을 찾을 수 없습니다.")
    Destroy lnv_json
    RETURN false
end if

//messagebox("ll_data_array", ll_data_array)

ll_count = lnv_json.getchildcount( ll_data_array )  

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_zincnt = lnv_json.getitemNumber( ll_child, "zinccnt")
	ll_in =  lnv_json.getitemNumber( ll_child, "zincin")
	ll_out =  lnv_json.getitemNumber( ll_child, "zincout")

	if (lnv_json.getitemString( ll_child, "gubun1")  = 'LME' or lnv_json.getitemString( ll_child, "gubun1")  = 'T/C' or lnv_json.getitemString( ll_child, "gubun1")  = '환율' or lnv_json.getitemString( ll_child, "gubun1")  = '황산' ) &
	   and lnv_json.getitemString( ll_child, "gubun2")  <> 'Cd' and lnv_json.getitemString( ll_child, "gubun2")  <> 'In'   THEN

		ll_row = tab_1.tabpage_1.dw_1.insertrow(0)
		ll_row = tab_1.tabpage_1.dw_3.insertrow(0)
		
		tab_1.tabpage_1.dw_1.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")   
		tab_1.tabpage_1.dw_1.object.xx1[ll_row] = lnv_json.getitemString( ll_child, "gubun1")   
		tab_1.tabpage_1.dw_1.object.xa1[ll_row] = lnv_json.getitemString( ll_child, "gubun2")   
		tab_1.tabpage_1.dw_1.object.xb1[ll_row] = lnv_json.getitemString( ll_child, "measure")   
	
		tab_1.tabpage_1.dw_1.object.xc1[ll_row] = lnv_json.getitemNumber( ll_child, "annual")
		tab_1.tabpage_1.dw_1.object.x1_1[ll_row] = lnv_json.getitemNumber( ll_child, "month_01")
		tab_1.tabpage_1.dw_1.object.x1_2[ll_row] = lnv_json.getitemNumber( ll_child, "month_02")
		tab_1.tabpage_1.dw_1.object.x1_3[ll_row] = lnv_json.getitemNumber( ll_child, "month_03")
		tab_1.tabpage_1.dw_1.object.x1_4[ll_row] = lnv_json.getitemNumber( ll_child, "month_04")
		tab_1.tabpage_1.dw_1.object.x1_5[ll_row] = lnv_json.getitemNumber( ll_child, "month_05")
		tab_1.tabpage_1.dw_1.object.x1_6[ll_row] = lnv_json.getitemNumber( ll_child, "month_06")
		tab_1.tabpage_1.dw_1.object.x1_7[ll_row] = lnv_json.getitemNumber( ll_child, "month_07")
		tab_1.tabpage_1.dw_1.object.x1_8[ll_row] = lnv_json.getitemNumber( ll_child, "month_08")
		tab_1.tabpage_1.dw_1.object.x1_9[ll_row] = lnv_json.getitemNumber( ll_child, "month_09")
		tab_1.tabpage_1.dw_1.object.x1_10[ll_row] = lnv_json.getitemNumber( ll_child, "month_10")
		tab_1.tabpage_1.dw_1.object.x1_11[ll_row] = lnv_json.getitemNumber( ll_child, "month_11")
		tab_1.tabpage_1.dw_1.object.x1_12[ll_row] = lnv_json.getitemNumber( ll_child, "month_12")
		
		tab_1.tabpage_1.dw_1.object.x2_1[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_01")
		tab_1.tabpage_1.dw_1.object.x2_2[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_02")
		tab_1.tabpage_1.dw_1.object.x2_3[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_03")
		tab_1.tabpage_1.dw_1.object.x2_4[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_04")
		tab_1.tabpage_1.dw_1.object.x2_5[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_05")
		tab_1.tabpage_1.dw_1.object.x2_6[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_06")
		tab_1.tabpage_1.dw_1.object.x2_7[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_07")
		tab_1.tabpage_1.dw_1.object.x2_8[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_08")
		tab_1.tabpage_1.dw_1.object.x2_9[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_09")
		tab_1.tabpage_1.dw_1.object.x2_10[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_10")
		tab_1.tabpage_1.dw_1.object.x2_11[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_11")
		tab_1.tabpage_1.dw_1.object.x2_12[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_12")
		
		tab_1.tabpage_1.dw_1.object.x3_1[ll_row] = lnv_json.getitemNumber( ll_child, "day_01")
		tab_1.tabpage_1.dw_1.object.x3_2[ll_row] = lnv_json.getitemNumber( ll_child, "day_02")
		tab_1.tabpage_1.dw_1.object.x3_3[ll_row] = lnv_json.getitemNumber( ll_child, "day_03")
		tab_1.tabpage_1.dw_1.object.x3_4[ll_row] = lnv_json.getitemNumber( ll_child, "day_04")
		tab_1.tabpage_1.dw_1.object.x3_5[ll_row] = lnv_json.getitemNumber( ll_child, "day_05")
		tab_1.tabpage_1.dw_1.object.x3_6[ll_row] = lnv_json.getitemNumber( ll_child, "day_06")
		tab_1.tabpage_1.dw_1.object.x3_7[ll_row] = lnv_json.getitemNumber( ll_child, "day_07")
		tab_1.tabpage_1.dw_1.object.x3_8[ll_row] = lnv_json.getitemNumber( ll_child, "day_08")
		tab_1.tabpage_1.dw_1.object.x3_9[ll_row] = lnv_json.getitemNumber( ll_child, "day_09")
		tab_1.tabpage_1.dw_1.object.x3_10[ll_row] = lnv_json.getitemNumber( ll_child, "day_10")
		tab_1.tabpage_1.dw_1.object.x3_11[ll_row] = lnv_json.getitemNumber( ll_child, "day_11")
		tab_1.tabpage_1.dw_1.object.x3_12[ll_row] = lnv_json.getitemNumber( ll_child, "day_12")
		
		tab_1.tabpage_1.dw_1.object.scode[ll_row] = lnv_json.getitemString( ll_child, "scode")   
		
		tab_1.tabpage_1.dw_3.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")   
		tab_1.tabpage_1.dw_3.object.xx1[ll_row] = lnv_json.getitemString( ll_child, "gubun1")   
		tab_1.tabpage_1.dw_3.object.xa1[ll_row] = lnv_json.getitemString( ll_child, "gubun2")   
		tab_1.tabpage_1.dw_3.object.xb1[ll_row] = lnv_json.getitemString( ll_child, "measure")   
	
		tab_1.tabpage_1.dw_3.object.xc1[ll_row] = lnv_json.getitemNumber( ll_child, "annual")
		tab_1.tabpage_1.dw_3.object.x1_1[ll_row] = lnv_json.getitemNumber( ll_child, "month_01")
		tab_1.tabpage_1.dw_3.object.x1_2[ll_row] = lnv_json.getitemNumber( ll_child, "month_02")
		tab_1.tabpage_1.dw_3.object.x1_3[ll_row] = lnv_json.getitemNumber( ll_child, "month_03")
		tab_1.tabpage_1.dw_3.object.x1_4[ll_row] = lnv_json.getitemNumber( ll_child, "month_04")
		tab_1.tabpage_1.dw_3.object.x1_5[ll_row] = lnv_json.getitemNumber( ll_child, "month_05")
		tab_1.tabpage_1.dw_3.object.x1_6[ll_row] = lnv_json.getitemNumber( ll_child, "month_06")
		tab_1.tabpage_1.dw_3.object.x1_7[ll_row] = lnv_json.getitemNumber( ll_child, "month_07")
		tab_1.tabpage_1.dw_3.object.x1_8[ll_row] = lnv_json.getitemNumber( ll_child, "month_08")
		tab_1.tabpage_1.dw_3.object.x1_9[ll_row] = lnv_json.getitemNumber( ll_child, "month_09")
		tab_1.tabpage_1.dw_3.object.x1_10[ll_row] = lnv_json.getitemNumber( ll_child, "month_10")
		tab_1.tabpage_1.dw_3.object.x1_11[ll_row] = lnv_json.getitemNumber( ll_child, "month_11")
		tab_1.tabpage_1.dw_3.object.x1_12[ll_row] = lnv_json.getitemNumber( ll_child, "month_12")
		
		tab_1.tabpage_1.dw_3.object.x2_1[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_01")
		tab_1.tabpage_1.dw_3.object.x2_2[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_02")
		tab_1.tabpage_1.dw_3.object.x2_3[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_03")
		tab_1.tabpage_1.dw_3.object.x2_4[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_04")
		tab_1.tabpage_1.dw_3.object.x2_5[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_05")
		tab_1.tabpage_1.dw_3.object.x2_6[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_06")
		tab_1.tabpage_1.dw_3.object.x2_7[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_07")
		tab_1.tabpage_1.dw_3.object.x2_8[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_08")
		tab_1.tabpage_1.dw_3.object.x2_9[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_09")
		tab_1.tabpage_1.dw_3.object.x2_10[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_10")
		tab_1.tabpage_1.dw_3.object.x2_11[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_11")
		tab_1.tabpage_1.dw_3.object.x2_12[ll_row] = lnv_json.getitemNumber( ll_child, "zinccnt_12")
		
		tab_1.tabpage_1.dw_3.object.x3_1[ll_row] = lnv_json.getitemNumber( ll_child, "day_01")
		tab_1.tabpage_1.dw_3.object.x3_2[ll_row] = lnv_json.getitemNumber( ll_child, "day_02")
		tab_1.tabpage_1.dw_3.object.x3_3[ll_row] = lnv_json.getitemNumber( ll_child, "day_03")
		tab_1.tabpage_1.dw_3.object.x3_4[ll_row] = lnv_json.getitemNumber( ll_child, "day_04")
		tab_1.tabpage_1.dw_3.object.x3_5[ll_row] = lnv_json.getitemNumber( ll_child, "day_05")
		tab_1.tabpage_1.dw_3.object.x3_6[ll_row] = lnv_json.getitemNumber( ll_child, "day_06")
		tab_1.tabpage_1.dw_3.object.x3_7[ll_row] = lnv_json.getitemNumber( ll_child, "day_07")
		tab_1.tabpage_1.dw_3.object.x3_8[ll_row] = lnv_json.getitemNumber( ll_child, "day_08")
		tab_1.tabpage_1.dw_3.object.x3_9[ll_row] = lnv_json.getitemNumber( ll_child, "day_09")
		tab_1.tabpage_1.dw_3.object.x3_10[ll_row] = lnv_json.getitemNumber( ll_child, "day_10")
		tab_1.tabpage_1.dw_3.object.x3_11[ll_row] = lnv_json.getitemNumber( ll_child, "day_11")
		tab_1.tabpage_1.dw_3.object.x3_12[ll_row] = lnv_json.getitemNumber( ll_child, "day_12")
		
		tab_1.tabpage_1.dw_3.object.scode[ll_row] = lnv_json.getitemString( ll_child, "scode")   
		
	END IF

next  

tab_1.tabpage_1.dw_1.object.zinccnt[1] = ll_zincnt
tab_1.tabpage_1.dw_3.object.zinccnt[1] = ll_zincnt

tab_1.tabpage_1.dw_1.object.in[1] = ll_in
tab_1.tabpage_1.dw_3.object.in[1] = ll_in

tab_1.tabpage_1.dw_1.object.out[1] = ll_out
tab_1.tabpage_1.dw_3.object.out[1] = ll_out
		
DESTROY lnv_json

tab_1.tabpage_1.dw_1.setfocus()
tab_1.tabpage_1.dw_1.setredraw(true)

RETURN true
end function

public function boolean wf_delete_proc (string as_backup_id, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

ls_body = '{"backup_id": "' + as_backup_id + '", "deleteid": "' + gstr_userenv.user_id  + '", "gubun": "' + as_gubun + '"}'  

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/backupdelete", 'POST', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_recovery_proc (string as_backup_id, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

ls_body = '{"backup_id": "' + as_backup_id + '", "recoveryid": "' + gstr_userenv.user_id  + '", "gubun": "' + as_gubun + '"}'  

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/backuprec", 'POST', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_proc (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

ls_body = '{"year": "' + as_year   + '", "procid": "' + gstr_userenv.user_id  + '"}'  

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/proc", 'POST', ls_body)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_update_proc ();String ls_scode, ls_year, ls_body
Long ll_zinccnt, ll_in, ll_out
Long ll_annual, ll_month_01, ll_month_02, ll_month_03, ll_month_04, ll_month_05, ll_month_06, ll_month_07, ll_month_08, ll_month_09, ll_month_10, ll_month_11, ll_month_12
Int i, li_chk 

tab_1.tabpage_1.dw_1.accepttext()

ls_year =  tab_1.tabpage_1.dw_1.object.year[1]

li_chk = 0

if tab_1.tabpage_1.dw_1.object.zinccnt[1] <> tab_1.tabpage_1.dw_3.object.zinccnt[1] then
	li_chk = li_chk + 1
end if

if tab_1.tabpage_1.dw_1.object.in[1] <> tab_1.tabpage_1.dw_3.object.in[1] then
	li_chk = li_chk + 1	
end if

if tab_1.tabpage_1.dw_1.object.out[1] <> tab_1.tabpage_1.dw_3.object.out[1] then
	li_chk = li_chk + 1	
end if

if li_chk > 0 then	
	ll_zinccnt = tab_1.tabpage_1.dw_1.object.zinccnt[1]
	ll_in = tab_1.tabpage_1.dw_1.object.in[1]
	ll_out = tab_1.tabpage_1.dw_1.object.out[1]	
	ls_body = '{"year": "' + ls_year + '", "zinccnt": "' + string(ll_zinccnt)  + '", "zincin": "' + string(ll_in)   + '", "zincout": "' + string(ll_out)  + '"}'  
	
	wf_basicdata_proc(ls_body)
end if

for i = 1 to tab_1.tabpage_1.dw_1.rowcount()
	
	li_chk = 0
	
	ls_scode = tab_1.tabpage_1.dw_1.object.scode[i]

	if tab_1.tabpage_1.dw_1.object.xc1[i] <> tab_1.tabpage_1.dw_3.object.xc1[i] then
		li_chk = li_chk + 1
	end if	
	if tab_1.tabpage_1.dw_1.object.x1_1[i] <> tab_1.tabpage_1.dw_3.object.x1_1[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_2[i] <> tab_1.tabpage_1.dw_3.object.x1_2[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_3[i] <> tab_1.tabpage_1.dw_3.object.x1_3[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_4[i] <> tab_1.tabpage_1.dw_3.object.x1_4[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_5[i] <> tab_1.tabpage_1.dw_3.object.x1_5[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_6[i] <> tab_1.tabpage_1.dw_3.object.x1_6[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_7[i] <> tab_1.tabpage_1.dw_3.object.x1_7[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_8[i] <> tab_1.tabpage_1.dw_3.object.x1_8[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_9[i] <> tab_1.tabpage_1.dw_3.object.x1_9[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_10[i] <> tab_1.tabpage_1.dw_3.object.x1_10[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_11[i] <> tab_1.tabpage_1.dw_3.object.x1_11[i] then
		li_chk = li_chk + 1
	end if
	if tab_1.tabpage_1.dw_1.object.x1_12[i] <> tab_1.tabpage_1.dw_3.object.x1_12[i] then
		li_chk = li_chk + 1
	end if
	
	if li_chk > 0 then			
		ll_annual = tab_1.tabpage_1.dw_1.object.xc1[i]
		ll_month_01 = tab_1.tabpage_1.dw_1.object.x1_1[i]
		ll_month_02 = tab_1.tabpage_1.dw_1.object.x1_2[i]
		ll_month_03 = tab_1.tabpage_1.dw_1.object.x1_3[i]
		ll_month_04 = tab_1.tabpage_1.dw_1.object.x1_4[i]
		ll_month_05 = tab_1.tabpage_1.dw_1.object.x1_5[i]
		ll_month_06 = tab_1.tabpage_1.dw_1.object.x1_6[i]
		ll_month_07 = tab_1.tabpage_1.dw_1.object.x1_7[i]
		ll_month_08 = tab_1.tabpage_1.dw_1.object.x1_8[i]
		ll_month_09 = tab_1.tabpage_1.dw_1.object.x1_9[i]
		ll_month_10 = tab_1.tabpage_1.dw_1.object.x1_10[i]
		ll_month_11 = tab_1.tabpage_1.dw_1.object.x1_11[i]
		ll_month_12 = tab_1.tabpage_1.dw_1.object.x1_12[i]
		ls_body = '{"year": "' + ls_year + '", "scode": "' + ls_scode  + '", "annual": "' + string(ll_annual)   + '", "month_01": "' + string(ll_month_01) 
		ls_body = ls_body + '", "month_02": "' + string(ll_month_02) + '", "month_03": "' + string(ll_month_03) + '", "month_04": "' + string(ll_month_04) + '", "month_05": "' + string(ll_month_05) 
		ls_body = ls_body + '", "month_06": "' + string(ll_month_06) + '", "month_07": "' + string(ll_month_07) + '", "month_08": "' + string(ll_month_08) + '", "month_09": "' + string(ll_month_09) 
		ls_body = ls_body + '", "month_10": "' + string(ll_month_10) + '", "month_11": "' + string(ll_month_11) + '", "month_12": "' + string(ll_month_12) 
		ls_body = ls_body + '"}'  
		
		wf_indicator_update(ls_body)
		
	end if
	
next

return true
end function

public function boolean wf_indicator_update (string as_bind);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

ls_body = as_bind

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/refindicator", 'PATCH', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_basicdata_proc (string as_bind);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

ls_body = as_bind

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/basicdata", 'PATCH', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

on w_30030001.create
int iCurrent
call super::create
end on

on w_30030001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

//wf_resize()

sle_id.x = tab_1.x
sle_id.y = tab_1.y + tab_1.height + 60

dw_cdt.Width = 	w_mainmdi.mdi_1.Width - 400

tab_1.x = dw_cdt.x
tab_1.y = dw_cdt.y + dw_cdt.Height + 100
tab_1.Width = 	w_mainmdi.mdi_1.Width - 400			
tab_1.Height = w_mainmdi.mdi_1.Height - 1200

tab_1.tabpage_1.dw_1.Width = tab_1.Width - 60
tab_1.tabpage_1.dw_1.Height = tab_1.Height -150
tab_1.tabpage_2.dw_2.Width = tab_1.Width - 60
tab_1.tabpage_2.dw_2.Height = tab_1.Height -150


end event

event open;call super::open;Date ld_toyear
ld_toyear = Today()

dw_cdt.object.toyear[1] = String(ld_toyear, "yyyy")

end event

event ue_retrieve;call super::ue_retrieve;Long   ll_gettab
String ls_year

ls_year = dw_cdt.object.toyear[1]

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year)	
		
		il_ghk = 'Y'
		
END CHOOSE

RETURN TRUE
end event

type sle_id from w_ancestor_08`sle_id within w_30030001
end type

type tab_1 from w_ancestor_08`tab_1 within w_30030001
string tag = "d_30020002_1"
integer x = 224
integer weight = 400
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "손익추정 계산"
string picturename = ".\res\Circle1.gif"
dw_3 dw_3
dw_1 dw_1
end type

on tabpage_1.create
this.dw_3=create dw_3
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_1)
end on

type dw_cdt from w_ancestor_08`dw_cdt within w_30030001
string dataobject = "d_30030001_cdt"
end type

event dw_cdt::ue_dddw_retrieve;call super::ue_dddw_retrieve;Long i

CHOOSE CASE column
		
	CASE 'toyear'		

		FOR i = 1 TO 99
			dddw.InsertRow(i)
			dddw.SetItem(i, 1, String(2019 + i))
		NEXT
				
END CHOOSE
end event

type st_1 from w_ancestor_08`st_1 within w_30030001
end type

type dw_3 from u_dw_freeform within tabpage_1
boolean visible = false
integer y = 1236
integer width = 681
integer height = 632
integer taborder = 30
string dataobject = "d_30030001_1_1"
end type

type dw_1 from u_dw_freeform within tabpage_1
integer width = 5531
integer height = 1876
integer taborder = 10
string dataobject = "d_30030001_1_1"
end type

event constructor;call super::constructor;insertrow(1)
end event

event clicked;call super::clicked;str_popup lstr_popup
string ls_return, ls_backup_id, ls_basic, ls_basic_nm, ls_year, ls_gubun
boolean lb_return
integer li_response
long	ll_zinccnt, ll_zinccnt_01, ll_zinccnt_02, ll_zinccnt_03, ll_zinccnt_04, ll_zinccnt_05, ll_zinccnt_06, ll_zinccnt_07, ll_zinccnt_08, ll_zinccnt_09, ll_zinccnt_10, ll_zinccnt_11, ll_zinccnt_12, ll_zinccnt_tot
long	ll_day_01, ll_day_02, ll_day_03, ll_day_04, ll_day_05, ll_day_06, ll_day_07, ll_day_08, ll_day_09, ll_day_10, ll_day_11, ll_day_12, ll_day_tot

ls_year = dw_1.object.year[1]

IF dwo.name = 'b_proc' THEN

	if gf_chk_null(ls_year) then return

	li_response = MessageBox("확인", "[" + ls_year + "]년도 기존 자료를 백업 처리 하시겠습니까?", Question!, YesNo!)
	
	IF li_response = 1 THEN
	
		lstr_popup.rvalue[1] = ls_year
		openwithparm(w_30030001_pop, lstr_popup)
		
		ls_return = Message.StringParm
		
		if ls_return <> '0000' then
			messagebox("취소", "자료 백업이 취소되었습니다.[재처리해주세요]")
			return
		end if
		
	END IF
	
	li_response = MessageBox("확인", "[" + ls_year + "]년도 시뮬레이션 처리 하시겠습니까?", Question!, YesNo!)
	
	IF li_response = 1 THEN
		
		// 로딩 페이지 노출
		gnv_loading.PostEvent("ue_show_loading")
		
		lb_return = wf_update_proc()
		
		if lb_return <> true then
			gnv_loading.PostEvent("ue_hide_loading")
			messagebox("오류", "기준지표 저장중 오류 발생.")
			return
		end if

		lb_return = wf_proc(ls_year)
		
		// 로딩 페이지 숨김
		gnv_loading.PostEvent("ue_hide_loading")
		
		if lb_return = true then
			messagebox("성공", "시물레이션 처리가 완료되었습니다.")
			event ue_retrieve()
		else
			messagebox("취소", "시물레이션 처리에 실패하였습니다.")
		end if

	END IF

ELSEIF dwo.name = 'b_zinc' THEN
	
	if il_ghk = 'N' then
		return
	end if

	lstr_popup.lvalue[1] = dw_1.object.zinccnt[1]
	
	openwithparm(w_30030001_1_pop, lstr_popup)
		
	ls_return = Message.StringParm
	
	if gf_chk_null(ls_return) then return

	if dw_1.object.zinccnt[1] <> Long(ls_return) then
	
		ll_day_01 =  dw_1.object.x3_1[1]
		ll_day_02 =  dw_1.object.x3_2[1]
		ll_day_03 =  dw_1.object.x3_3[1]
		ll_day_04 =  dw_1.object.x3_4[1]
		ll_day_05 =  dw_1.object.x3_5[1]
		ll_day_06 =  dw_1.object.x3_6[1]
		ll_day_07 =  dw_1.object.x3_7[1]
		ll_day_08 =  dw_1.object.x3_8[1]
		ll_day_09 =  dw_1.object.x3_9[1]
		ll_day_10 =  dw_1.object.x3_10[1]
		ll_day_11 =  dw_1.object.x3_11[1]
		ll_day_12 =  dw_1.object.x3_12[1]
		
		ll_day_tot = ll_day_01 + ll_day_02 + ll_day_03 + ll_day_04 + ll_day_05 + ll_day_06 + ll_day_07 + ll_day_08 + ll_day_09 + ll_day_10 + ll_day_11 + ll_day_12
		ll_zinccnt = Long(ls_return) / ll_day_tot
		
		dw_1.object.x2_1[1] = ll_day_01 * ll_zinccnt
		dw_1.object.x2_2[1] = ll_day_02 * ll_zinccnt
		dw_1.object.x2_3[1] = ll_day_03 * ll_zinccnt
		dw_1.object.x2_4[1] = ll_day_04 * ll_zinccnt
		dw_1.object.x2_5[1] = ll_day_05 * ll_zinccnt
		dw_1.object.x2_6[1] = ll_day_06 * ll_zinccnt
		dw_1.object.x2_7[1] = ll_day_07 * ll_zinccnt
		dw_1.object.x2_8[1] = ll_day_08 * ll_zinccnt
		dw_1.object.x2_9[1] = ll_day_09 * ll_zinccnt
		dw_1.object.x2_10[1] = ll_day_10 * ll_zinccnt
		dw_1.object.x2_11[1] = ll_day_11 * ll_zinccnt
		dw_1.object.x2_12[1] = ll_day_12 * ll_zinccnt
		
	end if
	
	dw_1.object.zinccnt[1] = Long(ls_return)

ELSEIF dwo.name = 'b_inout' THEN
	
	if il_ghk = 'N' then
		return
	end if
	
	lstr_popup.lvalue[1] = dw_1.object.in[1]
	lstr_popup.lvalue[2] = dw_1.object.out[1]
	
	openwithparm(w_30030001_2_pop, lstr_popup)
		
	lstr_popup = message.powerobjectparm
	
	if lstr_popup.rvalue[1] <> '0000' then return

	dw_1.object.in[1] = lstr_popup.lvalue[1]
	dw_1.object.out[1] = lstr_popup.lvalue[2]
	
END IF
end event

event itemfocuschanged;return
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "백업자료 관리"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle2.gif"
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_freeform within tabpage_2
integer width = 5541
integer height = 1864
integer taborder = 20
string dataobject = "d_30030001_2"
end type

event constructor;call super::constructor;insertrow(1)
end event

event clicked;call super::clicked;str_popup lstr_popup
string ls_return, ls_backup_id, ls_basic, ls_basic_nm, ls_year, ls_gubun
boolean lb_return
integer li_response

IF dwo.name = 'b_proc' THEN
	
	lstr_popup.rvalue[1] = dw_cdt.object.toyear[1]
	openwithparm(w_30030001_pop, lstr_popup)
	
	ls_return = Message.StringParm
	
	if ls_return = '0000' then
		messagebox("성공", "자료 백업이 완료되었습니다.")
	else
		messagebox("취소", "자료 백업이 취소되었습니다.")
	end if
	
ELSEIF dwo.name = 'b_del' THEN
	
	 ls_backup_id = dw_2.object.backupid[1]
	 ls_gubun = '1';
	
	if gf_chk_null(ls_backup_id) or gf_chk_null(ls_gubun) then return

	li_response = MessageBox("확인", "[" + ls_backup_id + "] 백업자료를 삭제하시겠습니까?", Question!, YesNo!)
	
	IF li_response = 1 THEN

		lb_return = wf_delete_proc(ls_backup_id, ls_gubun)
		
		if lb_return = true then
			messagebox("성공", "백업 자료 삭제가 완료되었습니다.")
		else
			messagebox("취소", "백업 자료 삭제에 실패하였습니다.")
		end if

	END IF
	
ELSEIF dwo.name = 'b_init' THEN
	
	ls_basic = dw_2.object.basic[1]
	ls_year = dw_cdt.object.toyear[1]
	
	if gf_chk_null(ls_basic) or gf_chk_null(ls_year) then return
	
	if ls_basic = 'y' then
		ls_basic_nm = '[' + ls_year + '년도 기초자료 포함]'
		ls_gubun = '0'
	else 
		ls_basic_nm = '[' + ls_year + '년도 기초자료 미포함]'
		ls_gubun = '1'
	end if

	li_response = MessageBox("확인", ls_basic_nm + " 저장된 자료를 삭제하시겠습니까?", Question!, YesNo!)
	
	IF li_response = 1 THEN
		
		lb_return = wf_recovery_proc('XXX' + ls_year + 'XXXX', ls_gubun)

		if lb_return = true then
			messagebox("성공", "저장 자료 삭제가 완료되었습니다.")
		else
			messagebox("취소", "저장 자료 삭제에 실패하였습니다.")
		end if

	END IF	
	
ELSEIF dwo.name = 'b_rec' THEN
	
	 ls_backup_id = dw_2.object.backupid[1]
	 ls_gubun = '8'
	
	if gf_chk_null(ls_backup_id) then return

	li_response = MessageBox("확인", "[" + ls_backup_id + "] 저장 자료 삭제 후 백업 자료를 복구하시겠습니까?", Question!, YesNo!)
	
	IF li_response = 1 THEN
		
		lb_return = wf_recovery_proc(ls_backup_id, ls_gubun)

		if lb_return = true then
			messagebox("성공", "백업 자료 복구가 완료되었습니다.")
		else
			messagebox("취소", "백업 자료 복구에 실패하였습니다.")
		end if

	END IF	

END IF
end event

event ue_dddw_retrieve;call super::ue_dddw_retrieve;String ls_body, ls_result, ls_error, ls_year
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row, i
Decimal ll_benchmark, ll_spot, ll_yp_tc
Boolean lb_result
JSONParser lnv_json

CHOOSE CASE column
		
	CASE 'comments'		
		
		dw_cdt.accepttext()
		
		ls_year = dw_cdt.object.toyear[1]

		ls_body = 'year=' + ls_year
		
		ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/backuplist", 'GET', ls_body)
		
		IF ls_result = 'FAIL' THEN
			RETURN
		END IF;
		
		lb_result = gf_api_call_chk(ls_result, '0')
		
		IF NOT(lb_result) THEN	RETURN
		
		lnv_json = CREATE JSONParser
		
		ls_error = lnv_json.LoadString(ls_result)
		
		if Len(ls_error) > 0 then
			 MessageBox("Error", "JSON 파싱 실패: " + ls_error)
			 Destroy lnv_json
			 RETURN
		end if
		
		ll_root = lnv_json.getrootitem( )  
		
		if ll_root <= 0 then
			 MessageBox("Error", "루트 노드를 가져오지 못했습니다.")
			 Destroy lnv_json
			 RETURN
		end if
		
		// 'data' 배열 가져오기
		ll_data_array = lnv_json.GetItemArray(ll_root, "data")
		
		if ll_data_array < 0 then
			 MessageBox("Error", "'data' 배열을 찾을 수 없습니다.")
			 Destroy lnv_json
			 RETURN
		end if

		ll_count = lnv_json.getchildcount( ll_data_array )  

		for ll_index = 1 to ll_count

			ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
			dddw.InsertRow(ll_index)
			dddw.SetItem(ll_index, 1, lnv_json.getitemString( ll_child, "backup_id"))
			dddw.SetItem(ll_index, 2, lnv_json.getitemString( ll_child, "comments"))
		
		next  
				
		DESTROY lnv_json

END CHOOSE
end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle3.gif"
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle4.gif"
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle5.gif"
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle6.gif"
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle7.gif"
long picturemaskcolor = 536870912
end type

type tabpage_8 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle8.gif"
long picturemaskcolor = 536870912
end type

type tabpage_9 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle9.gif"
long picturemaskcolor = 536870912
end type

