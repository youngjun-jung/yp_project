$PBExportHeader$u_dw_freeform.sru
$PBExportComments$DataWindow Ancestor Freeform
forward
global type u_dw_freeform from datawindow
end type
end forward

global type u_dw_freeform from datawindow
string tag = "wh"
integer width = 4558
integer height = 600
string title = "none"
borderstyle borderstyle = stylelowered!
event keydown pbm_dwnkey
event mousemove pbm_dwnmousemove
event type long ue_popup_after ( string as_column,  string as_data,  long al_row )
event type boolean ue_validation ( long al_row )
event type boolean ue_delete_before ( long row )
event lbuttonup pbm_dwnlbuttonup
event mouseleave ( )
event ue_enter_after ( )
event ue_dddw_retrieve ( datawindow dddw,  long row,  string column )
event ue_dddw_itemchanged ( long row,  string column,  string data )
end type
global u_dw_freeform u_dw_freeform

type variables
Public:

str_popup istr_popup

String is_transaction

Private:

Constant Integer VK_TAB        = 9
Constant Integer WM_MOUSEWHEEL = 522
Constant Integer WM_MOUSELEAVE = 675
Constant Long    FOCUS_COLOR   = 33548754

Boolean ib_cancel
Boolean ib_color
Boolean ib_lbtn_clicking
String  is_start_column
String  is_end_column
String  is_orgdata
String  is_old_column
String  is_old_object
end variables

forward prototypes
public function long of_popup (boolean ab_f2press, string as_column, string as_tag, long al_pos, string as_data, long al_row)
public function window of_getwindow (dragobject adrg_object)
public subroutine of_excute (string as_object)
end prototypes

event keydown;Long   ll_pos
String ls_column, ls_tag

Window l_window

ls_column = GetColumnName()

CHOOSE CASE Key
		
	CASE KeyEnter!
		
		l_window = of_getwindow(This)
		
		AcceptText()
		
		IF ib_cancel THEN
			ib_cancel = FALSE
			RETURN 1
		END IF
		
		IF ls_column = is_end_column THEN
			Event ue_enter_after()
		ELSE
			Send(Handle(This), 256, 9, Long(0,0))
		END IF
		
		RETURN 1
		
	CASE KeyF2!
		
		ls_tag = Lower(Describe(ls_column + ".Tag"))
		ll_pos = Pos(ls_tag, '[')
		
		IF ll_pos > 0 THEN
			ll_pos = Pos(Left(ls_tag, ll_pos - 1), '<')
		ELSE
			ll_pos = Pos(ls_tag, '<')
		END IF
		
		of_popup(TRUE, ls_column, ls_tag, ll_pos, '', GetRow())
		
		IF ib_cancel THEN
			ib_cancel = FALSE
			RETURN 1
		END IF
		
//		IF ls_column = is_last THEN
//			Event ue_last_action()
//		ELSE
//			Send(Handle(This), 256, 9, Long(0,0))
//		END IF
		
		RETURN 1
		
	CASE KeyUpArrow!, KeyDownArrow!
		
		RETURN 1
		
END CHOOSE
end event

event mousemove;String ls_now_object, ls_old_picture, ls_now_picture

ls_now_object = dwo.Name

// 기존 활성화 오브젝트와 현재 활성화 오브젝트가 다른 경우

IF NOT is_old_object = ls_now_object THEN
	
	// 기존 활성화된 오브젝트가 존재하는 경우 초기화
	
	IF NOT gf_chk_null(is_old_object) THEN
		
		ls_old_picture = Describe(is_old_object + ".FileName")
		ls_old_picture = Reverse('fig.1' + Mid(Reverse(ls_old_picture), 6))
		
		Modify(is_old_object + ".FileName = '" + ls_old_picture + "'")
		
