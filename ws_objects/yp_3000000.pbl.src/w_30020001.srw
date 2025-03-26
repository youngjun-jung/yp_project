$PBExportHeader$w_30020001.srw
forward
global type w_30020001 from w_ancestor_08
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

global type w_30020001 from w_ancestor_08
end type
global w_30020001 w_30020001

forward prototypes
public function boolean wf_retrieve_1 (string as_year, string as_gubun)
public function boolean wf_retrieve_2 (string as_year, string as_gubun)
end prototypes

public function boolean wf_retrieve_1 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

if as_gubun = '0' then
	ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/products", 'GET', ls_body)	
else
	ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/products", 'GET', ls_body)	
end if

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

	tab_1.tabpage_2.dw_2.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_2.dw_2.object.name_1[ll_row] = lnv_json.getitemString( ll_child, "name_1")  
	tab_1.tabpage_2.dw_2.object.lname_1[ll_row] = lnv_json.getitemString( ll_child, "lname_1")  
	tab_1.tabpage_2.dw_2.object.mname_1[ll_row] = lnv_json.getitemString( ll_child, "mname_1")  
	tab_1.tabpage_2.dw_2.object.sname_1[ll_row] = lnv_json.getitemString( ll_child, "sname_1")  
	tab_1.tabpage_2.dw_2.object.lname_2[ll_row] = lnv_json.getitemString( ll_child, "lname_2")  
	tab_1.tabpage_2.dw_2.object.mname_2[ll_row] = lnv_json.getitemString( ll_child, "mname_2")  
	tab_1.tabpage_2.dw_2.object.sname2[ll_row] = lnv_json.getitemString( ll_child, "sname_2")  
	tab_1.tabpage_2.dw_2.object.month_01[ll_row] = lnv_json.getitemnumber( ll_child, "month_01")  
	tab_1.tabpage_2.dw_2.object.month_02[ll_row] = lnv_json.getitemnumber( ll_child, "month_02")  
	tab_1.tabpage_2.dw_2.object.month_03[ll_row] = lnv_json.getitemnumber( ll_child, "month_03")  
	tab_1.tabpage_2.dw_2.object.month_04[ll_row] = lnv_json.getitemnumber( ll_child, "month_04")  
	tab_1.tabpage_2.dw_2.object.month_05[ll_row] = lnv_json.getitemnumber( ll_child, "month_05")  
	tab_1.tabpage_2.dw_2.object.month_06[ll_row] = lnv_json.getitemnumber( ll_child, "month_06")  
	tab_1.tabpage_2.dw_2.object.month_07[ll_row] = lnv_json.getitemnumber( ll_child, "month_07")  
	tab_1.tabpage_2.dw_2.object.month_08[ll_row] = lnv_json.getitemnumber( ll_child, "month_08")  
	tab_1.tabpage_2.dw_2.object.month_09[ll_row] = lnv_json.getitemnumber( ll_child, "month_09")  
	tab_1.tabpage_2.dw_2.object.month_10[ll_row] = lnv_json.getitemnumber( ll_child, "month_10")  
	tab_1.tabpage_2.dw_2.object.month_11[ll_row] = lnv_json.getitemnumber( ll_child, "month_11")  
	tab_1.tabpage_2.dw_2.object.month_12[ll_row] = lnv_json.getitemnumber( ll_child, "month_12")  

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_2 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid, ls_month
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

if as_gubun = '0' then

	ls_month = '00'
	
else
	
	ls_month = dw_cdt.object.month[1]
	
end if

ls_body = 'year=' + as_year + '&month=' + ls_month

if as_gubun = '0' then
	ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/products_dtl", 'GET', ls_body)	
else
	ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/products_dtl", 'GET', ls_body)	
