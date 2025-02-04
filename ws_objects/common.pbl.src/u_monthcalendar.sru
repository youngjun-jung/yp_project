$PBExportHeader$u_monthcalendar.sru
$PBExportComments$Calendar
forward
global type u_monthcalendar from monthcalendar
end type
end forward

global type u_monthcalendar from monthcalendar
integer width = 1006
integer height = 760
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type
global u_monthcalendar u_monthcalendar

type variables
str_parameter istr_parameter
end variables

on u_monthcalendar.create
end on

on u_monthcalendar.destroy
end on

event constructor;istr_parameter = Message.PowerObjectParm
end event

event losefocus;Hide()
end event

event dateselected;Date   ld_date
Long   ll_row
String ls_column, ls_org_value, ls_new_value

GetSelectedDate(ld_date)

ll_row       = istr_parameter.LongValue[1]
ls_column    = istr_parameter.strValue [3]
ls_org_value = istr_parameter.strValue [4]
ls_new_value = String(ld_date, 'YYYYMMDD')

IF NOT ls_org_value = ls_new_value THEN
	istr_parameter.DataWindow.Dynamic Event ue_dddw_itemchanged(ll_row, ls_column, ls_new_value)
END IF

istr_parameter.DataWindow.SetItem(ll_row, ls_column, ls_new_value)
istr_parameter.DataWindow.SetFocus()
istr_parameter.DataWindow.SetColumn(ls_column)
istr_parameter.DataWindow.SelectText(1, 100)
end event

