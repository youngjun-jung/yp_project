$PBExportHeader$w_30030001_pop.srw
forward
global type w_30030001_pop from window
end type
type dw_1 from u_dw_cdt within w_30030001_pop
end type
type st_2 from statictext within w_30030001_pop
end type
type st_1 from statictext within w_30030001_pop
end type
type mle_1 from multilineedit within w_30030001_pop
end type
type cb_2 from commandbutton within w_30030001_pop
end type
type cb_1 from commandbutton within w_30030001_pop
end type
end forward

global type w_30030001_pop from window
integer width = 3127
integer height = 1360
boolean titlebar = true
string title = "데이터 백업"
boolean controlmenu = true
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
st_2 st_2
st_1 st_1
mle_1 mle_1
cb_2 cb_2
cb_1 cb_1
end type
global w_30030001_pop w_30030001_pop

forward prototypes
public function boolean wf_save_proc (string as_year, string as_comments)
end prototypes

public function boolean wf_save_proc (string as_year, string as_comments);String ls_body, ls_result, ls_error, ls_userid
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
String ls_year
JSONParser lnv_json

dw_1.accepttext()

ls_body = '{"year": "' + as_year + '", "comments": "' + as_comments + '", "procid": "' + gstr_userenv.user_id  + '"}'  

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/backup", 'POST', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN FALSE
		
DESTROY lnv_json

RETURN true
end function

on w_30030001_pop.create
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.mle_1=create mle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.st_2,&
this.st_1,&
this.mle_1,&
this.cb_2,&
this.cb_1}
end on

on w_30030001_pop.destroy
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;str_popup lstr_popup

lstr_popup = message.powerobjectparm

dw_1.object.toyear[1] = lstr_popup.rvalue[1]
end event

type dw_1 from u_dw_cdt within w_30030001_pop
integer x = 82
integer y = 184
integer width = 640
integer height = 140
integer taborder = 10
string dataobject = "d_30030001_pop_cdt"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dddw_retrieve;call super::ue_dddw_retrieve;Long i

CHOOSE CASE column
		
	CASE 'toyear'		

		FOR i = 1 TO 99
			dddw.InsertRow(i)
			dddw.SetItem(i, 1, String(2019 + i))
		NEXT
				
END CHOOSE
end event

type st_2 from statictext within w_30030001_pop
integer x = 87
integer y = 108
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "■ 백업 연도"
boolean focusrectangle = false
end type

type st_1 from statictext within w_30030001_pop
integer x = 91
integer y = 372
integer width = 402
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "■ 백업 내용"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_30030001_pop
integer x = 78
integer y = 452
integer width = 2898
integer height = 564
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 4000
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_30030001_pop
integer x = 2533
integer y = 1060
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(w_30030001_pop)
end event

type cb_1 from commandbutton within w_30030001_pop
integer x = 2057
integer y = 1060
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;boolean lb_return
string ls_year, ls_comments
integer li_response

dw_1.accepttext()

ls_year = dw_1.object.toyear[1]
ls_comments = mle_1.text

if Len(ls_comments) < 10 then
	messagebox("확인", "내용을 10자 이상 기재해주세요.")
	return
end if

li_response = MessageBox("확인", "백업자료를 저장하시겠습니까?", Question!, YesNo!)
	
IF li_response = 1 THEN

	lb_return = wf_save_proc(ls_year, ls_comments)
	
	if lb_return = true then
		closewithreturn(w_30030001_pop, '0000')
	else
		closewithreturn(w_30030001_pop, '9999')
	end if
	
END IF
end event

