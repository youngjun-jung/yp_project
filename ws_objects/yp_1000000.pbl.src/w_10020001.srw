$PBExportHeader$w_10020001.srw
forward
global type w_10020001 from w_ancestor_05
end type
end forward

global type w_10020001 from w_ancestor_05
end type
global w_10020001 w_10020001

on w_10020001.create
call super::create
end on

on w_10020001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

sle_id.x = dw_1.x
sle_id.y = dw_1.y + dw_1.height + 60
end event

event open;call super::open;Date ld_today, ld_frdate
ld_today = Today()

ld_frdate = RelativeDate(ld_today, - 30)

dw_cdt.object.frdate[1] = String(ld_frdate, "yyyyMMdd")
dw_cdt.object.todate[1] = String(ld_today, "yyyyMMdd")

dw_cdt.object.frdate[1] = '20240101'
dw_cdt.object.todate[1] = '20241231'

end event

type dw_1 from w_ancestor_05`dw_1 within w_10020001
integer y = 756
integer height = 1640
string dataobject = "d_10020001"
end type

type sle_id from w_ancestor_05`sle_id within w_10020001
end type

type dw_cdt from w_ancestor_05`dw_cdt within w_10020001
integer height = 420
string dataobject = "d_10020001_cdt"
end type

type st_1 from w_ancestor_05`st_1 within w_10020001
end type

