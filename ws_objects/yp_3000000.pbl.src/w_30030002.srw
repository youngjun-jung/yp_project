$PBExportHeader$w_30030002.srw
forward
global type w_30030002 from w_ancestor_08
end type
type dw_1 from u_dw_grid within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
end forward

global type w_30030002 from w_ancestor_08
end type
global w_30030002 w_30030002

forward prototypes
public subroutine wf_resize ()
public function boolean wf_retrieve_1 (string as_year)
end prototypes

public subroutine wf_resize ();

				
end subroutine

public function boolean wf_retrieve_1 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/plestimation", 'GET', ls_body)

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

	tab_1.tabpage_1.dw_1.object.year[ll_row] = lnv_json.getitemstring( ll_child, "year")  
	tab_1.tabpage_1.dw_1.object.sname[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_1.dw_1.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "pledc001")
	tab_1.tabpage_1.dw_1.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "pledc002")
	tab_1.tabpage_1.dw_1.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "pledc003")
	tab_1.tabpage_1.dw_1.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "pledc004")
	tab_1.tabpage_1.dw_1.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "pledc005")
	tab_1.tabpage_1.dw_1.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "pledc006")
	tab_1.tabpage_1.dw_1.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "pledc007")

next  
		
DESTROY lnv_json

RETURN true
end function

on w_30030002.create
int iCurrent
call super::create
end on

on w_30030002.destroy
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


end event

event open;call super::open;Date ld_toyear
ld_toyear = Today()

dw_cdt.object.toyear[1] = String(ld_toyear, "yyyy")

end event

event ue_retrieve;call super::ue_retrieve;Long   ll_gettab
String ls_year

ls_year = dw_cdt.object.toyear[1]

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year)	
		
END CHOOSE

RETURN TRUE
end event

event ue_excel;call super::ue_excel;boolean lb_return

lb_return = gf_excel_proc(tab_1.tabpage_1.dw_1)
end event

type sle_id from w_ancestor_08`sle_id within w_30030002
end type

type tab_1 from w_ancestor_08`tab_1 within w_30030002
string tag = "d_30020002_1"
integer x = 224
integer weight = 400
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "손익추정"
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

type dw_cdt from w_ancestor_08`dw_cdt within w_30030002
string dataobject = "d_30030002_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_30030002
end type

type dw_1 from u_dw_grid within tabpage_1
integer taborder = 10
string dataobject = "d_30030002_1"
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
end type

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle4.gif"
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle5.gif"
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle6.gif"
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle7.gif"
long picturemaskcolor = 536870912
end type

type tabpage_8 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle8.gif"
long picturemaskcolor = 536870912
end type

type tabpage_9 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle9.gif"
long picturemaskcolor = 536870912
end type