//		Modify(is_old_object + ".Border = 0")
		
	END IF
	
	// 버튼 클릭상태를 체크하여 현재 활성화된 오브젝트가 컬럼인 경우 MouseOver 효과
	
	IF ib_lbtn_clicking THEN
		
		is_old_object = ""
		
	ELSE
	
		IF dwo.Type = 'bitmap' THEN
			
			ls_now_picture = Describe(ls_now_object + ".FileName")
			ls_now_picture = Reverse('fig.2' + Mid(Reverse(ls_now_picture), 6))
			
			Modify(ls_now_object + ".FileName = '" + ls_now_picture + "'")
			
//			Modify(ls_now_object + ".Border = 6")
		
			is_old_object = ls_now_object
			
		ELSE
			
			is_old_object = ""
			
		END IF
		
	END IF
	
END IF


end event

event type boolean ue_validation(long al_row);RETURN TRUE
end event

event type boolean ue_delete_before(long row);RETURN TRUE
end event

event lbuttonup;String ls_now_object, ls_now_picture, ls_tag, ls_classify, ls_column, ls_value

IF NOT ib_lbtn_clicking THEN RETURN
	
ls_now_object = dwo.Name
ls_tag        = Lower(dwo.Tag )
ls_column     = Mid(ls_now_object, 3)

IF dwo.Type = 'bitmap' THEN

	ls_now_picture = Describe(ls_now_object + ".FileName")
	
	IF is_old_object = ls_now_object THEN
		ls_now_picture = Reverse('fig.2' + Mid(Reverse(ls_now_picture), 6))
	ELSE
		ls_now_picture = Reverse('fig.1' + Mid(Reverse(ls_now_picture), 6))
	END IF
	
	Modify(ls_now_object + ".FileName = '" + ls_now_picture + "'")
	
//	Modify(ls_now_object + ".Border = 6")
	
END IF

// Button Up Script

IF is_old_object = ls_now_object THEN
	
	Long   ll_xpos, ll_ypos
	String ls_rectangle
	
	Window      l_window	
	PowerObject	l_parentobject
	Tab			l_tab
	
	str_parameter lstr_parameter
	
	ls_rectangle = 'r' + Mid(ls_now_object, 2)
	l_window     = of_getwindow(This)
	
//	ll_xpos = PixelsToUnits(xpos, XPixelsToUnits!)
//	ll_ypos = PixelsToUnits(ypos, YPixelsToUnits!)

	ll_xpos = X
	ll_ypos = Y
	
	// Parent Object = Tab : Tab Size

	l_parentobject = GetParent()
	
	IF l_parentobject.Typeof() = UserObject! THEN
		
		l_parentobject = l_parentobject.GetParent()
		
		IF l_parentobject.Typeof() = Tab! THEN
			
			l_tab = l_parentobject
			
			ll_xpos = l_tab.X +  20 + X
			ll_ypos = l_tab.Y + 116 + Y
			
		END IF
		
	END IF
	
	ll_xpos += Long(Describe(ls_rectangle + ".X")) - Long(Describe("DataWindow.HorizontalScrollPosition"))
	ll_ypos += Long(Describe(ls_rectangle + ".Y")) + Long(Describe(ls_rectangle + ".Height")) &
																  - Long(Describe("DataWindow.VerticalScrollPosition"))

	AcceptText()
	
	lstr_parameter.DataWindow   = This
	lstr_parameter.LongValue[1] = row
	lstr_parameter.strValue [1] = Left(ls_tag, Pos(ls_tag, '/') - 1)
	lstr_parameter.strValue [2] =  Mid(ls_tag, Pos(ls_tag, '/') + 1)
	lstr_parameter.strValue [3] = ls_column
	lstr_parameter.strValue [4] = GetItemString(row, ls_column)
	
	CHOOSE CASE Left(lstr_parameter.strValue[1], 4)
			
		CASE 'cale'
	
			IF IsValid(u_monthcalendar) THEN
				l_window.CloseUserObject(u_monthcalendar)
			END IF
	
	//			u_monthcalendar.Move(ll_xpos, ll_ypos)
			
			l_window.OpenUserObjectWithParm(u_monthcalendar, lstr_parameter, ll_xpos, ll_ypos)
			
			u_monthcalendar.SetPosition(ToTop!)
			u_monthcalendar.Show()
			
			u_monthcalendar.Post SetFocus()
			
			String ls_date
			
			ls_date = String(lstr_parameter.strValue[4], '@@@@-@@-@@')
			
			IF IsDate(ls_date) THEN
				u_monthcalendar.SetSelectedDate(Date(ls_date))
			END IF
			
		CASE 'dddw'
	
			IF IsValid(u_dw_dddw) THEN
				l_window.CloseUserObject(u_dw_dddw)
			END IF
			
			l_window.OpenUserObjectWithParm(u_dw_dddw, lstr_parameter, ll_xpos, ll_ypos)
			
			u_dw_dddw.SetPosition(ToTop!)
			u_dw_dddw.Show()
			
			u_dw_dddw.Post SetFocus()	
			
	END CHOOSE
	
	//	lw_window.Dynamic Event ue_dwbtn_call(ls_classify, This, ls_column, ls_value, li_xinit, li_yinit)
	
