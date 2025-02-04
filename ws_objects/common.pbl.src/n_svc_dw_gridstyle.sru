$PBExportHeader$n_svc_dw_gridstyle.sru
forward
global type n_svc_dw_gridstyle from n_svc_dw_base
end type
type size from structure within n_svc_dw_gridstyle
end type
type trackmouseevent from structure within n_svc_dw_gridstyle
end type
end forward

type size from structure
	long		cx
	long		cy
end type

type trackmouseevent from structure
	unsignedlong		cbsize
	unsignedlong		dwflags
	unsignedlong		hwndtrack
	unsignedlong		dwhovertime
end type

global type n_svc_dw_gridstyle from n_svc_dw_base
event clicked pbm_dwnlbuttonclk
event mousemove pbm_dwnmousemove
event rbuttondown pbm_dwnrbuttondown
event resize pbm_dwnresize
event retrieveend pbm_dwnretrieveend
event other pbm_other
event mouseleave ( )
end type
global n_svc_dw_gridstyle n_svc_dw_gridstyle

type prototypes
Function ulong GetDC ( &
	ulong hWnd &
	) Library "user32.dll"

Function ulong SelectObject ( &
	ulong hdc, &
	ulong hWnd &
	) Library "gdi32.dll"

Function boolean GetTextExtentPoint32 ( &
	ulong hdcr, &
	string lpString, &
	long nCount, &
	Ref SIZE size &
	) Library "gdi32.dll" Alias For "GetTextExtentPoint32W"

Function long ReleaseDC ( &
	ulong hWnd, &
	ulong hdcr &
	) Library "user32.dll"

Function boolean TrackMouseEvent ( &
	Ref TRACKMOUSEEVENT lpEventTrack &
	) Library "user32.dll"

Function boolean IsThemeActive ( &
	) Library "UxTheme.dll"

end prototypes

type variables
Window iw_parent
Constant String ARROW_SUFFIX = "_arrow"
Constant String SHADE_SUFFIX = "_shade"
Constant String HLINE_SUFFIX = "_hline"
Constant String TRANSPARENT = "536870912"
String is_colfilter[]
String is_original_filter
String is_original_sort
String is_sort
Boolean ib_popupmenu
Boolean ib_arrow
Boolean ib_shade
Boolean ib_highlite
Boolean ib_highlite_added
String is_prevcolumn
String is_prevcolor
Integer ii_original[]
String is_colname[]
String is_graycolor[]
String is_orangecolor[]
Boolean ib_mouseover

Constant ULong WM_MOUSEHOVER = 673
Constant ULong WM_MOUSELEAVE = 675
Constant ULong TME_HOVER = 1
Constant ULong TME_LEAVE = 2
Constant ULong TME_NONCLIENT = 16
Constant ULong TME_QUERY = 1073741824
Constant ULong TME_CANCEL = 2147483648
Constant ULong HOVER_DEFAULT = 4294967295

end variables

forward prototypes
public subroutine of_addvisuals ()
public subroutine of_delvisuals ()
public subroutine of_sortarrow (string as_colname)
public subroutine of_process_popup (string as_process, long al_row, string as_colname)
public subroutine of_initialize ()
public subroutine of_headerline (string as_colname)
public function long of_resizewidth (string as_colname)
public subroutine of_sortshade (string as_colname)
public function integer of_setreg (string as_entry, string as_value)
public function string of_getreg (string as_entry, string as_default)
public subroutine of_addautowidth (string as_colname)
public subroutine of_reordercolumns (string as_colname[])
public function string of_getcoldesc (string as_colname, boolean ab_usecolname)
public function integer of_setreg (string as_subkey, string as_entry, string as_value)
public function string of_getreg (string as_subkey, string as_entry, string as_default)
public subroutine of_trackmouseevent (boolean ab_mousetracking)
public function string of_combinefilter ()
public subroutine of_setstyle (boolean ab_popupmenu, boolean ab_arrow, boolean ab_shade, boolean ab_highlite)
end prototypes

event clicked;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.Clicked
//
// PURPOSE:    This event will sort the datawindow based on which
//					header was clicked on. The column header must be named
//					colname + '_t' which is the default naming convention.
//
// ARGUMENTS:  xpos	-	The distance of the pointer from the left side of the
//								DataWindow workspace.
//					ypos	-	The distance of the pointer from the top of the
//								DataWindow workspace.
//					row	-	The number of the row the user clicked.
//					dwo	-	A reference to the control within the DataWindow under
//								the pointer when the user clicked.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_sort, ls_objname, ls_colname
Integer li_len

ls_objname = dwo.Name

// bail out if this is not the header area
If row > 0 Or ls_objname = "datawindow" Then Return

