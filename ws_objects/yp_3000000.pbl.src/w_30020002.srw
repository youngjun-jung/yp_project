$PBExportHeader$w_30020002.srw
forward
global type w_30020002 from w_ancestor_08
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
type tabpage_7 from userobject within tab_1
end type
type dw_7 from u_dw_grid within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_7 dw_7
end type
type tabpage_8 from userobject within tab_1
end type
type dw_8 from u_dw_grid within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_8 dw_8
end type
type tabpage_9 from userobject within tab_1
end type
type dw_9 from u_dw_grid within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_9 dw_9
end type
end forward

global type w_30020002 from w_ancestor_08
end type
global w_30020002 w_30020002

forward prototypes
public subroutine wf_resize ()
public function boolean wf_retrieve_1 (string as_year)
public function boolean wf_retrieve_2 (string as_year)
public function boolean wf_retrieve_3 (string as_year)
public function boolean wf_retrieve_4 (string as_year)
public function boolean wf_retrieve_5 (string as_year)
public function boolean wf_retrieve_6 (string as_year)
public function boolean wf_retrieve_7 (string as_year)
public function boolean wf_retrieve_8 (string as_year)
public function boolean wf_retrieve_9 (string as_year)
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

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productszinc", 'GET', ls_body)

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

	tab_1.tabpage_1.dw_1.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_1.dw_1.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_1.dw_1.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_1.dw_1.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_1.dw_1.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_1.dw_1.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_1.dw_1.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_1.dw_1.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_2 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productszincdust", 'GET', ls_body)

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

	tab_1.tabpage_2.dw_2.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_2.dw_2.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_2.dw_2.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_2.dw_2.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_2.dw_2.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_2.dw_2.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_2.dw_2.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_2.dw_2.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_3 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productscadmium", 'GET', ls_body)

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

	tab_1.tabpage_3.dw_3.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_3.dw_3.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_3.dw_3.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_3.dw_3.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_3.dw_3.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_3.dw_3.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_3.dw_3.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_3.dw_3.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_4 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productscoppersulfate", 'GET', ls_body)

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

	tab_1.tabpage_4.dw_4.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_4.dw_4.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_4.dw_4.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_4.dw_4.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_4.dw_4.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_4.dw_4.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_4.dw_4.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_4.dw_4.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_5 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productssulfuricacid", 'GET', ls_body)

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

	tab_1.tabpage_5.dw_5.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_5.dw_5.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_5.dw_5.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_5.dw_5.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_5.dw_5.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_5.dw_5.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_5.dw_5.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_5.dw_5.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_6 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productselcopper", 'GET', ls_body)

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

	tab_1.tabpage_6.dw_6.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_6.dw_6.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_6.dw_6.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_6.dw_6.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_6.dw_6.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_6.dw_6.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_6.dw_6.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_6.dw_6.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_7 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productsplaster", 'GET', ls_body)

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
tab_1.tabpage_7.dw_7.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_7.dw_7.insertrow(0)

	tab_1.tabpage_7.dw_7.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_7.dw_7.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_7.dw_7.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_7.dw_7.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_7.dw_7.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_7.dw_7.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_7.dw_7.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_7.dw_7.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_8 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productsgold", 'GET', ls_body)

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
tab_1.tabpage_8.dw_8.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_8.dw_8.insertrow(0)

	tab_1.tabpage_8.dw_8.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_8.dw_8.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_8.dw_8.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_8.dw_8.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_8.dw_8.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_8.dw_8.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_8.dw_8.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_8.dw_8.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

public function boolean wf_retrieve_9 (string as_year);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_cdt.accepttext()

