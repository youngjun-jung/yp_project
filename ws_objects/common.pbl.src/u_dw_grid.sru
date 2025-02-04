$PBExportHeader$u_dw_grid.sru
$PBExportComments$DataWindow Ancestor Grid
forward
global type u_dw_grid from datawindow
end type
end forward

global type u_dw_grid from datawindow
string tag = "wh"
integer width = 4649
integer height = 3144
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event keydown pbm_dwnkey
event mousemove pbm_dwnmousemove
event type long ue_popup_after ( string as_column,  string as_data,  long al_row )
event type boolean ue_validation ( long al_row )
event mouseleave ( )
event lbuttonup pbm_dwnlbuttonup
event ue_enter_after ( )
event ue_dddw_retrieve ( datawindow dddw,  long row,  string column )
event ue_dddw_itemchanged ( long row,  string column,  string data )
end type
global u_dw_grid u_dw_grid

type variables
Public:

Boolean ib_selectrow						// Select Row
Boolean ib_extendrow						// Select Multirow
Boolean ib_sort          = TRUE		// Sort
Boolean ib_row_stress	 = TRUE		// Row Stress
Boolean ib_row_mousemove = TRUE		// Row MouseMove
Boolean ib_new_last		 = TRUE		// Last Row Insert
Boolean ib_msg_retrieve  = TRUE		// Retrieve Message
Boolean ib_msg_update	 = TRUE		// Insert, Update, Delete Message
String  is_transaction	 = 'SQLCA'  // Transaction

str_popup 			 istr_popup				// Popup Structure
n_svc_dw_gridstyle isrv_gridstyle		// Sort Service
n_svc_dw_selectrow isrv_select			// Select Service

Private:

Boolean ib_lbtn_clicking		// Button Clicking
Boolean ib_cancel					// Popup Cancel
String  is_start_column			// First Column
String  is_end_column			// Last Column
String  is_column[]  			// All Column
String  is_old_object
String  is_detail_org_color, is_detail_color			// Original Detail Band Color

Constant ULong WM_MOUSEHOVER = 673
Constant ULong WM_MOUSELEAVE = 675
Constant Long  ROW_STRESS    = 15269887
Constant Long  ROW_MOUSEMOVE = 16775408

// Set DataWindow Color

Constant Long DATAWINDOW_COLOR = 16777215
//Constant Long HEADER_COLOR     = 32768
Constant Long HEADER_COLOR     = RGB(229,242,243)
Constant Long DETAIL_COLOR     = 16777215
//Constant Long SUMMARY_COLOR    = 31185883
Constant Long SUMMARY_COLOR    = RGB(229,242,243)
Constant Long HEADER1_COLOR    = 32041192
Constant Long HEADER2_COLOR    = 32764915
end variables

forward prototypes
public function long of_popup (boolean ab_f2press, string as_column, string as_tag, long al_pos, string as_data, long al_row)
public function boolean of_startservice (string as_servicename)
public function window of_getwindow (dragobject adrg_object)
public subroutine of_excute (string as_column, long al_row, string as_tag)
end prototypes

event keydown;  Long ll_pos
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
			IF ib_new_last THEN
				IF GetRow() = RowCount() THEN
					Event ue_enter_after()
					RETURN 1
				END IF
			ELSE
				Event ue_enter_after()
				RETURN 1
			END IF
		END IF
			
		Send(Handle(This), 256, 9, Long(0,0))
		
		RETURN 1
		
	CASE KeyF2!
		
		AcceptText()
		
		ls_tag = Lower(Describe(ls_column + ".Tag"))

		CHOOSE CASE TRUE
				
			CASE Pos(ls_tag, '#popup') > 0
		
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
				
			CASE Pos(ls_tag, '#dddw') > 0
				
				ls_tag = Describe("cp_" + ls_column + ".Tag")
				
				of_excute(ls_column, GetRow(), ls_tag)
				
			CASE Pos(ls_tag, '#calendar') > 0
				
				ls_tag = Describe("cp_" + ls_column + ".Tag")
				
				of_excute(ls_column, GetRow(), ls_tag)				
				
		END CHOOSE
		
		RETURN 1
		
END CHOOSE
end event

