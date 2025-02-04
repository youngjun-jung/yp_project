$PBExportHeader$u_dw_toolbar_menu.sru
$PBExportComments$Datawindow Toolbar UserObject
forward
global type u_dw_toolbar_menu from datawindow
end type
end forward

global type u_dw_toolbar_menu from datawindow
integer width = 3739
integer height = 100
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event mousemove pbm_dwnmousemove
event mouseleave ( )
event lbuttonup pbm_dwnlbuttonup
end type
global u_dw_toolbar_menu u_dw_toolbar_menu

type variables
Boolean ib_lbtn_clicking
String  is_old_object = ""

Constant ULong WM_MOUSELEAVE = 675
end variables

forward prototypes
public subroutine of_excute (string as_object)
public subroutine of_setpicture (string as_icon[], string as_text[])
public function window of_getwindow (dragobject adrg_object)
end prototypes

event mousemove;String ls_now_object, ls_old_picture, ls_now_picture, ls_disable

ls_now_object = dwo.Name

IF NOT Right(is_old_object, 2) = Right(ls_now_object, 2) THEN
	
	// 기존 활성화된 오브젝트가 존재하는 경우 초기화
	
	IF NOT gf_chk_null(is_old_object) THEN
		
		// BackGround
		ls_old_picture = GetItemString(1, is_old_object)
		ls_old_picture = Reverse('fig.10' + Mid(Reverse(ls_old_picture), 7))
		
		SetItem(1, is_old_object, ls_old_picture)
		
		Modify(is_old_object + ".Border = 0")
		
	END IF

	IF (NOT dwo.Type = 'text') OR (ib_lbtn_clicking) THEN		// Not Column, Not Button Clicking
		is_old_object = ""
		RETURN
	END IF
	
	IF NOT Left(ls_now_object, 4) = 'back' THEN ls_now_object = 'back' + Right(ls_now_object, 2)
	
	//messagebox("GetItemString(1, ls_now_object)", GetItemString(1, ls_now_object))
	
	ls_now_picture = GetItemString(1, ls_now_object)
	
	// Disable
	IF Right(ls_now_picture, 6) = '04.gif' THEN
		is_old_object = ""
		RETURN
	END IF	
	
	ls_now_picture = Reverse('fig.20' + Mid(Reverse(ls_now_picture), 7))
	
	SetItem(1, ls_now_object, ls_now_picture)

	Modify(ls_now_object + ".Border = 0")
	
	is_old_object = ls_now_object
	
END IF


end event

event mouseleave();String ls_old_picture

IF NOT gf_chk_null(is_old_object) THEN
	
	ls_old_picture = GetItemString(1, is_old_object)
	ls_old_picture = Reverse('fig.10' + Mid(Reverse(ls_old_picture), 7))
	
	SetItem(1, is_old_object, ls_old_picture)
		
	Modify(is_old_object + ".Border = 0")
	
END IF
	
ib_lbtn_clicking = FALSE
is_old_object    = ""
end event

event lbuttonup;
String ls_now_object, ls_now_picture

ib_lbtn_clicking = FALSE
	
ls_now_object = dwo.Name

IF dwo.Type = 'column' or dwo.Type = 'text'  THEN
		
	IF NOT Left(ls_now_object, 4) = 'back' THEN ls_now_object = 'back' + Right(ls_now_object, 2)

	IF Right(is_old_object, 2) = Right(ls_now_object, 2) THEN

		ls_now_picture = GetItemString(1, ls_now_object)	
		ls_now_picture = Reverse('fig.20' + Mid(Reverse(ls_now_picture), 7))
		
		SetItem(1, ls_now_object, ls_now_picture)
		
//		Modify(ls_now_object + ".Border = 6")
		Modify(ls_now_object + ".Border = 0")
		
		of_excute(ls_now_object)
		
	ELSE
	
		ls_now_picture = GetItemString(1, ls_now_object)
		
		IF NOT Right(ls_now_picture, 6) = '04.gif' THEN
	
			ls_now_picture = Reverse('fig.20' + Mid(Reverse(ls_now_picture), 7))
			
			SetItem(1, ls_now_object, ls_now_picture)
		
			Modify(ls_now_object + ".Border = 0")

			is_old_object = ls_now_object
			
		END IF
		
	END IF
	
