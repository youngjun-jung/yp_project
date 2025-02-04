$PBExportHeader$w_upgrade.srw
$PBExportComments$업그레이드
forward
global type w_upgrade from window
end type
type dw_2 from datawindow within w_upgrade
end type
type hpb_upgrade from hprogressbar within w_upgrade
end type
type st_message from statictext within w_upgrade
end type
type dw_1 from datawindow within w_upgrade
end type
end forward

global type w_upgrade from window
integer width = 1481
integer height = 280
boolean titlebar = true
string title = "업그레이드"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event type boolean ue_upgrade ( )
dw_2 dw_2
hpb_upgrade hpb_upgrade
st_message st_message
dw_1 dw_1
end type
global w_upgrade w_upgrade

type variables
n_upgrade u_upgrade
end variables

event type boolean ue_upgrade();Long     i, ll_find, ll_fileopen
Boolean  lb_update
String   ls_path

Long     ll_rowcnt_source , ll_rowcnt_target , ll_filesize
Datetime ld_created_source, ld_created_target, ld_modified_source, ld_modified_target, ld_accessed_source
String   ls_filename, ls_result
Blob     lb_file

ls_path = GetCurrentDirectory()

SetPointer(HourGlass!)

dw_1.Retrieve()

u_upgrade.of_Directory(ls_path)

ll_rowcnt_source = dw_1.RowCount()
ll_rowcnt_target = dw_2.RowCount()

hpb_upgrade.MaxPosition = ll_rowcnt_source

FOR i = 1 TO ll_rowcnt_source
	
	Yield()
	
	hpb_upgrade.StepIt()
	
	lb_update = FALSE
	
	ls_filename        = dw_1.GetItemString  (i, 'fileid'     )
	ll_filesize        = dw_1.GetItemNumber  (i, 'filesize'   )
	ld_created_source  = dw_1.GetItemDatetime(i, 'created_dt' )
	ld_modified_source = dw_1.GetItemDatetime(i, 'modified_dt')
	ld_accessed_source = dw_1.GetItemDatetime(i, 'accessed_dt')
	
	ll_find = dw_2.Find("name = '" + ls_filename + "'", 1, ll_rowcnt_target)
	
	IF ll_find = 0 THEN
		
		lb_update = TRUE
		
	ELSE
		
		ld_created_target  = dw_2.GetItemDatetime(ll_find, 'createdate')
		ld_modified_target = dw_2.GetItemDatetime(ll_find, 'writedate' )
		
		IF String(ld_created_target , 'YYYYMMDDHHMMSS') < String(ld_created_source , 'YYYYMMDDHHMMSS') OR &
			String(ld_modified_target, 'YYYYMMDDHHMMSS') < String(ld_modified_source, 'YYYYMMDDHHMMSS') THEN
			
			lb_update = TRUE
			
		ELSE
			
			CONTINUE
			
		END IF
		
	END IF
	
	IF NOT lb_update THEN CONTINUE
	
	st_message.Text = ls_path + "\" + ls_filename
	
	SELECTBLOB FILEBLOB
	      INTO :lb_file
			FROM TB_UPDATE_COCARD
		  WHERE FILEID = :ls_filename
		  USING SQLCA;
	
	ll_fileopen = FileOpen(ls_path + "\" + ls_filename, StreamMode!, Write!, LockWrite!, Replace!)
		
	FileWriteEx(ll_fileopen, lb_file)
		
	FileClose(ll_fileopen)
	
	u_upgrade.of_setfiletime(ls_path + "\" + ls_filename, ld_created_source, ld_accessed_source, ld_modified_source)
	
NEXT

DECLARE SP &
	PROCEDURE FOR SP_CON_CHK('7') using SQLCA;
									
	EXECUTE SP;
	
	FETCH SP INTO :ls_result;
	
	CLOSE SP;
	  
IF SQLCA.SQLCode = -1 THEN
          MessageBox("오류", SQLCA.SQLErrText)
          ROLLBACK USING SQLCA;
END IF

Run(ls_path + "\corporate_card.exe " + ls_result)

SetPointer(Arrow!)

HALT CLOSE

RETURN TRUE
end event

on w_upgrade.create
this.dw_2=create dw_2
this.hpb_upgrade=create hpb_upgrade
this.st_message=create st_message
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.hpb_upgrade,&
this.st_message,&
this.dw_1}
end on

on w_upgrade.destroy
destroy(this.dw_2)
destroy(this.hpb_upgrade)
destroy(this.st_message)
destroy(this.dw_1)
end on

event open;u_upgrade = CREATE n_upgrade

u_upgrade.ShareData(dw_2)

Post Event ue_upgrade()
end event

event closequery;DESTROY u_upgrade
end event

type dw_2 from datawindow within w_upgrade
integer x = 709
integer y = 216
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_source"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(SQLCA)
end event

type hpb_upgrade from hprogressbar within w_upgrade
integer x = 27
integer y = 108
integer width = 1385
integer height = 44
unsignedinteger maxposition = 100
integer setstep = 1
end type

type st_message from statictext within w_upgrade
integer x = 27
integer y = 16
integer width = 1385
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_upgrade
integer x = 27
integer y = 216
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_target"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(SQLCA)
end event