event mousemove;// Highlight header effects
//IF IsValid(isrv_gridstyle) THEN
//	isrv_gridstyle.Event MouseMove(xpos, ypos, row, dwo)
//END IF

Long ll_pos1, ll_pos2

IF ib_row_mousemove THEN

	ll_pos1 = Pos(is_detail_org_color, '~t')
	ll_pos2 = Pos(is_detail_org_color, '16777215)')
/*	
	IF ll_pos1 > 0 AND ll_pos2 > 0 THEN
		
		IF ib_row_stress THEN
			Object.DataWindow.Detail.Color = Replace(is_detail_org_color, ll_pos2, 9, "if(Getrow() = " + String(row) + ", " + String(ROW_MOUSEMOVE) + ", if(Mod(Getrow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)))")
		ELSE
			Object.DataWindow.Detail.Color = Replace(is_detail_org_color, ll_pos2, 9, "if(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215))")
		END IF
		
	ELSE
		
		IF ib_row_stress THEN
			Object.DataWindow.Detail.Color = "16777215~tif(Getrow() = " + String(row) + ", " + String(ROW_MOUSEMOVE) + ", " + &
																	 "if(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215))"
		ELSE
			Object.DataWindow.Detail.Color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"
		END IF
		
	END IF
*/	
END IF

String ls_now_object, ls_old_picture, ls_now_picture

ls_now_object = dwo.Name

// 기존 활성화 오브젝트와 현재 활성화 오브젝트가 다른 경우

IF NOT is_old_object = ls_now_object THEN
	
	// 기존 활성화된 오브젝트가 존재하는 경우 초기화
	
	IF NOT gf_chk_null(is_old_object) THEN
		
		ls_old_picture = Lower(Describe(is_old_object + ".Expression"))
		
		CHOOSE CASE TRUE
				
			CASE Pos(ls_old_picture, 'calendar') > 0
				
				ls_old_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\calendar1.gif~~', ~~'.\res\calendar1.gif~~'))"
				
			CASE Pos(ls_old_picture, 'dddw') > 0
				
				ls_old_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\dddw1.gif~~', ~~'.\res\dddw1.gif~~'))"
				
		END CHOOSE

		Modify(is_old_object + ".Expression = '" + ls_old_picture + "'")
		
//		Modify(is_old_object + ".Border = 0")
		
	END IF
	
	// 버튼 클릭상태를 체크하여 현재 활성화된 오브젝트가 컬럼인 경우 MouseOver 효과
	
	IF ib_lbtn_clicking THEN
		
		is_old_object = ""
		
	ELSE
	
		IF dwo.Type = 'compute' AND Left(ls_now_object, 3) = 'cp_' THEN
			
			ls_now_picture = Lower(Describe(ls_now_object + ".Expression"))
		
			CHOOSE CASE TRUE
					
				CASE Pos(ls_now_picture, 'calendar') > 0
					
					ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\calendar2.gif~~', ~~'.\res\calendar1.gif~~'))"
					
				CASE Pos(ls_now_picture, 'dddw') > 0
					
					ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\dddw2.gif~~', ~~'.\res\dddw1.gif~~'))"
					
			END CHOOSE
			
			Modify(ls_now_object + ".Expression = '" + ls_now_picture + "'")
			
//			MessageBox("",ls_now_object + ".Expression = '" + ls_now_picture + "'")
	
//			SELECT REPLACE(:ls_now_picture, ' ', NULL) INTO :ls_now_picture FROM DUAL;
//			
//			ls_now_picture = Mid(ls_now_picture, 9)
//			ls_now_picture = Reverse(Mid(Reverse(ls_now_picture), 3))
//			
//			ls_now_picture = Reverse('fig.2' + Mid(Reverse(ls_now_picture), 6))
//	
//			Modify(ls_now_object + ".Expression = 'Bitmap(~~'" + ls_now_picture + "~~')'")
			
//			Modify(ls_now_object + ".Border = 6")
		
			is_old_object = ls_now_object
			
		ELSE
			
			is_old_object = ""
			
		END IF
		
	END IF
	
END IF


end event

event type boolean ue_validation(long al_row);AcceptText()

RETURN TRUE
end event

event mouseleave();// Row Stress, Row Mousemove Init