END IF
end event

public subroutine of_excute (string as_object);String ls_icon, ls_value

Window lw_window

lw_window = of_getwindow(This)

ls_value = as_object

IF lw_window.ClassName() = 'w_mainmdi' THEN	lw_window = w_mainmdi.GetActiveSheet()

IF NOT IsValid(lw_window) THEN RETURN

CHOOSE CASE TRUE
		
CASE Pos(ls_value, 'back01') > 0 AND gs_ret = '1'
		
		lw_window.Dynamic Event ue_retrieve()
		
	CASE Pos(ls_value, 'back02') > 0 AND gs_new = '1'
		
		lw_window.Dynamic Event ue_new()
		
	CASE Pos(ls_value, 'back03') > 0 AND gs_save = '1'
		
		lw_window.Dynamic Event ue_save()
		
	CASE Pos(ls_value, 'back04') > 0 AND gs_del = '1'
		
		lw_window.Dynamic Event ue_delete()
		
	CASE Pos(ls_value, 'back05') > 0 AND gs_pre = '1'
		
		lw_window.Dynamic Event ue_preview()
		
	CASE Pos(ls_value, 'back06') > 0 AND gs_print = '1'
		
		lw_window.Dynamic Event ue_print()
		
	CASE Pos(ls_value, 'back07') > 0 AND gs_exel = '1'
		
		lw_window.Dynamic Event ue_excel()
		
	CASE Pos(ls_value, 'back08') > 0 AND gs_close = '1'
		
		Close(lw_window)

		lw_window = w_mainmdi.GetActiveSheet()
		
		gf_window_control('close', ClassName(), Title)
		
		IF lw_window.ClassName() = 'w_main_bg' THEN	w_mainmdi.wf_chk_menu_fun_id('0')
		
END CHOOSE
end subroutine

public subroutine of_setpicture (string as_icon[], string as_text[]);Long i, ll_close

ll_close = UpperBound(as_icon)

FOR i = 1 TO ll_close
	SetItem(1, 'icon' + String(i, '00'), as_icon[i])
	SetItem(1, 'text' + String(i, '00'), as_text[i])
NEXT
end subroutine

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

on u_dw_toolbar_menu.create
end on

on u_dw_toolbar_menu.destroy
end on

event other;IF Message.Number = WM_MOUSELEAVE THEN
	Event mouseleave()
END IF
end event

event constructor;Long i

InsertRow(1)

FOR i = 1 TO 10
//	SetItem(1, 'back' + String(i, '00'), gstr_userenv.Appdir + "\Res\Back01.gif")
	SetItem(1, 'back' + String(i, '00'), ".\Res\Back01.gif")
NEXT
end event

event clicked;String ls_now_object, ls_now_picture

IF dwo.Type = 'column' THEN
	
	ls_now_object = dwo.Name
	
	IF NOT Left(ls_now_object, 4) = 'back' THEN ls_now_object = 'back' + Right(ls_now_object, 2)
	
	CHOOSE CASE TRUE
		
	CASE Pos(ls_now_object, 'back01') > 0 AND gs_ret <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back02') > 0 AND gs_new <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back03') > 0 AND gs_save <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back04') > 0 AND gs_del <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back05') > 0 AND gs_pre <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back06') > 0 AND gs_print <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back07') > 0 AND gs_exel <> '1'
		
		return
		
	CASE Pos(ls_now_object, 'back08') > 0 AND gs_close <> '1'
		
		return
		
END CHOOSE
	
	ls_now_picture = GetItemString(1, ls_now_object)
	
	IF Right(ls_now_picture, 6) = '04.gif' THEN RETURN
	
	ls_now_picture = Reverse('fig.30' + Mid(Reverse(ls_now_picture), 7))
	
	SetItem(1, ls_now_object, ls_now_picture)
		
	Modify(ls_now_object + ".Border = 5")
	
	ib_lbtn_clicking = TRUE
	
END IF
end event