// see if object clicked is header or gridsort arrow
If Right(ls_objname, 2) = "_t" Then
	li_len = 2
Else
	If Right(ls_objname, Len(ARROW_SUFFIX)) = ARROW_SUFFIX Then
		li_len = Len(ARROW_SUFFIX)
	End If
End If

If li_len > 0 Then
	// get column name from object name
	ls_colname = Left(ls_objname, Len(ls_objname) - li_len)
	// if column is a dropdown, sort on display value not data value
	If idw_client.Describe(ls_colname + ".Edit.Style") = "dddw" Or &
		idw_client.Describe(ls_colname + ".Edit.CodeTable") = "yes" Then
		ls_colname = "LookUpDisplay(" + ls_colname + ")"
	End If
	// build sort key
	ls_sort = ls_colname + " A"
	If ls_sort = is_sort Then
		is_sort = ls_colname + " D"
	Else
		is_sort = ls_sort
	End If
	// remove visual cues
	of_DelVisuals()
	// apply new sort
	idw_client.SetSort(is_sort)
	idw_client.Sort()
	// add visual cues
	of_AddVisuals()
	// save settings
	of_SetReg("sortorder", is_sort)
	// force row select
	idw_client.Event RowFocusChanged(idw_client.GetRow())
End If

Return 0

end event

event mousemove;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.MouseMove
//
// PURPOSE:    This event is called whenever the mouse moves over the
//					datawindow. If the mouse is over the header area, the header
//					background becomes white and the header lines become orange.
//
// ARGUMENTS:  xpos	-	The distance of the pointer from the left side of the
//								DataWindow workspace.
//					ypos	-	The distance of the pointer from the top of the
//								DataWindow workspace.
//					row	-	The number of the row the mouse was over.
//					dwo	-	A reference to the control within the DataWindow
//								that the mouse was over.
// -----------------------------------------------------------------------------

String ls_objname, ls_colname, ls_syntax
String SHADECOLOR
Integer li_idx

// turn on mouse tracking
If Not ib_mouseover Then
	of_TrackMouseEvent(True)
End If

// control highlighting the headers
If ib_highlite Then
	SHADECOLOR = String(RGB(250,248,243))
	If dwo.Type = "text" Then
		If dwo.band = "header" Then
			// get object name/type
			ls_objname = dwo.Name
			// get out if this is one of the header lines
			If Right(ls_objname, 7) = "_hline1" Then Return
			If Right(ls_objname, 7) = "_hline2" Then Return
			If Right(ls_objname, 7) = "_hline3" Then Return
			// determine column name
			If Right(ls_objname, Len(ARROW_SUFFIX)) = ARROW_SUFFIX Then
				ls_colname = Left(ls_objname, Len(ls_objname) - Len(ARROW_SUFFIX))
			End If
			If Right(ls_objname, 2) = "_t" Then
				ls_colname = Left(ls_objname, Len(ls_objname) - 2)
			End If
			// get out if same column as last time
			If ls_colname = is_prevcolumn Then Return
			If is_prevcolumn <> "" Then
				// restore object state
				ls_syntax = is_prevcolumn + "_t.background.color=" + is_prevcolor
				idw_client.Modify(ls_syntax)
				// make the header lines gray
				For li_idx = 1 To 3
					ls_syntax = is_prevcolumn + "_hline" + &
							String(li_idx) + ".background.color=" + is_graycolor[li_idx]
					idw_client.Modify(ls_syntax)
				Next
			End If
			// save column name
			is_prevcolumn = ls_colname
			// save current object state
			is_prevcolor = idw_client.Describe(is_prevcolumn + "_t.background.color")
			// set object state to highlighted
			ls_syntax = is_prevcolumn + "_t.background.color=" + SHADECOLOR
			idw_client.Modify(ls_syntax)
			// make the header lines orange
			For li_idx = 1 To 3
				ls_syntax = is_prevcolumn + "_hline" + &
						String(li_idx) + ".background.color=" + is_orangecolor[li_idx]
				idw_client.Modify(ls_syntax)
			Next
		Else
			// restore object state
			ls_syntax = is_prevcolumn + "_t.background.color=" + is_prevcolor
			idw_client.Modify(ls_syntax)
			// make the header lines gray
			For li_idx = 1 To 3
				ls_syntax = is_prevcolumn + "_hline" + &
						String(li_idx) + ".background.color=" + is_graycolor[li_idx]
				idw_client.Modify(ls_syntax)
			Next
			is_prevcolumn = ""
		End If
	Else
		// restore object state
		ls_syntax = is_prevcolumn + "_t.background.color=" + is_prevcolor
		idw_client.Modify(ls_syntax)
		// make the header lines gray
		For li_idx = 1 To 3
			ls_syntax = is_prevcolumn + "_hline" + &
					String(li_idx) + ".background.color=" + is_graycolor[li_idx]
			idw_client.Modify(ls_syntax)
		Next
		is_prevcolumn = ""
	End If