IF NOT gf_chk_null(is_detail_color) THEN Object.DataWindow.Detail.Color = is_detail_color

//IF ib_row_mousemove THEN
//	IF ib_row_stress THEN
//		Object.DataWindow.Detail.Color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"
//	ELSE
//		Object.DataWindow.Detail.Color = "16777215"
//	END IF
//END IF

String ls_old_picture

IF NOT gf_chk_null(is_old_object) THEN
	
	ls_old_picture = Lower(Describe(is_old_object + ".Expression"))
		
	CHOOSE CASE TRUE
			
		CASE Pos(ls_old_picture, 'calendar') > 0
			
			ls_old_picture = "Bitmap(~~'.\res\calendar1.gif~~')"
			
		CASE Pos(ls_old_picture, 'dddw') > 0
			
			ls_old_picture = "Bitmap(~~'.\res\dddw1.gif~~')"
			
	END CHOOSE
	
	Modify(is_old_object + ".Expression = '" + ls_old_picture + "'")
	
//	Modify(is_old_object + ".Border = 0")
	
END IF
	
ib_lbtn_clicking = FALSE
is_old_object    = ""
end event

event lbuttonup;String ls_now_object, ls_now_picture, ls_tag, ls_classify, ls_column, ls_value

IF NOT ib_lbtn_clicking THEN RETURN
	
ls_now_object = dwo.Name
ls_tag        = Lower(dwo.Tag )
ls_column     = Mid(ls_now_object, 4)

IF dwo.Type = 'compute' AND Left(ls_now_object, 3) = 'cp_' THEN
	
	ls_now_picture = Lower(Describe(ls_now_object + ".Expression"))
		
	CHOOSE CASE TRUE
			
		CASE Pos(ls_now_picture, 'calendar') > 0
	
			IF is_old_object = ls_now_object THEN
				ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\calendar2.gif~~', ~~'.\res\calendar1.gif~~'))"
			ELSE
				ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\calendar1.gif~~', ~~'.\res\calendar1.gif~~'))"
			END IF
			
		CASE Pos(ls_now_picture, 'dddw') > 0
	
			IF is_old_object = ls_now_object THEN
				ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\dddw2.gif~~', ~~'.\res\dddw1.gif~~'))"
			ELSE
				ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\dddw1.gif~~', ~~'.\res\dddw1.gif~~'))"
			END IF			
			
	END CHOOSE
	
	Modify(ls_now_object + ".Expression = '" + ls_now_picture + "'")
	
//	Modify(ls_now_object + ".Border = 6")
	
END IF

// Button Up Script
IF is_old_object = ls_now_object THEN
	
	of_excute(ls_column, row, ls_tag)
	