end if

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

	tab_1.tabpage_1.dw_1.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_1.dw_1.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_1.dw_1.object.lname[ll_row] = lnv_json.getitemString( ll_child, "lname")  
	tab_1.tabpage_1.dw_1.object.mname[ll_row] = lnv_json.getitemString( ll_child, "mname")  
	tab_1.tabpage_1.dw_1.object.sname[ll_row] = lnv_json.getitemString( ll_child, "sname")  
	tab_1.tabpage_1.dw_1.object.measure[ll_row] = lnv_json.getitemString( ll_child, "measure")  
	tab_1.tabpage_1.dw_1.object.da0101[ll_row] = lnv_json.getitemnumber(ll_child, "da0101")
	tab_1.tabpage_1.dw_1.object.da0102[ll_row] = lnv_json.getitemnumber(ll_child, "da0102")
	tab_1.tabpage_1.dw_1.object.da0103[ll_row] = lnv_json.getitemnumber(ll_child, "da0103")
	tab_1.tabpage_1.dw_1.object.da0201[ll_row] = lnv_json.getitemnumber(ll_child, "da0201")
	tab_1.tabpage_1.dw_1.object.da0202[ll_row] = lnv_json.getitemnumber(ll_child, "da0202")
	tab_1.tabpage_1.dw_1.object.da0203[ll_row] = lnv_json.getitemnumber(ll_child, "da0203")
	tab_1.tabpage_1.dw_1.object.da0301[ll_row] = lnv_json.getitemnumber(ll_child, "da0301")
	tab_1.tabpage_1.dw_1.object.da0302[ll_row] = lnv_json.getitemnumber(ll_child, "da0302")
	tab_1.tabpage_1.dw_1.object.da0303[ll_row] = lnv_json.getitemnumber(ll_child, "da0303")
	tab_1.tabpage_1.dw_1.object.da0401[ll_row] = lnv_json.getitemnumber(ll_child, "da0401")
	tab_1.tabpage_1.dw_1.object.da0402[ll_row] = lnv_json.getitemnumber(ll_child, "da0402")
	tab_1.tabpage_1.dw_1.object.da0403[ll_row] = lnv_json.getitemnumber(ll_child, "da0403")
	tab_1.tabpage_1.dw_1.object.da0501[ll_row] = lnv_json.getitemnumber(ll_child, "da0501")
	tab_1.tabpage_1.dw_1.object.da0502[ll_row] = lnv_json.getitemnumber(ll_child, "da0502")
	tab_1.tabpage_1.dw_1.object.da0503[ll_row] = lnv_json.getitemnumber(ll_child, "da0503")
	tab_1.tabpage_1.dw_1.object.da0601[ll_row] = lnv_json.getitemnumber(ll_child, "da0601")
	tab_1.tabpage_1.dw_1.object.da0602[ll_row] = lnv_json.getitemnumber(ll_child, "da0602")
	tab_1.tabpage_1.dw_1.object.da0603[ll_row] = lnv_json.getitemnumber(ll_child, "da0603")
	tab_1.tabpage_1.dw_1.object.da0701[ll_row] = lnv_json.getitemnumber(ll_child, "da0701")
	tab_1.tabpage_1.dw_1.object.da0702[ll_row] = lnv_json.getitemnumber(ll_child, "da0702")
	tab_1.tabpage_1.dw_1.object.da0703[ll_row] = lnv_json.getitemnumber(ll_child, "da0703")
	tab_1.tabpage_1.dw_1.object.da0801[ll_row] = lnv_json.getitemnumber(ll_child, "da0801")
	tab_1.tabpage_1.dw_1.object.da0802[ll_row] = lnv_json.getitemnumber(ll_child, "da0802")
	tab_1.tabpage_1.dw_1.object.da0803[ll_row] = lnv_json.getitemnumber(ll_child, "da0803")
	tab_1.tabpage_1.dw_1.object.da0901[ll_row] = lnv_json.getitemnumber(ll_child, "da0901")
	tab_1.tabpage_1.dw_1.object.da0902[ll_row] = lnv_json.getitemnumber(ll_child, "da0902")
	tab_1.tabpage_1.dw_1.object.da0903[ll_row] = lnv_json.getitemnumber(ll_child, "da0903")
	tab_1.tabpage_1.dw_1.object.da1001[ll_row] = lnv_json.getitemnumber(ll_child, "da1001")
	tab_1.tabpage_1.dw_1.object.da1002[ll_row] = lnv_json.getitemnumber(ll_child, "da1002")
	tab_1.tabpage_1.dw_1.object.da1003[ll_row] = lnv_json.getitemnumber(ll_child, "da1003")
	tab_1.tabpage_1.dw_1.object.da1101[ll_row] = lnv_json.getitemnumber(ll_child, "da1101")
	tab_1.tabpage_1.dw_1.object.da1102[ll_row] = lnv_json.getitemnumber(ll_child, "da1102")
	tab_1.tabpage_1.dw_1.object.da1103[ll_row] = lnv_json.getitemnumber(ll_child, "da1103")
	tab_1.tabpage_1.dw_1.object.da1201[ll_row] = lnv_json.getitemnumber(ll_child, "da1201")
	tab_1.tabpage_1.dw_1.object.da1202[ll_row] = lnv_json.getitemnumber(ll_child, "da1202")
	tab_1.tabpage_1.dw_1.object.da1203[ll_row] = lnv_json.getitemnumber(ll_child, "da1203")
	tab_1.tabpage_1.dw_1.object.da1301[ll_row] = lnv_json.getitemnumber(ll_child, "da1301")
	tab_1.tabpage_1.dw_1.object.da1302[ll_row] = lnv_json.getitemnumber(ll_child, "da1302")
	tab_1.tabpage_1.dw_1.object.da1303[ll_row] = lnv_json.getitemnumber(ll_child, "da1303")
	tab_1.tabpage_1.dw_1.object.da1401[ll_row] = lnv_json.getitemnumber(ll_child, "da1401")
	tab_1.tabpage_1.dw_1.object.da1402[ll_row] = lnv_json.getitemnumber(ll_child, "da1402")
	tab_1.tabpage_1.dw_1.object.da1403[ll_row] = lnv_json.getitemnumber(ll_child, "da1403")
	tab_1.tabpage_1.dw_1.object.da1501[ll_row] = lnv_json.getitemnumber(ll_child, "da1501")
	tab_1.tabpage_1.dw_1.object.da1502[ll_row] = lnv_json.getitemnumber(ll_child, "da1502")
	tab_1.tabpage_1.dw_1.object.da1503[ll_row] = lnv_json.getitemnumber(ll_child, "da1503")
	tab_1.tabpage_1.dw_1.object.da1601[ll_row] = lnv_json.getitemnumber(ll_child, "da1601")
	tab_1.tabpage_1.dw_1.object.da1602[ll_row] = lnv_json.getitemnumber(ll_child, "da1602")
	tab_1.tabpage_1.dw_1.object.da1603[ll_row] = lnv_json.getitemnumber(ll_child, "da1603")
	tab_1.tabpage_1.dw_1.object.da1701[ll_row] = lnv_json.getitemnumber(ll_child, "da1701")
	tab_1.tabpage_1.dw_1.object.da1702[ll_row] = lnv_json.getitemnumber(ll_child, "da1702")
	tab_1.tabpage_1.dw_1.object.da1703[ll_row] = lnv_json.getitemnumber(ll_child, "da1703")
	tab_1.tabpage_1.dw_1.object.da1801[ll_row] = lnv_json.getitemnumber(ll_child, "da1801")
	tab_1.tabpage_1.dw_1.object.da1802[ll_row] = lnv_json.getitemnumber(ll_child, "da1802")
	tab_1.tabpage_1.dw_1.object.da1803[ll_row] = lnv_json.getitemnumber(ll_child, "da1803")
	tab_1.tabpage_1.dw_1.object.da1901[ll_row] = lnv_json.getitemnumber(ll_child, "da1901")
	tab_1.tabpage_1.dw_1.object.da1902[ll_row] = lnv_json.getitemnumber(ll_child, "da1902")
	tab_1.tabpage_1.dw_1.object.da1903[ll_row] = lnv_json.getitemnumber(ll_child, "da1903")
	tab_1.tabpage_1.dw_1.object.da2001[ll_row] = lnv_json.getitemnumber(ll_child, "da2001")
	tab_1.tabpage_1.dw_1.object.da2002[ll_row] = lnv_json.getitemnumber(ll_child, "da2002")
	tab_1.tabpage_1.dw_1.object.da2003[ll_row] = lnv_json.getitemnumber(ll_child, "da2003")
	tab_1.tabpage_1.dw_1.object.db0101[ll_row] = lnv_json.getitemnumber(ll_child, "db0101")
	tab_1.tabpage_1.dw_1.object.db0102[ll_row] = lnv_json.getitemnumber(ll_child, "db0102")
	tab_1.tabpage_1.dw_1.object.db0103[ll_row] = lnv_json.getitemnumber(ll_child, "db0103")
	tab_1.tabpage_1.dw_1.object.dc0101[ll_row] = lnv_json.getitemnumber(ll_child, "dc0101")
	tab_1.tabpage_1.dw_1.object.dc0102[ll_row] = lnv_json.getitemnumber(ll_child, "dc0102")
	tab_1.tabpage_1.dw_1.object.dc0103[ll_row] = lnv_json.getitemnumber(ll_child, "dc0103")
	tab_1.tabpage_1.dw_1.object.dc0201[ll_row] = lnv_json.getitemnumber(ll_child, "dc0201")
	tab_1.tabpage_1.dw_1.object.dc0202[ll_row] = lnv_json.getitemnumber(ll_child, "dc0202")
	tab_1.tabpage_1.dw_1.object.dc0203[ll_row] = lnv_json.getitemnumber(ll_child, "dc0203")
	tab_1.tabpage_1.dw_1.object.dc0301[ll_row] = lnv_json.getitemnumber(ll_child, "dc0301")
	tab_1.tabpage_1.dw_1.object.dc0302[ll_row] = lnv_json.getitemnumber(ll_child, "dc0302")
	tab_1.tabpage_1.dw_1.object.dc0303[ll_row] = lnv_json.getitemnumber(ll_child, "dc0303")
	tab_1.tabpage_1.dw_1.object.dd0101[ll_row] = lnv_json.getitemnumber(ll_child, "dd0101")
	tab_1.tabpage_1.dw_1.object.dd0102[ll_row] = lnv_json.getitemnumber(ll_child, "dd0102")
	tab_1.tabpage_1.dw_1.object.dd0103[ll_row] = lnv_json.getitemnumber(ll_child, "dd0103") 


