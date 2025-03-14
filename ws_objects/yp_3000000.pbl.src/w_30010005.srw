$PBExportHeader$w_30010005.srw
forward
global type w_30010005 from w_ancestor_03
end type
end forward

global type w_30010005 from w_ancestor_03
integer height = 3024
end type
global w_30010005 w_30010005

type variables
Long il_chk_cnt
end variables

on w_30010005.create
call super::create
end on

on w_30010005.destroy
call super::destroy
end on

event open;call super::open;Date ld_today, ld_date
ld_today = Today()

ld_date = RelativeDate(ld_today, - 30)

dw_cdt.object.toyear[1] = String(ld_date, "yyyy")





end event

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_year
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Long ll_j_sale_in, ll_j_sale_local, ll_j_sale_out, ll_j_sale_etc, ll_j_sale_sum, ll_j_income_in, ll_j_income_local, ll_j_income_out, ll_j_income_etc, ll_j_income_sum
Long ll_sale_in, ll_sale_local, ll_sale_out, ll_sale_etc, ll_sale_sum, ll_income_in, ll_income_local, ll_income_out, ll_income_etc, ll_income_sum
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_year = dw_cdt.object.toyear[1]

// DataWindow 초기화
dw_1.Reset()

ls_body = 'year=' + ls_year

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/selfconsumption", 'GET', ls_body)

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
	
	ll_row = dw_1.insertrow(0)

 	//dw_1.object.num[ll_row] = ll_row //lnv_json.getitemnumber( ll_child, "num")  
	dw_1.object.lname[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	dw_1.object.mname[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	dw_1.object.measure[ll_row] = lnv_json.getitemstring( ll_child, "measure")  
	dw_1.object.month_01[ll_row] = lnv_json.getitemnumber( ll_child, "month_01")  
	dw_1.object.month_02[ll_row] = lnv_json.getitemnumber( ll_child, "month_02")  
	dw_1.object.month_03[ll_row] = lnv_json.getitemnumber( ll_child, "month_03")  
	dw_1.object.month_1[ll_row] = lnv_json.getitemnumber( ll_child, "month_1")  
	dw_1.object.month_04[ll_row] = lnv_json.getitemnumber( ll_child, "month_04")  
	dw_1.object.month_05[ll_row] = lnv_json.getitemnumber( ll_child, "month_05")  
	dw_1.object.month_06[ll_row] = lnv_json.getitemnumber( ll_child, "month_06")  
	dw_1.object.month_2[ll_row] = lnv_json.getitemnumber( ll_child, "month_2") 
	dw_1.object.month_07[ll_row] = lnv_json.getitemnumber( ll_child, "month_07")  
	dw_1.object.month_08[ll_row] = lnv_json.getitemnumber( ll_child, "month_08")  
	dw_1.object.month_09[ll_row] = lnv_json.getitemnumber( ll_child, "month_09")  
	dw_1.object.month_3[ll_row] = lnv_json.getitemnumber( ll_child, "month_3") 
	dw_1.object.month_10[ll_row] = lnv_json.getitemnumber( ll_child, "month_10")  
	dw_1.object.month_11[ll_row] = lnv_json.getitemnumber( ll_child, "month_11")  
	dw_1.object.month_12[ll_row] = lnv_json.getitemnumber( ll_child, "month_12")   
	dw_1.object.month_4[ll_row] = lnv_json.getitemnumber( ll_child, "month_4") 
	dw_1.object.month_0[ll_row] = lnv_json.getitemnumber( ll_child, "month_0") 

next  

DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_30010005
string dataobject = "d_30010005"
end type

event dw_1::doubleclicked;call super::doubleclicked;str_popup lstr_popup

if row < 1 then return

lstr_popup.rvalue[1] = gf_date_format(dw_1.object.frdate[row], '1')
lstr_popup.rvalue[2] = gf_date_format(dw_1.object.todate[row], '1')
lstr_popup.rvalue[3] = dw_1.object.mcode[row]
lstr_popup.rvalue[4] = dw_1.object.name_1[row]

if gf_chk_null(lstr_popup.rvalue[3]) then return

openwithparm(w_10010001_pop, lstr_popup)


end event

type sle_id from w_ancestor_03`sle_id within w_30010005
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_30010005
string dataobject = "d_30010005_cdt"
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

type st_1 from w_ancestor_03`st_1 within w_30010005
end type