ls_body = 'year=' + as_year

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/productssilver", 'GET', ls_body)

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
tab_1.tabpage_9.dw_9.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = tab_1.tabpage_9.dw_9.insertrow(0)

	tab_1.tabpage_9.dw_9.object.lgubun[ll_row] = lnv_json.getitemstring( ll_child, "lname")  
	tab_1.tabpage_9.dw_9.object.mgubun[ll_row] = lnv_json.getitemstring( ll_child, "mname")  
	tab_1.tabpage_9.dw_9.object.sgubun[ll_row] = lnv_json.getitemstring( ll_child, "sname")  
	tab_1.tabpage_9.dw_9.object.won_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "won_cnt")
	tab_1.tabpage_9.dw_9.object.won_amt[ll_row] = lnv_json.getitemnumber( ll_child, "won_amt")
	tab_1.tabpage_9.dw_9.object.cnt[ll_row] = lnv_json.getitemnumber( ll_child, "cnt")
	tab_1.tabpage_9.dw_9.object.unit_cost[ll_row] = lnv_json.getitemnumber( ll_child, "unit_cost")
	tab_1.tabpage_9.dw_9.object.amt[ll_row] = lnv_json.getitemnumber( ll_child, "amt")

next  
		
DESTROY lnv_json

RETURN true
end function

on w_30020002.create
int iCurrent
call super::create
end on

on w_30020002.destroy
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

tab_1.tabpage_7.dw_7.Width = tab_1.Width - 60
tab_1.tabpage_7.dw_7.Height = tab_1.Height -150

tab_1.tabpage_8.dw_8.Width = tab_1.Width - 60
tab_1.tabpage_8.dw_8.Height = tab_1.Height -150

tab_1.tabpage_9.dw_9.Width = tab_1.Width - 60
tab_1.tabpage_9.dw_9.Height = tab_1.Height -150

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
		
	CASE 2
		
		dw_cdt.AcceptText()
		
		wf_retrieve_2(ls_year)	
		
	CASE 3
		
		dw_cdt.AcceptText()
		
		wf_retrieve_3(ls_year)	
		
	CASE 4
		
		dw_cdt.AcceptText()
		
		wf_retrieve_4(ls_year)	
		
	CASE 5
		
		dw_cdt.AcceptText()
		
		wf_retrieve_5(ls_year)	
		
	CASE 6
		
		dw_cdt.AcceptText()
		
		wf_retrieve_6(ls_year)	
		
	CASE 7
		
		dw_cdt.AcceptText()
		
		wf_retrieve_7(ls_year)	
		
	CASE 8
		
		dw_cdt.AcceptText()
		
		wf_retrieve_8(ls_year)	
		
	CASE 9
		
		dw_cdt.AcceptText()
		
		wf_retrieve_9(ls_year)		
		
END CHOOSE

RETURN TRUE
end event

type sle_id from w_ancestor_08`sle_id within w_30020002
end type

type tab_1 from w_ancestor_08`tab_1 within w_30020002
string tag = "d_30020002_1"
integer x = 224
integer y = 500
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
string text = "아연"
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

type dw_cdt from w_ancestor_08`dw_cdt within w_30020002
string dataobject = "d_30020002_cdt"
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

type st_1 from w_ancestor_08`st_1 within w_30020002
end type

type dw_1 from u_dw_grid within tabpage_1
integer taborder = 10
string dataobject = "d_30020002_1"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "아연말"
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
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "카드뮴"
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
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "황산동"
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
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "황산"
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
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "전기동"
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
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "석고"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle7.gif"
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_7.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_7)
end on

type dw_7 from u_dw_grid within tabpage_7
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "금"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle8.gif"
long picturemaskcolor = 536870912
dw_8 dw_8
end type

on tabpage_8.create
this.dw_8=create dw_8
this.Control[]={this.dw_8}
end on

on tabpage_8.destroy
destroy(this.dw_8)
end on

type dw_8 from u_dw_grid within tabpage_8
integer taborder = 20
string dataobject = "d_30020002_1"
end type

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "은"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle9.gif"
long picturemaskcolor = 536870912
dw_9 dw_9
end type

on tabpage_9.create
this.dw_9=create dw_9
this.Control[]={this.dw_9}
end on

on tabpage_9.destroy
destroy(this.dw_9)
end on

type dw_9 from u_dw_grid within tabpage_9
integer taborder = 20
string dataobject = "d_30020002_1"
end type

