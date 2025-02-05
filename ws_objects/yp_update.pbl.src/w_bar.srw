$PBExportHeader$w_bar.srw
forward
global type w_bar from window
end type
type dw_4 from datawindow within w_bar
end type
type dw_3 from datawindow within w_bar
end type
type dw_2 from datawindow within w_bar
end type
type dw_1 from datawindow within w_bar
end type
type hpb_upgrade from hprogressbar within w_bar
end type
type st_1 from statictext within w_bar
end type
end forward

global type w_bar from window
integer width = 1495
integer height = 236
boolean enabled = false
windowtype windowtype = response!
string icon = "AppIcon!"
boolean center = true
event ue_open ( string as_code )
event type boolean ue_upgrade ( )
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
hpb_upgrade hpb_upgrade
st_1 st_1
end type
global w_bar w_bar

type variables
n_upgrade u_upgrade
n_upgrade_res u_upgrade_res
end variables

forward prototypes
public function boolean wf_file_api (string as_filename)
public function boolean wf_file_res_api (string as_filename)
end prototypes

event type boolean ue_upgrade();Long     i, ll_find, ll_fileopen
Boolean  lb_update, lb_result
String   ls_path, ls_body, ls_result, ls_error, ls_gubun
Long ll_root, ll_count, ll_index, ll_child, ll_row, ll_data_array
JSONParser lnv_json

Long     ll_rowcnt_source , ll_rowcnt_target , ll_filesize
Datetime ld_created_source, ld_created_target, ld_modified_source, ld_modified_target, ld_accessed_source
String   ls_filename
Blob     lb_file

ls_path = GetCurrentDirectory()

SetPointer(HourGlass!)

//dw_1.Retrieve()

u_upgrade.of_Directory(ls_path)
u_upgrade_res.of_Directory(ls_path + '\res')

ls_body = 'fileid=%'

ls_result = gf_api_call("http://localhost:3000/api/file", 'GET', ls_body)

// messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
	RETURN false
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN false

lnv_json = CREATE JSONParser

ls_error = lnv_json.LoadString(ls_result)

if Len(ls_error) > 0 then
    MessageBox("Error", "JSON 파싱 실패: " + ls_error)
    Destroy lnv_json
    RETURN false
end if

ll_root = lnv_json.getrootitem( )  

if ll_root <= 0 then
    MessageBox("Error", "루트 노드를 가져오지 못했습니다.")
    Destroy lnv_json
    return false
end if

// 'data' 배열 가져오기
ll_data_array = lnv_json.GetItemArray(ll_root, "data")

if ll_data_array < 0 then
    MessageBox("Error", "'data' 배열을 찾을 수 없습니다.")
    Destroy lnv_json
    return false
end if

//messagebox("ll_data_array", ll_data_array)

ll_count = lnv_json.getchildcount( ll_data_array )  

// DataWindow 초기화
dw_3.Reset()
dw_4.Reset()

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  

	ls_gubun = lnv_json.getitemstring( ll_child, "gubun")  
	
	if ls_gubun = 'YP' then
		
		ll_row = dw_3.insertrow(0)
		
		dw_3.object.name[ll_row] = lnv_json.getitemstring( ll_child, "fileid")  
		dw_3.object.size[ll_row] = lnv_json.getitemnumber( ll_child, "filesize")  
		dw_3.object.ver[ll_row] = lnv_json.getitemstring( ll_child, "ver")  
		dw_3.object.createdate[ll_row] = lnv_json.getitemdatetime( ll_child, "created_dt")  
		dw_3.object.writedate[ll_row] = lnv_json.getitemdatetime( ll_child, "modified_dt")  
	
	elseif ls_gubun = 'RES' then 
		
		ll_row = dw_4.insertrow(0)
		
		dw_4.object.name[ll_row] = lnv_json.getitemstring( ll_child, "fileid")  
		dw_4.object.size[ll_row] = lnv_json.getitemnumber( ll_child, "filesize")  
		dw_4.object.ver[ll_row] = lnv_json.getitemstring( ll_child, "ver")  
		dw_4.object.createdate[ll_row] = lnv_json.getitemdatetime( ll_child, "created_dt")  
		dw_4.object.writedate[ll_row] = lnv_json.getitemdatetime( ll_child, "modified_dt")  
		
	end if

next  
		
DESTROY lnv_json

ll_rowcnt_source = dw_1.RowCount()
ll_rowcnt_target = dw_3.RowCount()

hpb_upgrade.MaxPosition = ll_rowcnt_source

