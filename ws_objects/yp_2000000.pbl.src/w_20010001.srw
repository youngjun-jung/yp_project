$PBExportHeader$w_20010001.srw
forward
global type w_20010001 from w_ancestor_03
end type
end forward

global type w_20010001 from w_ancestor_03
end type
global w_20010001 w_20010001

on w_20010001.create
call super::create
end on

on w_20010001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event ue_retrieve;call super::ue_retrieve;String ls_result, ls_result_ori, ls_body, ls_error, ls_userid, ls_url, ls_date, ls_cur_unit, ls_ttb, ls_tts, ls_deal_bas_r
String ls_bkpr, ls_yy_efee_r, ls_ten_dd_efee_r, ls_kftc_bkpr, ls_kftc_deal_bas_r, ls_cur_nm
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
Int li_status
JSONParser lnv_json
RESTClient lnv_rest

dw_cdt.accepttext()

// RESTClient 객체 생성
lnv_rest = CREATE RESTClient

ls_date = dw_cdt.object.todate[1]

ls_url = 'https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=6BDv2XPympfR6XM6oudP7dq1W0LCb0n9&searchdate=' + ls_date + '&data=AP01'

//messagebox("ls_url", ls_url)

li_status = lnv_rest.SendGetRequest(ls_url, ls_result)

DESTROY lnv_rest

IF gf_chk_null(ls_result) OR li_status <> 1 THEN
	MESSAGEBOX("오류", "조회중 오류가 발생했습니다.")
	RETURN false
END IF;

IF ls_result = '[]' THEN
	MESSAGEBOX("확인", "조회 내역이 없습니다.")
	RETURN false
END IF;

ls_result_ori = ls_result

ls_result = '{"data":' + ls_result + '}'

//messagebox("ls_result", ls_result)

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
    return false
end if

// 'data' 배열 가져오기
ll_data_array = lnv_json.GetItemArray(ll_root, "data")

if ll_data_array < 0 then
    MessageBox("Error", "'data 배열을 찾을 수 없습니다.")
    Destroy lnv_json
    RETURN false
end if

//messagebox("ll_data_array", ll_data_array)

ll_count = lnv_json.getchildcount( ll_data_array )  

// DataWindow 초기화
dw_1.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  
	
	ls_cur_unit = lnv_json.getitemstring( ll_child, "cur_unit")  
	ls_ttb = lnv_json.getitemstring( ll_child, "ttb")  
	ls_tts = lnv_json.getitemstring( ll_child, "tts")  
	ls_deal_bas_r = lnv_json.getitemstring( ll_child, "deal_bas_r")  
	ls_bkpr = lnv_json.getitemstring( ll_child, "bkpr")  
	ls_yy_efee_r = lnv_json.getitemstring( ll_child, "yy_efee_r")  
	ls_ten_dd_efee_r = lnv_json.getitemstring( ll_child, "ten_dd_efee_r")  
	ls_kftc_bkpr = lnv_json.getitemstring( ll_child, "kftc_bkpr")  
	ls_kftc_deal_bas_r = lnv_json.getitemstring( ll_child, "kftc_deal_bas_r")  
	ls_cur_nm = lnv_json.getitemstring( ll_child, "cur_nm")  
	
	ll_row = dw_1.insertrow(0)
	
	dw_1.object.todate[ll_row] = ls_date
	dw_1.object.source[ll_row] = 'KOR'
	dw_1.object.cur_unit[ll_row] = ls_cur_unit
	dw_1.object.ttb[ll_row] = ls_ttb
	dw_1.object.tts[ll_row] = ls_tts
	dw_1.object.deal_bas_r[ll_row] = ls_deal_bas_r
	dw_1.object.bkpr[ll_row] = ls_bkpr
	dw_1.object.yy_efee_r[ll_row] = ls_yy_efee_r
	dw_1.object.ten_dd_efee_r[ll_row] = ls_ten_dd_efee_r
	dw_1.object.kftc_bkpr[ll_row] = ls_kftc_bkpr
	dw_1.object.kftc_deal_bas_r[ll_row] = ls_kftc_deal_bas_r
	dw_1.object.cur_nm[ll_row] = ls_cur_nm

next  
		
DESTROY lnv_json

// RESTClient 객체 생성
lnv_rest = CREATE RESTClient

//ls_body = ls_result_ori

ls_body = '{"checkdate":"' + ls_date + '", "source":"KOR",' + '"data":' + ls_result_ori + '}'

//messagebox("ls_body", ls_body)

ls_result = gf_api_call("http://localhost:3000/api/exchange", 'POST', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

DESTROY lnv_rest

RETURN true
end event

event open;call super::open;Date ld_today
ld_today = Today()

ld_today = RelativeDate(ld_today, -1)

dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

end event

type dw_1 from w_ancestor_03`dw_1 within w_20010001
string dataobject = "d_20010001"
boolean ib_selectrow = true
end type

event dw_1::doubleclicked;call super::doubleclicked;EVENT ue_save()
end event

type sle_id from w_ancestor_03`sle_id within w_20010001
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_20010001
string dataobject = "d_20010001_cdt"
boolean righttoleft = true
end type

type st_1 from w_ancestor_03`st_1 within w_20010001
end type

