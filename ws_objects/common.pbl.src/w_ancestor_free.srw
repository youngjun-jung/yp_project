$PBExportHeader$w_ancestor_free.srw
forward
global type w_ancestor_free from w_ancestor
end type
type st_1 from statictext within w_ancestor_free
end type
type sle_id from singlelineedit within w_ancestor_free
end type
end forward

global type w_ancestor_free from w_ancestor
st_1 st_1
sle_id sle_id
end type
global w_ancestor_free w_ancestor_free

on w_ancestor_free.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_id=create sle_id
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_id
end on

on w_ancestor_free.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_id)
end on

event open;call super::open;String ls_message
message lm_massage
lm_massage =  Message;
ls_message = lm_massage.stringparm

st_1.text = '■ ' + lm_massage.stringparm

gf_window_control('open', ClassName(), ls_message)

sle_id.text = ClassName()

end event

type st_1 from statictext within w_ancestor_free
integer x = 206
integer y = 124
integer width = 1088
integer height = 108
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 553648127
long bordercolor = 8388608
boolean focusrectangle = false
end type

type sle_id from singlelineedit within w_ancestor_free
integer x = 224
integer y = 2584
integer width = 576
integer height = 76
integer taborder = 10
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