End If

Return 0

end event

event rbuttondown;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.RButtonDown
//
// PURPOSE:    This event instantiates the popup menu.
//
// ARGUMENTS:  xpos	-	The distance of the pointer from the left side of the
//								DataWindow workspace.
//					ypos	-	The distance of the pointer from the top of the
//								DataWindow workspace.
//					row	-	The number of the row the user clicked.
//					dwo	-	A reference to the control within the DataWindow under
//								the pointer when the user clicked.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

m_svc_dwgridstyle_popup lm_popup
n_svc_dw_gridstyle ln_this
String ls_objname

// turn off mouse tracking
If ib_mouseover Then
	of_TrackMouseEvent(False)
End If

// display the popup menu
If ib_popupmenu Then
	ls_objname = dwo.Name
	lm_popup = Create m_svc_dwgridstyle_popup
	// register datawindow to menu
	ln_this = this
	lm_popup.mf_register(ln_this, row, ls_objname)
	// show the popup menu
	lm_popup.m_popup.PopMenu(iw_parent.PointerX(), iw_parent.PointerY())
	Destroy lm_popup
	// force redraw
	idw_client.SetRedraw(True)
End If

Return 0

end event

event resize;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.Resize
//
// PURPOSE:    This event recreates the shadow object in the correct size.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

If ib_shade Then
	idw_client.SetRedraw(False)
	// remove visual cues
	of_DelVisuals()
	// add visual cues
	of_AddVisuals()
	idw_client.SetRedraw(True)
End If

Return 0

end event

event retrieveend;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.RetrieveEnd
//
// PURPOSE:    This event resizes all the registered columns.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Integer li_idx, li_max

li_max = UpperBound(is_colname)
For li_idx = 1 To li_max
	of_ResizeWidth(is_colname[li_idx])
Next

Return 0

end event

event other;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.Other
//
// PURPOSE:    This event is called by the Other event of the datawindow. It
//					triggers mouse events.
//
// ARGUMENTS:  wparam	-	UnsignedLong by value
//					lparam	-	Long by value
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/30/2006	RolandS		Initial creation
// -----------------------------------------------------------------------------

If Message.Number = WM_MOUSELEAVE Then
	this.Event MouseLeave()
End If

end event

event mouseleave();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.MouseLeave
//
// PURPOSE:    This event occurs when the mouse leaves the control.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// -----------------------------------------------------------------------------

String ls_syntax
Integer li_idx

// turn off mouse tracking
If ib_mouseover Then
	of_TrackMouseEvent(False)
End If

If ib_highlite Then
	// restore object state
	ls_syntax = is_prevcolumn + "_t.background.color=" + is_prevcolor
	idw_client.Modify(ls_syntax)
	// make the header lines gray
	For li_idx = 1 To 3
		ls_syntax = is_prevcolumn + "_hline" + &
				String(li_idx) + ".background.color=" + is_graycolor[li_idx]
		idw_client.Modify(ls_syntax)
	Next
	is_prevcolumn = ""
End If

end event

public subroutine of_addvisuals ();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_AddVisuals
//
// PURPOSE:    This function adds Arrows & Shading to columns.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_colname, ls_array[]
Long ll_row, ll_max

ls_colname = idw_client.Describe("Datawindow.Table.Sort")

ll_max = of_Parse(ls_colname, ", ", ls_array)
For ll_row = 1 To ll_max
	ls_colname = Left(ls_array[ll_row], Pos(ls_array[ll_row], " ") - 1)
	If Left(ls_colname, 14) = "LookUpDisplay(" Then
		ls_colname = Mid(ls_colname, 15)
		ls_colname = Left(ls_colname, Len(ls_colname) - 1)
	End If
	If idw_client.Describe(ls_colname + ".Visible") = "1" Then
		If ib_arrow Then
			of_SortArrow(ls_colname)
		End If
		If ib_shade Then
			of_SortShade(ls_colname)
		End If
	End If
Next

end subroutine

public subroutine of_delvisuals ();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_DelVisuals
//
// PURPOSE:    This function removes Arrows & Shading from columns.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_colname, ls_array[], ls_syntax
Long ll_row, ll_max

ls_colname = idw_client.Describe("Datawindow.Table.Sort")

ll_max = of_Parse(ls_colname, ", ", ls_array)