//	Long   ll_xpos, ll_ypos
//	String ls_rectangle
//	
//	Window      l_window	
//	PowerObject	l_parentobject
//	Tab			l_tab
//	
//	str_parameter lstr_parameter
//	
//	ls_rectangle = ls_column
//	l_window     = of_getwindow(This)
//	
////	li_xpos = PixelsToUnits(xpos, XPixelsToUnits!)
////	li_ypos = PixelsToUnits(ypos, YPixelsToUnits!)
//
//	ll_xpos = X
//	ll_ypos = Y
//	
//	// Parent Object = Tab : Tab Size
//
//	l_parentobject = GetParent()
//	
//	IF l_parentobject.Typeof() = UserObject! THEN
//		
//		l_parentobject = l_parentobject.GetParent()
//		
//		IF l_parentobject.Typeof() = Tab! THEN
//			
//			l_tab = l_parentobject
//			
//			ll_xpos = l_tab.X +  20 + X
//			ll_ypos = l_tab.Y + 116 + Y
//			
//		END IF
//		
//	END IF
//	
//	ll_xpos += Long(Describe(ls_rectangle + ".X")) - Long(Describe("DataWindow.HorizontalScrollPosition"))
//	ll_ypos += Long(Describe(ls_rectangle + ".Y")) + Long(Describe("DataWindow.Header.Height"))       &
//																  + Long(Describe("DataWindow.Detail.Height")) * row &
//																  - Long(Describe("DataWindow.VerticalScrollPosition"))
//
//	AcceptText()
//	
//	lstr_parameter.DataWindow   = This
//	lstr_parameter.LongValue[1] = row
//	lstr_parameter.strValue [1] = Left(ls_tag, Pos(ls_tag, '/') - 1)
//	lstr_parameter.strValue [2] =  Mid(ls_tag, Pos(ls_tag, '/') + 1)
//	lstr_parameter.strValue [3] = ls_column
//	lstr_parameter.strValue [4] = GetItemString(row, ls_column)
//	
//	CHOOSE CASE Left(lstr_parameter.strValue[1], 4)
//			
//		CASE 'cale'
//	
//			IF IsValid(u_monthcalendar) THEN
//				l_window.CloseUserObject(u_monthcalendar)
//			END IF
//	
//	//			u_monthcalendar.Move(ll_xpos, ll_ypos)
//			
//			l_window.OpenUserObjectWithParm(u_monthcalendar, lstr_parameter, ll_xpos, ll_ypos)
//			
//			u_monthcalendar.SetPosition(ToTop!)
//			u_monthcalendar.Show()
//			
//			u_monthcalendar.Post SetFocus()
//			
//			String ls_date
//			
//			ls_date = String(lstr_parameter.strValue[4], '@@@@-@@-@@')
//			
//			IF IsDate(ls_date) THEN
//				u_monthcalendar.SetSelectedDate(Date(ls_date))
//			END IF
//			
//		CASE 'dddw'
//	
//			IF IsValid(u_dw_dddw) THEN
//				l_window.CloseUserObject(u_dw_dddw)
//			END IF
//			
//			l_window.OpenUserObjectWithParm(u_dw_dddw, lstr_parameter, ll_xpos, ll_ypos)
//			
//			u_dw_dddw.SetPosition(ToTop!)
//			u_dw_dddw.Show()
//			
//			u_dw_dddw.Post SetFocus()	
//			
//	END CHOOSE
	
//	lw_window.Dynamic Event ue_dwbtn_call(ls_classify, This, ls_column, ls_value, li_xinit, li_yinit)
	
END IF

ib_lbtn_clicking = FALSE
end event

event ue_enter_after();
Window lw_window

lw_window = of_getwindow(This)
/*
IF IsValid(lw_window) THEN
	IF ib_new_last THEN
		lw_window.Dynamic Event ue_new()
	ELSE
		lw_window.Dynamic Event ue_insert()
	END IF
END IF
*/
end event

public function long of_popup (boolean ab_f2press, string as_column, string as_tag, long al_pos, string as_data, long al_row); Boolean lb_self
Datetime ldt_null
     Int li_ocolumn , li_column
    Long i, ll_start, ll_end   , ll_upper , ll_pos1  , ll_pos2
  String ls_coltype , ls_where , ls_colpos, ls_getcol, ls_value, ls_ovalue

IF al_pos > 0 THEN
	
	li_ocolumn = GetColumn()
	
//	is_orgdata = GetItemString(al_row, as_column)
	
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
			SetItem(al_row, li_column, Date(istr_popup.rvalue[i]))
		ELSE
			SetItem(al_row, li_column, Dec(istr_popup.rvalue[i]))
		END IF
		
	NEXT
	
	Event ue_popup_after(as_column, ls_ovalue, al_row)
	
	RETURN 2

END IF

RETURN 0
end function

public function boolean of_startservice (string as_servicename);// Start a datawindow service

CHOOSE CASE Lower(as_servicename)
	CASE "gridstyle"
		isrv_gridstyle = Create n_svc_dw_gridstyle
		isrv_gridstyle.of_Register(This)
	CASE "select"
		isrv_select = Create n_svc_dw_selectrow
		isrv_select.of_Register(This)
	CASE ELSE
		RETURN FALSE
END CHOOSE

RETURN TRUE
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

public subroutine of_excute (string as_column, long al_row, string as_tag);Long ll_xpos, ll_ypos

Window      l_window	
PowerObject	l_parentobject
Tab			l_tab

str_parameter lstr_parameter

l_window = of_getwindow(This)

//	li_xpos = PixelsToUnits(xpos, XPixelsToUnits!)
//	li_ypos = PixelsToUnits(ypos, YPixelsToUnits!)

ll_xpos = X
ll_ypos = Y - 4

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