next  
		
DESTROY lnv_json

RETURN true
end function

on w_30020001.create
int iCurrent
call super::create
end on

on w_30020001.destroy
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
String ls_year, ls_gubun
long ll_value

ls_year = dw_cdt.object.toyear[1]
ls_gubun = dw_cdt.object.gubun[1]

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_2(ls_year, ls_gubun)

		// constructor 이벤트에서 특정 열을 고정				
		// 고정할 열의 해드 이름
		ll_value = Long(tab_1.tabpage_1.dw_1.Object.measure_t.X) + Long(tab_1.tabpage_1.dw_1.Object.measure_t.Width) + 6
		
		tab_1.tabpage_1.dw_1.Object.DataWindow.HorizontalScrollSplit = ll_value
	
		tab_1.tabpage_1.dw_1.Modify("DataWindow.HorizontalScrollPosition= " + '0' )
			
		tab_1.tabpage_1.dw_1.Modify("DataWindow.HorizontalScrollPosition2= " + String(ll_value))

	CASE 2
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year, ls_gubun)	
				
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
				
END CHOOSE

end event

type sle_id from w_ancestor_08`sle_id within w_30020001
end type

type tab_1 from w_ancestor_08`tab_1 within w_30020001
integer x = 219
integer y = 484
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
string text = "생산계획"
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

