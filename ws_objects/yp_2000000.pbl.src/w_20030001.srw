$PBExportHeader$w_20030001.srw
forward
global type w_20030001 from w_ancestor_03
end type
end forward

global type w_20030001 from w_ancestor_03
end type
global w_20030001 w_20030001

on w_20030001.create
call super::create
end on

on w_20030001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event open;call super::open;Date ld_toyear
ld_toyear = Today()

dw_cdt.object.toyear[1] = String(ld_toyear, "yyyy")

end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_toyear
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_toyear = dw_cdt.object.toyear[1]

// DataWindow 초기화
dw_1.Reset()

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

	ll_row = dw_1.insertrow(0)
	
	dw_1.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")   
	dw_1.object.gubun1[ll_row] = lnv_json.getitemString( ll_child, "gubun1")   
	dw_1.object.gubun2[ll_row] = lnv_json.getitemString( ll_child, "gubun2")   
	dw_1.object.measure[ll_row] = lnv_json.getitemString( ll_child, "measure")   

	dw_1.object.annual[ll_row] = lnv_json.getitemNumber( ll_child, "annual")
	dw_1.object.month_1[ll_row] = lnv_json.getitemNumber( ll_child, "month_01")
	dw_1.object.month_2[ll_row] = lnv_json.getitemNumber( ll_child, "month_02")
	dw_1.object.month_3[ll_row] = lnv_json.getitemNumber( ll_child, "month_03")
	dw_1.object.month_4[ll_row] = lnv_json.getitemNumber( ll_child, "month_04")
	dw_1.object.month_5[ll_row] = lnv_json.getitemNumber( ll_child, "month_05")
	dw_1.object.month_6[ll_row] = lnv_json.getitemNumber( ll_child, "month_06")
	dw_1.object.month_7[ll_row] = lnv_json.getitemNumber( ll_child, "month_07")
	dw_1.object.month_8[ll_row] = lnv_json.getitemNumber( ll_child, "month_08")
	dw_1.object.month_9[ll_row] = lnv_json.getitemNumber( ll_child, "month_09")
	dw_1.object.month_10[ll_row] = lnv_json.getitemNumber( ll_child, "month_10")
	dw_1.object.month_11[ll_row] = lnv_json.getitemNumber( ll_child, "month_11")
	dw_1.object.month_12[ll_row] = lnv_json.getitemNumber( ll_child, "month_12")
	
	dw_1.object.bigo[ll_row] = lnv_json.getitemString( ll_child, "bigo")   

	

next  
		
DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_20030001
string dataobject = "d_20030001"
end type

event dw_1::doubleclicked;call super::doubleclicked;EVENT ue_save()
end event

type sle_id from w_ancestor_03`sle_id within w_20030001
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_20030001
string dataobject = "d_20030001_cdt"
boolean righttoleft = true
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

type st_1 from w_ancestor_03`st_1 within w_20030001
end type