END IF

ib_lbtn_clicking = FALSE
end event

event mouseleave();String ls_old_picture

IF NOT gf_chk_null(is_old_object) THEN
	
	ls_old_picture = Describe(is_old_object + ".FileName")
	ls_old_picture = Reverse('fig.1' + Mid(Reverse(ls_old_picture), 6))
	
	Modify(is_old_object + ".FileName = '" + ls_old_picture + "'")
	
//	Modify(is_old_object + ".Border = 0")
	
END IF
	
ib_lbtn_clicking = FALSE
is_old_object    = ""
end event

public function long of_popup (boolean ab_f2press, string as_column, string as_tag, long al_pos, string as_data, long al_row); Boolean lb_self
Datetime ldt_null
     Int li_ocolumn , li_column
    Long i, ll_start, ll_end   , ll_upper , ll_pos1  , ll_pos2
  String ls_coltype , ls_where , ls_colpos, ls_getcol, ls_value, ls_ovalue

IF al_pos > 0 THEN
	
	li_ocolumn = GetColumn()
	
	is_orgdata = GetItemString(al_row, as_column)
	
	// 조건절
	
	ll_pos1 = Pos(as_tag, '[')
	ll_pos2 = Pos(as_tag, ']')
	
	IF ll_pos1 > 0 THEN
		ls_where =  Mid(as_tag, ll_pos1 + 1, ll_pos2 - ll_pos1 - 1)
		as_tag   = Left(as_tag, ll_pos1 - 1)
	END IF
	
	ll_pos1 = Pos(ls_where, '{')
	ll_pos2 = Pos(ls_where, '}')
	
	DO WHILE ll_pos1 > 0
		
		ls_getcol  = Mid(ls_where, ll_pos1 + 1, ll_pos2 - ll_pos1 - 1)
		ls_coltype = Lower(Describe(ls_getcol + ".ColType"))
			
		IF Pos(ls_coltype, 'char') > 0 THEN
			ls_value = "'" + GetItemString(al_row, ls_getcol) + "'"
		ELSEIF Pos(ls_coltype, 'date') > 0 THEN
			ls_value = String(GetItemDate(al_row, ls_getcol), 'yyyymmdd')
		ELSEIF Pos(ls_coltype, 'datetime') > 0 THEN
			ls_value = String(GetItemDatetime(al_row, ls_getcol))
		ELSE
			ls_value = String(GetItemDecimal(al_row, ls_getcol))
		END IF
		
		ls_where = Replace(ls_where, ll_pos1, ll_pos2 - ll_pos1 + 1, ls_value)
		
		ll_pos1 = Pos(ls_where, '{', ll_pos2)
		ll_pos2 = Pos(ls_where, '}', ll_pos2)
		
	LOOP
	
	// 테이블명칭
	
	ll_pos1 = Pos(as_tag, '<')
	ll_pos2 = Pos(as_tag, '>')
	
	IF ll_pos1 > 0 THEN
		
		as_tag = Mid(as_tag, ll_pos1 + 1, ll_pos2 - ll_pos1 - 1)
		
		IF Lower(Left(as_tag, 2)) = 'w_' THEN
			lb_self = TRUE
			as_tag = Mid(as_tag, 3)
		ELSE
			lb_self = FALSE
		END IF
		
	END IF
	
	// 컬럼위치
	
	ll_pos1 = Pos(as_tag, '(')
	ll_pos2 = Pos(as_tag, ')')
	
	IF ll_pos1 > 0 THEN
		ls_colpos =  Mid(as_tag, ll_pos1 + 1, ll_pos2 - ll_pos1 - 1)
		as_tag    = Left(as_tag, ll_pos1 - 1)
	END IF
	
	IF Len(ls_colpos) > 0 THEN
		ll_start = Long(Left(ls_colpos, Pos(ls_colpos, ',') - 1))
		ll_end   = Long( Mid(ls_colpos, Pos(ls_colpos, ',') + 1))
	ELSE
		ll_start = 0
		ll_end   = 1
	END IF
	
	istr_popup.table = as_tag
	istr_popup.where = ls_where
	istr_popup.data  = as_data
	
	IF NOT ab_f2press THEN
		
		// 값 초기화
	
		FOR i = 1 TO (ll_end - ll_start + 1)
			
			li_column = li_ocolumn + i - 1 + ll_start
			
			ls_coltype = Lower(Describe("#" + String(li_column) + ".ColType"))
			
			IF li_column = li_ocolumn THEN CONTINUE

			IF Pos(ls_coltype, 'char') > 0 THEN
				SetItem(al_row, li_column, '')
			ELSEIF Pos(ls_coltype, 'date') > 0 OR Pos(ls_coltype, 'time') > 0 THEN
				SetItem(al_row, li_column, ldt_null)
			ELSE
				SetItem(al_row, li_column, 0)
			END IF
			
		NEXT
		
		IF gf_chk_null(as_data) THEN
			Event ue_popup_after(as_column, Trim(as_data), al_row)
			RETURN 0
		END IF
		
	END IF
	
	IF lb_self THEN
		OpenWithParm(w_popup, istr_popup, 'w_' + as_tag + '_popup')
	ELSE
		OpenWithParm(w_popup, istr_popup)
	END IF
	
	IF NOT IsValid(Message.PowerObjectParm) THEN
		ib_cancel = TRUE
		SetFocus()
		SelectText(1, 100)
		RETURN 1
	END IF
	
	istr_popup = Message.PowerObjectParm
	
	ll_upper = UpperBound(istr_popup.rvalue)
	
	FOR i = 1 TO (ll_end - ll_start + 1)
		
		li_column = li_ocolumn + i - 1 + ll_start

		ls_coltype = Lower(Describe("#" + String(li_column) + ".ColType"))
		
		IF li_column = li_ocolumn THEN ls_ovalue = istr_popup.rvalue[i]
		
		IF Pos(ls_coltype, 'char') > 0 THEN
			SetItem(al_row, li_column, istr_popup.rvalue[i])
		ELSEIF Pos(ls_coltype, 'date') > 0 OR Pos(ls_coltype, 'time') > 0 THEN
			SetItem(al_row, li_column, Datetime(istr_popup.rvalue[i]))
		ELSE
			SetItem(al_row, li_column, Dec(istr_popup.rvalue[i]))
		END IF
		
	NEXT
	
	Event ue_popup_after(as_column, ls_ovalue, al_row)
	
	RETURN 2

