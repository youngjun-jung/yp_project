$PBExportHeader$w_10020001_bak.srw
forward
global type w_10020001_bak from w_ancestor_03
end type
type cb_1 from commandbutton within w_10020001_bak
end type
type cb_2 from commandbutton within w_10020001_bak
end type
type cb_3 from commandbutton within w_10020001_bak
end type
end forward

global type w_10020001_bak from w_ancestor_03
integer height = 3024
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_10020001_bak w_10020001_bak

type variables
Long il_chk_cnt
end variables

on w_10020001_bak.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on w_10020001_bak.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;Date ld_today, ld_frdate
ld_today = Today()

ld_frdate = RelativeDate(ld_today, - 30)

dw_cdt.object.frdate[1] = String(ld_frdate, "yyyyMMdd")
dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

dw_cdt.object.frdate[1] = '20240101'
dw_cdt.object.todate[1] = '20241231'




end event

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event ue_retrieve;call super::ue_retrieve;String ls_body, ls_result, ls_error, ls_frdate, ls_todate, ls_sale, ls_b_sale
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Long ll_j_sale_in, ll_j_sale_local, ll_j_sale_out, ll_j_sale_etc, ll_j_sale_sum, ll_j_income_in, ll_j_income_local, ll_j_income_out, ll_j_income_etc, ll_j_income_sum
Long ll_sale_in, ll_sale_local, ll_sale_out, ll_sale_etc, ll_sale_sum, ll_income_in, ll_income_local, ll_income_out, ll_income_etc, ll_income_sum
Boolean lb_result
JSONParser lnv_json

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]

// DataWindow 초기화
dw_1.Reset()

ls_body = 'frdate=' + ls_frdate + '&todate=' + ls_todate

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/sale", 'GET', ls_body)

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

