$PBExportHeader$u_tab.sru
$PBExportComments$Tab Object
forward
global type u_tab from tab
end type
end forward

global type u_tab from tab
integer width = 2240
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
end type
global u_tab u_tab

event selectionchanged;
Window lw_sheet
gs_width_chk = '1'
gs_window = Control[newindex].Tag

lw_sheet = w_mainmdi.GetFirstSheet()
		
DO WHILE IsValid(lw_sheet)

	IF lw_sheet.ClassName() = gs_window THEN
		
		lw_sheet.BringToTop = TRUE
		lw_sheet.Post SetFocus()
		
		lw_sheet.windowstate = maximized!
		
		w_mainmdi.mdi_1.width = gl_width
		
		gs_width_chk = '0'

		w_mainmdi.mdi_1.width = gl_width - gl_tv_width

		w_mainmdi.mdi_1.Height = w_mainmdi.tv_menu.Height - w_mainmdi.uo_tab.Height

		RETURN

	END IF
	
	lw_sheet = w_mainmdi.GetNextSheet(lw_sheet)
	
LOOP

end event

event doubleclicked;//String gs_window
//
//Window lw_sheet
//
//IF index > 0 THEN
//
//	gs_window = Control[index].Tag
//	
//	lw_sheet = w_mainmdi.GetFirstSheet()
//			
//	DO WHILE IsValid(lw_sheet)
//	
//		IF lw_sheet.ClassName() = gs_window THEN
//			Close(lw_sheet)
//			RETURN
//		END IF
//		
//		lw_sheet = w_mainmdi.GetNextSheet(lw_sheet)
//		
//	LOOP
//	
//END IF
end event

