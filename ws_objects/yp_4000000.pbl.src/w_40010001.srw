$PBExportHeader$w_40010001.srw
forward
global type w_40010001 from w_ancestor_03
end type
end forward

global type w_40010001 from w_ancestor_03
end type
global w_40010001 w_40010001

on w_40010001.create
call super::create
end on

on w_40010001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_userid = dw_cdt.object.userid[1]

IF gf_chk_null(ls_userid) THEN	ls_userid = '%'

ls_body = 'id=' + '%' + ls_userid + '%'

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/user", 'GET', ls_body)

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
dw_1.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ll_row = dw_1.insertrow(0)

	dw_1.object.userid[ll_row] = lnv_json.getitemstring( ll_child, "userid")  
	dw_1.object.username[ll_row] = lnv_json.getitemstring( ll_child, "username")  
	dw_1.object.groupid[ll_row] = lnv_json.getitemstring( ll_child, "groupid")  
	dw_1.object.groupname[ll_row] = lnv_json.getitemstring( ll_child, "groupname")  
	dw_1.object.passwd[ll_row] = lnv_json.getitemstring( ll_child, "passwd")  
	dw_1.object.fail_cnt[ll_row] = lnv_json.getitemnumber( ll_child, "fail_cnt")  

next  
		
DESTROY lnv_json

RETURN true
end event

event ue_delete;call super::ue_delete;String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result

dw_cdt.accepttext()

ll_row = dw_1.getrow()

IF ll_row < 1 THEN RETURN false

ls_userid = dw_1.object.userid[ll_row]

IF gf_chk_null(ls_userid) THEN	RETURN false

ls_body = '{"id": "' + ls_userid +'"}'

ls_body = ''

IF Messagebox("확인",  "[ " + ls_userid + " ]  를 삭제하시겠습니까?", Question!, YesNo!, 1) = 2 THEN RETURN false 

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/user/" + ls_userid , 'DELETE', ls_body)

IF ls_result = 'FAIL' THEN
	MESSAGEBOX("Error", "DB 처리 실패")
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	
	MESSAGEBOX("Error", "삭제 실패")
	RETURN false
END IF

MESSAGEBOX("성공", "삭제 완료되었습니다.")

event ue_retrieve()

RETURN true
end event

event ue_new;call super::ue_new;open(w_40010001_insert_pop)

IF gf_chk_null(Message.StringParm) THEN RETURN FALSE

if Message.StringParm = '0000' then
	event ue_retrieve()
end if

return true
end event

event ue_save;call super::ue_save;String ls_userid
Long ll_row

ll_row = dw_1.getrow()

IF ll_row < 1 THEN RETURN false

ls_userid = dw_1.object.userid[ll_row]

openwithparm(w_40010001_update_pop, ls_userid)

IF gf_chk_null(Message.StringParm) THEN RETURN FALSE

MESSAGEBOX("성공", "수정이 완료되었습니다.")

if Message.StringParm = '0000' then
	event ue_retrieve()
end if

return true

end event

type dw_1 from w_ancestor_03`dw_1 within w_40010001
string dataobject = "d_40010001"
boolean ib_selectrow = true
end type

event dw_1::doubleclicked;call super::doubleclicked;EVENT ue_save()
end event

type sle_id from w_ancestor_03`sle_id within w_40010001
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_40010001
string dataobject = "d_40010001_cdt"
boolean righttoleft = true
end type

type st_1 from w_ancestor_03`st_1 within w_40010001
end type

