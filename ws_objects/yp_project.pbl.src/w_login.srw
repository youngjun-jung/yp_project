$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type dw_1 from datawindow within w_login
end type
end forward

global type w_login from window
integer width = 2779
integer height = 2968
boolean titlebar = true
string title = "사업 및 원가분석 시스템"
boolean controlmenu = true
long backcolor = 134217730
string icon = ".\res\credit.ico"
boolean center = true
st_2 st_2
st_1 st_1
dw_1 dw_1
end type
global w_login w_login

type prototypes

end prototypes

type variables
Boolean ib_resize
String  is_old_object

String is_title
String is_window

end variables

forward prototypes
public function boolean wf_login ()
end prototypes

public function boolean wf_login ();String sUserid, sPassword, ls_result, ls_login_flag, ls_body
Long ll_root, ll_count, ll_index, ll_child
Boolean lb_result
JSONParser lnv_json

dw_1.AcceptText()

sUserid   = dw_1.GetItemString(1, 'userid'  )
sPassword = dw_1.GetItemString(1, 'password')
gstr_userenv.pwd = sPassword
gstr_userenv.user_id = sUserid

IF gf_chk_null(sUserid) THEN
	MessageBox("확인", "아이디를 입력하십시오.")
	dw_1.SetFocus()
	dw_1.SetColumn('userid')
	RETURN FALSE
END IF

IF gf_chk_null(sPassword) THEN
	MessageBox("확인", "비밀번호를 입력하십시오.")
	dw_1.SetFocus()
	dw_1.SetColumn('password')
	RETURN FALSE
END IF
  
ls_body = '{"id": "' + sUserid + '", "pw": "' + sPassword + '"}'  

ls_result = gf_api_call("http://localhost:3000/api/login", 'POST', ls_body)

IF ls_result = 'FAIL' THEN
	RETURN FALSE
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE

CHOOSE CASE lb_result
		
	CASE TRUE

	    IF dw_1.Object.id_save[1] = '1' THEN
			SetProfileString("id.ini", "ID", "id", sUserid)
			SetProfileString("id.ini", "PW", "pw", sPassword)
	    END IF

		lnv_json = CREATE JSONParser

		ls_result = lnv_json.LoadString(ls_result)
		ll_root = lnv_json.getrootitem( )  
		ll_count = lnv_json.getchildcount( ll_root )  

		for ll_index = 1 to ll_count    
		
			ll_child = lnv_json.getchilditem( ll_root, ll_index )  
		
			ls_login_flag = lnv_json.getitemstring( ll_child, "returncode")  
			gstr_userenv.user_id = lnv_json.getitemstring( ll_child, "userid")  
			gstr_userenv.user_nm = lnv_json.getitemstring( ll_child, "username")   
			gstr_userenv.user_dept = lnv_json.getitemstring( ll_child, "groupnm")   
			gstr_userenv.grp = lnv_json.getitemstring( ll_child, "groupid")   

		next  
		
		DESTROY lnv_json

		IF ls_login_flag = 'Y'THEN  
		
			Open(w_mainmdi)

			Close(This)
			
			RETURN TRUE
			
		ELSEIF ls_login_flag = 'T' THEN  
			
			Open(w_pw_chg_new)

			Close(This)
			
			RETURN TRUE
			
		ELSEIF ls_login_flag = 'S' THEN  
			
			MESSAGEBOX("확인", "실패건수가 5회이상입니다. 관리자에게 문의해주세요.")
			
			RETURN FALSE
			
		ELSEIF ls_login_flag = 'G' THEN  
			
			MESSAGEBOX("확인", "부서 미지정 상태입니다.[관리자 문의]")
			
			RETURN FALSE	
			
		ELSE
			
			MESSAGEBOX("확인", "아이디(또는 패스워드)를 확인해주세요.")
			
			RETURN FALSE

		END IF
		
END CHOOSE

MESSAGEBOX("확인", "아이디(또는 패스워드)를 확인해주세요.")

RETURN FALSE


end function

on w_login.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_1}
end on

on w_login.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;String ls_id, ls_pw

dw_1.SetRedraw(false)

ls_id = ProfileString("id.ini", "ID", "id", "")
ls_pw = ProfileString("id.ini", "PW", "pw", "")

//AnimateWindow(Handle(This), 500, 16)

IF gf_chk_null(ls_id) THEN 
	ls_id = ''
END IF
dw_1.SetItem(1, 'userid'  , ls_id)
dw_1.SetItem(1, 'password'  , ls_pw)

dw_1.SetFocus()
dw_1.SetColumn('userid')
dw_1.SelectText(1, 100)
dw_1.SetRedraw(true)



end event

type st_2 from statictext within w_login
integer x = 155
integer y = 2728
integer width = 133
integer height = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 50
integer y = 2728
integer width = 133
integer height = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_login
event keydown pbm_dwnkey
integer width = 2775
integer height = 2892
integer taborder = 10
string title = "none"
string dataobject = "d_login"
boolean border = false
boolean livescroll = true
end type

event keydown;String sColumn

CHOOSE CASE Key
		
	CASE KeyEnter!
		
		AcceptText()
		
		sColumn = GetColumnName()
		
		CHOOSE CASE sColumn
				
			CASE 'userid'
				
				SetColumn('password')
				
			CASE 'password'
				
				IF NOT wf_login() THEN RETURN 1
				
		END CHOOSE
		
		RETURN 1
		
END CHOOSE
end event

event clicked;String sPassword

CHOOSE CASE dwo.Name
		
	CASE 't_3'
			
		IF NOT wf_login() THEN RETURN
	
END CHOOSE
end event

event constructor;insertrow(1)
end event