ll_xpos += Long(Describe(as_column + ".X")) - Long(Describe("DataWindow.HorizontalScrollPosition"))
ll_ypos += Long(Describe(as_column + ".Y")) + Long(Describe("DataWindow.Header.Height"))       &
														  + Long(Describe("DataWindow.Detail.Height")) * al_row &
														  - Long(Describe("DataWindow.VerticalScrollPosition"))

AcceptText()

lstr_parameter.DataWindow   = This
lstr_parameter.LongValue[1] = al_row
lstr_parameter.strValue [1] = Left(as_tag, Pos(as_tag, '/') - 1)
lstr_parameter.strValue [2] =  Mid(as_tag, Pos(as_tag, '/') + 1)
lstr_parameter.strValue [3] = as_column
lstr_parameter.strValue [4] = GetItemString(al_row, as_column)

CHOOSE CASE Left(lstr_parameter.strValue[1], 4)
		
	CASE 'cale'

		IF IsValid(u_monthcalendar) THEN
			l_window.CloseUserObject(u_monthcalendar)
		END IF
		
		l_window.OpenUserObjectWithParm(u_monthcalendar, lstr_parameter, ll_xpos, ll_ypos)
		
		String ls_date
		
		ls_date = String(lstr_parameter.strValue[4], '@@@@-@@-@@')
		
		IF IsDate(ls_date) THEN
			u_monthcalendar.SetSelectedDate(Date(ls_date))
		END IF
		
		u_monthcalendar.SetPosition(ToTop!)
		u_monthcalendar.Show()
		
		u_monthcalendar.Post SetFocus()
		
	CASE 'dddw'

		IF IsValid(u_dw_dddw) THEN
			l_window.CloseUserObject(u_dw_dddw)
		END IF
		
		l_window.OpenUserObjectWithParm(u_dw_dddw, lstr_parameter, ll_xpos, ll_ypos)
		
		u_dw_dddw.SetPosition(ToTop!)
		u_dw_dddw.Show()
		
		u_dw_dddw.Post SetFocus()
		
END CHOOSE
end subroutine

event constructor;Long   i, ll_colcnt, ll_taborder, ll_order1, ll_order2, ll_pos , ll_grpid
String ls_objects  ,ls_style    , ls_bands , ls_left  , ls_type

IF (NOT Visible) OR gf_chk_null(DataObject) THEN RETURN

CHOOSE CASE is_transaction
		
	CASE 'SQLCA'
		
		SetTransObject(SQLCA)
		
	CASE 'TRHPC'
		
		SetTransObject(TRHPC)
		
END CHOOSE

//Object.DataWindow.Color         = 32435950		// DataWindow Color
Object.DataWindow.Color         = DATAWINDOW_COLOR
Object.DataWindow.Header.Color  = HEADER_COLOR
Object.DataWindow.Summary.Color = SUMMARY_COLOR

ls_objects = Describe("DataWindow.Objects")

DO

	ll_pos = Pos(ls_objects, "~t")
	
	IF ll_pos > 0 THEN
		ls_left    = Lower(Left(ls_objects, ll_pos - 1))
		ls_objects =  Mid(ls_objects, ll_pos + 1)
	END IF
	
	IF ls_left = 'grpid' THEN ll_grpid++
	
	ls_bands = Describe(ls_left + ".Band")
	ls_type  = Describe(ls_left + ".Type")
	
	CHOOSE CASE ls_bands
			
		CASE 'header'
			
			//Modify(ls_left + ".Color = 16777215")
			
		CASE 'detail'
			
		CASE 'footer', 'summary'
			
	END CHOOSE
	
LOOP WHILE ll_pos > 0

SetRedraw(TRUE)

// Group Band Color

ls_bands = Object.DataWindow.Bands

IF Pos(ls_bands, 'trailer.1') > 0 THEN
	Modify("DataWindow.Header.1.Color  = " + String(HEADER1_COLOR) + "~t" + &
			 "DataWindow.Trailer.1.Color = " + String(HEADER1_COLOR))
END IF

IF Pos(ls_bands, 'trailer.2') > 0 THEN
	Modify("DataWindow.Header.2.Color  = " + String(HEADER2_COLOR) + "~t" + &
			 "DataWindow.Trailer.2.Color = " + String(HEADER2_COLOR))