FOR i = 1 TO ll_rowcnt_target
	
	Yield()
	
	hpb_upgrade.StepIt()
	
	lb_update = FALSE
	
	ls_filename        = dw_3.GetItemString  (i, 'name'     )
	ll_filesize        = dw_3.GetItemNumber  (i, 'size'   )
	ld_created_target  = dw_3.GetItemDatetime(i, 'createdate' )
	ld_modified_target = dw_3.GetItemDatetime(i, 'writedate')
	
	st_1.text = ls_path + '\' + ls_filename
	
	ll_find = dw_1.Find("name = '" + ls_filename + "'", 1, ll_rowcnt_target)

	IF ll_find = 0 THEN
		
		lb_update = TRUE
		
	ELSE
		
		ld_created_source  = dw_1.GetItemDatetime(ll_find, 'createdate')
		ld_modified_source = dw_1.GetItemDatetime(ll_find, 'writedate' )
		
		IF String(ld_created_target , 'YYYYMMDDHHMMSS') > String(ld_created_source , 'YYYYMMDDHHMMSS') OR &
			String(ld_modified_target, 'YYYYMMDDHHMMSS') > String(ld_modified_source, 'YYYYMMDDHHMMSS') THEN
			
			lb_update = TRUE
			
		ELSE
			
			CONTINUE
			
		END IF
		
	END IF
	
	IF NOT lb_update THEN CONTINUE
	
	lb_result = wf_file_res_api(ls_filename)
	
	IF NOT lb_update THEN
		messagebox("오류", "파일 다운로드 오류 : " + ls_filename)
	END IF
	
NEXT

ll_rowcnt_source = dw_2.RowCount()
ll_rowcnt_target = dw_4.RowCount()

hpb_upgrade.MaxPosition = ll_rowcnt_source

FOR i = 1 TO ll_rowcnt_target
	
	Yield()
	
	hpb_upgrade.StepIt()
	
	lb_update = FALSE
	
	ls_filename        = dw_4.GetItemString  (i, 'name'     )
	ll_filesize        = dw_4.GetItemNumber  (i, 'size'   )
	ld_created_target  = dw_4.GetItemDatetime(i, 'createdate' )
	ld_modified_target = dw_4.GetItemDatetime(i, 'writedate')
	
	st_1.text = ls_path + '\' + ls_filename
	
	ll_find = dw_2.Find("name = '" + ls_filename + "'", 1, ll_rowcnt_target)

	IF ll_find = 0 THEN
		
		lb_update = TRUE
		
	ELSE
		
		ld_created_source  = dw_2.GetItemDatetime(ll_find, 'createdate')
		ld_modified_source = dw_2.GetItemDatetime(ll_find, 'writedate' )
		
		IF String(ld_created_target , 'YYYYMMDDHHMMSS') > String(ld_created_source , 'YYYYMMDDHHMMSS') OR &
			String(ld_modified_target, 'YYYYMMDDHHMMSS') > String(ld_modified_source, 'YYYYMMDDHHMMSS') THEN
			
			lb_update = TRUE
			
		ELSE
			
			CONTINUE
			
		END IF
		
	END IF
	
	IF NOT lb_update THEN CONTINUE
	
	lb_result = wf_file_api(ls_filename)
	
	IF NOT lb_update THEN
		messagebox("오류", "파일 다운로드 오류 : " + ls_filename)
	END IF
	
NEXT

HALT CLOSE

return true 

Run(ls_path + "\yp.exe u")

SetPointer(Arrow!)

HALT CLOSE

RETURN TRUE
end event

public function boolean wf_file_api (string as_filename);// 변수 선언
HTTPClient lnv_http
Blob lblb_response
Integer li_status, li_FileNum
String ls_url, ls_filePath, ls_fileName, ls_ver

ls_fileName = as_filename

// REST API URL 설정 (다운로드할 파일의 엔드포인트)
ls_url = "http://localhost:3000/api/update?fileName=" + ls_fileName

// 로컬에 저장할 파일 경로
//ls_filePath = "d:\downloads\" + ls_fileName
ls_filePath = GetCurrentDirectory() + "\" + ls_fileName

// HTTPClient 객체 생성
lnv_http = Create HTTPClient

// 인증 키 설정 (Authorization 헤더에 추가)
lnv_http.SetRequestHeader("x-api-key", "YP")

// GET 요청 보내기
li_status = lnv_http.SendRequest("GET", ls_url)

