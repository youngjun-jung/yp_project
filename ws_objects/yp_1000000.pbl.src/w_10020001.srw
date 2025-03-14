$PBExportHeader$w_10020001.srw
forward
global type w_10020001 from w_ancestor_05
end type
end forward

global type w_10020001 from w_ancestor_05
end type
global w_10020001 w_10020001

on w_10020001.create
call super::create
end on

on w_10020001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event open;call super::open;Date ld_today, ld_frdate
ld_today = Today()

ld_frdate = RelativeDate(ld_today, - 30)

dw_cdt.object.frdate[1] = String(ld_frdate, "yyyyMMdd")
dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

dw_cdt.object.frdate[1] = '20220101'
dw_cdt.object.todate[1] = '20220101'

end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_frdate, ls_todate
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
String ls_class_code, ls_codenm, ls_lcode, ls_lcodenm, ls_mcode, ls_mcodenm, ls_scode, ls_mat_code, ls_sname, ls_measure, ls_displayValue, ls_b_mcode
Decimal ld_weight, ld_unit_cost, ld_amount_tot, ld_amount_direct, ld_amount_indirect
Decimal ld_amount_tot_sum, ld_amount_direct_sum, ld_amount_indirect_sum
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]
ls_class_code = dw_cdt.object.target[1]
ls_displayValue = dw_cdt.Describe("evaluate('Lookupdisplay(target)', " + string(1) + ")")

// DataWindow 초기화
dw_1.Reset()

ls_body = 'frdate=' + mid(ls_frdate, 1, 6) + '&todate=' + mid(ls_todate, 1, 6) + '&class_code=' + ls_class_code

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/cogm", 'GET', ls_body)

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

ld_amount_tot_sum = 0
ld_amount_direct_sum = 0
ld_amount_indirect_sum = 0
ls_b_mcode = 'FIRST'

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  

	ls_class_code = lnv_json.getitemString( ll_child, "class_code")  
	ls_codenm = lnv_json.getitemString( ll_child, "codenm")  
	ls_lcode = lnv_json.getitemString( ll_child, "lcode")  
	ls_lcodenm = lnv_json.getitemString( ll_child, "lcodenm")  
	ls_mcode = lnv_json.getitemString( ll_child, "mcode")  
	ls_mcodenm = lnv_json.getitemString( ll_child, "mcodenm")  
	ls_scode = lnv_json.getitemString( ll_child, "scode")  
	ls_mat_code = lnv_json.getitemString( ll_child, "mat_code")  
	ls_sname = lnv_json.getitemString( ll_child, "sname")  
	ls_measure = lnv_json.getitemString( ll_child, "measure")  
	ld_weight = lnv_json.getitemNumber( ll_child, "weight") 
	ld_unit_cost = lnv_json.getitemNumber( ll_child, "unit_cost") 
	ld_amount_tot = lnv_json.getitemNumber( ll_child, "amount_tot") 
	ld_amount_direct = lnv_json.getitemNumber( ll_child, "amount_direct") 
	ld_amount_indirect = lnv_json.getitemNumber( ll_child, "amount_indirect") 
	
	if (ls_mcode <> ls_b_mcode AND ls_b_mcode <> 'FIRST')  then
		
		ll_row = dw_1.insertrow(0)
		
		dw_1.object.scodenm[ll_row] = '소계'
		
		dw_1.object.nu_amt[ll_row] = ld_amount_tot_sum
		dw_1.object.nu_direct_amt[ll_row] = ld_amount_direct_sum
		dw_1.object.nu_indirect_amt[ll_row] = ld_amount_indirect_sum
		
		ld_amount_tot_sum = 0
		ld_amount_direct_sum = 0
		ld_amount_indirect_sum = 0
		
	end if
	
	ls_b_mcode = ls_mcode

	ll_row = dw_1.insertrow(0)
	
	dw_1.object.frdate[ll_row] = mid(ls_frdate, 1, 4) + '.' + mid(ls_frdate, 5, 2)
	dw_1.object.todate[ll_row] = mid(ls_todate, 1, 4) + '.' + mid(ls_todate, 5, 2)
	
	dw_1.object.lcode[ll_row] = ls_lcode
	dw_1.object.lcodenm[ll_row] = ls_lcodenm
	dw_1.object.mcode[ll_row] = ls_mcode
	dw_1.object.mcodenm[ll_row] = ls_mcodenm
	dw_1.object.scode[ll_row] = ls_scode
	dw_1.object.scodenm[ll_row] = ls_sname
	dw_1.object.mat_code[ll_row] = ls_mat_code
	dw_1.object.measure[ll_row] = ls_measure
	dw_1.object.nu_cnt[ll_row] = ld_weight
	dw_1.object.nu_unit[ll_row] = ld_unit_cost
	dw_1.object.nu_amt[ll_row] = ld_amount_tot
	dw_1.object.nu_direct_amt[ll_row] = ld_amount_direct
	dw_1.object.nu_indirect_amt[ll_row] = ld_amount_indirect
	
	ld_amount_tot_sum = ld_amount_tot_sum + ld_amount_tot
	ld_amount_direct_sum = ld_amount_direct_sum + ld_amount_direct
	ld_amount_indirect_sum = ld_amount_indirect_sum + ld_amount_indirect

next  

IF ll_count > 0 THEN
	
	ll_row = dw_1.insertrow(0)
			
	dw_1.object.scodenm[ll_row] = '소계'
			
	dw_1.object.nu_amt[ll_row] = ld_amount_tot_sum
	dw_1.object.nu_direct_amt[ll_row] = ld_amount_direct_sum
	dw_1.object.nu_indirect_amt[ll_row] = ld_amount_indirect_sum
			
	ld_amount_tot_sum = 0
	ld_amount_direct_sum = 0
	ld_amount_indirect_sum = 0
	
END IF
		
DESTROY lnv_json

dw_cdt.object.n_target_code[1] = ls_class_code
dw_cdt.object.n_target[1] = ls_displayValue

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_05`dw_1 within w_10020001
integer y = 756
integer height = 1640
string dataobject = "d_10020001"
end type

type sle_id from w_ancestor_05`sle_id within w_10020001
end type

type dw_cdt from w_ancestor_05`dw_cdt within w_10020001
integer height = 420
string dataobject = "d_10020001_cdt"
end type

type st_1 from w_ancestor_05`st_1 within w_10020001
end type

