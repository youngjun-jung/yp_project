$PBExportHeader$n_svc_dw_selectrow.sru
forward
global type n_svc_dw_selectrow from n_svc_dw_base
end type
end forward

global type n_svc_dw_selectrow from n_svc_dw_base
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
event rowfocuschanged pbm_dwnrowchange
end type
global n_svc_dw_selectrow n_svc_dw_selectrow

type prototypes

end prototypes

type variables
String is_style
Long   il_start
end variables

forward prototypes
public subroutine of_select_single (long al_row)
public subroutine of_select_extend (long al_row, boolean ab_ctrl, boolean ab_shift)
public subroutine of_setselectstyle (string as_style)
end prototypes

event clicked;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.Clicked
//
// PURPOSE:    This event will select rows based on the current style.
//
// ARGUMENTS:  xpos	-	The distance of the pointer from the left side of the
//								DataWindow workspace.
//					ypos	-	The distance of the pointer from the top of the
//								DataWindow workspace.
//					row	-	The number of the row the user clicked.
//					dwo	-	A reference to the control within the DataWindow under
//								the pointer when the user clicked.
// -----------------------------------------------------------------------------

Choose Case is_style
	Case "single"
		of_Select_Single(row)
	Case "extend"
		of_Select_Extend(row, KeyDown(KeyControl!), KeyDown(KeyShift!))
End Choose

Return 0

end event

event doubleclicked;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.DoubleClicked
//
// PURPOSE:    This event will deselect all rows except current.
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
// 11/12/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

If Len(is_style) > 0 And row > 0 Then
	idw_client.SelectRow(0, False)
	idw_client.SelectRow(row, True)
End If

Return 0

end event

event rowfocuschanged;// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.RowFocusChanged
//
// PURPOSE:    This event will select rows based on the current style.
//
// ARGUMENTS:  currentrow	-	The number of the row that has just
//										become current.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

CHOOSE CASE is_style
	CASE "single"
		idw_client.SelectRow(0, False)
		idw_client.SelectRow(currentrow, True)
	CASE "extend"
		If Not KeyDown(KeyControl!) Then
			If Not KeyDown(KeyShift!) Then
				idw_client.SelectRow(0, False)
				idw_client.SelectRow(currentrow, True)
			Else
				idw_client.SelectRow(currentrow, True)
			End If
		End If
END CHOOSE
il_start = currentrow

Return 0

end event

public subroutine of_select_single (long al_row);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.of_Select_Single
//
// PURPOSE:    This function selects a single row.
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

If al_row = 0 Then Return

// deselect all rows
idw_client.SelectRow(0, False)

// select this row
idw_client.SelectRow(al_row, True)
il_start = al_row

// make this the current row
If idw_client.GetRow() <> al_row Then
	idw_client.SetRow(al_row)
	idw_client.ScrollToRow(al_row)
End If

end subroutine

public subroutine of_select_extend (long al_row, boolean ab_ctrl, boolean ab_shift);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.of_Select_Extend
//
// PURPOSE:    This function selects rows in extended select mode.
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Long ll_row

If al_row = 0 Then Return

If ab_ctrl Then
	If idw_client.IsSelected(al_row) Then
		idw_client.SelectRow(al_row, False)
	Else
		idw_client.SelectRow(al_row, True)
	End If
Else
	If ab_shift Then
		If il_start = 0 Then
			idw_client.SelectRow(al_row, True)
		Else
			If il_start < al_row Then
				FOR ll_row = il_start TO al_row
					idw_client.SelectRow(ll_row, True)
				NEXT
			Else
				FOR ll_row = al_row TO il_start
					idw_client.SelectRow(ll_row, True)
				NEXT
			End If
		End If
	Else
		of_select_single(al_row)
	End If 
End If

end subroutine

public subroutine of_setselectstyle (string as_style);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_selectrow.of_SetSelectStyle
//
// PURPOSE:    This function sets the select style. Allowed values:
//						single	- Selects one row
//						extend	- Selects multiple rows using shift&ctrl keys
//
// ARGUMENTS:  as_colname	- The column to process
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

is_style = Lower(as_style)

end subroutine

on n_svc_dw_selectrow.create
call super::create
end on

on n_svc_dw_selectrow.destroy
call super::destroy
end on

