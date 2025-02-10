$PBExportHeader$w_10010001.srw
forward
global type w_10010001 from w_ancestor_03
end type
end forward

global type w_10010001 from w_ancestor_03
integer height = 3024
end type
global w_10010001 w_10010001

type variables
Long il_chk_cnt
end variables

on w_10010001.create
call super::create
end on

on w_10010001.destroy
call super::destroy
end on

event open;call super::open;Date ld_today, ld_frdate
ld_today = Today()

ld_frdate = RelativeDate(ld_today, - 30)

dw_cdt.object.frdate[1] = String(ld_frdate, "yyyyMMdd")
dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

dw_cdt.object.frdate[1] = '20240101'
dw_cdt.object.todate[1] = '20241231'
end event

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_frdate, ls_todate
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]

// DataWindow 초기화
dw_1.Reset()

ls_body = 'frdate=' + ls_frdate + '&todate=' + ls_todate

ls_result = gf_api_call("http://localhost:3000/api/sale", 'GET', ls_body)

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

	dw_1.object.frdate[ll_row] = ls_frdate
	dw_1.object.todate[ll_row] = ls_todate
	dw_1.object.sale[ll_row] = lnv_json.getitemstring( ll_child, "sale")  
	dw_1.object.name_1[ll_row] = lnv_json.getitemstring( ll_child, "name_1")  
	dw_1.object.in_1[ll_row] = lnv_json.getitemNumber( ll_child, "in_1")  
	dw_1.object.in_local_1[ll_row] = lnv_json.getitemNumber( ll_child, "in_local_1")  
	dw_1.object.out_1[ll_row] = lnv_json.getitemNumber( ll_child, "out_1")  
	dw_1.object.etc_1[ll_row] = lnv_json.getitemNumber( ll_child, "etc_1")  
	dw_1.object.sum_1[ll_row] = lnv_json.getitemNumber( ll_child, "sum_1")  
	dw_1.object.income[ll_row] = lnv_json.getitemstring( ll_child, "income")  
	dw_1.object.name_2[ll_row] = lnv_json.getitemstring( ll_child, "name_2")  
	dw_1.object.in_2[ll_row] = lnv_json.getitemNumber( ll_child, "in_2")  
	dw_1.object.in_local_2[ll_row] = lnv_json.getitemNumber( ll_child, "in_local_2")  
	dw_1.object.out_2[ll_row] = lnv_json.getitemNumber( ll_child, "out_2")  
	dw_1.object.etc_2[ll_row] = lnv_json.getitemNumber( ll_child, "etc_2")  
	dw_1.object.sum_2[ll_row] = lnv_json.getitemNumber( ll_child, "sum_2")  
	
next  
		
DESTROY lnv_json

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_10010001
string dataobject = "d_10010001"
boolean ib_selectrow = true
end type

event dw_1::doubleclicked;call super::doubleclicked;str_popup lstr_popup

if row < 1 then return

lstr_popup.rvalue[1] = dw_1.object.frdate[row]
lstr_popup.rvalue[2] = dw_1.object.todate[row]
lstr_popup.rvalue[3] = dw_1.object.name_1[row]

openwithparm(w_10010001_pop, lstr_popup)


end event

type sle_id from w_ancestor_03`sle_id within w_10010001
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_10010001
string dataobject = "d_10010001_cdt"
end type

type st_1 from w_ancestor_03`st_1 within w_10010001
end type

