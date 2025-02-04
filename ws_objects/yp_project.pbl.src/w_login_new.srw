$PBExportHeader$w_login_new.srw
forward
global type w_login_new from window
end type
type st_2 from statictext within w_login_new
end type
type st_1 from statictext within w_login_new
end type
type dw_1 from datawindow within w_login_new
end type
end forward

global type w_login_new from window
integer width = 2779
integer height = 2968
boolean titlebar = true
string title = "법인카드"
boolean controlmenu = true
long backcolor = 134217730
string icon = "C:\Users\jun\Desktop\pb_source\법인카드\res\credit.ico"
boolean center = true
st_2 st_2
st_1 st_1
dw_1 dw_1
end type
global w_login_new w_login_new

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

public function boolean wf_login ();String sUserid, sPassword, sPassword2, sUserName, sUserDept, sUserTel, sDefMenu, sChangedate, sTodate, ls_result, ls_ip2, ls_grp
String ls_result2, ls_result3, ls_result4, ls_result5, ls_result6, ls_result7
long lFail_cnt, i, lDate_cnt
boolean b

dw_1.AcceptText()

sUserid   = dw_1.GetItemString(1, 'userid'  )
sPassword = dw_1.GetItemString(1, 'password')
gstr_userenv.pwd = sPassword


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
/*
SELECT USERNAME, USERID, GROUPID
  INTO :gstr_userenv.user_nm, :gstr_userenv.user_id, :gstr_userenv.grp
  FROM ADM_USER
 WHERE USERID = :sUserid
 USING SQLCA;
*/  

CHOOSE CASE SQLCA.SQLCode
		
	CASE 0
/*
	DECLARE SP7 &
					PROCEDURE FOR SP_LOGIN(:sUserid, :sPassword) using SQLCA;
									
					EXECUTE SP7;
	
					FETCH SP7 INTO :ls_result, :ls_result2, :gstr_userenv.user_dept, :ls_result3, :ls_result4, :ls_result5, :ls_result6, :ls_result7;
	
					CLOSE SP7;
	
        IF SQLCA.SQLCode = -1 THEN
            MessageBox("오류", SQLCA.SQLErrText)
            ROLLBACK USING SQLCA;
        END IF
*/		  
	    IF dw_1.Object.id_save[1] = '1' THEN
			SetProfileString("id.ini", "ID", "id", sUserid)
			SetProfileString("id.ini", "PW", "pw", sPassword)
	    END IF

		IF ls_result = 'Y'THEN  
		
			Open(w_mainmdi)

			Close(This)
			
			RETURN TRUE
			
		ELSEIF ls_result = 'T' THEN  
			
			Open(w_pw_chg_new)

			Close(This)
			
			RETURN TRUE
			
		ELSEIF ls_result = 'S' THEN  
			
			MESSAGEBOX("확인", "실패건수가 5회이상입니다. 관리자에게 문의해주세요.")
			
			RETURN FALSE
			
		ELSEIF ls_result = 'G' THEN  
			
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

on w_login_new.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_1}
end on

on w_login_new.destroy
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

type st_2 from statictext within w_login_new
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

event clicked;IF Messagebox("확인",  "ERPDB 접속하시겠습니까?", Question!, YesNo!, 1) = 2 THEN Return 

CONNECT USING EBSQL;

IF EBSQL.SQLCode = -1 THEN
	MessageBox("오류", EBSQL.SQLErrText)
	RETURN
END IF

MessageBox("성공", "ERPDB 접속 성공")


end event

type st_1 from statictext within w_login_new
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

event clicked;boolean lb_result

IF Messagebox("확인",  "ERPDB 등록하시겠습니까?", Question!, YesNo!, 1) = 2 THEN Return 

lb_result = gf_reg_erp()

if lb_result = true then
	messagebox("완료", "등록완료")
else
	messagebox("완료", "이미 등록된  PC입니다.")
end if


end event

type dw_1 from datawindow within w_login_new
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

