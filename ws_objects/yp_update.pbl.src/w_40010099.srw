$PBExportHeader$w_40010099.srw
forward
global type w_40010099 from w_ancestor_free
end type
type dw_1 from u_dw_grid within w_40010099
end type
type dw_2 from u_dw_grid within w_40010099
end type
type cb_5 from commandbutton within w_40010099
end type
type hpb_upload from hprogressbar within w_40010099
end type
type sle_directory from singlelineedit within w_40010099
end type
type st_2 from statictext within w_40010099
end type
type pb_directory from picturebutton within w_40010099
end type
type pb_3 from picturebutton within w_40010099
end type
type pb_4 from picturebutton within w_40010099
end type
end forward

global type w_40010099 from w_ancestor_free
dw_1 dw_1
dw_2 dw_2
cb_5 cb_5
hpb_upload hpb_upload
sle_directory sle_directory
st_2 st_2
pb_directory pb_directory
pb_3 pb_3
pb_4 pb_4
end type
global w_40010099 w_40010099

type variables
n_upgrade_n u_upgrade
end variables

on w_40010099.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_5=create cb_5
this.hpb_upload=create hpb_upload
this.sle_directory=create sle_directory
this.st_2=create st_2
this.pb_directory=create pb_directory
this.pb_3=create pb_3
this.pb_4=create pb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_5
this.Control[iCurrent+4]=this.hpb_upload
this.Control[iCurrent+5]=this.sle_directory
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.pb_directory
this.Control[iCurrent+8]=this.pb_3
this.Control[iCurrent+9]=this.pb_4
end on

on w_40010099.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_5)
destroy(this.hpb_upload)
destroy(this.sle_directory)
destroy(this.st_2)
destroy(this.pb_directory)
destroy(this.pb_3)
destroy(this.pb_4)
end on

event closequery;call super::closequery;DESTROY u_upgrade
end event

event open;call super::open;
u_upgrade = CREATE n_upgrade_n
	
u_upgrade.ShareData(dw_1)
	
sle_directory.Text = gstr_userenv.path
	
pb_directory.Event Clicked()

dw_2.settransobject(sqlca)
	
dw_2.SetRedraw(FALSE)
	
dw_2.Retrieve()
	
dw_2.SetRedraw(TRUE)

sle_directory.setfocus()
	

end event

type st_1 from w_ancestor_free`st_1 within w_40010099
end type

type sle_id from w_ancestor_free`sle_id within w_40010099
end type

type dw_1 from u_dw_grid within w_40010099
integer x = 238
integer y = 532
integer width = 2482
integer height = 2012
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_source"
end type

event clicked;call super::clicked;IF row < 1 THEN RETURN

if dw_1.object.chk[row] ='Y' then
	 dw_1.object.chk[row] ='N'
else
	 dw_1.object.chk[row] ='Y'
end if

end event

type dw_2 from u_dw_grid within w_40010099
integer x = 3195
integer y = 532
integer width = 2592
integer height = 2008
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_target"
end type

type cb_5 from commandbutton within w_40010099
integer x = 2816
integer y = 444
integer width = 288
integer height = 168
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "업로드"
end type

event clicked;Long     i, ll_find, ll_newrow, ll_fileopen, ll_count
Boolean  lb_update
String   ls_path, ls_chk, ls_return

Long     ll_rowcnt_source , ll_rowcnt_target , ll_filesize
Datetime ld_created_source, ld_created_target, ld_modified_source, ld_modified_target, ld_accessed_source
String   ls_filename
Blob     lb_file
str_parameter lstr_parameter

ls_path = sle_directory.Text

ll_rowcnt_source = dw_1.RowCount()
ll_rowcnt_target = dw_2.RowCount()

hpb_upload.MaxPosition = ll_rowcnt_source

SetPointer(HourGlass!)

