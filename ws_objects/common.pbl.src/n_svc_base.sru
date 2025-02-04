$PBExportHeader$n_svc_base.sru
forward
global type n_svc_base from nonvisualobject
end type
end forward

global type n_svc_base from nonvisualobject
end type
global n_svc_base n_svc_base

type prototypes
Function ulong GetSysColor ( &
	integer nIndex &
	) Library "user32.dll"

end prototypes

type variables
String is_company = ""

end variables

forward prototypes
public function long of_parse (string as_text, string as_sep, ref string as_array[])
public subroutine of_initialize ()
public function unsignedlong of_syscolor (integer ai_index)
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
public function integer of_setreg (string as_subkey, string as_entry, string as_value)
public function integer of_setreg (string as_entry, string as_value)
public function string of_getreg (string as_subkey, string as_entry, string as_default)
public function string of_getreg (string as_entry, string as_default)
public function string of_getappname ()
public function window of_getwindow (dragobject adrg_object)
end prototypes

public function long of_parse (string as_text, string as_sep, ref string as_array[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_Parse
//
// PURPOSE:    This function parses a string into an array.
//
// ARGUMENTS:  as_text	- The object that was clicked on
//					as_sep	- The separator characters
//					as_array	- By ref output array
//
//	RETURN:		The number of items in the array
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_empty[], ls_work
Long ll_pos, ll_each

as_array = ls_empty

If IsNull(as_text) Or as_text = "" Then Return 0

ll_pos = Pos(as_text, as_sep)
DO WHILE ll_pos > 0
	ls_work = Trim(Left(as_text, ll_pos - 1))
	as_text = Trim(Mid(as_text, ll_pos + 1))
	as_array[UpperBound(as_array) + 1] = ls_work
	ll_pos = Pos(as_text, as_sep)
LOOP
as_array[UpperBound(as_array) + 1] = Trim(as_text)

Return UpperBound(as_array)

end function

public subroutine of_initialize ();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_Initialize
//
// PURPOSE:    This function is used by services for initialization.
//					It is called by of_Register in the descendant.
// -----------------------------------------------------------------------------

end subroutine

public function unsignedlong of_syscolor (integer ai_index);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_SysColor
//
// PURPOSE:    This function returns the color number for a system color.
//
// ARGUMENTS:  ai_index - The the color index.
//
// These are the argument values:
//
// Object                     Value Object                     Value
// -------------------------- ----- -------------------------- -----
// Scroll Bar                   0   Button Face                 15
// Desktop                      1   Button Shadow               16
// Active Title Bar             2   Disabled Text               17
// Inactive Title Bar           3   Button Text                 18
// Menu Bar                     4   Inactive Title Bar Text     19
// Window Background            5   Button Highlight            20
// Window Frame                 6   Button Dark Shadow          21
// Menu Text                    7   Button Light Shadow         22
// Window Text                  8   Tooltip Text                23
// Active Title Bar Text        9   Tooltip Background          24
// Active Border               10   Hyperlink                   26
// Inactive Border             11   Active Title Bar Gradient   27
// Application Workspace       12   Inactive Title Bar Gradient 28
// Highlight                   13   Flat Menu Highlight         29
// Highlight Text              14   Flat Menu Background        30
//
// RETURN:     Color number.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/12/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

Return GetSysColor(ai_index)

end function

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_ReplaceAll
//
// PURPOSE:    This function all of the occurrences of a string within
//					another string.
//
// ARGUMENTS:  as_oldstring	- The string to be updated
//					as_findstr		- The string to look for
//					as_replace		- The replacement string
//
//	RETURN:		The updated string
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring

end function

public function integer of_setreg (string as_subkey, string as_entry, string as_value);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_SetReg
//
// PURPOSE:    This function sets parameters in the registry.
//
// ARGUMENTS:  as_subkey	- Optional subkey
//					as_entry		- Entry name
//					as_value		- Value to be stored
//
//	RETURN:		Result of RegistrySet
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_regkey

// build registry key name
ls_regkey  = "HKEY_CURRENT_USER\Software\"
ls_regkey += is_company + "\" + of_GetAppName()
If Len(as_subkey) > 0 Then
	ls_regkey += "\" + as_subkey
End If

// set value in initialization source
Return RegistrySet(ls_regkey, as_entry, as_value)

end function

public function integer of_setreg (string as_entry, string as_value);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_SetReg
//
// PURPOSE:    This function sets parameters in the registry.
//
// ARGUMENTS:  as_entry		- Entry name
//					as_value		- Value to be stored
//
//	RETURN:		Result of RegistrySet
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Return this.of_SetReg("", as_entry, as_value)

end function

public function string of_getreg (string as_subkey, string as_entry, string as_default);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_SetReg
//
// PURPOSE:    This function gets parameters from the registry.
//
// ARGUMENTS:  as_subkey	- Optional subkey
//					as_entry		- Entry name
//					as_value		- Default value if none found
//
//	RETURN:		The value stored in the registry.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

String ls_regkey, ls_regvalue

// build registry key name
ls_regkey  = "HKEY_CURRENT_USER\Software\"
ls_regkey += is_company + "\" + of_GetAppName()
If Len(as_subkey) > 0 Then
	ls_regkey += "\" + as_subkey
End If

// get value from initialization source
RegistryGet(ls_regkey, as_entry, ls_regvalue)
If ls_regvalue = "" Then
	ls_regvalue = as_default
End If

Return ls_regvalue

end function

public function string of_getreg (string as_entry, string as_default);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_SetReg
//
// PURPOSE:    This function gets parameters from the registry.
//
// ARGUMENTS:  as_entry		- Entry name
//					as_value		- Default value if none found
//
//	RETURN:		The value stored in the registry.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/03/2006  RolandS		Initial creation
// -----------------------------------------------------------------------------

Return this.of_GetReg("", as_entry, as_default)

end function

public function string of_getappname ();// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_GetAppName
//
// PURPOSE:    This function returns the application name.
//
// RETURN:     Applicaton name.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 12/05/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

String ls_appname
Application la_app

la_app = GetApplication()
If la_app.DisplayName = "" Then
	ls_appname = WordCap(la_app.AppName)
Else
	ls_appname = WordCap(la_app.DisplayName)
End If

Return ls_appname

end function

public function window of_getwindow (dragobject adrg_object);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_base.of_GetWindow
//
// PURPOSE:    This function returns the parent window for the control.
//
// ARGUMENTS:  adrg_object	- Object to get parent of
//
// RETURN:     The parent window.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/03/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

PowerObject	lpo_parent
Window lw_window

// loop thru parents until a window is found
lpo_parent = adrg_object.GetParent()
Do While lpo_parent.TypeOf() <> Window! and IsValid(lpo_parent)
	lpo_parent = lpo_parent.GetParent()
Loop

// set return to the window or null if not found
If IsValid (lpo_parent) Then
	lw_window = lpo_parent
Else
	SetNull(lw_window)
End If

Return lw_window

end function

on n_svc_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_svc_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