END IF

IF Pos(ls_bands, 'trailer.3') > 0 THEN
	Modify("DataWindow.Header.3.Color  = " + String(HEADER2_COLOR) + "~t" + &
			 "DataWindow.Trailer.3.Color = " + String(HEADER2_COLOR))
END IF

Object.Datawindow.HideGrayLine = TRUE

// Footer Band Resize

//Long  ll_height, ll_header, ll_detail, ll_scroll
//
//IF Long(Describe("DataWindow.HorizontalScrollMaximum")) > 0 THEN ll_scroll = 60
//
//ll_header = Long(Describe("DataWindow.Header.Height"))
//ll_detail = Long(Describe("DataWindow.Detail.Height"))
//ll_height = Mod(Height + ll_header + ll_scroll + 4, ll_detail)
//
//Modify("DataWindow.Footer.Height = '" + String(ll_height) + "''")

ll_order1 = 10
ll_colcnt = Long(Describe("DataWindow.Column.Count"))

FOR i = 1 TO ll_colcnt
	
	is_column[i] = Describe("#" + String(i) + ".Name")
	
	ll_taborder = Long(Describe("#" + String(i) + ".TabSequence"))
	
	IF ll_taborder = 0 THEN CONTINUE
	
	ll_order1 = Min(ll_order1, ll_taborder)
	ll_order2 = Max(ll_order2, ll_taborder)
	
	IF ll_taborder = ll_order1 THEN is_start_column = Describe("#" + String(i) + ".Name")
	IF ll_taborder = ll_order2 THEN is_end_column   = Describe("#" + String(i) + ".Name")
	
NEXT

// Detail Band Color

is_detail_org_color = Object.DataWindow.Detail.Color

SELECT REPLACE(REPLACE(:is_detail_org_color, '"', NULL), ' ', NULL)
  INTO :is_detail_org_color
  FROM DUAL;

ll_pos = Pos(is_detail_org_color, '~t')

IF ll_pos < 1 THEN
	
	is_detail_org_color = String(DETAIL_COLOR) + "~t"
/*	
	IF ib_row_stress THEN
		is_detail_color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"
		Object.DataWindow.Detail.Color = is_detail_color
	END IF
*/
ELSE
	
	is_detail_org_color = "16777215~t" + Mid(is_detail_org_color, ll_pos + 1)
	
	// Rows Stress
	
	ll_pos = Pos(is_detail_org_color, '16777215)')
/*	
	IF ib_row_stress THEN
		is_detail_color = Replace(is_detail_org_color, ll_pos, 9, "if(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215))")
		Object.DataWindow.Detail.Color = is_detail_color
	END IF
*/	
END IF

// Load GridStyle Server

//IF ib_sort THEN
//
//	IF of_startservice("GridStyle") THEN
//		
//		isrv_gridstyle.of_setstyle(FALSE, TRUE, TRUE, TRUE)
//		
//		FOR i = 1 TO ll_colcnt
//			
//			IF Describe("#" + String(i) + ".Visible") = '0' THEN CONTINUE
//			
//			isrv_gridstyle.of_addautowidth(Describe("#" + String(i) + ".Name"))
//			
//		NEXT
//		
//	END IF
//	
//END IF

// Load Selectrow Server

//IF ib_extendrow OR ib_selectrow THEN
//	
//	IF ib_selectrow THEN ls_style = "Single"
//	IF ib_extendrow THEN ls_style = "Extend"
//	
//	IF of_startservice("Select") THEN isrv_select.of_SetSelectStyle(ls_style)
//	
//END IF
end event

on u_dw_grid.create
end on

on u_dw_grid.destroy
end on

event dberror;MessageBox("데이터윈도우(" + ClassName(This) + ") 오류-" + String(sqldbcode), sqlerrtext)
ScrollToRow(row)
SetFocus()

RETURN 2
end event

event itemerror;RETURN 1
end event

event retrievestart;SetPointer(HourGlass!)


Reset()
end event

event itemfocuschanged;String ls_tag, ls_flag