ll_sale_in = 0
ll_sale_local = 0
ll_sale_out = 0
ll_sale_etc = 0
ll_sale_sum = 0
ll_income_in = 0
ll_income_local = 0
ll_income_out = 0
ll_income_etc = 0
ll_income_sum = 0

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  

	ll_j_sale_in = lnv_json.getitemNumber( ll_child, "in_1")  
	ll_j_sale_local = lnv_json.getitemNumber( ll_child, "in_local_1")  
	ll_j_sale_out = lnv_json.getitemNumber( ll_child, "out_1")
	ll_j_sale_etc = lnv_json.getitemNumber( ll_child, "etc_1")  
	ll_j_sale_sum = lnv_json.getitemNumber( ll_child, "sum_1")  
	ll_j_income_in = lnv_json.getitemNumber( ll_child, "in_2") 
	ll_j_income_local = lnv_json.getitemNumber( ll_child, "in_local_2")  
	ll_j_income_out = lnv_json.getitemNumber( ll_child, "out_2")
	ll_j_income_etc = lnv_json.getitemNumber( ll_child, "etc_2") 
	ll_j_income_sum = lnv_json.getitemNumber( ll_child, "sum_2")  

	ls_sale = lnv_json.getitemstring( ll_child, "sale") 
	
	if (ls_b_sale =  '아연' and ls_sale <> '아연') or (ls_b_sale = '황산동' and ls_sale <> '황산동') &
		or (ls_b_sale = '은부산물' and ls_sale <> '은부산물')  then
		
		ll_row = dw_1.insertrow(0)
		
		dw_1.object.name_1[ll_row] = '소계'
		dw_1.object.in_1[ll_row] = ll_sale_in
		dw_1.object.in_local_1[ll_row] = ll_sale_local
		dw_1.object.out_1[ll_row] = ll_sale_out
		dw_1.object.etc_1[ll_row] = ll_sale_etc 
		dw_1.object.sum_1[ll_row] = ll_sale_sum
		dw_1.object.name_2[ll_row] = '소계'
		dw_1.object.in_2[ll_row] = ll_income_in
		dw_1.object.in_local_2[ll_row] = ll_income_local  
		dw_1.object.out_2[ll_row] = ll_income_out
		dw_1.object.etc_2[ll_row] = ll_income_etc
		dw_1.object.sum_2[ll_row] = ll_income_sum

		ll_sale_in = 0
		ll_sale_local = 0
		ll_sale_out = 0
		ll_sale_etc = 0
		ll_sale_sum = 0
		ll_income_in = 0
		ll_income_local = 0
		ll_income_out = 0
		ll_income_etc = 0
		ll_income_sum = 0

	end if
	
	ll_row = dw_1.insertrow(0)
	
	dw_1.object.frdate[ll_row] = gf_date_format(ls_frdate, '0')
	dw_1.object.todate[ll_row] = gf_date_format(ls_todate, '0')
	dw_1.object.sale[ll_row] = ls_sale
	dw_1.object.name_1[ll_row] = lnv_json.getitemstring( ll_child, "name_1")  
	dw_1.object.in_1[ll_row] = ll_j_sale_in
	dw_1.object.in_local_1[ll_row] = ll_j_sale_local
	dw_1.object.out_1[ll_row] = ll_j_sale_out
	dw_1.object.etc_1[ll_row] = ll_j_sale_etc 
	dw_1.object.sum_1[ll_row] = ll_j_sale_sum
	dw_1.object.income[ll_row] = lnv_json.getitemstring( ll_child, "income")  
	dw_1.object.name_2[ll_row] = lnv_json.getitemstring( ll_child, "name_2")  
	dw_1.object.in_2[ll_row] = ll_j_income_in
	dw_1.object.in_local_2[ll_row] = ll_j_income_local  
	dw_1.object.out_2[ll_row] = ll_j_income_out
	dw_1.object.etc_2[ll_row] = ll_j_income_etc
	dw_1.object.sum_2[ll_row] = ll_j_income_sum
	dw_1.object.mcode[ll_row] = lnv_json.getitemstring( ll_child, "mcode") 

	ls_b_sale = ls_sale
	
	ll_sale_in = ll_sale_in + ll_j_sale_in
	ll_sale_local = ll_sale_local + ll_j_sale_local
	ll_sale_out = ll_sale_out + ll_j_sale_out
	ll_sale_etc = ll_sale_etc + ll_j_sale_etc
	ll_sale_sum = ll_sale_sum + ll_j_sale_sum
	ll_income_in = ll_income_in + ll_j_income_in
	ll_income_local = ll_income_local + ll_j_income_local
	ll_income_out = ll_income_out + ll_j_income_out
	ll_income_etc = ll_income_etc + ll_j_income_etc
	ll_income_sum = ll_income_sum +  ll_j_income_sum
	
next  

ll_row = dw_1.insertrow(0)
		
dw_1.object.name_1[ll_row] = '소계'
dw_1.object.in_1[ll_row] = ll_sale_in
dw_1.object.in_local_1[ll_row] = ll_sale_local
dw_1.object.out_1[ll_row] = ll_sale_out
dw_1.object.etc_1[ll_row] = ll_sale_etc 
dw_1.object.sum_1[ll_row] = ll_sale_sum
dw_1.object.name_2[ll_row] = '소계'
dw_1.object.in_2[ll_row] = ll_income_in
dw_1.object.in_local_2[ll_row] = ll_income_local  
dw_1.object.out_2[ll_row] = ll_income_out
dw_1.object.etc_2[ll_row] = ll_income_etc
dw_1.object.sum_2[ll_row] = ll_income_sum
		
DESTROY lnv_json

dw_1.setfocus()
dw_1.setredraw(true)

RETURN true
end event

type dw_1 from w_ancestor_03`dw_1 within w_10020001_bak
string dataobject = "d_10010001"
end type

event dw_1::doubleclicked;call super::doubleclicked;str_popup lstr_popup

if row < 1 then return

lstr_popup.rvalue[1] = gf_date_format(dw_1.object.frdate[row], '1')
lstr_popup.rvalue[2] = gf_date_format(dw_1.object.todate[row], '1')
lstr_popup.rvalue[3] = dw_1.object.mcode[row]
lstr_popup.rvalue[4] = dw_1.object.name_1[row]

if gf_chk_null(lstr_popup.rvalue[3]) then return

openwithparm(w_10010001_pop, lstr_popup)


end event

type sle_id from w_ancestor_03`sle_id within w_10020001_bak
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_10020001_bak
string dataobject = "d_10010001_cdt"
end type

