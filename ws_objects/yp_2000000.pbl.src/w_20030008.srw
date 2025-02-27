$PBExportHeader$w_20030008.srw
forward
global type w_20030008 from w_ancestor_08
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
type tabpage_3 from userobject within tab_1
end type
type dw_3 from u_dw_grid within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
end forward

global type w_20030008 from w_ancestor_08
end type
global w_20030008 w_20030008

forward prototypes
public function boolean wf_retrieve_1 (string as_year)
end prototypes

public function boolean wf_retrieve_1 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://localhost:3000/api/zincconcentrate", 'GET', ls_body)	

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

// DataWindow 초기화
tab_1.tabpage_1.dw_1.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_1.dw_1.insertrow(0)

	tab_1.tabpage_1.dw_1.object.gubun[ll_row] = lnv_json.getitemString( ll_child, "gubun")  
	tab_1.tabpage_1.dw_1.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_1.dw_1.object.sname[ll_row] = lnv_json.getitemString( ll_child, "sname")  
	
	tab_1.tabpage_1.dw_1.object.cnt_01[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_01")  
	tab_1.tabpage_1.dw_1.object.unit_cost_01[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_01")  
	tab_1.tabpage_1.dw_1.object.amt_01[ll_row] = lnv_json.getitemnumber( ll_child, "amt_01")  
	tab_1.tabpage_1.dw_1.object.cnt_02[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_02")  
	tab_1.tabpage_1.dw_1.object.unit_cost_02[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_02")  
	tab_1.tabpage_1.dw_1.object.amt_02[ll_row] = lnv_json.getitemnumber( ll_child, "amt_02") 
	tab_1.tabpage_1.dw_1.object.cnt_03[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_03")  
	tab_1.tabpage_1.dw_1.object.unit_cost_03[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_03")  
	tab_1.tabpage_1.dw_1.object.amt_03[ll_row] = lnv_json.getitemnumber( ll_child, "amt_03") 
	tab_1.tabpage_1.dw_1.object.cnt_04[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_04")  
	tab_1.tabpage_1.dw_1.object.unit_cost_04[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_04")  
	tab_1.tabpage_1.dw_1.object.amt_04[ll_row] = lnv_json.getitemnumber( ll_child, "amt_04") 
	tab_1.tabpage_1.dw_1.object.cnt_05[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_05")  
	tab_1.tabpage_1.dw_1.object.unit_cost_05[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_05")  
	tab_1.tabpage_1.dw_1.object.amt_05[ll_row] = lnv_json.getitemnumber( ll_child, "amt_05") 
	tab_1.tabpage_1.dw_1.object.cnt_06[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_06")  
	tab_1.tabpage_1.dw_1.object.unit_cost_06[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_06")  
	tab_1.tabpage_1.dw_1.object.amt_06[ll_row] = lnv_json.getitemnumber( ll_child, "amt_06") 
	tab_1.tabpage_1.dw_1.object.cnt_07[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_07")  
	tab_1.tabpage_1.dw_1.object.unit_cost_07[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_07")  
	tab_1.tabpage_1.dw_1.object.amt_07[ll_row] = lnv_json.getitemnumber( ll_child, "amt_07") 
	tab_1.tabpage_1.dw_1.object.cnt_08[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_08")  
	tab_1.tabpage_1.dw_1.object.unit_cost_08[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_08")  
	tab_1.tabpage_1.dw_1.object.amt_08[ll_row] = lnv_json.getitemnumber( ll_child, "amt_08") 
	tab_1.tabpage_1.dw_1.object.cnt_09[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_09")  
	tab_1.tabpage_1.dw_1.object.unit_cost_09[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_09")  
	tab_1.tabpage_1.dw_1.object.amt_09[ll_row] = lnv_json.getitemnumber( ll_child, "amt_09") 
	tab_1.tabpage_1.dw_1.object.cnt_10[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_10")  
	tab_1.tabpage_1.dw_1.object.unit_cost_10[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_10")  
	tab_1.tabpage_1.dw_1.object.amt_10[ll_row] = lnv_json.getitemnumber( ll_child, "amt_10") 
	tab_1.tabpage_1.dw_1.object.cnt_11[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_11")  
	tab_1.tabpage_1.dw_1.object.unit_cost_11[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_11")  
	tab_1.tabpage_1.dw_1.object.amt_11[ll_row] = lnv_json.getitemnumber( ll_child, "amt_11") 
	tab_1.tabpage_1.dw_1.object.cnt_12[ll_row] = lnv_json.getitemnumber( ll_child, "cnt_12")  
	tab_1.tabpage_1.dw_1.object.unit_cost_12[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost_12")  
	tab_1.tabpage_1.dw_1.object.amt_12[ll_row] = lnv_json.getitemnumber( ll_child, "amt_12") 

	tab_1.tabpage_1.dw_1.object.idx[ll_row] = lnv_json.getitemnumber( ll_child, "idx")  

next  
		
DESTROY lnv_json

RETURN true
end function

on w_20030008.create
int iCurrent
call super::create
end on

on w_20030008.destroy
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

tab_1.tabpage_3.dw_3.Width = tab_1.Width - 60
tab_1.tabpage_3.dw_3.Height = tab_1.Height -150

end event

event ue_retrieve;call super::ue_retrieve;Long   ll_gettab
String ls_year

ls_year = dw_cdt.object.toyear[1]

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year)
		
	CASE 2
		
		dw_cdt.AcceptText()
		
	CASE 3
		
		dw_cdt.AcceptText()	
				
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

	CASE 3
		
		gf_excel_proc(tab_1.tabpage_3.dw_3)
				
END CHOOSE

end event

type sle_id from w_ancestor_08`sle_id within w_20030008
end type

type tab_1 from w_ancestor_08`tab_1 within w_20030008
integer x = 219
integer y = 492
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "아연정광 구매계획"
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

type dw_cdt from w_ancestor_08`dw_cdt within w_20030008
string dataobject = "d_20030008_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_20030008
end type

type dw_1 from u_dw_grid within tabpage_1
integer x = 5
integer y = 16
integer taborder = 10
string dataobject = "d_20030008_1"
end type

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
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
string dataobject = "d_20030006_2"
end type

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
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw_grid within tabpage_3
integer x = 5
integer y = 16
integer taborder = 20
string dataobject = "d_20030006_3"
end type