END IF

RETURN 0
end function

public function window of_getwindow (dragobject adrg_object);PowerObject	lpo_parent
Window      lw_window

lpo_parent = adrg_object.GetParent()

DO WHILE lpo_parent.TypeOf() <> Window! AND IsValid(lpo_parent)
	lpo_parent = lpo_parent.GetParent()
LOOP

IF IsValid (lpo_parent) THEN
	lw_window = lpo_parent
ELSE
	SetNull(lw_window)
END IF

RETURN lw_window

end function

public subroutine of_excute (string as_object);Integer li_xpos, li_ypos
String  ls_column

Window lw_window

ls_column = Mid(as_object, 3)
lw_window = of_getwindow(This)

li_xpos = Integer(Describe(as_object + ".X"))
li_ypos = Integer(Describe(as_object + ".Y"))

lw_window.Dynamic Event ue_calendar(This.PointerX(), This.PointerY())

//String ls_value, ls_class
//
//Window lw_sheet
//
//ls_value = GetItemString(1, as_object)
//ls_class = Parent.ClassName()
//
//IF Left(ls_class, 2) = 'w_' AND Right(ls_class, 4) = '_new' THEN
//	lw_sheet = Parent
//ELSE
//	lw_sheet = w_mainmdi.GetActiveSheet()
//END IF
//
//IF NOT IsValid(lw_sheet) THEN RETURN
//
//CHOOSE CASE TRUE
//		
//	CASE Pos(ls_value, 'top') > 0
//		
//		lw_sheet.Dynamic Event ue_top()
//		
//	CASE Pos(ls_value, 'prior') > 0
//		
//		lw_sheet.Dynamic Event ue_prior()
//		
//	CASE Pos(ls_value, 'next') > 0
//		
//		lw_sheet.Dynamic Event ue_next()
//		
//	CASE Pos(ls_value, 'bottom') > 0
//		
//		lw_sheet.Dynamic Event ue_bottom()
//		
//	CASE Pos(ls_value, 'retrieve') > 0
//		
//		lw_sheet.Dynamic Event ue_retrieve()
//		
//	CASE Pos(ls_value, 'new') > 0
//		
//		lw_sheet.Dynamic Event ue_new()
//		
//	CASE Pos(ls_value, 'save') > 0
//		
//		lw_sheet.Dynamic Event ue_save()
//		
//	CASE Pos(ls_value, 'delete') > 0
//		
//		lw_sheet.Dynamic Event ue_delete()
//		
//	CASE Pos(ls_value, 'preview') > 0
//		
//		lw_sheet.Dynamic Event ue_preview()
//		
//	CASE Pos(ls_value, 'print') > 0
//		
//		lw_sheet.Dynamic Event ue_print()
//		
//	CASE Pos(ls_value, 'excel') > 0
//		
//		lw_sheet.Dynamic Event ue_excel()
//		
//	CASE Pos(ls_value, 'close') > 0
//		
//		Close(lw_sheet)
//		
//END CHOOSE
end subroutine

