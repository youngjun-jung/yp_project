﻿$PBExportHeader$w_30010006.srw
forward
global type w_30010006 from w_ancestor_08
end type
type dw_1 from u_dw_grid within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw_grid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
end forward

global type w_30010006 from w_ancestor_08
end type
global w_30010006 w_30010006

forward prototypes
public function boolean wf_retrieve_1 (string as_year, string as_gubun)
public function boolean wf_retrieve_2 (string as_year, ref string as_gubun)
end prototypes

public function boolean wf_retrieve_1 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_year
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Long ll_j_sale_in, ll_j_sale_local, ll_j_sale_out, ll_j_sale_etc, ll_j_sale_sum, ll_j_income_in, ll_j_income_local, ll_j_income_out, ll_j_income_etc, ll_j_income_sum
Long ll_sale_in, ll_sale_local, ll_sale_out, ll_sale_etc, ll_sale_sum, ll_income_in, ll_income_local, ll_income_out, ll_income_etc, ll_income_sum
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_year = dw_cdt.object.toyear[1]

// DataWindow 초기화
tab_1.tabpage_1.dw_1.Reset()

ls_body = 'year=' + ls_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/zincauto", 'GET', ls_body)

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
	
	ll_row = tab_1.tabpage_1.dw_1.insertrow(0)

 	//tab_1.tabpage_1.dw_1.object.num[ll_row] = ll_row //lnv_json.getitemnumber( ll_child, "num")  
	tab_1.tabpage_1.dw_1.object.lname[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_1.dw_1.object.mname[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_1.dw_1.object.sname[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_1.dw_1.object.month_01[ll_row] = lnv_json.getitemnumber( ll_child, "month_01")  
	tab_1.tabpage_1.dw_1.object.month_02[ll_row] = lnv_json.getitemnumber( ll_child, "month_02")  
	tab_1.tabpage_1.dw_1.object.month_03[ll_row] = lnv_json.getitemnumber( ll_child, "month_03")  
	tab_1.tabpage_1.dw_1.object.month_1[ll_row] = lnv_json.getitemnumber( ll_child, "month_1")  
	tab_1.tabpage_1.dw_1.object.month_04[ll_row] = lnv_json.getitemnumber( ll_child, "month_04")  
	tab_1.tabpage_1.dw_1.object.month_05[ll_row] = lnv_json.getitemnumber( ll_child, "month_05")  
	tab_1.tabpage_1.dw_1.object.month_06[ll_row] = lnv_json.getitemnumber( ll_child, "month_06")  
	tab_1.tabpage_1.dw_1.object.month_2[ll_row] = lnv_json.getitemnumber( ll_child, "month_2") 
	tab_1.tabpage_1.dw_1.object.month_07[ll_row] = lnv_json.getitemnumber( ll_child, "month_07")  
	tab_1.tabpage_1.dw_1.object.month_08[ll_row] = lnv_json.getitemnumber( ll_child, "month_08")  
	tab_1.tabpage_1.dw_1.object.month_09[ll_row] = lnv_json.getitemnumber( ll_child, "month_09")  
	tab_1.tabpage_1.dw_1.object.month_3[ll_row] = lnv_json.getitemnumber( ll_child, "month_3") 
	tab_1.tabpage_1.dw_1.object.month_10[ll_row] = lnv_json.getitemnumber( ll_child, "month_10")  
	tab_1.tabpage_1.dw_1.object.month_11[ll_row] = lnv_json.getitemnumber( ll_child, "month_11")  
	tab_1.tabpage_1.dw_1.object.month_12[ll_row] = lnv_json.getitemnumber( ll_child, "month_12")   
	tab_1.tabpage_1.dw_1.object.month_4[ll_row] = lnv_json.getitemnumber( ll_child, "month_4") 
	tab_1.tabpage_1.dw_1.object.month_0[ll_row] = lnv_json.getitemnumber( ll_child, "month_0") 

next  

DESTROY lnv_json

tab_1.tabpage_1.dw_1.setfocus()
tab_1.tabpage_1.dw_1.setredraw(true)

RETURN true
end function

public function boolean wf_retrieve_2 (string as_year, ref string as_gubun);String ls_body, ls_result, ls_error, ls_year
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Long ll_j_sale_in, ll_j_sale_local, ll_j_sale_out, ll_j_sale_etc, ll_j_sale_sum, ll_j_income_in, ll_j_income_local, ll_j_income_out, ll_j_income_etc, ll_j_income_sum
Long ll_sale_in, ll_sale_local, ll_sale_out, ll_sale_etc, ll_sale_sum, ll_income_in, ll_income_local, ll_income_out, ll_income_etc, ll_income_sum
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_year = dw_cdt.object.toyear[1]

// DataWindow 초기화
tab_1.tabpage_2.dw_2.Reset()

ls_body = 'year=' + ls_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/zincconcplan", 'GET', ls_body)

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
	
	ll_row = tab_1.tabpage_2.dw_2.insertrow(0)

	tab_1.tabpage_2.dw_2.object.lname[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_2.dw_2.object.mname[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_2.dw_2.object.sname[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_2.dw_2.object.month_01[ll_row] = lnv_json.getitemnumber( ll_child, "month_01")  
	tab_1.tabpage_2.dw_2.object.month_02[ll_row] = lnv_json.getitemnumber( ll_child, "month_02")  
	tab_1.tabpage_2.dw_2.object.month_03[ll_row] = lnv_json.getitemnumber( ll_child, "month_03")  
	tab_1.tabpage_2.dw_2.object.month_1[ll_row] = lnv_json.getitemnumber( ll_child, "month_1")  
	tab_1.tabpage_2.dw_2.object.month_04[ll_row] = lnv_json.getitemnumber( ll_child, "month_04")  
	tab_1.tabpage_2.dw_2.object.month_05[ll_row] = lnv_json.getitemnumber( ll_child, "month_05")  
	tab_1.tabpage_2.dw_2.object.month_06[ll_row] = lnv_json.getitemnumber( ll_child, "month_06")  
	tab_1.tabpage_2.dw_2.object.month_2[ll_row] = lnv_json.getitemnumber( ll_child, "month_2") 
	tab_1.tabpage_2.dw_2.object.month_07[ll_row] = lnv_json.getitemnumber( ll_child, "month_07")  
	tab_1.tabpage_2.dw_2.object.month_08[ll_row] = lnv_json.getitemnumber( ll_child, "month_08")  
	tab_1.tabpage_2.dw_2.object.month_09[ll_row] = lnv_json.getitemnumber( ll_child, "month_09")  
	tab_1.tabpage_2.dw_2.object.month_3[ll_row] = lnv_json.getitemnumber( ll_child, "month_3") 
	tab_1.tabpage_2.dw_2.object.month_10[ll_row] = lnv_json.getitemnumber( ll_child, "month_10")  
	tab_1.tabpage_2.dw_2.object.month_11[ll_row] = lnv_json.getitemnumber( ll_child, "month_11")  
	tab_1.tabpage_2.dw_2.object.month_12[ll_row] = lnv_json.getitemnumber( ll_child, "month_12")   
	tab_1.tabpage_2.dw_2.object.month_4[ll_row] = lnv_json.getitemnumber( ll_child, "month_4") 
	tab_1.tabpage_2.dw_2.object.month_0[ll_row] = lnv_json.getitemnumber( ll_child, "month_0") 

next  

DESTROY lnv_json

tab_1.tabpage_2.dw_2.setfocus()
tab_1.tabpage_2.dw_2.setredraw(true)

RETURN true
end function

on w_30010006.create
int iCurrent
call super::create
end on

on w_30010006.destroy
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

event ue_retrieve;call super::ue_retrieve;Long   ll_gettab
String ls_year, ls_gubun

ls_year = dw_cdt.object.toyear[1]
ls_gubun = '0'

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year, ls_gubun)
		
	CASE 2
		
		dw_cdt.AcceptText()
		
		wf_retrieve_2(ls_year, ls_gubun)	
								
END CHOOSE

RETURN TRUE
end event

event open;call super::open;Date ld_toyear
ld_toyear = Today()

dw_cdt.object.toyear[1] = String(ld_toyear, "yyyy")
end event

event ue_excel;call super::ue_excel;Long   ll_gettab

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		gf_excel_proc(tab_1.tabpage_1.dw_1)
		
	CASE 2
		
		gf_excel_proc(tab_1.tabpage_2.dw_2)
				
END CHOOSE

end event

type sle_id from w_ancestor_08`sle_id within w_30010006
end type

type tab_1 from w_ancestor_08`tab_1 within w_30010006
integer x = 224
integer y = 488
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "정광(거래처별)"
string picturename = ".\res\Circle1.gif"
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_cdt from w_ancestor_08`dw_cdt within w_30010006
string dataobject = "d_30010006_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_30010006
end type

type dw_1 from u_dw_grid within tabpage_1
integer x = 5
integer y = 16
integer taborder = 10
string dataobject = "d_30010006_1"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "정광수불(계획)"
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

type dw_2 from u_dw_grid within tabpage_2
integer x = 5
integer y = 16
integer taborder = 20
string dataobject = "d_30010006_2"
end type

