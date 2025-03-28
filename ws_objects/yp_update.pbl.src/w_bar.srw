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
integer width = 1463
integer height = 192
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
public function boolean wf_file_res_api (string as_apiurl, string as_filename)
public function boolean wf_file_api (string as_apiurl, string as_gubun, string as_ip, string as_userid, string as_filename, string as_filever)
end prototypes

event type boolean ue_upgrade();Long     i, j, ll_find, ll_fileopen
Boolean  lb_update, lb_result
String   ls_path, ls_body, ls_result, ls_error, ls_gubun
Long ll_root, ll_object, ll_object_count, ll_count, ll_index, ll_child, ll_row, ll_data_array
JSONParser lnv_json

Long     ll_rowcnt_source , ll_rowcnt_target , ll_filesize
Datetime ld_created_source, ld_created_target, ld_modified_source, ld_modified_target, ld_accessed_source
String   ls_filename, ls_file_version
Blob     lb_file

// ip 확인 객체
OLEObject objWMIService, IPConfigSet, IPConfig
String ls_clientip

// Property 변수
String ls_version, ls_mode, ls_serverip, ls_port, ls_source
String ls_apiUrl
// ID 변수
String ls_userid

ls_userid = ProfileString("id.ini", "ID", "id", "")

// 프로그램 버전 확인
ls_version = ProfileString("property.ini", "APP_VERSION", "version", "")

// 현재 운영 모드 읽기 (DEV/PROD)
ls_mode = ProfileString("property.ini", "MODE", "state", "")

// 운영모드에 따른 property get
ls_serverip = ProfileString("property.ini", ls_mode + "_SERVER", "serverip", "")
ls_port = ProfileString("property.ini", ls_mode + "_SERVER", "port", "")
ls_source = ProfileString("property.ini", ls_mode + "_PATH", "source", "")

ls_apiUrl = "http://" + ls_serverip + ":" + ls_port;

// 결과 확인 예시
/*MessageBox("설정 정보", &
    "현재 모드: " + ls_mode + "~r~n" + &
    "IP: " + ls_ip + "~r~n" + &
    "PORT: " + ls_port + "~r~n" + &
    "SOURCE: " + ls_source + &
	 "URL: " + ls_apiUrl)
*/

// OLEObject 생성 및 연결
objWMIService = CREATE OLEObject
objWMIService.ConnectToObject("winmgmts:{impersonationLevel=impersonate}!//./root/cimv2")

// 네트워크 어댑터 정보 가져오기
IPConfigSet = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")
IPConfig = IPConfigSet.ItemIndex(0)

ls_clientip = IPConfig.Properties_.Item("IPAddress").Value(0)

DESTROY objWMIService


ls_path = GetCurrentDirectory()

SetPointer(HourGlass!)

//dw_1.Retrieve()

u_upgrade.of_Directory(ls_path)
u_upgrade_res.of_Directory(ls_path + '\res')

ls_body = 'appver=' + ls_version

ls_result = gf_api_call(ls_apiUrl + "/api/program/checkverion", 'GET', ls_body)

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

ll_object = lnv_json.GetItemObject(ll_root, "reformData")

if ll_object <= 0 then
    MessageBox("Error", "'reformData' 오브젝트를 찾을 수 없습니다.")
    Destroy lnv_json
    RETURN false
end if

ll_object_count = lnv_json.getChildcount(ll_object)

// 업데이트 항목이 없으면 Skip
if ll_object_count = 0 then
	Run(ls_path + "\yp.exe u")
	SetPointer(Arrow!)

	HALT CLOSE
	RETURN TRUE
end if

hpb_upgrade.MaxPosition = ll_object_count

// DataWindow 초기화
//dw_3.Reset()
//dw_4.Reset()

for i = 1 to ll_object_count
	// 업데이트 구분
	ls_gubun = lnv_json.GetChildKey(ll_object, i)
	
	// 파일 정보 array
	ll_data_array = lnv_json.GetChildItem(ll_object, i)
	ll_count = lnv_json.GetChildCount(ll_data_array)
	
	for j = 1 to ll_count
		ll_child = lnv_json.GetChildItem(ll_data_array, j)

		ls_filename = lnv_json.GetItemString(ll_child, "fileid")
		ll_filesize = lnv_json.GetItemNumber(ll_child, "filesize")
		ls_file_version = lnv_json.GetItemString(ll_child, "ver")
		
		/* MessageBox("Update type: " + ls_gubun + "#" + String(j), &
			 "FileName: " + ls_fileid + "~r~n" + &
			 "FileSize: " + String(ll_filesize) + "~r~n" + &
			 "Version: " + ls_ver) */

	Yield()
	
	lb_update = FALSE
	lb_update = wf_file_api(ls_apiUrl, ls_gubun, ls_clientip, ls_userid, ls_filename, ls_file_version)
	hpb_upgrade.StepIt()

	IF NOT lb_update THEN
		messagebox("오류", "파일 다운로드 오류 : " + ls_filename)
		HALT CLOSE
	END IF
	
	next

