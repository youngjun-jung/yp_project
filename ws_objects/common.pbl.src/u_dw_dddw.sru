$PBExportHeader$u_dw_dddw.sru
$PBExportComments$DataWindow - like dddw
forward
global type u_dw_dddw from datawindow
end type
end forward

global type u_dw_dddw from datawindow
integer width = 686
integer height = 400
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event keydown pbm_dwnkey
event mousemove pbm_dwnmousemove
event mouseleave ( )
end type
global u_dw_dddw u_dw_dddw

type variables
str_parameter istr_parameter

Constant ULong WM_MOUSEHOVER = 673
Constant ULong WM_MOUSELEAVE = 675
Constant Long  ROW_STRESS    = 15269887
Constant Long  ROW_MOUSEMOVE = 32894207
end variables

event keydown;CHOOSE CASE key
		
	CASE KeyEnter!
		
		Long   i, ll_row, ll_getrow
		String ls_target, ls_set_column[], ls_column, ls_get_column, ls_org_value, ls_new_value
		
		ll_getrow    = GetRow()
		ll_row       = istr_parameter.LongValue[1]
		ls_target    = istr_parameter.strValue [2]
		ls_column    = istr_parameter.strValue [3]
		ls_org_value = istr_parameter.strValue [4]
		
		IF gf_chk_null(ls_org_value) THEN ls_org_value = ''

		DO WHILE Pos(ls_target, '/') > 0
				
			i++
			
			ls_set_column[i] = Left(ls_target, Pos(ls_target, '/') - 1)
			ls_target        =  Mid(ls_target, Pos(ls_target, '/') + 1)
			
			IF ls_column = ls_set_column[i] THEN
				ls_new_value = GetItemString(ll_getrow, i)
			END IF
			
		LOOP
		
		IF NOT ls_org_value = ls_new_value THEN
			istr_parameter.DataWindow.Dynamic Event ue_dddw_itemchanged(ll_row, ls_column, ls_new_value)
		END IF
		
		FOR i = 1 TO UpperBound(ls_set_column)
			istr_parameter.DataWindow.SetItem(ll_row, ls_set_column[i], GetItemString(ll_getrow, i))
		NEXT

		istr_parameter.DataWindow.SetFocus()
		istr_parameter.DataWindow.SetColumn(ls_column)
		istr_parameter.DataWindow.SelectText(1, 100)

		RETURN 1
		
END CHOOSE
end event

event mousemove;Object.DataWindow.Detail.Color = "16777215~tif(Getrow() = " + String(row) + ", " + String(ROW_MOUSEMOVE) + ", " + &
														 "if(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215))"
end event

on u_dw_dddw.create
end on

on u_dw_dddw.destroy
end on

event constructor;Long   i, ll_rowcnt, ll_find, ll_colcnt, ll_width, ll_height, ll_xlimit, ll_ylimit
String ls_target, ls_column, ls_get_column

gs_dddw_cnt = 10

istr_parameter = Message.PowerObjectParm

DataObject = istr_parameter.strValue[1]

SetTransObject(SQLCA)

Object.DataWindow.Detail.Color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"

istr_parameter.DataWindow.Dynamic Event ue_dddw_retrieve(This, istr_parameter.LongValue[1], istr_parameter.strValue[3])

ls_target = istr_parameter.strValue[2]

DO WHILE Pos(ls_target, '/') > 0
		
	i++
	
	ls_get_column = Left(ls_target, Pos(ls_target, '/') - 1)
	ls_target     =  Mid(ls_target, Pos(ls_target, '/') + 1)
	
	IF istr_parameter.strValue[3] = ls_get_column THEN EXIT
	
LOOP

ll_rowcnt = RowCount()

ls_column = Describe("#" + String(i) + ".Name")

ll_find = Find(ls_column + " = '" + istr_parameter.strValue[4] + "'", 1, ll_rowcnt)

IF ll_find > 0 THEN
	SelectRow(0      , FALSE)
	SelectRow(ll_find, TRUE )
	ScrollToRow(ll_find)
ELSE
//	IF NOT gf_chk_null(istr_parameter.strValue[4]) THEN 
END IF

IF ll_rowcnt = 0 THEN
	
	istr_parameter.DataWindow.SetFocus()
	
ELSE
		
	ll_colcnt = Long(Object.DataWindow.Column.Count)
	
	FOR i = 1 TO ll_colcnt
		ll_width += Long(Describe("#" + String(i) + ".Width"))			
	NEXT
	
	IF ll_rowcnt > gs_dddw_cnt THEN
		ll_width  = ll_width + ll_colcnt * 14 + 77 + 8	//  8 : Lowered Size
		ll_height = 76 * gs_dddw_cnt + 4 + 16 							// 16 : Lowered Size
		VScrollBar = TRUE
	ELSE
		ll_width  = ll_width + ll_colcnt * 14 + 8
		ll_height = 76 * ll_rowcnt + 4 + 16
		VScrollBar = FALSE
	END IF
	
	ll_xlimit = w_mainmdi.mdi_1.Width
	ll_ylimit = w_mainmdi.mdi_1.Height
	
	IF (X + ll_width ) > ll_xlimit THEN X -= (X + ll_width ) - ll_xlimit
	IF (Y + ll_height) > ll_ylimit THEN Y -= (Y + ll_height) - ll_ylimit
	
	Resize(ll_width, ll_height)
	

	
END IF
end event

event losefocus;Hide()
end event

event clicked;IF row > 0 THEN
	
	SetRow(row)
	
	Event Keydown(KeyEnter!, 0)
	
	RETURN 1
	
END IF
end event

event other;IF Message.Number = WM_MOUSELEAVE THEN
	Event mouseleave()
END IF
end event

event rowfocuschanged;IF currentrow > 0 THEN
	SelectRow(0, FALSE)
	SelectRow(currentrow, TRUE)
END IF
end event