event constructor;Long   i, ll_colcnt, ll_taborder, ll_order1, ll_order2

CHOOSE CASE is_transaction
		
	CASE 'SQLCA'
		
		SetTransObject(SQLCA)
		
	CASE 'TRHPC'
		
		SetTransObject(TRHPC)
		
END CHOOSE

ll_order1 = 10
ll_colcnt = Long(Describe("DataWindow.Column.Count"))

FOR i = 1 TO ll_colcnt
	
	ll_taborder = Long(Describe("#" + String(i) + ".TabSequence"))
	
	IF ll_taborder = 0 THEN CONTINUE
	
	ll_order1 = Min(ll_order1, ll_taborder)
	ll_order2 = Max(ll_order2, ll_taborder)
	
	IF ll_taborder = ll_order1 THEN is_start_column = Describe("#" + String(i) + ".Name")
	IF ll_taborder = ll_order2 THEN is_end_column   = Describe("#" + String(i) + ".Name")
	
NEXT
end event

on u_dw_freeform.create
end on

on u_dw_freeform.destroy
end on

event itemerror;RETURN 1
end event

event retrievestart;Reset()
end event

event itemfocuschanged;String ls_tag, ls_flag, ls_column

IF row > 0 THEN
	
	SetRedraw(FALSE)
	
	ls_column = dwo.Name
	ls_tag    = Lower(dwo.Tag)
	ls_flag   = Left(ls_tag, 1)
	
	IF ib_color THEN

		IF NOT gf_chk_null(is_old_column) THEN
			Modify("r_" + is_old_column + ".Brush.Color      = 16777215~t" + &
							  is_old_column + ".BackGround.Color = 16777215")
		END IF
		
		Modify("r_" + ls_column + ".Brush.Color      = " + String(FOCUS_COLOR) + "~t" + &
						  ls_column + ".BackGround.Color = " + String(FOCUS_COLOR))
		
		is_old_column = ls_column
		
	END IF
	
	IF Upper(ls_flag) = 'K' THEN			
		gf_toggle(Handle(This), 'K')
	ELSE
		gf_toggle(Handle(This), 'E')
	END IF
	
	SelectText(1, 100)
	
	SetRedraw(TRUE)
	