For ll_row = 1 To ll_max
	ls_colname = Left(ls_array[ll_row], Pos(ls_array[ll_row], " ") - 1)
	If Left(ls_colname, 14) = "LookUpDisplay(" Then
		ls_colname = Mid(ls_colname, 15)

		ls_colname = Left(ls_colname, Len(ls_colname) - 1)
	End If
	ls_syntax = "destroy " + ls_colname + ARROW_SUFFIX
	idw_client.Modify(ls_syntax)
	ls_syntax = "destroy " + ls_colname + SHADE_SUFFIX
	idw_client.Modify(ls_syntax)
Next

end subroutine

public subroutine of_sortarrow (string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_SortArrow
//
// PURPOSE:    This function creates the arrow object.
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// 11/27/2006	RolandS		Changed ypos offset from 60 to 64
// -----------------------------------------------------------------------------

String ls_object, ls_xpos, ls_ypos, ls_width, ls_text, ls_syntax
String ARROWCOLOR
Integer li_height

ARROWCOLOR  = String(of_SysColor(16))

// determine new object name and size
ls_object  = as_colname + ARROW_SUFFIX
ls_xpos  = idw_client.Describe(as_colname + "_t.x")
ls_width = idw_client.Describe(as_colname + "_t.width")
If Right(is_sort, 1) = "A" Then
	ls_text = "t"
Else
	ls_text = "u"
End If
li_height = Integer(idw_client.Describe("DataWindow.Header.Height"))
ls_ypos = String(li_height - 64)

// build create string
ls_syntax  = 'create text(band=header alignment="1" text="' + ls_text + '" border="0" '
ls_syntax += 'color="' + ARROWCOLOR + '" x="' + ls_xpos + '" y="' + ls_ypos + '" height="44" width="' + ls_width + '" '
ls_syntax += 'html.valueishtml="0" name=' + ls_object + ' visible="1" font.face="Marlett" '
ls_syntax += 'font.height="-10" font.weight="400" font.family="0" font.pitch="2" '
ls_syntax += 'font.charset="2" background.mode="1" background.color="' + TRANSPARENT + '")'

// create the object
idw_client.Modify(ls_syntax)

end subroutine

public subroutine of_process_popup (string as_process, long al_row, string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_Process_Popup
//
// PURPOSE:    This function processes the popup menu functions.
//
// CALLED BY:  Called by m_dwgridstyle_popup
//
// ARGUMENTS:  as_process	- The menu item that was chosen
//					al_row		- The row that was clicked on
//					as_colname	- The column that was clicked on
//
//	RETURN:		The number of items in the array
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/02/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_value, ls_type, ls_filter, ls_sort, ls_columns, ls_empty[]
Integer li_colnbr, li_rtn
Long ll_row, ll_max

idw_client.SetRedraw(False)

Choose Case as_process
	Case "m_filterbyselection"
		li_colnbr = Integer(idw_client.Describe(as_colname + ".ID"))
		If li_colnbr = 0 Then
			idw_client.SetRedraw(True)
			Return
		End If
		ls_value = String(idw_client.object.data[al_row, li_colnbr])
		If IsNull(ls_value) Then
			ls_filter = "isnull(" + as_colname + ")"
		Else
			ls_type = Lower(Left(idw_client.Describe(as_colname + ".ColType"), 5))
			Choose Case ls_type
				Case "decim", "numbe", "long", "ulong", "real"
					ls_filter = as_colname + " = " + ls_value
				Case ELSE
					ls_filter = "string(" + as_colname + ") = ~"" + ls_value + "~""
			End Choose
		End If
		is_colfilter[li_colnbr] = ls_filter
		ls_filter = of_CombineFilter()
		idw_client.SetFilter(ls_filter)
		idw_client.Filter()
		idw_client.Sort()
	Case "m_filterexcludingselection"
		li_colnbr = Integer(idw_client.Describe(as_colname + ".ID"))
		If li_colnbr = 0 Then
			idw_client.SetRedraw(True)
			Return
		End If
		ls_value  = String(idw_client.object.data[al_row, li_colnbr])
		ls_type = Lower(Left(idw_client.Describe(as_colname + ".ColType"), 5))
		If IsNull(ls_value) Then
			ls_filter = "not isnull(" + as_colname + ")"
		Else
			ls_type = Lower(Left(idw_client.Describe(as_colname + ".ColType"), 5))
			Choose Case ls_type
				Case "decim", "numbe", "long", "ulong", "real"
					ls_filter = as_colname + " <> " + ls_value
				Case ELSE
					ls_filter = "string(" + as_colname + ") <> ~"" + ls_value + "~""
			End Choose
		End If
		is_colfilter[li_colnbr] = ls_filter
		ls_filter = of_CombineFilter()
		idw_client.SetFilter(ls_filter)
		idw_client.Filter()
		idw_client.Sort()
	Case "m_removeselectionfilter"
		li_colnbr = Integer(idw_client.Describe(as_colname + ".ID"))
		If li_colnbr = 0 Then
			idw_client.SetRedraw(True)
			Return
		End If
		is_colfilter[li_colnbr] = ""
		ls_filter = of_CombineFilter()
		idw_client.SetFilter(ls_filter)
		idw_client.Filter()
		idw_client.Sort()
	Case "m_originalfilter"
		is_colfilter = ls_empty
		ls_filter = is_original_filter
		idw_client.SetFilter(ls_filter)
		idw_client.Filter()
		idw_client.Sort()
	Case "m_sortascending"
		// remove visual cues
		of_DelVisuals()
		// update sort order
		is_sort = as_colname + " A"
		idw_client.SetSort(is_sort)
		// apply sort
		idw_client.Sort()
		// add visual cues
		of_AddVisuals()
		// save settings
		of_SetReg("sortorder", is_sort)
	Case "m_sortdescending"
		// remove visual cues
		of_DelVisuals()
		// update sort order
		is_sort = as_colname + " D"
		idw_client.SetSort(is_sort)
		// apply sort
		idw_client.Sort()
		// add visual cues
		of_AddVisuals()
		// save settings
		of_SetReg("sortorder", is_sort)
	Case "m_originalsort"
		// remove visual cues
		of_DelVisuals()
		// update sort order
		is_sort = is_original_sort
		idw_client.SetSort(is_sort)
		// apply sort
		idw_client.Sort()
		// add visual cues
		of_AddVisuals()
		// save settings
		of_SetReg("sortorder", is_sort)
	Case "m_specifysort"
		idw_client.SetRedraw(True)
		SetNull(ls_sort)
		li_rtn = idw_client.SetSort(ls_sort)
		If li_rtn = 1 Then
			// get the new sort order
			is_sort = idw_client.Describe("Datawindow.Table.Sort")
			// remove visual cues
			of_DelVisuals()
			// apply sort
			idw_client.Sort()
			// add visual cues
			of_AddVisuals()
			// save settings
			of_SetReg("sortorder", is_sort)
		End If
	Case "m_specifyfilter"
		idw_client.SetRedraw(True)
		SetNull(ls_filter)
		li_rtn = idw_client.SetFilter(ls_filter)
		If li_rtn = 1 Then
			idw_client.Filter()
			idw_client.Sort()
		End If
	Case "m_print"
		idw_client.Print()
	Case "m_saveas"
		idw_client.SetRedraw(True)
		idw_client.SaveAs()
End Choose

idw_client.SetRedraw(True)

// force row select
idw_client.Event RowFocusChanged(idw_client.GetRow())

end subroutine

public subroutine of_initialize ();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_Initialize
//
// PURPOSE:    This function initializes the service.
//
// ARGUMENTS:  adw_client - The client datawindow.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Integer li_col, li_max

iw_parent = of_GetWindow(idw_client)

If Len(idw_client.DataObject) > 0 Then
	// save original sort order
	is_original_sort   = idw_client.Describe("Datawindow.Table.Sort")
	// save original filter order
	is_original_filter = idw_client.Describe("Datawindow.Table.Filter")
	If is_original_filter = "?" Then
		is_original_filter = ""
	End If
	// restore saved sort order
	is_sort = of_GetReg("sortorder", is_original_sort)
	idw_client.SetSort(is_sort)
	// record original size
	li_max = Integer(idw_client.Object.DataWindow.Column.Count)
	For li_col = 1 To li_max
		ii_original[li_col] = Integer(idw_client.Describe("#" + String(li_col) + ".Width"))
	Next
End If

end subroutine

public subroutine of_headerline (string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_HeaderLine
//
// PURPOSE:    This function creates the header line object.
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// 11/27/2006	RolandS		Corrected the color value
// 11/30/2006 	RolandS		Changed to 3 hlines of different colors
// -----------------------------------------------------------------------------

String ls_objname, ls_width, ls_syntax, ls_xpos, ls_ypos
Integer li_height, li_idx

// determine new object size
ls_xpos  = idw_client.Describe(as_colname + "_t.x")
ls_width = idw_client.Describe(as_colname + "_t.width")
li_height = Integer(idw_client.Describe("DataWindow.Header.Height"))

For li_idx = 1 To 3
	// set object name & y position
	ls_objname = as_colname + HLINE_SUFFIX + String(li_idx)
	ls_ypos = String(li_height - (4 * li_idx))
	// build create string
	ls_syntax  = 'create text(band=header alignment="0" text="" border="0" color="0" '
	ls_syntax += ' x="' + ls_xpos + '" y="' + ls_ypos + '" height="4" width="' + ls_width + '" '
	ls_syntax += 'html.valueishtml="0" name=' + ls_objname + ' visible="1" font.face="Tahoma" '
	ls_syntax += 'font.height="-10" font.weight="400" font.family="2" font.pitch="2" '
	ls_syntax += 'font.charset="0" background.mode="2" background.color="' + is_graycolor[li_idx] + '")'
	// create the object
	idw_client.Modify(ls_syntax)
Next

end subroutine

public function long of_resizewidth (string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_ResizeWidth
//
// PURPOSE:    This function resizes the column so that it is wide enough to
//					fit the longest value. Normally it would be called from the
//					RetrieveEnd event of the datawindow.
//
// ARGUMENTS:  as_colname - The name of the column to resize.
//
// RETURN:     Row containing the longest value.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Constant Integer WM_GETFONT = 49
Integer li_rc, li_colnbr, li_size, li_maxwidth
Long ll_maxrow, ll_row, ll_max
ULong lul_Handle, lul_hDC, lul_hFont
String ls_format, ls_value, ls_modify, ls_describe
SIZE lstr_size
StaticText lst_text

li_rc = iw_parent.OpenUserObject(lst_text)
If li_rc = 1 Then
	// get column number
	li_colnbr  = Integer(idw_client.Describe(as_colname + ".ID"))
	// get column format string
	ls_format = idw_client.Describe(as_colname + ".Format")
	// give static text same font properties as column
	lst_text.FaceName = idw_client.Describe(as_colname + ".Font.Face")
	lst_text.TextSize = Integer(idw_client.Describe(as_colname + ".Font.Height"))
	lst_text.Weight = Integer(idw_client.Describe(as_colname + ".Font.Weight"))
	// set italic property
	If idw_client.Describe(as_colname + ".Font.Italic") = "1" Then
		lst_text.Italic = True
	Else
		lst_text.Italic = False
	End If
	// set charset property
	CHOOSE CASE idw_client.Describe(as_colname + ".Font.CharSet")
		CASE "0"
			lst_text.FontCharSet = ANSI!
		CASE "2"
			lst_text.FontCharSet = Symbol!
		CASE "128"
			lst_text.FontCharSet = ShiftJIS!
		CASE "255"
			lst_text.FontCharSet = OEM!
		CASE ELSE
			lst_text.FontCharSet = DefaultCharSet!
	END CHOOSE
	// set family property
	CHOOSE CASE idw_client.Describe(as_colname + ".Font.Family")
		CASE "1"
			lst_text.FontFamily = Roman!
		CASE "2"
			lst_text.FontFamily = Swiss!
		CASE "3"
			lst_text.FontFamily = Modern!
		CASE "4"
			lst_text.FontFamily = Script!
		CASE "5"
			lst_text.FontFamily = Decorative!
		CASE ELSE
			lst_text.FontFamily = AnyFont!
	END CHOOSE
	// set pitch property
	CHOOSE CASE idw_client.Describe(as_colname + ".Font.Pitch")
		CASE "1"
			lst_text.FontPitch = Fixed!
		CASE "2"
			lst_text.FontPitch = Variable!
		CASE ELSE
			lst_text.FontPitch = Default!
	END CHOOSE
	// create device context for statictext
	lul_Handle = Handle(lst_text)
	lul_hDC = GetDC(lul_Handle)
	// get handle to the font used by statictext
	lul_hFont = Send(lul_Handle, WM_GETFONT, 0, 0)
	// Select it into the device context
	SelectObject(lul_hDC, lul_hFont)
	// walk thru each row of datawindow
	ll_max = idw_client.RowCount()
	FOR ll_row = 1 TO ll_max
		// if column is a dropdown/codetable, get display value
		If idw_client.Describe(as_colname + ".Edit.Style") = "dddw" Or &
			idw_client.Describe(as_colname + ".Edit.CodeTable") = "yes" Then
			ls_describe = "Evaluate('LookupDisplay(" + as_colname + ")', " + String(ll_row) + ")"
			ls_value = idw_client.Describe(ls_describe)
		Else
			// get value from datawindow
			ls_value = RightTrim(String(idw_client.object.data[ll_row, li_colnbr], ls_format))
		End If
		// determine text width
		If Not GetTextExtentPoint32(lul_hDC, ls_value, Len(ls_value), lstr_Size) Then
			ReleaseDC(lul_Handle, lul_hDC)
			iw_parent.CloseUserObject(lst_text)
			Return -1
		End If
		// convert length in pixels to PBUnits
		li_size = PixelsToUnits(lstr_Size.cx, XPixelsToUnits!)
		If li_size > li_maxwidth Then
			li_maxwidth = li_size
			ll_maxrow = ll_row
		End If
	NEXT
	// release the device context
	ReleaseDC(lul_Handle, lul_hDC)
	// modify the column width
	If li_maxwidth > ii_original[li_colnbr] Then
		ls_modify = as_colname + ".Width = " + String(li_maxwidth + 8)
	Else
		ls_modify = as_colname + ".Width = " + String(ii_original[li_colnbr])
	End If
	// change the column width
	idw_client.Modify(ls_modify)
	// destroy statictext
	iw_parent.CloseUserObject(lst_text)
End If

// return longest row
Return ll_maxrow

end function

public subroutine of_sortshade (string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_SortShade
//
// PURPOSE:    This function creates the shade object.
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// 11/27/2006	RolandS		Corrected the color value
// -----------------------------------------------------------------------------

String ls_object, ls_height, ls_xpos, ls_width, ls_syntax
String SHADECOLOR
Integer li_xpos, li_width, li_height

SHADECOLOR  = String(RGB(247,247,247))

// determine new object name and size
ls_object = as_colname + SHADE_SUFFIX
li_xpos   = Integer(idw_client.Describe(as_colname + ".x"))
li_width  = Integer(idw_client.Describe(as_colname + ".width"))
li_height = Integer(idw_client.Describe("Datawindow.Detail.height"))
li_height = li_height * (idw_client.RowCount() + 1)
If li_height < idw_client.Height Then li_height = idw_client.Height
ls_height = String(li_height)

// make xpos an expression
ls_xpos  = String(li_xpos) + '~tInteger(Describe(~''
ls_xpos += as_colname + '.X~')) - 8'

// make width an expression
ls_width  = String(li_width) + '~tInteger(Describe(~''
ls_width += as_colname + '.Width~')) + 14'

// build create string
ls_syntax  = 'create text(band=background alignment="0" text="" border="0" color="' + TRANSPARENT + '" '
ls_syntax += 'x="' + ls_xpos + '" y="0" height="' + ls_height + '" width="' + ls_width + '" '
ls_syntax += 'html.valueishtml="0" name=' + ls_object + ' visible="1" font.face="Marlett" '
ls_syntax += 'font.height="-12" font.weight="400" font.family="0" font.pitch="2" '
ls_syntax += 'font.charset="2" background.mode="0" background.color="' + SHADECOLOR + '")'

// create the object
idw_client.Modify(ls_syntax)

end subroutine

public function integer of_setreg (string as_entry, string as_value);// save settings
Return Super::of_SetReg("GridStyle\" + &
			idw_client.DataObject, as_entry, as_value)

end function

public function string of_getreg (string as_entry, string as_default);// get settings
Return Super::of_GetReg("GridStyle\" + &
			idw_client.DataObject, as_entry, as_default)

end function

public subroutine of_addautowidth (string as_colname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_AddAutoWidth
//
// PURPOSE:    This function adds a column to the array listing the
//					columns to be resized.
//
// ARGUMENTS:  as_colname - The name of the column to resize.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Integer li_col

li_col = UpperBound(is_colname) + 1

is_colname[li_col] = as_colname

end subroutine

public subroutine of_reordercolumns (string as_colname[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_ReorderColumns
//
// PURPOSE:    This function reorders the columns by making them all invisible
//					and then making them visible in the new order.
//
// ARGUMENTS:  as_colname - Array of column names to make visible.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/05/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_modify, ls_colname
Integer li_col, li_max

If UpperBound(as_colname) = 0 Then Return

idw_client.SetRedraw(False)

// make all columns invisible
li_max = Integer(idw_client.Object.DataWindow.Column.Count)
For li_col = 1 To li_max
	ls_colname = idw_client.Describe("#" + String(li_col) + ".Name")
	ls_modify += ls_colname + ".Visible='0' "
Next
idw_client.Modify(ls_modify)

// make columns visible in new order
li_max = UpperBound(as_colname)
For li_col = 1 To li_max
	idw_client.Modify(as_colname[li_col] + ".Visible='1'")
	idw_client.SetPosition(as_colname[li_col] + "_t", "header", True)
	idw_client.SetPosition(as_colname[li_col] + HLINE_SUFFIX + "1", "header", True)
	idw_client.SetPosition(as_colname[li_col] + HLINE_SUFFIX + "2", "header", True)
	idw_client.SetPosition(as_colname[li_col] + HLINE_SUFFIX + "3", "header", True)
Next

idw_client.SetRedraw(True) 

end subroutine

public function string of_getcoldesc (string as_colname, boolean ab_usecolname);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_GetColDesc
//
// PURPOSE:    This function returns the text of the column header if named
//					colname_t or the colname with underscores removed.
//
// ARGUMENTS:  as_colname    - The name of the column.
//					ab_usecolname - If True, use column name when text not found.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_header

// from text object related to the column
ls_header = idw_client.Describe(as_colname + "_t.Text")
If ls_header = "!" And ab_usecolname Then
	ls_header = of_ReplaceAll(as_colname, "_", " ")
	ls_header = Wordcap(ls_header)
End If

Return Trim(ls_header)

end function

public function integer of_setreg (string as_subkey, string as_entry, string as_value);// save settings
Return Super::of_SetReg("GridStyle\" + &
			idw_client.DataObject + "\" + as_subkey, as_entry, as_value)

end function

public function string of_getreg (string as_subkey, string as_entry, string as_default);// get settings
Return Super::of_GetReg("GridStyle\" + &
			idw_client.DataObject + "\" + as_subkey, as_entry, as_default)

end function

public subroutine of_trackmouseevent (boolean ab_mousetracking);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_TrackMouseEvent
//
// PURPOSE:    This function turns on/off mouse tracking. Tracking causes the
//					mouseleave event to occur.
//
// ARGUMENTS:  as_colname	- The column to process
// -----------------------------------------------------------------------------

TRACKMOUSEEVENT lpTrackMouseEvent

If ab_mousetracking Then
	lpTrackMouseEvent.dwFlags = TME_LEAVE
Else
	lpTrackMouseEvent.dwFlags = TME_LEAVE + TME_CANCEL
End If

ib_mouseover = ab_mousetracking
lpTrackMouseEvent.cbSize = 16
lpTrackMouseEvent.hwndTrack = Handle(idw_client)
lpTrackMouseEvent.dwHoverTime = HOVER_DEFAULT
TrackMouseEvent(lpTrackMouseEvent)

end subroutine

public function string of_combinefilter ();// -----------------------------------------------------------------------------
// SCRIPT:		n_svc_dw_gridstyle.of_CombineFilter
//
// PURPOSE:		Combines the column filters from the instance array into a single
//					filter string.
//
// RETURN:		The filter string
//
// DATE			PROGRAMMER	ENH#	DESCRIPTION OF CHANGE / REASON
// ----------	----------	-----	-----------------------------------------------
// 01/08/2007	RolandS		1375	New development
// -----------------------------------------------------------------------------

String ls_filter
Integer li_idx, li_max

If Len(is_original_filter) > 0 Then
	ls_filter = "( " + is_original_filter + " )"
End If

li_max = UpperBound(is_colfilter)
For li_idx = 1 To li_max
	If Len(is_colfilter[li_idx]) > 0 Then
		If Len(ls_filter) > 0 Then
			ls_filter += " AND "
		End If
		ls_filter += "( " + is_colfilter[li_idx] + " )"
	End If
Next

Return ls_filter

end function

public subroutine of_setstyle (boolean ab_popupmenu, boolean ab_arrow, boolean ab_shade, boolean ab_highlite);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_gridstyle.of_SetStyle
//
// PURPOSE:    This function sets the options to display sort arrows
//					or to shade the column background. Also sets option to have
//					header highlited when the mouse is over it.
//
// ARGUMENTS:  ab_popupmenu	- The popup menu option
//					ab_arrow			- The arrow option
//					ab_shade			- The shade option
//					ab_highlite		- The highlight header option
// -----------------------------------------------------------------------------

Integer li_col, li_max
String  ls_colname

ib_popupmenu = ab_popupmenu
ib_arrow     = ab_arrow
ib_shade     = ab_shade
ib_highlite  = ab_highlite

idw_client.SetRedraw(False)

// delete any existing visuals
of_DelVisuals()

// add any desired visuals
of_AddVisuals()

// add headerlines
If ib_highlite And ib_highlite_added = False Then
	ib_highlite_added = True
	li_max = Integer(idw_client.Object.DataWindow.Column.Count)
	For li_col = 1 To li_max
		If idw_client.Describe("#" + String(li_col) + ".Visible") = "1" Then
			ls_colname = idw_client.Describe("#" + String(li_col) + ".Name")
			of_HeaderLine(ls_colname)
		End If
	Next
End If

idw_client.SetRedraw(True)

end subroutine

on n_svc_dw_gridstyle.create
call super::create
end on

on n_svc_dw_gridstyle.destroy
call super::destroy
end on

event constructor;call super::constructor;// initialize line colors
If IsThemeActive() Then
	is_graycolor[1] = String(RGB(203,199,184))
	is_graycolor[2] = String(RGB(214,210,194))
	is_graycolor[3] = String(RGB(226,222,205))
Else
	is_graycolor[1] = TRANSPARENT
	is_graycolor[2] = TRANSPARENT
	is_graycolor[3] = TRANSPARENT
End If

is_orangecolor[1] = String(RGB(207,114,37))
is_orangecolor[2] = String(RGB(227,145,79))
is_orangecolor[3] = String(RGB(227,150,88))

end event