type dw_cdt from w_ancestor_08`dw_cdt within w_30020001
string dataobject = "d_30020001_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_30020001
end type

type dw_1 from u_dw_grid within tabpage_1
integer x = 5
integer y = 16
integer taborder = 10
string dataobject = "d_30020001_2"
boolean ib_selectrow = true
end type

event retrieveend;call super::retrieveend;long ll_value

//고정시키고자하는 컬럼 또는 오브젝트의 명과 변경하여 사용(예: totcnt_t => cvcod) 
ll_value = Long(This.Object.measure_t.X) + Long(This.Object.measure_t.Width) + 6 
	
This.Object.DataWindow.HorizontalScrollSplit = ll_value 
	
This.Modify("DataWindow.HorizontalScrollPosition= " + '0' ) 
This.Modify("DataWindow.HorizontalScrollPosition2= " + String(ll_value)) 

end event

event scrollhorizontal;call super::scrollhorizontal;Long ll_value 

//고정시키고자하는 컬럼 또는 오브젝트의 명과 변경하여 사용(예: totcnt_t => cvcod) 
ll_value = Long(This.Object.measure_t.X) + Long(This.Object.measure_t.Width) + 6 

IF pane = 1 THEN 
 IF scrollpos <> 1 THEN 
 This.Modify("DataWindow.HorizontalScrollPosition= " + '1' ) 
 END IF 
ELSEIF pane = 2 THEN 
 IF scrollpos < ll_value THEN 
 This.Modify("DataWindow.HorizontalScrollPosition2= " + String(ll_value) ) 
 END IF 
END IF 
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "생산계획(상세)"
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
string dataobject = "d_30020001_1"
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
end type