//	IF Describe(dwo.name + ".Edit.Style") = 'editmask' THEN SelectText(1, 100)

END IF
end event

event itemchanged;  Long ll_pos
String ls_column, ls_tag, ls_data

IF NOT GetFocus() = This AND NOT gf_chk_null(data) THEN RETURN

ls_column = dwo.Name
ls_tag    = Lower(dwo.Tag)
ls_data   = Trim(data)
ll_pos    = Pos(ls_tag, '[')

IF ll_pos > 0 THEN
	ll_pos = Pos(Left(ls_tag, ll_pos - 1), '<')
ELSE
	ll_pos = Pos(ls_tag, '<')
END IF

RETURN of_popup(FALSE, ls_column, ls_tag, ll_pos, ls_data, row)
end event

event other;CHOOSE CASE Message.Number
		
	CASE WM_MOUSEWHEEL
		
		RETURN 1
		
	CASE WM_MOUSELEAVE
		
		Event MouseLeave()
		
END CHOOSE
end event

event dberror;//CHOOSE CASE sqldbcode
//		
//	CASE 2627
//		
//		MessageBox("중복오류", sqlerrtext + "~r~n~r~n중복된 코드가 존재합니다.")
//		
//		ScrollToRow(row)
//		
//		SetFocus()
//		
//	CASE ELSE
//		
//		MessageBox("데이터윈도우(" + ClassName(This) + ") 오류-" + String(sqldbcode), sqlerrtext)
//		
//		ScrollToRow(row)
//		
//		SetFocus()
//		
//END CHOOSE

MessageBox("데이터윈도우(" + ClassName(This) + ") 오류-" + String(sqldbcode), sqlerrtext)
ScrollToRow(row)
SetFocus()

RETURN 2
end event

event clicked;String ls_now_object, ls_now_picture

IF dwo.Type = 'bitmap' THEN
	
	ls_now_object = dwo.Name
	
	ls_now_picture = Describe(ls_now_object + ".FileName")
	ls_now_picture = Reverse('fig.3' + Mid(Reverse(ls_now_picture), 6))
	
	Modify(ls_now_object + ".FileName = '" + ls_now_picture + "'")

//	SetColumn(Mid(ls_now_object, 3))
	
	ib_lbtn_clicking = TRUE
	
END IF
end event

event updateend;IF rowsinserted > 0 THEN	
	gf_microhelp('status', "자료가 저장되었습니다.")
ELSEIF rowsupdated > 0 THEN
	gf_microhelp('status', "자료가 수정되었습니다.")
ELSEIF rowsdeleted > 0 THEN
	gf_microhelp('status', "자료가 삭제되었습니다.")
END IF

SetFocus()
end event