// 상태 코드 확인 및 처리
If li_status = 1 Then // 요청 성공 여부 확인
    If lnv_http.GetResponseStatusCode() = 200 Then // HTTP 상태 코드가 200인지 확인
        // 응답 데이터를 Blob으로 가져오기
        lnv_http.GetResponseBody(lblb_response)

		// 파일 열기 (스트림 모드, 쓰기 권한)
		li_FileNum = FileOpen(ls_FilePath, StreamMode!, Write!, LockWrite!, Replace!)
		
		If li_FileNum < 0 Then
			 MessageBox("오류", "파일을 열 수 없습니다: " + ls_FilePath)
			 Return false
		End If  

        // Blob 데이터를 로컬 파일로 저장
        FileWriteEx(li_FileNum, lblb_response)
        //MessageBox("성공", "파일이 성공적으로 다운로드되었습니다: " + ls_filePath)
    Else
        //MessageBox("오류", "HTTP 상태 코드: " + String(lnv_http.GetResponseStatusCode()))
	   return false	  
    End If
Else
    //MessageBox("오류", "GET 요청 실패")
	Return false 
End If

FileClose(li_FileNum)

// HTTPClient 객체 제거
Destroy lnv_http

return true


end function

public function boolean wf_file_res_api (string as_filename);// 변수 선언
HTTPClient lnv_http
Blob lblb_response
Integer li_status, li_FileNum
String ls_url, ls_filePath, ls_fileName, ls_ver

ls_fileName = as_filename

// REST API URL 설정 (다운로드할 파일의 엔드포인트)
ls_url = "http://localhost:3000/api/update?fileName=" + ls_fileName

// 로컬에 저장할 파일 경로
//ls_filePath = "d:\downloads\" + ls_fileName
ls_filePath = GetCurrentDirectory() + "\res\" + ls_fileName

// HTTPClient 객체 생성
lnv_http = Create HTTPClient

// 인증 키 설정 (Authorization 헤더에 추가)
lnv_http.SetRequestHeader("x-api-key", "YP")

// GET 요청 보내기
li_status = lnv_http.SendRequest("GET", ls_url)

// 상태 코드 확인 및 처리
If li_status = 1 Then // 요청 성공 여부 확인
    If lnv_http.GetResponseStatusCode() = 200 Then // HTTP 상태 코드가 200인지 확인
        // 응답 데이터를 Blob으로 가져오기
        lnv_http.GetResponseBody(lblb_response)

		// 파일 열기 (스트림 모드, 쓰기 권한)
		li_FileNum = FileOpen(ls_FilePath, StreamMode!, Write!, LockWrite!, Replace!)
		
		If li_FileNum < 0 Then
			 MessageBox("오류", "파일을 열 수 없습니다: " + ls_FilePath)
			 Return false
		End If  

        // Blob 데이터를 로컬 파일로 저장
        FileWriteEx(li_FileNum, lblb_response)
        //MessageBox("성공", "파일이 성공적으로 다운로드되었습니다: " + ls_filePath)
    Else
        //MessageBox("오류", "HTTP 상태 코드: " + String(lnv_http.GetResponseStatusCode()))
	   return false	  
    End If
Else
    //MessageBox("오류", "GET 요청 실패")
	Return false 
End If

FileClose(li_FileNum)

// HTTPClient 객체 제거
Destroy lnv_http

return true


end function

on w_bar.create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.hpb_upgrade=create hpb_upgrade
this.st_1=create st_1
this.Control[]={this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.hpb_upgrade,&
this.st_1}
end on

on w_bar.destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.hpb_upgrade)
destroy(this.st_1)
end on

event open;u_upgrade = CREATE n_upgrade
u_upgrade_res = CREATE n_upgrade_res

u_upgrade.ShareData(dw_1)
u_upgrade_res.ShareData(dw_2)

Post Event ue_upgrade()
end event

type dw_4 from datawindow within w_bar
integer x = 2491
integer y = 1740
integer width = 2386
integer height = 572
integer taborder = 20
string title = "none"
string dataobject = "d_target_n"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_bar
integer x = 114
integer y = 1740
integer width = 2350
integer height = 572
integer taborder = 20
string title = "none"
string dataobject = "d_target"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_bar
integer x = 2501
integer y = 600
integer width = 2386
integer height = 1088
integer taborder = 20
string title = "none"
string dataobject = "d_source_n"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_bar
integer x = 110
integer y = 600
integer width = 2363
integer height = 1088
integer taborder = 10
string title = "none"
string dataobject = "d_source"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type hpb_upgrade from hprogressbar within w_bar
integer x = 50
integer y = 128
integer width = 1385
integer height = 44
unsignedinteger maxposition = 10
integer setstep = 1
end type

type st_1 from statictext within w_bar
integer x = 55
integer y = 36
integer width = 1367
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 553648127
boolean focusrectangle = false
end type