FOR i = 1 TO ll_rowcnt_source
	
	Yield()
	
	hpb_upload.StepIt()
	
	dw_1.ScrollToRow(i)
	
	lb_update = FALSE
	
	ls_filename        = dw_1.GetItemString  (i, 'name'      )
	ls_chk				 = dw_1.GetItemString  (i, 'chk'       )
	ll_filesize        = dw_1.GetItemNumber  (i, 'size'      )
	ld_created_source  = dw_1.GetItemDatetime(i, 'createdate')
	ld_modified_source = dw_1.GetItemDatetime(i, 'writedate' )
	ld_accessed_source = dw_1.GetItemDatetime(i, 'accessdate')

	if ls_chk = 'N' then CONTINUE
			
	ll_find = dw_2.Find("fileid = '" + ls_filename + "'", 1, ll_rowcnt_target)
	
	IF ll_find = 0 THEN
		
		ll_newrow = dw_2.InsertRow(0)
		
		dw_2.SetItem(ll_newrow, 'fileid'     , ls_filename       )
		dw_2.SetItem(ll_newrow, 'filesize'   , ll_filesize       )
		dw_2.SetItem(ll_newrow, 'created_dt' , ld_created_source )
		dw_2.SetItem(ll_newrow, 'modified_dt', ld_modified_source)
		dw_2.SetItem(ll_newrow, 'accessed_dt', ld_accessed_source)
		
		dw_2.ScrollToRow(ll_newrow)
		
		lb_update = TRUE
		
	ELSE
		
		ld_created_target  = dw_2.GetItemDatetime(ll_find, 'created_dt' )
		ld_modified_target = dw_2.GetItemDatetime(ll_find, 'modified_dt')
		
		IF String(ld_created_target , 'YYYYMMDDHHMMSS') < String(ld_created_source , 'YYYYMMDDHHMMSS') OR &
			String(ld_modified_target, 'YYYYMMDDHHMMSS') < String(ld_modified_Source, 'YYYYMMDDHHMMSS') THEN
			
			lb_update = TRUE
			
			dw_2.SetItem(ll_find, 'filesize'   , ll_filesize       )
			dw_2.SetItem(ll_find, 'created_dt' , ld_created_source )
			dw_2.SetItem(ll_find, 'modified_dt', ld_modified_source)
			dw_2.SetItem(ll_find, 'accessed_dt', ld_accessed_source)
		
			dw_2.ScrollToRow(ll_find)
			
		ELSE
			
			CONTINUE
			
		END IF
		
	END IF
	
	IF NOT lb_update THEN CONTINUE
	
	ll_count++
	
	lstr_parameter.strvalue[1] = ls_path
	lstr_parameter.strvalue[2] = ls_filename
	
	//openwithparm(w_hpc9992_pop, lstr_parameter)
	
	ls_return = Message.StringParm   
	
	if len(ls_return) <> 14 then
		hpb_upload.Position = ll_rowcnt_source
		messagebox("확인", "update가 취소되었습니다.")
		return
	end if
	
	ll_fileopen = FileOpen(ls_path + "\" + ls_filename, StreamMode!)

	FileReadEx(ll_fileopen, lb_file)
		
	FileClose(ll_fileopen)
		
	IF dw_2.Update() = -1 THEN
		ROLLBACK USING TRHPC;
		RETURN
	END IF
	/*
	UPDATEBLOB HIPLUS_CS.TB_UPDATE_COCARD
			 SET FILEBLOB = :lb_file
		  WHERE FILEID = :ls_filename
		  USING SQLCA;
		  
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("UPDATEBLOB Error", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;
		RETURN
	END IF
	
	UPDATEBLOB HIS_UPDATE_CS
			 SET FILEBLOB = :lb_file
		  WHERE UPDATEDATE = :ls_return
		  AND GUBUN = '7'
		  USING SQLCA;
		  
	IF SQLCA.SQLCode = -1 THEN
		MessageBox("UPDATEBLOB Error", SQLCA.SQLErrText)
		ROLLBACK USING SQLCA;
		RETURN
	END IF
	*/
NEXT
	
COMMIT USING SQLCA;

SetPointer(Arrow!)

IF ll_count = 0 THEN
	MessageBox("확인", "업로드 할 파일이 없습니다.")
	st_2.text = "업로드 할 파일이 없습니다."
ELSE
	MessageBox("확인", "파일업로드(" + String(ll_count) + "건)가 완료되었습니다.")
	st_2.text = "파일업로드(" + String(ll_count) + "건)가 완료되었습니다."
END IF


end event

type hpb_upload from hprogressbar within w_40010099
integer x = 3195
integer y = 392
integer width = 1883
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type sle_directory from singlelineedit within w_40010099
integer x = 814
integer y = 308
integer width = 1906
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_40010099
integer x = 512
integer y = 432
integer width = 2226
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217857
long backcolor = 553648127
boolean focusrectangle = false
end type

type pb_directory from picturebutton within w_40010099
integer x = 238
integer y = 296
integer width = 265
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "폴더"
boolean originalsize = true
end type

event clicked;String ls_path

ls_path = sle_directory.Text

IF GetFolder("폴더선택", ls_path) = 1 THEN
	sle_directory.Text = ls_path
	SetPointer(HourGlass!)
	SetRedraw(FALSE)
	u_upgrade.of_Directory(ls_path)
	SetRedraw(TRUE)
END IF
end event

type pb_3 from picturebutton within w_40010099
integer x = 526
integer y = 296
integer width = 265
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
boolean originalsize = true
end type

event clicked;String ls_path

ls_path = sle_directory.text

SetProfileString("hpc.ini", "PATH", "path", ls_path)

gstr_userenv.path = ls_path

messagebox("확인", "해당 경로를 저장하였습니다.")
end event

type pb_4 from picturebutton within w_40010099
integer x = 238
integer y = 408
integer width = 265
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전체선택"
boolean originalsize = true
end type

event clicked;Long ll_rowcount, i
String ls_chk

ll_rowcount = dw_1.rowcount()
				
FOR i = 1 TO ll_rowcount
	ls_chk = dw_1.object.chk[i]
	
	if ls_chk = 'N' then
		dw_1.object.chk[i] ='Y'
	else
		dw_1.object.chk[i] ='N'
	end if
	
NEXT	
dw_1.accepttext()
end event

