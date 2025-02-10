$PBExportHeader$w_10010001_pop.srw
forward
global type w_10010001_pop from w_ancestor_pop1
end type
end forward

global type w_10010001_pop from w_ancestor_pop1
string title = "기간별 매출 내역"
end type
global w_10010001_pop w_10010001_pop

on w_10010001_pop.create
call super::create
end on

on w_10010001_pop.destroy
call super::destroy
end on

event open;str_popup lstr_popup

lstr_popup = message.powerobjectparm

dw_cdt.object.frdate[1] = lstr_popup.rvalue[1]
dw_cdt.object.todate[1] = lstr_popup.rvalue[2]
dw_cdt.object.name_1[1] = lstr_popup.rvalue[3]

messagebox("lstr_popup.rvalue[3]", lstr_popup.rvalue[3])

event ue_open()
end event

event ue_open;call super::ue_open;String ls_body, ls_result, ls_error, ls_frdate, ls_todate, ls_name
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]
ls_name = dw_cdt.object.name_1[1]

// DataWindow 초기화
dw_1.Reset()

ls_body = 'frdate=' + ls_frdate + '&todate=' + ls_todate + '&codenm=' + ls_name

messagebox("ls_body", ls_body)

ls_result = gf_api_call("http://localhost:3000/api/saleledger", 'GET', ls_body)

//messagebox("ls_result", ls_result)

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

//messagebox("ll_data_array", ll_data_array)

ll_count = lnv_json.getchildcount( ll_data_array )  

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = dw_1.insertrow(0)

	dw_1.object.saledate[ll_row] = lnv_json.getitemstring( ll_child, "saledate")  
	dw_1.object.insert_id[ll_row] = lnv_json.getitemstring( ll_child, "insert_id")  
	dw_1.object.path_name[ll_row] = lnv_json.getitemstring( ll_child, "path_name")  
	dw_1.object.product_code[ll_row] = lnv_json.getitemstring( ll_child, "product_code")  
	dw_1.object.product_name[ll_row] = lnv_json.getitemstring( ll_child, "product_name")  
	dw_1.object.measure[ll_row] = lnv_json.getitemstring( ll_child, "measure")  
	dw_1.object.weight[ll_row] = lnv_json.getitemnumber( ll_child, "weight")  
	dw_1.object.amount_won[ll_row] = lnv_json.getitemnumber( ll_child, "amount_won")  
	dw_1.object.vat[ll_row] = lnv_json.getitemnumber( ll_child, "vat")  
	
next  
		
DESTROY lnv_json

RETURN
end event

type st_id from w_ancestor_pop1`st_id within w_10010001_pop
end type

type dw_1 from w_ancestor_pop1`dw_1 within w_10010001_pop
string dataobject = "d_10010001_pop"
boolean ib_selectrow = true
end type

type dw_cdt from w_ancestor_pop1`dw_cdt within w_10010001_pop
string dataobject = "d_10010001_pop_cdt"
end type

type cb_2 from w_ancestor_pop1`cb_2 within w_10010001_pop
end type

type st_1 from w_ancestor_pop1`st_1 within w_10010001_pop
string text = "□ 기간별 매출 내역"
end type

