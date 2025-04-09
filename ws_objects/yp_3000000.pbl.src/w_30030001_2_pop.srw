$PBExportHeader$w_30030001_2_pop.srw
forward
global type w_30030001_2_pop from window
end type
type dw_1 from datawindow within w_30030001_2_pop
end type
type cb_2 from commandbutton within w_30030001_2_pop
end type
type cb_1 from commandbutton within w_30030001_2_pop
end type
end forward

global type w_30030001_2_pop from window
integer width = 1463
integer height = 692
boolean titlebar = true
string title = "아연괴 프리미엄"
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_30030001_2_pop w_30030001_2_pop

on w_30030001_2_pop.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_30030001_2_pop.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;str_popup lstr_popup

lstr_popup = message.powerobjectparm

dw_1.object.in[1] = lstr_popup.lvalue[1]
dw_1.object.out[1] = lstr_popup.lvalue[2]
end event

type dw_1 from datawindow within w_30030001_2_pop
integer x = 14
integer y = 16
integer width = 1399
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_30030001_1_1_2"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_30030001_2_pop
integer x = 969
integer y = 444
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

event clicked;str_popup lstr_popup

lstr_popup.rvalue[1] = '9999'

closewithreturn(w_30030001_2_pop, lstr_popup)
end event

type cb_1 from commandbutton within w_30030001_2_pop
integer x = 494
integer y = 444
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

event clicked;str_popup lstr_popup

dw_1.accepttext()

lstr_popup.lvalue[1] = dw_1.object.in[1]
lstr_popup.lvalue[2] = dw_1.object.out[1]
lstr_popup.rvalue[1] = '0000'

closewithreturn(w_30030001_2_pop, lstr_popup)
end event

