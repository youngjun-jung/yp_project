$PBExportHeader$w_20030008.srw
forward
global type w_20030008 from w_ancestor_08
end type
type dw_1 from u_dw_grid within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type dw_2 from u_dw_grid within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type dw_4 from u_dw_freeform within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
st_3 st_3
st_2 st_2
dw_4 dw_4
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
public function boolean wf_retrieve_21 (string as_year)
public function boolean wf_retrieve_22 (string as_year)
end prototypes

public function boolean wf_retrieve_1 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/zincconcentrate", 'GET', ls_body)	

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

public function boolean wf_retrieve_21 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/zincconcentratemanual", 'GET', ls_body)	

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
tab_1.tabpage_2.dw_2.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_2.dw_2.insertrow(0)
	
	tab_1.tabpage_2.dw_2.object.gubun[ll_row] = lnv_json.getitemString( ll_child, "gubun")  
	tab_1.tabpage_2.dw_2.object.measure[ll_row] = lnv_json.getitemString( ll_child, "measure")  
	
	tab_1.tabpage_2.dw_2.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_2.dw_2.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_2.dw_2.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_22 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/zincconcentrateunitcost", 'GET', ls_body)	

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
tab_1.tabpage_2.dw_4.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = 1 //tab_1.tabpage_2.dw_2.insertrow(0)
	
	tab_1.tabpage_2.dw_4.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	
	tab_1.tabpage_2.dw_4.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "month_01")  
	tab_1.tabpage_2.dw_4.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "month_02")  
	tab_1.tabpage_2.dw_4.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "month_03")
	tab_1.tabpage_2.dw_4.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "month_04")
	tab_1.tabpage_2.dw_4.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "month_05")
	tab_1.tabpage_2.dw_4.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "month_06")
	tab_1.tabpage_2.dw_4.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "month_07")
	tab_1.tabpage_2.dw_4.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "month_08")
	tab_1.tabpage_2.dw_4.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "month_09")
	tab_1.tabpage_2.dw_4.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "month_10")
	tab_1.tabpage_2.dw_4.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "month_11")
	tab_1.tabpage_2.dw_4.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "month_12")
	
	tab_1.tabpage_2.dw_4.object.cost_01[ll_row] = lnv_json.getitemnumber( ll_child, "cost_01")  
	tab_1.tabpage_2.dw_4.object.cost_02[ll_row] = lnv_json.getitemnumber( ll_child, "cost_02")  
	tab_1.tabpage_2.dw_4.object.cost_03[ll_row] = lnv_json.getitemnumber( ll_child, "cost_03")
	tab_1.tabpage_2.dw_4.object.cost_04[ll_row] = lnv_json.getitemnumber( ll_child, "cost_04")
	tab_1.tabpage_2.dw_4.object.cost_05[ll_row] = lnv_json.getitemnumber( ll_child, "cost_05")
	tab_1.tabpage_2.dw_4.object.cost_06[ll_row] = lnv_json.getitemnumber( ll_child, "cost_06")
	tab_1.tabpage_2.dw_4.object.cost_07[ll_row] = lnv_json.getitemnumber( ll_child, "cost_07")
	tab_1.tabpage_2.dw_4.object.cost_08[ll_row] = lnv_json.getitemnumber( ll_child, "cost_08")
	tab_1.tabpage_2.dw_4.object.cost_09[ll_row] = lnv_json.getitemnumber( ll_child, "cost_09")
	tab_1.tabpage_2.dw_4.object.cost_10[ll_row] = lnv_json.getitemnumber( ll_child, "cost_10")
	tab_1.tabpage_2.dw_4.object.cost_11[ll_row] = lnv_json.getitemnumber( ll_child, "cost_11")
	tab_1.tabpage_2.dw_4.object.cost_12[ll_row] = lnv_json.getitemnumber( ll_child, "cost_12")
	
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
/*
tab_1.tabpage_2.dw_2.Width = tab_1.Width - 60
tab_1.tabpage_2.dw_2.Height = tab_1.Height -150

tab_1.tabpage_3.dw_3.Width = tab_1.Width - 60
tab_1.tabpage_3.dw_3.Height = tab_1.Height -150
*/

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
		
		wf_retrieve_21(ls_year)
		wf_retrieve_22(ls_year)
		
		tab_1.tabpage_2.dw_4.setredraw(true)
		
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
	/*	
	CASE 2
		
		gf_excel_proc(tab_1.tabpage_2.dw_2)

	CASE 3
		
		gf_excel_proc(tab_1.tabpage_3.dw_3)
	*/			
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
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "기초자료"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle2.gif"
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
st_3 st_3
st_2 st_2
dw_4 dw_4
end type

on tabpage_2.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.st_3=create st_3
this.st_2=create st_2
this.dw_4=create dw_4
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.st_3,&
this.st_2,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_4)
end on

type cb_2 from commandbutton within tabpage_2
integer x = 3808
integer y = 1564
integer width = 517
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

type cb_1 from commandbutton within tabpage_2
integer x = 1431
integer y = 1572
integer width = 517
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

type dw_2 from u_dw_grid within tabpage_2
integer x = 37
integer y = 156
integer width = 1911
integer height = 1384
integer taborder = 20
string dataobject = "d_20030008_21"
end type

type st_3 from statictext within tabpage_2
integer x = 2199
integer y = 48
integer width = 745
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
string text = "※ 월별 아연정광 단가"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_2
integer x = 41
integer y = 44
integer width = 640
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
string text = "※ 고품위 아연정광"
boolean focusrectangle = false
end type

type dw_4 from u_dw_freeform within tabpage_2
integer x = 2185
integer y = 144
integer width = 2171
integer height = 1408
integer taborder = 20
string dataobject = "d_20030008_22"
boolean border = false
end type

event constructor;call super::constructor;insertrow(0)
end event

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

