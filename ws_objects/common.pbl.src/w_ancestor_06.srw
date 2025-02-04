$PBExportHeader$w_ancestor_06.srw
forward
global type w_ancestor_06 from w_ancestor
end type
type sle_id from singlelineedit within w_ancestor_06
end type
type dw_cdt from u_dw_cdt within w_ancestor_06
end type
type st_1 from statictext within w_ancestor_06
end type
end forward

global type w_ancestor_06 from w_ancestor
integer width = 6203
integer height = 2984
boolean border = false
sle_id sle_id
dw_cdt dw_cdt
st_1 st_1
end type
global w_ancestor_06 w_ancestor_06

on w_ancestor_06.create
int iCurrent
call super::create
this.sle_id=create sle_id
this.dw_cdt=create dw_cdt
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_id
this.Control[iCurrent+2]=this.dw_cdt
this.Control[iCurrent+3]=this.st_1
end on

on w_ancestor_06.destroy
call super::destroy
destroy(this.sle_id)
destroy(this.dw_cdt)
destroy(this.st_1)
end on

event open;call super::open;String ls_message
message lm_massage
lm_massage =  Message;
ls_message = lm_massage.stringparm

st_1.text = '■ ' + lm_massage.stringparm

//st_1.text = lm_massage.stringparm

gf_window_control('open', ClassName(), ls_message)

sle_id.text = ClassName()


end event

type sle_id from singlelineedit within w_ancestor_06
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

type dw_cdt from u_dw_cdt within w_ancestor_06
integer x = 215
integer y = 284
integer width = 5577
integer height = 156
integer taborder = 20
end type

type st_1 from statictext within w_ancestor_06
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