IF row > 0 THEN
	
	ls_tag  = Lower(dwo.Tag)
	ls_flag = Left(ls_tag, 1)
	
	CHOOSE CASE Upper(ls_flag)			
		CASE 'K'
			gf_toggle(Handle(This), 'K')
		CASE 'E'
			gf_toggle(Handle(This), 'E')
	END CHOOSE
	
	IF Describe(dwo.name + ".Edit.Style") = 'editmask' THEN SelectText(1, 100)

END IF
end event

event losefocus;AcceptText()
end event

event clicked;Double ld_value
Long   ll_getrow, ll_row
String ls_type  , ls_column, ls_coltype, ls_expression

ls_type   = dwo.Type
ls_column = dwo.Name

// 주석을 풀면 Rowfocuschanging이랑 겹침

//IF row > 0 THEN
//	IF NOT row = GetRow() THEN SetRow(row)
//END IF

String ls_now_object, ls_now_picture
	
ls_now_object = dwo.Name

IF ls_type = 'compute' AND Left(ls_now_object, 3) = 'cp_' THEN
	
	ChangeDirectory(gstr_userenv.Appdir)
	
	ls_now_picture = Lower(Describe(ls_now_object + ".Expression"))
		
	CHOOSE CASE TRUE
			
		CASE Pos(ls_now_picture, 'calendar') > 0
			
			ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\calendar3.gif~~', ~~'.\res\calendar1.gif~~'))"
			
		CASE Pos(ls_now_picture, 'dddw') > 0
			
			ls_now_picture = "Bitmap(if(getrow()=" + String(row) + ",~~'.\res\dddw3.gif~~', ~~'.\res\dddw1.gif~~'))"
			
	END CHOOSE
	
	Modify(ls_now_object + ".Expression = '" + ls_now_picture + "'")

//	SetColumn(Mid(ls_now_object, 4))
	
	ib_lbtn_clicking = TRUE
	
END IF

// Calculator
	
IF ls_type = 'column' OR ls_type = 'compute' THEN
	
	IF RowCount() = 0 THEN RETURN
	
	IF row = 0 THEN
		ll_row = 1
	ELSE
		ll_row = row
	END IF
	
	ls_coltype = dwo.ColType

	IF IsValid(w_calculator) AND (Pos(Lower(ls_coltype), 'number') > 0 OR Pos(Lower(ls_coltype), 'deci') > 0 OR &
									      Pos(Lower(ls_coltype), 'int'   ) > 0 OR Pos(Lower(ls_coltype), 'long') > 0) THEN
	
		ld_value = GetItemNumber(ll_row, ls_column)
		
		w_calculator.wf_calc(ld_value)
		
	END IF

	
//	IF row > 0 THEN ScrollToRow(row)
	
END IF

IF row > 0 THEN //AND ls_type = 'datawindow' THEN
	SetRow(row)
END IF

// Sort on grid headers
//IF IsValid(isrv_gridstyle) THEN
//	isrv_gridstyle.Event Clicked(xpos, ypos, row, dwo)
//END IF
//
//// Select rows
//IF IsValid(isrv_select) THEN
//	isrv_select.Event Clicked(xpos, ypos, row, dwo)
//END IF
end event

event rbuttondown;// Display sort popup menu
IF IsValid(isrv_gridstyle) THEN
	isrv_gridstyle.Event RButtonDown(xpos, ypos, row, dwo)
END IF


//  Char lc_sort = 'A'
//  Long ll_pos
//String ls_dwoname, ls_column, ls_tblsort
//
//ls_dwoname = dwo.Name
//
//IF row > 0 THEN RETURN
//	
//CHOOSE CASE Lower(dwo.Type)
//
//	CASE 'text'
//		
//		ll_pos = Pos(ls_dwoname, '_t')
//		
//		IF ll_pos > 0 THEN
//		
//			ls_column  = Left(ls_dwoname, Len(ls_dwoname) - 2)
//			ls_tblsort = Object.DataWindow.Table.Sort
//			
//			IF ls_tblsort = ls_column + Space(1) + lc_sort THEN
//				lc_sort = 'D'
//			ELSE
//				lc_sort = 'A'
//			END IF
//			
//			SetRedraw(FALSE)
//			
//			SetSort(ls_column + Space(1) + lc_sort)
//			Sort()
//			
//			Event RowFocusChanged(1)
//			
//			SetRedraw(TRUE)
//			
//		END IF		
//
//END CHOOSE
end event

