$PBExportHeader$w_20010003.srw
forward
global type w_20010003 from w_ancestor_03
end type
end forward

global type w_20010003 from w_ancestor_03
end type
global w_20010003 w_20010003

on w_20010003.create
call super::create
end on

on w_20010003.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event open;call super::open;Date ld_today
ld_today = Today()

ld_today = RelativeDate(ld_today, -1)

dw_cdt.object.frdate[1] = String(ld_today, "yyyyMMdd")
dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

dw_cdt.object.frdate[1] = '20250102'
dw_cdt.object.todate[1] = '20250102'

end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_year
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Decimal ll_benchmark, ll_spot, ll_yp_tc
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

// DataWindow 초기화
dw_1.Reset()

ls_body = ''

ls_result = gf_api_call("http://localhost:3000/api/tc", 'GET', ls_body)

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
	
	ls_year = lnv_json.getitemString( ll_child, "year")   
	ll_benchmark = lnv_json.getitemNumber( ll_child, "benchmark")
	ll_spot = lnv_json.getitemNumber( ll_child, "spot")
	ll_yp_tc = lnv_json.getitemNumber( ll_child, "yp_tc")
	
	ll_row = dw_1.insertrow(0)
	
	dw_1.object.year[ll_row] = ls_year
	dw_1.object.benchmark[ll_row] = ll_benchmark
	dw_1.object.spot[ll_row] = ll_spot
	dw_1.object.yp_tc[ll_row] = ll_yp_tc

next  
		
DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_20010003
string dataobject = "d_20010003"
end type

event dw_1::doubleclicked;call super::doubleclicked;EVENT ue_save()
end event

type sle_id from w_ancestor_03`sle_id within w_20010003
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_20010003
string dataobject = "d_20010003_cdt"
boolean righttoleft = true
end type

type st_1 from w_ancestor_03`st_1 within w_20010003
end type

