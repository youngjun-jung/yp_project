$PBExportHeader$w_30010007.srw
forward
global type w_30010007 from w_ancestor_03
end type
end forward

global type w_30010007 from w_ancestor_03
integer height = 3024
end type
global w_30010007 w_30010007

type variables
Long il_chk_cnt
end variables

on w_30010007.create
call super::create
end on

on w_30010007.destroy
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

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/distributiontable", 'GET', ls_body)

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

 	//dw_1.object.num[ll_row] = ll_row
	dw_1.object.year[ll_row] = ls_year
	dw_1.object.scode[ll_row] = lnv_json.getitemstring( ll_child, "scode")  
	dw_1.object.sname[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	dw_1.object.dtdc001_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc001_per")  
	dw_1.object.dtdc001[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc001")  
	dw_1.object.dtdc002_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc002_per")  
	dw_1.object.dtdc002[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc002")  
	dw_1.object.dtdc003_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc003_per")  
	dw_1.object.dtdc003[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc003")  
	dw_1.object.dtdc004_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc004_per")  
	dw_1.object.dtdc004[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc004") 
	dw_1.object.dtdc005_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc005_per")  
	dw_1.object.dtdc005[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc005")  
	dw_1.object.dtdc006_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc006_per")  
	dw_1.object.dtdc006[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc006") 
	dw_1.object.dtdc007_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc007_per")  
	dw_1.object.dtdc007[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc007")  
	dw_1.object.dtdc008_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc008_per")   
	dw_1.object.dtdc008[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc008") 
	dw_1.object.dtdc009_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc009_per") 
	dw_1.object.dtdc009[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc009") 
	dw_1.object.dtdc010_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc010_per") 
	dw_1.object.dtdc010[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc010") 
	dw_1.object.dtdc011_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc011_per") 
	dw_1.object.dtdc011[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc011") 
	dw_1.object.dtdc012_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc012_per") 
	dw_1.object.dtdc012[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc012") 
	dw_1.object.dtdc013_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc013_per") 
	dw_1.object.dtdc013[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc013") 
	dw_1.object.dtdc014_per[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc014_per") 
	dw_1.object.dtdc014[ll_row] = lnv_json.getitemnumber( ll_child, "dtdc014") 

next  

DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_30010007
string dataobject = "d_30010007"
end type

type sle_id from w_ancestor_03`sle_id within w_30010007
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_30010007
string dataobject = "d_30010007_cdt"
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

type st_1 from w_ancestor_03`st_1 within w_30010007
end type

