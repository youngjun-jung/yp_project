$PBExportHeader$w_process_popup.srw
forward
global type w_process_popup from window
end type
type p_1 from picture within w_process_popup
end type
end forward

global type w_process_popup from window
integer width = 2107
integer height = 1240
boolean border = false
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
windowanimationstyle openanimation = rightroll!
integer animationtime = 50
p_1 p_1
end type
global w_process_popup w_process_popup

forward prototypes

end prototypes

on w_process_popup.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_process_popup.destroy
destroy(this.p_1)
end on

type p_1 from picture within w_process_popup
integer width = 2107
integer height = 1244
boolean enabled = false
boolean originalsize = true
string picturename = "D:\ypzinc\workspace-pb\yp_project\res\Loading.gif"
boolean focusrectangle = false
end type

