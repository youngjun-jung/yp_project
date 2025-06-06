﻿$PBExportHeader$w_30010002.srw
forward
global type w_30010002 from w_ancestor_03
end type
end forward

global type w_30010002 from w_ancestor_03
integer height = 3024
end type
global w_30010002 w_30010002

type variables
Long il_chk_cnt
end variables

on w_30010002.create
call super::create
end on

on w_30010002.destroy
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

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/ref1", 'GET', ls_body)

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

 	dw_1.object.num[ll_row] = ll_row //lnv_json.getitemnumber( ll_child, "num")  
	dw_1.object.xa[ll_row] = lnv_json.getitemstring( ll_child, "xa")  
	dw_1.object.xb[ll_row] = lnv_json.getitemstring( ll_child, "xb")  
	dw_1.object.xc[ll_row] = lnv_json.getitemstring( ll_child, "xc")  
	dw_1.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	dw_1.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	dw_1.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	dw_1.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	dw_1.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	dw_1.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	dw_1.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	dw_1.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	dw_1.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	dw_1.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	dw_1.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	dw_1.object.xo[ll_row] = lnv_json.getitemnumber( ll_child, "xo")  
	dw_1.object.xp[ll_row] = lnv_json.getitemnumber( ll_child, "xp")  
	dw_1.object.xq[ll_row] = lnv_json.getitemnumber( ll_child, "xq")  
	dw_1.object.xr[ll_row] = lnv_json.getitemnumber( ll_child, "xr")  
	dw_1.object.xs[ll_row] = lnv_json.getitemnumber( ll_child, "xs")    

next  

DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_30010002
string dataobject = "d_30010002"
end type

type sle_id from w_ancestor_03`sle_id within w_30010002
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_30010002
string dataobject = "d_30010002_cdt"
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

type st_1 from w_ancestor_03`st_1 within w_30010002
end type

