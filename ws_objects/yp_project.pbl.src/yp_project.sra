$PBExportHeader$yp_project.sra
$PBExportComments$Generated Application Object
forward
global type yp_project from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
str_userenv 		gstr_userenv
str_menu		gstr_menu
String gs_main_chk = '0'
String gs_title, gs_window
string gs_ret, gs_new, gs_save, gs_del, gs_pre, gs_print, gs_exel, gs_close, gs_picdir, gs_mod
string gs_menufun[] , gs_menufun_c[], gs_menunm[] ,gs_menuid[] , gs_screenid[] , gs_p_menuid[], gs_p_menunm[]
string ls_erp_frdate, ls_erp_todate

uo_wait_box luo_waitbox

Long gs_dddw_cnt
Long gl_width, gl_height, gl_tv_width
string gs_width_chk = '0'

//string gl_api_ip = '211.35.173.34'
string gl_api_ip = 'localhost'
string gl_api_port = '8080'

end variables

global type yp_project from application
string appname = "yp_project"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "22.2.0.3397"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global yp_project yp_project

type prototypes
Function Ulong   ImmGetContext         (Ulong handle)                                   Library "Imm32.dll"
Function Boolean ImmSetConversionStatus(Ulong hims  , Ulong conversion, Ulong sentence) Library "Imm32.dll"
Function Ulong   ImmReleaseContext     (Ulong handle, Ulong hims)                       Library "Imm32.dll"

Function Boolean AnimateWindow(Long hwnd, Long dwTime, Long dwFlags) Library "User32.dll" 
end prototypes

on yp_project.create
appname="yp_project"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on yp_project.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
gstr_userenv.path = GetCurrentDirectory()

idle(1800)

open(w_login)

end event

event idle;/*
gl_width = 0
		
open(w_login)

close(w_mainmdi)
*/
end event

event systemerror;String ls_title, ls_message
String ls_body, ls_result, ls_error, ls_returncode, ls_errmenu, ls_errobject, ls_errevent, ls_errtext, ls_userid 
Long ll_errnumber, ll_errline
Long ll_root, ll_data_array, ll_count, ll_index, ll_child, ll_row
Boolean lb_result
JSONParser lnv_json

ls_title = this.Displayname
if Trim(ls_title) = '' or isnull(ls_title) then ls_title = Upper(ClassName())


ls_message = '에러NO: ' + String(error.Number) + '~r~n'
ls_message += '객 체: ' + error.object + + '~r~n'
ls_message += '이벤트: ' + error.objectevent + + '~r~n'
ls_message += '위 치: ' + String(error.line) + + '~r~n'
ls_message += '안내문: ' + error.text + + '~r~n'

messagebox(ls_title, ls_message)

ll_errnumber =  Error.Number
ls_errmenu = Error.WindowMenu
ls_errobject =  Error.Object
ls_errevent = Error.ObjectEvent
ll_errline =  Error.Line
ls_errtext = Error.Text
ls_userid = gstr_userenv.user_id

ls_body = '{"errnumber": "' + string(ll_errnumber) + '", "errmenu": "' + ls_errmenu + '", "errobject": "'+ ls_errobject + '", "errevent": "'+ ls_errevent + '", "errline": "' + string(ll_errline) + '", "errtext": "' + ls_errtext + '", "userid": "' + ls_userid + '"}'  

ls_result = gf_api_call("http://" + gl_api_ip + ":" + gl_api_port + "/api/error", 'POST', ls_body)

IF ls_result = 'FAIL' or gf_chk_null(ls_result) THEN
	RETURN 
END IF;

lb_result = gf_api_call_chk(ls_result, '0')

IF NOT(lb_result) THEN	RETURN 

lnv_json = CREATE JSONParser

ls_error = lnv_json.LoadString(ls_result)

if Len(ls_error) > 0 then
    MessageBox("Error", "JSON 파싱 실패: " + ls_error)
    Destroy lnv_json
    RETURN 
end if

ll_root = lnv_json.getrootitem( )  

if ll_root <= 0 then
    MessageBox("Error", "루트 노드를 가져오지 못했습니다.")
    Destroy lnv_json
    RETURN 
end if

ll_count = lnv_json.getchildcount( ll_root )  

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_root, ll_index )  
	
	ls_returncode = lnv_json.getitemstring( ll_child, "returncode")  

next  
		
DESTROY lnv_json

IF ls_returncode = '0000' THEN

	CloseWithReturn(w_40010001_insert_pop, ls_returncode)
	
ELSE	
	
	MessageBox("실패", "오류 정보 저장에 실패 하였습니다.")
	
END IF

end event

