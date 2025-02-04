$PBExportHeader$uo_wait_box.sru
forward
global type uo_wait_box from nonvisualobject
end type
end forward

global type uo_wait_box from nonvisualobject
end type
global uo_wait_box uo_wait_box

type prototypes
subroutine OpenWait(int nRadius, ulong clr,ulong clrBack, boolean bShowSecond, readonly string szTitle, int nMargin, long nReserve) system library "PbIdea.dll" alias for "OpenWait"
subroutine CloseWait() system library "PbIdea.dll" alias for "CloseWait"
subroutine SetWaitPos(int x ,int y) system library "PbIdea.dll" alias for "SetWaitPos"
function boolean GetWaitPos(ref int x ,ref int y,ref int w,ref int h) system library "PbIdea.dll" alias for "GetWaitPos"

end prototypes

type variables
//en:Multi thread based wait box
end variables

on uo_wait_box.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_wait_box.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;CloseWait()
end event

