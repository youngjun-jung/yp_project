$PBExportHeader$w_30010008.srw
forward
global type w_30010008 from w_ancestor_08
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
type tabpage_4 from userobject within tab_1
end type
type dw_4 from u_dw_grid within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from u_dw_grid within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_6 from u_dw_grid within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6 dw_6
end type
end forward

global type w_30010008 from w_ancestor_08
end type
global w_30010008 w_30010008

forward prototypes
public function boolean wf_retrieve_1 (string as_year, string as_gubun)
public function boolean wf_retrieve_2 (string as_year, string as_gubun)
public function boolean wf_retrieve_3 (string as_year, string as_gubun)
public function boolean wf_retrieve_4 (string as_year, string as_gubun)
public function boolean wf_retrieve_5 (string as_year, string as_gubun)
public function boolean wf_retrieve_6 (string as_year, ref string as_gubun)
end prototypes

public function boolean wf_retrieve_1 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' + as_gubun 

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/submaterialaia", 'GET', ls_body)	

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
	tab_1.tabpage_1.dw_1.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_1.dw_1.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_1.dw_1.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_1.dw_1.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_1.dw_1.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_1.dw_1.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_1.dw_1.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_1.dw_1.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_1.dw_1.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_1.dw_1.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_1.dw_1.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_1.dw_1.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_1.dw_1.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_1.dw_1.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_1.dw_1.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_1.dw_1.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_1.dw_1.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_1.dw_1.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")  

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_2 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' +  as_gubun

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/laborcostaia", 'GET', ls_body)	

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
	tab_1.tabpage_2.dw_2.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_2.dw_2.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_2.dw_2.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_2.dw_2.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_2.dw_2.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_2.dw_2.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_2.dw_2.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_2.dw_2.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_2.dw_2.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_2.dw_2.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_2.dw_2.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_2.dw_2.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_2.dw_2.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_2.dw_2.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_2.dw_2.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_2.dw_2.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_2.dw_2.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_2.dw_2.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")  

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_3 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' +  as_gubun

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/eleccostaia", 'GET', ls_body)	

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
tab_1.tabpage_3.dw_3.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_3.dw_3.insertrow(0)

	tab_1.tabpage_3.dw_3.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_3.dw_3.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_3.dw_3.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_3.dw_3.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_3.dw_3.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_3.dw_3.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_3.dw_3.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_3.dw_3.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_3.dw_3.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_3.dw_3.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_3.dw_3.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_3.dw_3.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_3.dw_3.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_3.dw_3.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_3.dw_3.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_3.dw_3.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_3.dw_3.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_3.dw_3.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_3.dw_3.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_4 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' +  as_gubun

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/otherexpensesaia", 'GET', ls_body)	

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
tab_1.tabpage_4.dw_4.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_4.dw_4.insertrow(0)

	tab_1.tabpage_4.dw_4.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_4.dw_4.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_4.dw_4.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_4.dw_4.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_4.dw_4.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_4.dw_4.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_4.dw_4.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_4.dw_4.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_4.dw_4.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_4.dw_4.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_4.dw_4.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_4.dw_4.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_4.dw_4.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_4.dw_4.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_4.dw_4.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_4.dw_4.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_4.dw_4.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_4.dw_4.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_4.dw_4.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_5 (string as_year, string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' +  as_gubun

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/repairexpensesaia", 'GET', ls_body)	

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
tab_1.tabpage_5.dw_5.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_5.dw_5.insertrow(0)

	tab_1.tabpage_5.dw_5.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_5.dw_5.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_5.dw_5.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_5.dw_5.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_5.dw_5.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_5.dw_5.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_5.dw_5.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_5.dw_5.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_5.dw_5.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_5.dw_5.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_5.dw_5.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_5.dw_5.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_5.dw_5.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_5.dw_5.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_5.dw_5.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_5.dw_5.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_5.dw_5.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_5.dw_5.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_5.dw_5.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_6 (string as_year, ref string as_gubun);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year + '&gubun=' +  as_gubun

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/depreciationaia", 'GET', ls_body)	

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
tab_1.tabpage_6.dw_6.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_6.dw_6.insertrow(0)

	tab_1.tabpage_6.dw_6.object.year[ll_row] = lnv_json.getitemString( ll_child, "year")  
	tab_1.tabpage_6.dw_6.object.month[ll_row] = lnv_json.getitemString( ll_child, "month")  
	tab_1.tabpage_6.dw_6.object.name[ll_row] = lnv_json.getitemString( ll_child, "name")  
	tab_1.tabpage_6.dw_6.object.xa[ll_row] = lnv_json.getitemnumber( ll_child, "xa")  
	tab_1.tabpage_6.dw_6.object.xb[ll_row] = lnv_json.getitemnumber( ll_child, "xb")  
	tab_1.tabpage_6.dw_6.object.xc[ll_row] = lnv_json.getitemnumber( ll_child, "xc")  
	tab_1.tabpage_6.dw_6.object.xd[ll_row] = lnv_json.getitemnumber( ll_child, "xd")  
	tab_1.tabpage_6.dw_6.object.xe[ll_row] = lnv_json.getitemnumber( ll_child, "xe")  
	tab_1.tabpage_6.dw_6.object.xf[ll_row] = lnv_json.getitemnumber( ll_child, "xf")  
	tab_1.tabpage_6.dw_6.object.xg[ll_row] = lnv_json.getitemnumber( ll_child, "xg")  
	tab_1.tabpage_6.dw_6.object.xh[ll_row] = lnv_json.getitemnumber( ll_child, "xh")  
	tab_1.tabpage_6.dw_6.object.zn[ll_row] = lnv_json.getitemnumber( ll_child, "zn") 
	tab_1.tabpage_6.dw_6.object.xi[ll_row] = lnv_json.getitemnumber( ll_child, "xi")  
	tab_1.tabpage_6.dw_6.object.xj[ll_row] = lnv_json.getitemnumber( ll_child, "xj")  
	tab_1.tabpage_6.dw_6.object.xk[ll_row] = lnv_json.getitemnumber( ll_child, "xk")  
	tab_1.tabpage_6.dw_6.object.xl[ll_row] = lnv_json.getitemnumber( ll_child, "xl")  
	tab_1.tabpage_6.dw_6.object.xm[ll_row] = lnv_json.getitemnumber( ll_child, "xm")  
	tab_1.tabpage_6.dw_6.object.xn[ll_row] = lnv_json.getitemnumber( ll_child, "xn")  
	tab_1.tabpage_6.dw_6.object.num[ll_row] = lnv_json.getitemnumber( ll_child, "num")

next  
		
DESTROY lnv_json

RETURN true
end function

on w_30010008.create
int iCurrent
call super::create
end on

on w_30010008.destroy
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

tab_1.tabpage_4.dw_4.Width = tab_1.Width - 60
tab_1.tabpage_4.dw_4.Height = tab_1.Height -150

tab_1.tabpage_5.dw_5.Width = tab_1.Width - 60
tab_1.tabpage_5.dw_5.Height = tab_1.Height -150

tab_1.tabpage_6.dw_6.Width = tab_1.Width - 60
tab_1.tabpage_6.dw_6.Height = tab_1.Height -150

end event

event ue_retrieve;call super::ue_retrieve;Long   ll_gettab
String ls_year, ls_gubun

ls_year = dw_cdt.object.toyear[1]
ls_gubun = dw_cdt.object.gubun[1]

ll_gettab = tab_1.SelectedTab

CHOOSE CASE ll_gettab
		
	CASE 1
		
		dw_cdt.AcceptText()
		
		wf_retrieve_1(ls_year, ls_gubun)
		
	CASE 2
		
		dw_cdt.AcceptText()
		
		wf_retrieve_2(ls_year, ls_gubun)
		
	CASE 3
		
		dw_cdt.AcceptText()	
		
		wf_retrieve_3(ls_year, ls_gubun)
		
	CASE 4
		
		dw_cdt.AcceptText()	
		
		wf_retrieve_4(ls_year, ls_gubun)	
	
	CASE 5
		
		dw_cdt.AcceptText()	
		
		wf_retrieve_5(ls_year, ls_gubun)	
		
	CASE 6
		
		dw_cdt.AcceptText()	
		
		wf_retrieve_6(ls_year, ls_gubun)		
								
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

type sle_id from w_ancestor_08`sle_id within w_30010008
end type

type tab_1 from w_ancestor_08`tab_1 within w_30010008
integer x = 224
integer y = 492
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "보조재료비"
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

type dw_cdt from w_ancestor_08`dw_cdt within w_30010008
string dataobject = "d_30010008_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_30010008
end type

type dw_1 from u_dw_grid within tabpage_1
integer x = 5
integer y = 16
integer taborder = 10
string dataobject = "d_30010008_1"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "노무비"
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
string dataobject = "d_30010008_2"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "전력비"
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
string dataobject = "d_30010008_3"
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "기타경비"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle4.gif"
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw_grid within tabpage_4
integer x = 5
integer y = 16
integer taborder = 20
string dataobject = "d_30010008_4"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "수선비"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle5.gif"
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from u_dw_grid within tabpage_5
integer x = 5
integer y = 16
integer taborder = 20
string dataobject = "d_30010008_5"
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "감가상각비"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle6.gif"
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from u_dw_grid within tabpage_6
integer x = 5
integer y = 16
integer taborder = 20
string dataobject = "d_30010008_6"
end type

