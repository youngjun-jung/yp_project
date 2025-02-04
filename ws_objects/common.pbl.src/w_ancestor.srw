$PBExportHeader$w_ancestor.srw
forward
global type w_ancestor from window
end type
end forward

global type w_ancestor from window
string tag = "xywh"
integer width = 6190
integer height = 2916
windowtype windowtype = child!
string icon = "AppIcon!"
event ue_resize ( )
event type boolean ue_retrieve ( )
event type boolean ue_new ( )
event type boolean ue_save ( )
event type boolean ue_delete ( )
event ue_excel ( )
event type boolean ue_print ( )
event ue_preview ( )
end type
global w_ancestor w_ancestor

type variables
str_size istr_size[30], istr_tab_size[30]
end variables

forward prototypes
public subroutine wf_resize ()
end prototypes

event type boolean ue_retrieve();return false
end event

event type boolean ue_new();return false
end event

event type boolean ue_save();return false
end event

event type boolean ue_delete();return false
end event

event ue_excel();return
end event

event type boolean ue_print();return false
end event

event ue_preview();return
end event

public subroutine wf_resize ();Long   i, j, k, ll_count, ll_tab_count
String ls_tag

Object     lo_typeof
DragObject ldo_object  , ldo_tab_object
Tab        tab_object

SetRedraw(FALSE)

//w_mainmdi.event ue_resize()

FOR i = 1 TO UpperBound(Control)
		
	lo_typeof = TypeOf(Control[i])
	
	IF lo_typeof = Rectangle!      OR &
		lo_typeof = RoundRectangle! THEN CONTINUE
			
	ll_count++

	ldo_object = Control[i]
	
	//messagebox("WorkSpaceWidth ()", WorkSpaceWidth ())
			
	ls_tag = Lower(ldo_object.Tag)
	/*
	IF Pos(ls_tag, 'x') > 0 THEN ldo_object.X      = WorkSpaceWidth () - istr_size[ll_count].X
	IF Pos(ls_tag, 'y') > 0 THEN ldo_object.Y      = WorkSpaceHeight() - istr_size[ll_count].Y
	IF Pos(ls_tag, 'w') > 0 THEN ldo_object.Width  = WorkSpaceWidth () - istr_size[ll_count].Width - 400
	IF Pos(ls_tag, 'h') > 0 THEN ldo_object.Height = WorkSpaceHeight() - istr_size[ll_count].Height - 1200
	*/
	IF Pos(ls_tag, 'x') > 0 THEN ldo_object.X      = gl_width //WorkSpaceWidth ()
	IF Pos(ls_tag, 'y') > 0 THEN ldo_object.Y      = gl_height //WorkSpaceHeight() 
	IF Pos(ls_tag, 'w') > 0 THEN ldo_object.Width  = w_mainmdi.mdi_1.Width - 400
	IF Pos(ls_tag, 'h') > 0 THEN ldo_object.Height = w_mainmdi.mdi_1.Height - 1200

	IF TypeOf(Control[i]) = Tab! THEN
		
		tab_object = ldo_object
		
		FOR j = 1 TO UpperBound(tab_object.Control)
			
			FOR k = 1 TO UpperBound(tab_object.Control[j].Control)
				
				IF tab_object.Control[j].Control[k].TypeOf() = Rectangle!      OR &
					tab_object.Control[j].Control[k].TypeOf() = RoundRectangle! THEN CONTINUE
					
				ll_tab_count++
			
				ldo_tab_object = tab_object.Control[j].Control[k]
			
				ls_tag = Lower(ldo_tab_object.Tag)
			/*	
				IF Pos(ls_tag, 'x') > 0 THEN ldo_tab_object.X      = WorkSpaceWidth () - istr_tab_size[ll_tab_count].X
				IF Pos(ls_tag, 'y') > 0 THEN ldo_tab_object.Y      = WorkSpaceHeight() - istr_tab_size[ll_tab_count].Y
				IF Pos(ls_tag, 'w') > 0 THEN ldo_tab_object.Width  = WorkSpaceWidth () - istr_tab_size[ll_tab_count].Width
				IF Pos(ls_tag, 'h') > 0 THEN ldo_tab_object.Height = WorkSpaceHeight() - istr_tab_size[ll_tab_count].Height
			*/	
				IF Pos(ls_tag, 'x') > 0 THEN ldo_object.X      = gl_width //WorkSpaceWidth ()
				IF Pos(ls_tag, 'y') > 0 THEN ldo_object.Y      = gl_height //WorkSpaceHeight() 
				IF Pos(ls_tag, 'w') > 0 THEN ldo_object.Width  = w_mainmdi.mdi_1.Width - 400
				IF Pos(ls_tag, 'h') > 0 THEN ldo_object.Height = w_mainmdi.mdi_1.Height - 1200
				
			
			NEXT					
			
		NEXT
		
	END IF
			
NEXT

SetRedraw(TRUE)
end subroutine

on w_ancestor.create
end on

on w_ancestor.destroy
end on

