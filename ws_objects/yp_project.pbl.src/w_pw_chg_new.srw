$PBExportHeader$w_pw_chg_new.srw
forward
global type w_pw_chg_new from window
end type
type dw_1 from datawindow within w_pw_chg_new
end type
type r_1 from rectangle within w_pw_chg_new
end type
end forward

global type w_pw_chg_new from window
integer width = 2738
integer height = 3280
boolean titlebar = true
string title = "패스워드변경"
boolean controlmenu = true
string icon = "C:\Users\jun\Desktop\pb_source\법인카드\res\credit.ico"
boolean center = true
dw_1 dw_1
r_1 r_1
end type
global w_pw_chg_new w_pw_chg_new

type variables
Boolean ib_resize
String  is_old_object

String is_title
String is_window

end variables

forward prototypes
public subroutine wf_chk ()
end prototypes

public subroutine wf_chk ();String ls_n_pw, ls_b_pw, ls_a_pw, ls_result, ls_return_msg

dw_1.accepttext()

ls_n_pw = dw_1.object.n_pw[1]
ls_b_pw = dw_1.object.b_pw[1]
ls_a_pw = dw_1.object.a_pw[1]

if isnull(ls_n_pw) then
	messagebox("확인", "현재 비밀번호를 입력해주세요.")
	return
end if

if ls_n_pw <>  gstr_userenv.pwd then
	messagebox("확인", "현재 비밀번호가 틀립니다.")
	return
end if

if isnull(ls_b_pw) or isnull(ls_a_pw) then
	messagebox("확인", "신규 비밀번호를 입력해주세요.")
	return
else
	if ls_a_pw <>  ls_b_pw then
		messagebox("확인", "신규비밀번호가 일치하지 않습니다.")
		return
	end if
end if

if ls_n_pw =  ls_b_pw then
	messagebox("확인", "현재비밀번호와 신규비밀번호가 같습니다.")
	return
end if
/*
DECLARE SP1 &
			PROCEDURE FOR SP_PASSWORD_CHECK_KDS_CS('7', :ls_b_pw, :gstr_userenv.user_id, '', '', '') using SQLCA;
							
			EXECUTE SP1;

			FETCH SP1 INTO :ls_result, :ls_return_msg;

			CLOSE SP1;

IF ls_result <> '0' THEN
	MESSAGEBOX("실패", ls_return_msg + '(' + ls_result + ')')			
	RETURN
END IF;

DECLARE SP7 &
			PROCEDURE FOR SP_LOGIN_CHG(:gstr_userenv.user_id, :ls_b_pw) using SQLCA;
							
			EXECUTE SP7;

			FETCH SP7 INTO :ls_result;

			CLOSE SP7;
*/
if ls_result = 'Y' then
	messagebox("확인", "비밀변경이 완료되었습니다.")
	
	open(w_mainmdi)

	close(w_pw_chg_new)	
	
elseif ls_result = 'S' then
	
	messagebox("확인", "신규암호체계 오류")
	
else
	
	messagebox("확인", "암호변경에 실패하였습니다.[관리자문의요망]")
	
end if
	


end subroutine

on w_pw_chg_new.create
this.dw_1=create dw_1
this.r_1=create r_1
this.Control[]={this.dw_1,&
this.r_1}
end on

on w_pw_chg_new.destroy
destroy(this.dw_1)
destroy(this.r_1)
end on

type dw_1 from datawindow within w_pw_chg_new
event keydown pbm_dwnkey
integer width = 7214
integer height = 3340
integer taborder = 10
string title = "none"
string dataobject = "d_pw_chg_new"
boolean border = false
boolean livescroll = true
end type

event keydown;String sColumn

CHOOSE CASE Key
		
	CASE KeyEnter!
		
		AcceptText()
		
		wf_chk()
		
		RETURN 1
		
END CHOOSE
end event

event clicked;
dw_1.accepttext()

CHOOSE CASE dwo.Name
		
	CASE 't_1'
		/*
		if len(gstr_userenv.pwd) < 8 then
			messagebox("확인", "8자리 미만 암호는 사용할수 없습니다.")
			return
		end if
		
		SQLCA.SP_LOGIN_CHG_NEXT(gstr_userenv.user_id)
			*/
		open(w_mainmdi)
		
		close(w_pw_chg_new)
		
	CASE 'r_3'
		
		wf_chk()
	
END CHOOSE


end event

event constructor;insertrow(1)
end event

type r_1 from rectangle within w_pw_chg_new
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 549
integer y = 1908
integer width = 329
integer height = 176
end type

