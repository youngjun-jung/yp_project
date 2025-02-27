$PBExportHeader$w_test_popup.srw
forward
global type w_test_popup from window
end type
type am_1 from animation within w_test_popup
end type
end forward

global type w_test_popup from window
integer width = 814
integer height = 764
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
am_1 am_1
end type
global w_test_popup w_test_popup

on w_test_popup.create
this.am_1=create am_1
this.Control[]={this.am_1}
end on

on w_test_popup.destroy
destroy(this.am_1)
end on

event open;integer li_return
li_return = am_1.Play(0, -1, -1)

messagebox("li_return", li_return)
end event

type am_1 from animation within w_test_popup
integer x = 41
integer y = 24
integer width = 686
integer height = 600
integer taborder = 10
boolean originalsize = false
boolean border = true
string animationname = "C:\Users\jminz\Desktop\1723185765969.avi"
boolean autoplay = true
boolean transparent = true
end type

