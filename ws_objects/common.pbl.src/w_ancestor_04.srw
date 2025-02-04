$PBExportHeader$w_ancestor_04.srw
forward
global type w_ancestor_04 from w_ancestor
end type
type sle_id from singlelineedit within w_ancestor_04
end type
type dw_cdt from u_dw_cdt within w_ancestor_04
end type
type st_1 from statictext within w_ancestor_04
end type
type dw_2 from u_dw_grid within w_ancestor_04
end type
type dw_1 from u_dw_grid within w_ancestor_04
end type
end forward

global type w_ancestor_04 from w_ancestor
integer height = 2864
sle_id sle_id
dw_cdt dw_cdt
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global w_ancestor_04 w_ancestor_04

on w_ancestor_04.create
int iCurrent
call super::create
this.sle_id=create sle_id
this.dw_cdt=create dw_cdt
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_id
this.Control[iCurrent+2]=this.dw_cdt
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_1
end on

on w_ancestor_04.destroy
call super::destroy
destroy(this.sle_id)
destroy(this.dw_cdt)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;String ls_message
message lm_massage
lm_massage =  Message;
ls_message = lm_massage.stringparm

st_1.text = '■ ' + lm_massage.stringparm

gf_window_control('open', ClassName(), ls_message)

sle_id.text = ClassName()

end event

type sle_id from singlelineedit within w_ancestor_04
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

type dw_cdt from u_dw_cdt within w_ancestor_04
integer x = 215
integer y = 284
integer width = 5577
integer height = 156
integer taborder = 10
end type

event itemfocuschanged;call super::itemfocuschanged;gf_toggle(handle(dw_1), 'K')
end event

type st_1 from statictext within w_ancestor_04
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

type dw_2 from u_dw_grid within w_ancestor_04
integer x = 2633
integer y = 564
integer width = 2427
integer height = 1896
integer taborder = 20
boolean bringtotop = true
end type

type dw_1 from u_dw_grid within w_ancestor_04
integer x = 215
integer y = 564
integer width = 2418
integer height = 1892
integer taborder = 10
boolean bringtotop = true
end type

event doubleclicked;call super::doubleclicked;//IF row > 0 AND pb_new.Enabled THEN	
//	istr_new.Status = 'R'
//	istr_new.dw_new = This
//END IF
end event

