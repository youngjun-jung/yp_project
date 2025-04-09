$PBExportHeader$nvo_loading.sru
forward
global type nvo_loading from nonvisualobject
end type
end forward

global type nvo_loading from nonvisualobject
event ue_show_loading ( )
event ue_hide_loading ( )
end type
global nvo_loading nvo_loading

forward prototypes
public subroutine of_hide_loading ()
public subroutine of_show_loading ()
end prototypes

event ue_show_loading(); of_show_loading()
end event

event ue_hide_loading();of_hide_loading()
end event

public subroutine of_hide_loading ();If IsValid(w_process_popup) Then
	Close(w_process_popup) 
End If
end subroutine

public subroutine of_show_loading ();Open(w_process_popup)
end subroutine

on nvo_loading.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_loading.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