event getfocus;SelectText(1, 100)
end event

event itemchanged;Long   ll_pos
String ls_column, ls_tag, ls_data, ls_dddwtag, ls_dddw, ls_dddwcols, ls_dddwcol

IF NOT GetFocus() = This AND NOT gf_chk_null(data) THEN RETURN

ls_column = dwo.Name
ls_tag    = Lower(dwo.Tag)
ls_data   = Trim(data)

CHOOSE CASE TRUE
		
	CASE Pos(ls_tag, '#popup') > 0

		ll_pos = Pos(ls_tag, '[')
		
		IF ll_pos > 0 THEN
			ll_pos = Pos(Left(ls_tag, ll_pos - 1), '<')
		ELSE
			ll_pos = Pos(ls_tag, '<')
		END IF
		
		RETURN of_popup(FALSE, ls_column, ls_tag, ll_pos, ls_data, row)
		
	CASE Pos(ls_tag, '#dddw') > 0
		
		ls_dddwtag  = Describe("cp_" + ls_column + ".Tag")
		ll_pos      = Pos(ls_dddwtag, '/')
		ls_dddw     = Left(ls_dddwtag, ll_pos - 1)
		ls_dddwcols =  Mid(ls_dddwtag, ll_pos + 1)
		
		// Init
		
		IF gf_chk_null(data) THEN
		
			ll_pos = Pos(ls_dddwcols, '/')
			
			DO WHILE ll_pos > 0
				
				ls_dddwcol  = Left(ls_dddwcols, ll_pos - 1)
				ls_dddwcols =  Mid(ls_dddwcols, ll_pos + 1)
				
				IF NOT ls_dddwcol = ls_column THEN
					SetItem(row, ls_dddwcol, '')
				END IF
				
				ll_pos = Pos(ls_dddwcols, '/')
				
			LOOP
			
		ELSE
		
			of_excute(ls_column, row, ls_dddwtag)
			
		END IF
		
END CHOOSE
end event

event rowfocuschanged;// Select rows
//IF IsValid(isrv_select) AND (ib_selectrow OR ib_extendrow) THEN
//	isrv_select.Event RowFocusChanged(currentrow)
//END IF

IF currentrow > 0 THEN

	IF ib_selectrow THEN
		SelectRow(0, FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	SetRowFocusIndicator(FocusRect!)
	
END IF
	
//	IF NOT ib_selectrow AND NOT ib_extendrow THEN
//		SetRowFocusIndicator(FocusRect!)
//	END IF
end event

event doubleclicked;//// Select rows
//IF IsValid(isrv_select) THEN
//	isrv_select.Event DoubleClicked(xpos, ypos, row, dwo)
//END IF
end event

event other;// Highlight header effects
IF IsValid(isrv_gridstyle) THEN
	isrv_gridstyle.Event Other(wparam, lparam)
END IF

CHOOSE CASE Message.Number
		
	CASE WM_MOUSELEAVE
		
		Event MouseLeave()
		
END CHOOSE
end event

event resize;// Resize the shadow
//IF IsValid(isrv_gridstyle) THEN
//	isrv_gridstyle.Event Resize(sizetype, newwidth, newheight)
//END IF
end event

event retrieveend;// Resize column width
//IF IsValid(isrv_gridstyle) THEN
//	isrv_gridstyle.Event RetrieveEnd(rowcount)
//END IF


IF ib_msg_retrieve THEN
	gf_microhelp('status', String(rowcount, '#,##0') + "건의 자료가 조회되었습니다.")
END IF

SetPointer(Arrow!)
end event

event updateend;IF ib_msg_update THEN
	gf_microhelp('status', "신규 : " + String(rowsinserted, '#,##0') + "건, " + &
								  "수정 : " + String(rowsupdated , '#,##0') + "건, " + &
								  "삭제 : " + String(rowsdeleted , '#,##0') + "건")
ELSE
	IF rowsinserted + rowsupdated > 0 THEN
		gf_microhelp('status', "자료가 저장되었습니다.")
	ELSEIF rowsdeleted > 0 THEN
		gf_microhelp('status', "자료가 삭제되었습니다.")
	END IF
END IF
end event