next

DESTROY lnv_json

Run(ls_path + "\yp.exe u")

SetPointer(Arrow!)

HALT CLOSE

RETURN TRUE
	/*st_1.text = ls_path + '\' + ls_filename
	
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
	
	lb_result = wf_file_res_api(ls_apiUrl, ls_filename)
	
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
	
	lb_result = wf_file_api(ls_apiUrl, ls_filename)
	
	IF NOT lb_update THEN
		messagebox("오류", "파일 다운로드 오류 : " + ls_filename)
	END IF
	
NEXT
*/

/*
hpb_upgrade.MaxPosition = ll_rowcnt_source

FOR i = 1 TO ll_rowcnt_target
	
	Yield()
	
	hpb_upgrade.StepIt()
	
	lb_update = FALSE
	
	ls_filename        = dw_3.GetItemString  (i, 'name'     )
	ll_filesize        = dw_3.GetItemNumber  (i, 'size'   )
	ls_ver
	//ld_created_target  = dw_3.GetItemDatetime(i, 'createdate' )
	//ld_modified_target = dw_3.GetItemDatetime(i, 'writedate')
	
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
	
	lb_result = wf_file_res_api(ls_apiUrl, ls_filename)
	
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
	
	lb_result = wf_file_api(ls_apiUrl, ls_filename)
	
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
*/
end event

public function boolean wf_file_res_api (string as_apiurl, string as_filename);// 변수 선언
HTTPClient lnv_http
Blob lblb_response
Integer li_status, li_FileNum
String ls_url, ls_filePath, ls_fileName, ls_ver

ls_fileName = as_filename

// REST API URL 설정 (다운로드할 파일의 엔드포인트)
//<<<<<<< HEAD
ls_url = as_apiUrl + "/api/update?fileName=" + ls_fileName
//=======
ls_url = "http://" + gl_api_ip + ":" + gl_api_port + "/api/update?fileName=" + ls_fileName
//>>>>>>> master

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

public function boolean wf_file_api (string as_apiurl, string as_gubun, string as_ip, string as_userid, string as_filename, string as_filever);// 변수 선언
HTTPClient lnv_http
Blob lblb_response
Integer li_status, li_FileNum
String ls_url, ls_filePath, ls_fileName, ls_ver



// REST API URL 설정 (다운로드할 파일의 엔드포인트)
//<<<<<<< HEAD
ls_url = as_apiUrl + "/api/program/update/" + as_gubun + "?ip=" + as_ip + "&userid=" + as_userid + "&fileid=" + as_filename + "&filever=" + as_filever
//=======
ls_url = "http://" + gl_api_ip + ":" + gl_api_port + "/api/update?fileName=" + ls_fileName
//>>>>>>> master

// 로컬에 저장할 파일 경로
//ls_filePath = "d:\downloads\" + ls_fileName
CHOOSE CASE as_gubun
	CASE 'YP'
		ls_filePath = GetCurrentDirectory() + "\update\"
	CASE 'RES'
		ls_filePath = GetCurrentDirectory() + "\update\res\"
END CHOOSE

ls_fileName = ls_filePath + as_filename

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
        If lnv_http.GetResponseBody(lblb_response) = 1 Then
            // 로컬 디렉토리가 없으면 생성
            If Not DirectoryExists(ls_filePath) Then
                CreateDirectory(ls_filePath)
            End If
            
            // 파일 열기 (스트림 모드, 쓰기 권한)
            li_FileNum = FileOpen(ls_fileName, StreamMode!, Write!, LockWrite!, Replace!)
            
            If li_FileNum < 0 Then
                MessageBox("오류", "파일을 열 수 없습니다: " + ls_filePath)
                Destroy lnv_http // HTTPClient 객체 제거
                Return false
            End If
            
            // Blob 데이터를 로컬 파일로 저장
            FileWriteEx(li_FileNum, lblb_response)
            FileClose(li_FileNum)
        Else
            MessageBox("오류", "응답 본문 가져오기 실패")
            Destroy lnv_http // HTTPClient 객체 제거
            Return false
        End If
    Else
        MessageBox("오류", "HTTP 상태 코드: " + String(lnv_http.GetResponseStatusCode()))
        Destroy lnv_http // HTTPClient 객체 제거
        Return false
    End If
Else
    MessageBox("오류", "GET 요청 실패")
    Destroy lnv_http // HTTPClient 객체 제거
    Return false 
End If

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
integer height = 68
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

