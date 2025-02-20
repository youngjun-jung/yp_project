$PBExportHeader$w_10020002.srw
forward
global type w_10020002 from w_ancestor_03
end type
type cb_1 from commandbutton within w_10020002
end type
type cb_3 from commandbutton within w_10020002
end type
type cb_2 from commandbutton within w_10020002
end type
type cb_4 from commandbutton within w_10020002
end type
type cb_5 from commandbutton within w_10020002
end type
type cb_6 from commandbutton within w_10020002
end type
end forward

global type w_10020002 from w_ancestor_03
integer height = 3024
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
end type
global w_10020002 w_10020002

type variables
Long il_chk_cnt
Oleobject pbobject, pblogin, ltable, ltablerows, addrows

end variables

on w_10020002.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_6
end on

on w_10020002.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
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

ls_result = gf_api_call("http://localhost:3000/api/sale", 'GET', ls_body)

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

type dw_1 from w_ancestor_03`dw_1 within w_10020002
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

type sle_id from w_ancestor_03`sle_id within w_10020002
integer x = 238
integer y = 2592
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_10020002
string dataobject = "d_10010001_cdt"
end type

type st_1 from w_ancestor_03`st_1 within w_10020002
end type

type cb_1 from commandbutton within w_10020002
integer x = 2249
integer y = 96
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
boolean lb_result

// OLE 객체 생성 및 RFC 연결 설정
oleSapRfc = CREATE OLEObject
li_rc = oleSapRfc.ConnectToNewObject("SAP.Functions")

IF li_rc <> 0 THEN
    MessageBox("Error", "SAP RFC 연결 실패")
    RETURN
END IF

//Production server (PRD)
oleSapRfc = oleSapRfc.connection // SAP CONNECTION OLE 사용 

/* 테스트서버 */
oleSapRfc.ApplicationServer = "211.35.173.42" // SERVER IP -> 
oleSapRfc.System = "YPP" // 시스템명
oleSapRfc.SystemNumber = 00 // 디폴트 0 
oleSapRfc.user = "IFGW01" // SAP 사용자명 (실제 sap id) 
oleSapRfc.Password = "123456" // SAP 페스워드 (실제 password) 
oleSapRfc.Client = "700" // CLIENT 번호 
oleSapRfc.Language = "EN" // LANGUAGE "KO" 

lb_result = oleSapRfc.logon(1, TRUE)

messagebox("lb_result", string(lb_result))

// 연결 실행
If not(lb_result) Then // LOGON 
   messagebox("SAP : ApplicationServer 로그인 에러 "," SAP ApplicationServer 로그인 에러입니다.") 
   setpointer(ARROW!) 
   RETURN
End if 


// RFC 함수 호출 (예: RFC_READ_TABLE)
oleFunction = oleSapRfc.Add("ZMM_WEIGH_002")
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

type cb_3 from commandbutton within w_10020002
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

event clicked;OLEObject oleSapConn, oleSapFunc

int li_ret

oleSapConn = CREATE OLEObject // OLE 생성 
li_ret = oleSapConn.ConnectToNewObject("Sap.Functions.Unicode") //A SAP 컴포넌트와 연계
if li_Ret <> 0 then
   Messagebox("확인", "SAP연결실패..")
   return 
end if

//messagebox("li_ret", li_ret)

//Production server (PRD)
oleSapConn = oleSapConn.connection // SAP CONNECTION OLE 사용 

/* 테스트서버 */
oleSapConn.ApplicationServer = "211.35.173.42" // SERVER IP -> 
oleSapConn.System = "YPP" // 시스템명
oleSapConn.SystemNumber = 00 // 디폴트 0 
oleSapConn.user = "IFGW01" // SAP 사용자명 (실제 sap id) 
oleSapConn.Password = "123456" // SAP 페스워드 (실제 password) 
oleSapConn.Client = "700" // CLIENT 번호 
oleSapConn.Language = "KO" // LANGUAGE "KO" 
/*
/* 운영서버 */
oleSapConn.ApplicationServer = "211.35.173.43" // SERVER IP -> 
oleSapConn.System = "YPP" // 시스템명
oleSapConn.SystemNumber = 00 // 디폴트 0 
oleSapConn.user = "12041" // SAP 사용자명 (실제 sap id) 
oleSapConn.Password = "ypzinc02" // SAP 페스워드 (실제 password) 
oleSapConn.Client = "100" // CLIENT 번호 
oleSapConn.Language = "KO" // LANGUAGE "KO" 
*/
If oleSapConn.logon(1, TRUE) <> True Then // LOGON 
   messagebox("SAP : ApplicationServer 로그인 에러 "," SAP ApplicationServer 로그인 에러입니다.") 
   setpointer(ARROW!) 
   RETURN
End if 

MessageBox("Success", "SAP ApplicationServer 로그인")

TRY
    oleSapFunc = oleSapConn.Add("ZMM_WEIGH_002")
    IF IsNull(oleSapFunc) THEN
        MessageBox("Error", "Function not found or not accessible!")
        RETURN
    END IF
CATCH (Throwable e)
    MessageBox("Error", e.GetMessage())
	ChangeDirectory(gstr_userenv.path)
	DESTROY oleSapConn
	DESTROY oleSapFunc
END TRY

return

// RFC 함수 호출 준비
oleSapFunc = oleSapConn.Add("ZMM_WEIGH_002")  // 호출할 RFC 이름 입력

MessageBox("Success", "RFC 함수 로드 성공")

IF IsNull(oleSapFunc) THEN
    MessageBox("Error", "RFC 함수 로드 실패")
    RETURN
END IF

MessageBox("Success", "RFC 함수 로드 성공")

// 파라미터 설정 (필요에 따라 수정)
oleSapFunc.Exports("I_KUNNR").Value = "1111"     // Export 파라미터 설정
oleSapFunc.Exports("I_NAME1").Value = "2222"

// RFC 호출 실행
IF oleSapFunc.Call() = FALSE THEN
    MessageBox("Error", "RFC 호출 실패")
    RETURN
END IF

// 결과 처리 (Import 파라미터 또는 테이블 데이터 읽기)
string ls_result
ls_result = oleSapFunc.Imports("KUNNR").Value  // Import 파라미터 값 가져오기
MessageBox("Result", ls_result)

// 종료 및 정리
DESTROY oleSapConn
DESTROY oleSapFunc

ChangeDirectory(gstr_userenv.path)


Return 

end event

type cb_2 from commandbutton within w_10020002
integer x = 3031
integer y = 120
integer width = 297
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "접속"
end type

event clicked;Boolean lb_return = False
Long ll_row = 9999, ll_inx
String ls_aaa, ls_bbb, ls_ccc

pblogin = create oleobject

pblogin.ConnectToNewObject("SAP.Functions")

pblogin.connection.ApplicationServer = "211.35.173.42" // SERVER IP -> 
pblogin.connection.System = "YPP" // 시스템명
pblogin.connection.SystemNumber = "00" // 디폴트 0 
pblogin.connection.user = "IFGW01" // SAP 사용자명 (실제 sap id) 
pblogin.connection.Password = "123456" // SAP 페스워드 (실제 password) 
pblogin.connection.Client = "700" // CLIENT 번호 
pblogin.connection.Language = "KO" // LANGUAGE "KO" 
pblogin.Connection.CodePage = '8500' 

lb_return = pblogin.connection.logon(0, TRUE)

if lb_return <> TRUE then
	MessageBox("","R/3 접속 실패")
	return
end if

TRY
	ltable = pblogin.Add("ZMM_WEIGH_002")
	
	ltable.Exports("I_KUNNR").Value = ""  // I_KUNNR 전달할 값
     ltable.Exports("I_NAME1").Value = ""  // I_NAME1 전달할 값
	
	//ltablerows = ltable.Tables("T_KUNNR")

	IF ltable.CALL = True THEN
		//접속을 종료하지 않고 계속 호출되면 결과는 레코드수가 누적 됨.
		
		ltablerows = ltable.Tables("T_KUNNR")
		
		//MessageBox("","Rows = " + String(ltablerows.rowcount))
		//MessageBox("","R/3 RFC 호출 성공")
		
		For ll_inx = 1 To 5 // ltablerows.RowCount()
		  //	ll_row = dw_1.InsertRow(0)
		  
		  //	dw_1.SetItem(ll_row, "테이블의 필드명", String(ITAB.cell(ll_inx , '테이블의 필드명')))
			  
			 // ls_aaa = ltable.imports("KUNNR").Value
			  
			  ls_aaa = String(ltablerows.cell(ll_inx , 'KUNNR'))
			  ls_bbb = String(ltablerows.cell(ll_inx , 'NAME1'))
			  ls_ccc = String(ltablerows.cell(ll_inx , 'Z_FLAG'))
			  
			  messagebox("ls_aaa", ls_aaa)
			  messagebox("ls_bbb", ls_bbb)
			  messagebox("ls_ccc", ls_ccc)
		Next

		pblogin.connection.logoff
		Destroy pblogin
		
	else
		MessageBox("","R/3 RFC 호출 실패")
		pblogin.connection.logoff
		Destroy pblogin
		return
	end if
   
CATCH (Throwable e)
    MessageBox("Error", e.GetMessage())
	ChangeDirectory(gstr_userenv.path)
	
	pblogin.connection.logoff
	Destroy pblogin

END TRY

	




end event

type cb_4 from commandbutton within w_10020002
integer x = 3342
integer y = 124
integer width = 270
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "종료"
end type

event clicked;pblogin.connection.logoff
MessageBox("","R/3 접속 종료")
Destroy pblogin

end event

type cb_5 from commandbutton within w_10020002
integer x = 3625
integer y = 124
integer width = 270
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "호출"
end type

event clicked;Boolean lb_return = False
Long ll_row = 9999

ltable = pblogin.Add("ZMM_WEIGH_002")
ltablerows = ltable.Tables("I_PB")
IF ltable.CALL = True THEN
	//접속을 종료하지 않고 계속 호출되면 결과는 레코드수가 누적 됨.
	MessageBox("","Rows = " + String(ltablerows.rowcount))
	return
else
	MessageBox("","R/3 RFC 호출 실패")
	return
end if

end event

type cb_6 from commandbutton within w_10020002
integer x = 3909
integer y = 124
integer width = 270
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "입력"
end type

event clicked;Boolean lb_return = False
Long ll_row = 9999
String ls_string

ltable = pblogin.Add("YQMB01_PB_01")

//ltable.exports("Import_Val", "값")
//ls_string = ltable.imports("Import_Val")

//structobj = ltable.exports("test_struct") OR
//FIELDOBJ = LTABLE.EXPORTS("test_struct1")
//structobj.value("name") = "홍길동" or
//fieldobj.value = "1234"

ltablerows = ltable.Tables("I_PB")
addrows = ltablerows.Rows.Add
addrows.value("LTXTNO", "111111")
addrows.value("TDFORMAT", "DD")
addrows.value("SUBNR", "DDDDDDD")
addrows.value("TDLINE", "DDDDD")
addrows = ltablerows.Rows.Add
addrows.value("LTXTNO", "22222")
addrows.value("TDFORMAT", "EE")
addrows.value("SUBNR", "EEEE")
addrows.value("TDLINE", "EEEEEEE")
addrows = ltablerows.Rows.Add
addrows.value("LTXTNO", "333333")
addrows.value("TDFORMAT", "FF")
addrows.value("SUBNR", "FFFFFF")
addrows.value("TDLINE", "FFFFFFF")

IF ltable.CALL = True THEN
MessageBox("","전송 Rows = " + String(ltablerows.rowcount))
return
else
MessageBox("","R/3 RFC 전송 실패" + String(ltable.Exception))
return
end if

end event

