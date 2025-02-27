$PBExportHeader$w_ancestor_08.srw
forward
global type w_ancestor_08 from w_ancestor
end type
type sle_id from singlelineedit within w_ancestor_08
end type
type tab_1 from tab within w_ancestor_08
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tab_1 from tab within w_ancestor_08
tabpage_1 tabpage_1
end type
type dw_cdt from u_dw_cdt within w_ancestor_08
end type
type st_1 from statictext within w_ancestor_08
end type
end forward

global type w_ancestor_08 from w_ancestor
sle_id sle_id
tab_1 tab_1
dw_cdt dw_cdt
st_1 st_1
end type
global w_ancestor_08 w_ancestor_08

on w_ancestor_08.create
int iCurrent
call super::create
this.sle_id=create sle_id
this.tab_1=create tab_1
this.dw_cdt=create dw_cdt
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_id
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_cdt
this.Control[iCurrent+4]=this.st_1
end on

on w_ancestor_08.destroy
call super::destroy
destroy(this.sle_id)
destroy(this.tab_1)
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

type sle_id from singlelineedit within w_ancestor_08
integer x = 224
integer y = 2584
integer width = 576
integer height = 76
integer taborder = 30
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

type tab_1 from tab within w_ancestor_08
integer x = 215
integer y = 496
integer width = 5563
integer height = 1992
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5527
integer height = 1876
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
end type

type dw_cdt from u_dw_cdt within w_ancestor_08
integer x = 215
integer y = 284
integer width = 5577
integer height = 156
integer taborder = 10
end type

event itemfocuschanged;call super::itemfocuschanged;//gf_toggle(handle(dw_1), 'K')
end event

type st_1 from statictext within w_ancestor_08
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

