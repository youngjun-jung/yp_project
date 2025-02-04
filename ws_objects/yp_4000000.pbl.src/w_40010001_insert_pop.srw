$PBExportHeader$w_40010001_insert_pop.srw
forward
global type w_40010001_insert_pop from w_ancestor_pop2
end type
type cb_3 from commandbutton within w_40010001_insert_pop
end type
type cb_1 from commandbutton within w_40010001_insert_pop
end type
end forward

global type w_40010001_insert_pop from w_ancestor_pop2
integer width = 2144
integer height = 1728
string title = "사용자 추가"
boolean minbox = false
windowtype windowtype = response!
cb_3 cb_3
cb_1 cb_1
end type
global w_40010001_insert_pop w_40010001_insert_pop

type variables
String is_groupid[], is_groupname[]
Long is_row
end variables

on w_40010001_insert_pop.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_1
end on

on w_40010001_insert_pop.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;call super::open;String ls_body, ls_result, ls_error
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_1.SetRedraw(false)

ls_body = 'id=' + '%'

ls_result = gf_api_call("http://localhost:3000/api/group", 'GET', ls_body)

IF ls_result = 'FAIL' THEN
	CLOSE(this)
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

is_row = 1

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  

	is_groupid[is_row] = lnv_json.getitemstring( ll_child, "groupid")  
	is_groupname[is_row] = lnv_json.getitemstring( ll_child, "groupname")  
	
	is_row =is_row + 1

next  

is_row = is_row - 1
		
DESTROY lnv_json

dw_1.SetColumn('userid')
dw_1.setfocus()
dw_1.SetRedraw(true)

RETURN
end event

event close;//
end event

type dw_1 from w_ancestor_pop2`dw_1 within w_40010001_insert_pop
integer x = 242
integer width = 1669
integer height = 980
string dataobject = "d_40010001_insert_pop"
end type

event dw_1::ue_dddw_retrieve;call super::ue_dddw_retrieve;Long i

dw_1.accepttext()

CHOOSE CASE column
		
	CASE 'groupid'		

		for i = 1 to is_row

			dddw.InsertRow(i)
			
			dddw.SetItem(i, 1, is_groupid[i]  )
			dddw.SetItem(i, 2, is_groupname[i]    )
		
		next
		
END CHOOSE
end event

event dw_1::constructor;call super::constructor;insertrow(1)
end event

type st_id from w_ancestor_pop2`st_id within w_40010001_insert_pop
integer x = 265
integer y = 1400
end type

type cb_2 from w_ancestor_pop2`cb_2 within w_40010001_insert_pop
end type

type st_1 from w_ancestor_pop2`st_1 within w_40010001_insert_pop
integer x = 233
string text = "□ 사용자 추가"
end type

type cb_3 from commandbutton within w_40010001_insert_pop
integer x = 1573
integer y = 1396
integer width = 325
integer height = 116
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;close(w_40010001_insert_pop)
end event

type cb_1 from commandbutton within w_40010001_insert_pop
integer x = 1198
integer y = 1396
integer width = 325
integer height = 116
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추가"
end type

event clicked;String ls_userid, ls_username, ls_passwd, ls_groupid
String ls_body, ls_result, ls_error, ls_returncode
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_1.accepttext()

ls_userid = dw_1.object.userid[1]
ls_username = dw_1.object.username[1]
ls_passwd = dw_1.object.passwd[1]
ls_groupid = dw_1.object.groupid[1]

if gf_chk_null(ls_userid) or gf_chk_null(ls_userid) or gf_chk_null(ls_userid) or gf_chk_null(ls_userid) then
	MessageBox("확인", "정보가 누락되었습니다.")
	return
end if

ls_body = '{"userid": "' + ls_userid + '", "username": "' + ls_username + '", "passwd": "' + ls_passwd + '", "groupid": "' + ls_groupid + '"}'  

ls_result = gf_api_call("http://localhost:3000/api/user", 'POST', ls_body)

IF ls_result = 'FAIL' or gf_chk_null(ls_result) THEN
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

ll_count = lnv_json.getchildcount( ll_root )  

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_root, ll_index )  
	
	ls_returncode = lnv_json.getitemstring( ll_child, "returncode")  

next  
		
DESTROY lnv_json

IF ls_returncode = '0000' THEN

	CloseWithReturn(w_40010001_insert_pop, ls_returncode)
	
ELSE	
	
	MessageBox("실패", "사용자 생성에 실패 하였습니다.")
	
END IF

RETURN
end event

