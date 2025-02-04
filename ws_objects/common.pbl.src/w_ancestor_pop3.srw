$PBExportHeader$w_ancestor_pop3.srw
forward
global type w_ancestor_pop3 from window
end type
type dw_1 from u_dw_freeform within w_ancestor_pop3
end type
type st_id from statictext within w_ancestor_pop3
end type
type cb_2 from commandbutton within w_ancestor_pop3
end type
type st_1 from statictext within w_ancestor_pop3
end type
end forward

global type w_ancestor_pop3 from window
integer width = 2363
integer height = 2408
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
string icon = "AppIcon!"
boolean center = true
event ue_open pbm_open
event type boolean ue_retrieve ( )
dw_1 dw_1
st_id st_id
cb_2 cb_2
st_1 st_1
end type
global w_ancestor_pop3 w_ancestor_pop3

type variables
Public:

Datetime id_sysdate
String   ls_message


Private:



end variables

on w_ancestor_pop3.create
this.dw_1=create dw_1
this.st_id=create st_id
this.cb_2=create cb_2
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_id,&
this.cb_2,&
this.st_1}
end on

on w_ancestor_pop3.destroy
destroy(this.dw_1)
destroy(this.st_id)
destroy(this.cb_2)
destroy(this.st_1)
end on

event open;event ue_open()

end event

event close;close(this)
end event

type dw_1 from u_dw_freeform within w_ancestor_pop3
integer x = 215
integer y = 296
integer width = 1874
integer height = 1724
integer taborder = 40
end type

event constructor;call super::constructor;insertrow(1)
end event

type st_id from statictext within w_ancestor_pop3
integer x = 215
integer y = 2172
integer width = 192
integer height = 88
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

event clicked;messagebox("화면번호", parent.ClassName())
end event

type cb_2 from commandbutton within w_ancestor_pop3
integer x = 3502
integer y = 2076
integer width = 270
integer height = 108
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;Close(parent)

end event

type st_1 from statictext within w_ancestor_pop3
integer x = 206
integer y = 124
integer width = 1088
integer height = 108
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217856
long backcolor = 553648127
string text = "□ "
long bordercolor = 8388608
boolean focusrectangle = false
end type