type st_1 from w_ancestor_03`st_1 within w_10020001_bak
end type

type cb_1 from commandbutton within w_10020001_bak
integer x = 1893
integer y = 112
integer width = 457
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;OLEObject oleSapRfc, oleFunction, oleTable
integer li_rc

// OLE 객체 생성 및 RFC 연결 설정
oleSapRfc = CREATE OLEObject
li_rc = oleSapRfc.ConnectToNewObject("SAP.Functions")

MessageBox("li_rc", li_rc)

IF li_rc <> 0 THEN
    MessageBox("Error", "SAP RFC 연결 실패")
    RETURN
END IF

// RFC 함수 호출 (예: RFC_READ_TABLE)
oleFunction = oleSapRfc.Add("RFC_READ_TABLE")
//oleFunction.Exports("QUERY_TABLE") = "T001" // 테이블 이름 설정

// 실행 및 결과 처리
IF oleFunction.Call() THEN
    oleTable = oleFunction.Imports("DATA")
    // 결과 데이터 처리 로직 추가
    MessageBox("Success", "데이터 조회 성공")
ELSE
    MessageBox("Error", "RFC 호출 실패")
END IF

// 작업 완료 후 OLE 객체 해제
DESTROY oleSapRfc
DESTROY oleFunction
DESTROY oleTable

end event

type cb_2 from commandbutton within w_10020001_bak
integer x = 2459
integer y = 100
integer width = 457
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;OLEObject oleSapGui, oleConnection
integer li_rc

// OLE 객체 생성
oleSapGui = CREATE OLEObject
li_rc = oleSapGui.ConnectToNewObject("SAP.GUI.ScriptingCtrl.1")

MessageBox("li_rc", li_rc)

IF li_rc <> 0 THEN
    MessageBox("Error", "SAP GUI 연결 실패")
    RETURN
END IF

// 세션 시작 및 연결 설정
oleConnection = oleSapGui.Children(0).Children(0).OpenConnection("SAP_NAME", True)
oleConnection.Client = "700"
oleConnection.User = "IFGW01"
oleConnection.Password = "123456"
oleConnection.Language = "KO"

// 연결 성공 여부 확인
IF oleConnection.IsConnected THEN
    MessageBox("Success", "SAP 연결 성공")
ELSE
    MessageBox("Error", "SAP 연결 실패")
END IF

// 작업 완료 후 OLE 객체 해제
DESTROY oleSapGui
DESTROY oleConnection

end event

type cb_3 from commandbutton within w_10020001_bak
integer x = 1431
integer y = 88
integer width = 457
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;OLEObject Sap_OLE 
OLEObject SapConn

int li_ret

Sap_OLE = CREATE OLEObject // OLE 생성 
li_ret = Sap_OLE.ConnectToNewObject("Sap.Functions.Unicode") //A SAP 컴포넌트와 연계
if li_Ret <> 0 then
   Messagebox("확인", "SAP연결실패..")
   return 
end if

//Production server (PRD)
SapConn = Sap_OLE.connection // SAP CONNECTION OLE 사용 

/* 운영서버 */
SapConn.ApplicationServer = "192.168.1.1" // SERVER IP -> 
SapConn.SystemNumber = 00 // 디폴트 0 
SapConn.user = "king" // SAP 사용자명 (실제 sap id) 
SapConn.Password = "k1234" // SAP 페스워드 (실제 password) 
SapConn.Client = "100" // CLIENT 번호 
SapConn.Language = "KO" // LANGUAGE "KO" 

If SapConn.logon(1, TRUE) <> True Then // LOGON 
   messagebox("SAP : ApplicationServer 로그인 에러 "," SAP ApplicationServer 로그인 에러입니다.") 
   setpointer(ARROW!) 

else
  messagebox("SAP : ApplicationServer 로그인 성공 "," SAP ApplicationServer 로그인 ") 
End if 

Return 

end event

