$PBExportHeader$w_ancestor_02.srw
forward
global type w_ancestor_02 from w_ancestor
end type
type sle_id from singlelineedit within w_ancestor_02
end type
type cb_2 from commandbutton within w_ancestor_02
end type
end forward

global type w_ancestor_02 from w_ancestor
integer width = 6185
integer height = 2856
sle_id sle_id
cb_2 cb_2
end type
global w_ancestor_02 w_ancestor_02

on w_ancestor_02.create
int iCurrent
call super::create
this.sle_id=create sle_id
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_id
this.Control[iCurrent+2]=this.cb_2
end on

on w_ancestor_02.destroy
call super::destroy
destroy(this.sle_id)
destroy(this.cb_2)
end on

event open;call super::open;String ls_message
message lm_massage
lm_massage =  Message;
ls_message = lm_massage.stringparm

//st_1.text = '□ ' + lm_massage.stringparm

gf_window_control('open', ClassName(), ls_message)

sle_id.text = ClassName()
end event

event resize;call super::resize;wf_resize()

end event

type sle_id from singlelineedit within w_ancestor_02
integer x = 224
integer y = 2584
integer width = 576
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 1073741824
long backcolor = 553648127
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_ancestor_02
integer x = 5413
integer y = 120
integer width = 379
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

