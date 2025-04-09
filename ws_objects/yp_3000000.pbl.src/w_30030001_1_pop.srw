$PBExportHeader$w_30030001_1_pop.srw
forward
global type w_30030001_1_pop from window
end type
type dw_1 from datawindow within w_30030001_1_pop
end type
type cb_2 from commandbutton within w_30030001_1_pop
end type
type cb_1 from commandbutton within w_30030001_1_pop
end type
end forward

global type w_30030001_1_pop from window
integer width = 832
integer height = 552
boolean titlebar = true
string title = "아연괴 생산량"
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_30030001_1_pop w_30030001_1_pop

on w_30030001_1_pop.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_30030001_1_pop.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;str_popup lstr_popup

lstr_popup = message.powerobjectparm

dw_1.object.zinccnt[1] = lstr_popup.lvalue[1]

end event

type dw_1 from datawindow within w_30030001_1_pop
integer x = 14
integer y = 16
integer width = 759
integer height = 252
integer taborder = 10
string title = "none"
string dataobject = "d_30030001_1_1_1"
boolean border = false
boolean livescroll = true
end type

event constructor;insertrow(1)
end event

type cb_2 from commandbutton within w_30030001_1_pop
integer x = 521
integer y = 304
integer width = 261
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

event clicked;close(w_30030001_1_pop)
end event

type cb_1 from commandbutton within w_30030001_1_pop
integer x = 233
integer y = 304
integer width = 274
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

event clicked;dw_1.accepttext()

closewithreturn(w_30030001_1_pop, string(dw_1.object.zinccnt[1]))
end event

