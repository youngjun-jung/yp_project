$PBExportHeader$w_mainmdi_bak.srw
forward
global type w_mainmdi_bak from window
end type
type mdi_1 from mdiclient within w_mainmdi_bak
end type
type cb_1 from commandbutton within w_mainmdi_bak
end type
type d_toolbar from u_dw_toolbar within w_mainmdi_bak
end type
type p_1 from picture within w_mainmdi_bak
end type
type dw_1 from datawindow within w_mainmdi_bak
end type
type dw_menu from datawindow within w_mainmdi_bak
end type
type uo_tab from u_tab within w_mainmdi_bak
end type
type uo_tab from u_tab within w_mainmdi_bak
end type
type tv_menu from datawindow within w_mainmdi_bak
end type
end forward

global type w_mainmdi_bak from window
integer width = 4224
integer height = 1984
boolean titlebar = true
string title = "영풍실적관리시스템"
string menuname = "m_mainmdi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = mdi!
long backcolor = 16777215
string icon = "C:\Users\jun\Desktop\pb_source\법인카드\res\credit.ico"
boolean center = true
event ue_resize ( )
mdi_1 mdi_1
cb_1 cb_1
d_toolbar d_toolbar
p_1 p_1
dw_1 dw_1
dw_menu dw_menu
uo_tab uo_tab
tv_menu tv_menu
end type
global w_mainmdi_bak w_mainmdi_bak

type prototypes
subroutine OpenWait(int nRadius, ulong clr,ulong clrBack, boolean bShowSecond, readonly string szTitle, int nMargin, long nReserve) system library "PbIdea.dll" alias for "OpenWait"
subroutine CloseWait() system library "PbIdea.dll" alias for "CloseWait"


end prototypes

type variables
Boolean ib_resize
String  is_old_object

String is_title
String is_window

string is_icon[8], is_text[8]

end variables

forward prototypes
public subroutine of_setpicture (string as_icon[], string as_text[])
public subroutine of_wait_open (string as_msg)
public subroutine of_wait_close ()
public function boolean wf_chk_menu_fun_id (string as_value)
public subroutine wf_resize ()
end prototypes

event ue_resize();wf_resize()
end event

public subroutine of_setpicture (string as_icon[], string as_text[]);Long ll_close, i

ll_close = UpperBound(as_icon)

FOR i = 1 TO ll_close
	d_toolbar.SetItem(1, 'icon' + String(i, '00'), as_icon[i])
	d_toolbar.SetItem(1, 'text' + String(i, '00'), as_text[i])
NEXT

end subroutine

public subroutine of_wait_open (string as_msg);Long ll_ran

ll_ran = 0

if not isvalid(luo_waitbox) then

	luo_waitbox = create uo_wait_box

end if

//luo_waitBox.OpenWait(64,RGB(220,220,220),RGB(20,20,20),TRUE,as_msg, 8,rand(6) - 1)
luo_waitBox.OpenWait(96,RGB(220,220,220),RGB(20,20,20),TRUE,as_msg, 8,ll_ran)



//post of_wait_close()
end subroutine

public subroutine of_wait_close ();if isvalid(luo_waitBox) then

	luo_waitBox.closewait( )

end if
end subroutine

public function boolean wf_chk_menu_fun_id (string as_value);String ls_picdir, ls_fun
Long ii

for ii = 1 to dw_1.rowcount()
	if gs_screenid[ii] = as_value then
		ls_fun = gs_menufun[ii]
	end if
next

gs_ret = mid(ls_fun, 1, 1)
gs_new = mid(ls_fun, 2, 1)
gs_save = mid(ls_fun, 3, 1)
gs_del = mid(ls_fun, 4, 1)
gs_pre = mid(ls_fun, 5, 1)
gs_print = mid(ls_fun, 6, 1)
gs_exel = mid(ls_fun, 7, 1)
gs_close = mid(ls_fun, 8, 1)
gs_mod = mid(ls_fun, 9, 1)

ls_picdir = ".\res\"

is_text[1] = "조회"
is_text[2] = "신규"
if gs_mod = '1' then
	is_text[3] = "수정"
else 
	is_text[3] = "저장"
end if
is_text[4] = "삭제"
is_text[5] = "미리보기"
is_text[6] = "인쇄"
is_text[7] = "엑셀저장"
is_text[8] = "닫기"

if gs_ret = '1' then
	is_icon[1] = ls_picdir + "Retrieve02.png"
	d_toolbar.Modify("text01.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[1] = ls_picdir + "Retrieve01.png"
	d_toolbar.Modify("text01.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_new = '1' then
	is_icon[2] = ls_picdir + "New02.png"
	d_toolbar.Modify("text02.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[2] = ls_picdir + "New01.png"
	d_toolbar.Modify("text02.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_save = '1' then
	is_icon[3] = ls_picdir + "Save02.png"
	d_toolbar.Modify("text03.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[3] = ls_picdir + "Save01.png"
	d_toolbar.Modify("text03.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_del = '1' then
	is_icon[4] = ls_picdir + "Delete02.png"
	d_toolbar.Modify("text04.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[4] = ls_picdir + "Delete01.png"
	d_toolbar.Modify("text04.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_pre = '1' then
	is_icon[5] = ls_picdir + "Preview02.png"
	d_toolbar.Modify("text05.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[5] = ls_picdir + "Preview01.png"
	d_toolbar.Modify("text05.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_print = '1' then
	is_icon[6] = ls_picdir + "Print02.png"
	d_toolbar.Modify("text06.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[6] = ls_picdir + "Print01.png"
	d_toolbar.Modify("text06.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_exel = '1' then
	is_icon[7] = ls_picdir + "Excel02.png"
	d_toolbar.Modify("text07.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[7] = ls_picdir + "Excel01.png"
	d_toolbar.Modify("text07.Color =" + String(RGB(168, 171, 176)) )
end if
if gs_close = '1' then
	is_icon[8] = ls_picdir + "Close02.png"
	d_toolbar.Modify("text08.Color =" + String(RGB(0, 120, 210)) )
else
	is_icon[8] = ls_picdir + "Close01.png"
	d_toolbar.Modify("text08.Color =" + String(RGB(168, 171, 176)) )
end if

of_setpicture(is_icon, is_text)

return true
end function

public subroutine wf_resize ();Integer li_base

if gl_width = WorkSpaceWidth () and gl_height > 3000 then 
	return	
else	
	gl_width = WorkSpaceWidth ()
	gl_height = WorkSpaceHeight ()
	gl_tv_width = tv_menu.Width
end if

li_base = tv_menu.X + tv_menu.Width + 3

uo_tab.Width = gl_width - gl_tv_width

d_toolbar.X = gl_width - d_toolbar.Width

tv_menu.Height = gl_height

mdi_1.X      = li_base
mdi_1.Y      = tv_menu.Y + uo_tab.Height

mdi_1.Width  = gl_width - gl_tv_width

mdi_1.Height = tv_menu.Height - uo_tab.Height



end subroutine

on w_mainmdi_bak.create
if this.MenuName = "m_mainmdi" then this.MenuID = create m_mainmdi
this.mdi_1=create mdi_1
this.cb_1=create cb_1
this.d_toolbar=create d_toolbar
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_menu=create dw_menu
this.uo_tab=create uo_tab
this.tv_menu=create tv_menu
this.Control[]={this.mdi_1,&
this.cb_1,&
this.d_toolbar,&
this.p_1,&
this.dw_1,&
this.dw_menu,&
this.uo_tab,&
this.tv_menu}
end on

on w_mainmdi_bak.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.cb_1)
destroy(this.d_toolbar)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_menu)
destroy(this.uo_tab)
destroy(this.tv_menu)
end on

event open;String ls_body, ls_result, ls_error
Long ll_root, ll_count, ll_index, ll_child, i, ll_row, ll_data_array
Boolean lb_result
JSONParser lnv_json

w_mainmdi.Width = 7195
w_mainmdi.Height = 3800
windowstate = maximized!

//tv_menu.settransobject(sqlca)
//tv_menu.retrieve('1' + gstr_userenv.grp)
//tv_menu.retrieve('1' + gstr_userenv.user_id)

if gstr_userenv.grp = '00000000' or gstr_userenv.grp = '99999999' then	
	dw_menu.DataObject = 'd_menu_admin'
	dw_menu.insertrow(1)
end if

tv_menu.object.t_1.text = '실적관리'
		
tv_menu.object.t_1.Font.height = -14

d_toolbar.object.t_2.text = '[' + gstr_userenv.user_dept + '] ' + gstr_userenv.user_nm

dw_menu.object.text01.Font.weight = 700

ls_body = 'id=' + gstr_userenv.user_id

ls_result = gf_api_call("http://" + gl_api_ip + ":3000/api/menu", 'GET', ls_body)

//messagebox("ls_result", ls_result)

IF ls_result = 'FAIL' THEN
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

// DataWindow 초기화
dw_1.Reset()

ll_root = lnv_json.getrootitem( )  

if ll_root <= 0 then
    MessageBox("Error", "루트 노드를 가져오지 못했습니다.")
    Destroy lnv_json
    return
end if

// 'data' 배열 가져오기
ll_data_array = lnv_json.GetItemArray(ll_root, "data")

if ll_data_array < 0 then
    MessageBox("Error", "'data' 배열을 찾을 수 없습니다.")
    Destroy lnv_json
    return
end if

//messagebox("ll_data_array", ll_data_array)

ll_count = lnv_json.getchildcount( ll_data_array )  

// DataWindow 초기화
dw_1.Reset()

i = 1

for ll_index = 1 to ll_count    

	ll_child = lnv_json.getchilditem( ll_data_array, ll_index )  

	gstr_menu.userid[i] = lnv_json.getitemstring( ll_child, "userid")  
	gstr_menu.p_menuname[i] = lnv_json.getitemstring( ll_child, "p_menuname")  
	gstr_menu.menuname[i] = lnv_json.getitemstring( ll_child, "menuname")  
	gstr_menu.p_menuid[i] = lnv_json.getitemstring( ll_child, "p_menuid")  
	gstr_menu.menuid[i] = lnv_json.getitemstring( ll_child, "menuid")  
	gstr_menu.screen_id[i] = lnv_json.getitemstring( ll_child, "screen_id")  
	gstr_menu.menu_fun[i] = lnv_json.getitemstring( ll_child, "menu_fun")  
	
	ll_row = dw_1.insertrow(1)
	
	dw_1.object.userid[ll_row] = gstr_menu.userid[i]
	dw_1.object.p_menuname[ll_row] = gstr_menu.p_menuname[i]
	dw_1.object.menuname[ll_row] = gstr_menu.menuname[i]
	dw_1.object.p_menuid[ll_row] = gstr_menu.p_menuid[i]
	dw_1.object.menuid[ll_row] = gstr_menu.menuid[i]
	dw_1.object.menu_m_screen_id[ll_row] = gstr_menu.screen_id[i]
	dw_1.object.menu_fun[ll_row] = gstr_menu.menu_fun[i]
	
	i = i + 1

next  
		
DESTROY lnv_json

//dw_1.settransobject(sqlca)
//dw_1.retrieve(gstr_userenv.user_id)

for i = 1 to dw_1.rowcount()
	
	gs_menunm[i] = dw_1.object.menuname[i]
	gs_menuid[i] = dw_1.object.menuid[i]
	gs_menufun[i] = dw_1.object.menu_fun[i]
	gs_screenid[i] = dw_1.object.menu_m_screen_id[i]
	gs_p_menuid[i] = dw_1.object.p_menuid[i]

next

if gs_main_chk = '0' then
	gs_title  = 'main'
	gs_window = 'w_main_bg'
end if

Window lw_sheet

w_mainmdi.SetRedraw(FALSE)

OpenSheetWithParm(lw_sheet, gs_title, gs_window, w_mainmdi, 1, Layered!)

gs_main_chk = '1'

w_mainmdi.Post SetRedraw(TRUE)

gs_ret = '0'
gs_new = '0'
gs_save = '0'
gs_del = '0'
gs_pre = '0'
gs_print = '0'
gs_exel = '0'
gs_close = '0'
gs_picdir = '0'
gs_mod = '0'


//tv_menu.object.adm_menu_cs_p_menuname[1] = '222'
//tv_menu.object.adm_menu_cs_menuname[1] = '111'


/*
handleparent: 부모 항목의 핸들. 최상위 항목의 경우 0을 사용.
handleafter: 추가할 위치의 이전 항목 핸들. 최상위 항목의 경우 0을 사용.
label: 항목에 표시될 텍스트.
pictureindex: 항목과 연결된 이미지 인덱스. 이미지가 없으면 0.
*/





end event

event resize;
event ue_resize()
end event

type mdi_1 from mdiclient within w_mainmdi_bak
end type

type cb_1 from commandbutton within w_mainmdi_bak
integer x = 1248
integer y = 36
integer width = 457
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;
Long ll_row, i, ll_level, j

tv_menu.reset()

ll_row = 1
ll_level = 1
j = dw_1.rowcount()

for i = 1 to dw_1.rowcount()
	
	//IF mid(gs_p_menuid[i], 1, 1) <> '1' THEN CONTINUE;

	IF mid(gs_p_menuid[i], 2, 7) = '0000000' THEN
		
		//messagebox('1gs_menunm[i] ', gs_menunm[i] )
		
		tv_menu.object.adm_menu_cs_p_menuname[ll_row] = gs_menunm[j] 
		
		//tv_menu.object.adm_menu_cs_p_menufun[i] = gs_menufun[i] 
		
		if i < dw_1.rowcount() then
			ll_row = tv_menu.Insertrow(0);
		end if
		
		ll_level = 1	
		
		messagebox("ll_row", ll_row )
		
	ELSE
		
		//messagebox('2gs_menunm[i] ', gs_menunm[i] )
		
		tv_menu.object.adm_menu_cs_menuname[ll_level] = gs_menunm[j] 
		//tv_menu.object.adm_menu_cs_menui[i] = gs_menuid[i] 
		//tv_menu.object.adm_menu_cs_screenie[i] = gs_screenid[i] 
		
		//tv_menu.object.adm_menu_cs_p_menufun[i] = gs_menufun[i] 
		
		ll_level = ll_level + 1
		
		messagebox("ll_level", ll_level )
		
	END IF;
	
 	j = j - 1

next

end event

type d_toolbar from u_dw_toolbar within w_mainmdi_bak
integer x = 3776
integer y = 112
integer width = 3877
integer height = 176
integer taborder = 20
string dataobject = "d_mdi_toolbar"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;Long i

InsertRow(1)

FOR i = 1 TO 10
//	SetItem(1, 'back' + String(i, '00'), gstr_userenv.Appdir + "\Res\Back01.gif")
	SetItem(1, 'back' + String(i, '00'), ".\Res\Back01.gif")
NEXT

String ls_picdir

ls_picdir = ".\res\"

is_icon[1] = ls_picdir + "Retrieve01.png"
is_icon[2] = ls_picdir + "New01.png"
is_icon[3] = ls_picdir + "Save01.png"
is_icon[4] = ls_picdir + "Delete01.png"
is_icon[5] = ls_picdir + "Preview01.png"
is_icon[6] = ls_picdir + "Print01.png"
is_icon[7] = ls_picdir + "Excel01.png"
is_icon[8] = ls_picdir + "Close01.png"


is_text[1] = "조회"
is_text[2] = "신규"
is_text[3] = "저장"
is_text[4] = "삭제"
is_text[5] = "미리보기"
is_text[6] = "인쇄"
is_text[7] = "엑셀저장"
is_text[8] = "닫기"

of_setpicture(is_icon, is_text)

ib_lbtn_clicking = false




end event

type p_1 from picture within w_mainmdi_bak
integer x = 201
integer y = 52
integer width = 663
integer height = 196
string picturename = ".\res\yp_logo.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_mainmdi_bak
boolean visible = false
integer x = 32
integer y = 36
integer width = 1115
integer height = 216
integer taborder = 10
string title = "none"
string dataobject = "d_hpc_menu"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_menu from datawindow within w_mainmdi_bak
integer x = 1166
integer y = 148
integer width = 2551
integer height = 140
integer taborder = 20
string title = "none"
string dataobject = "d_menu"
boolean controlmenu = true
boolean border = false
boolean livescroll = true
end type

event clicked;window lw_sheet

CHOOSE CASE dwo.Name
		
	CASE 'back01'
				
		tv_menu.settransobject(sqlca)
		//tv_menu.retrieve('1' + gstr_userenv.user_id)
			
		tv_menu.object.t_1.text = '실적관리'
			
		tv_menu.object.t_1.Font.height = -14
		
		//dw_menu.Modify("t_1.Color =" + String(RGB(0, 120, 210)) )
		dw_menu.Modify("text01.Color =" + String(RGB(36, 36, 255)) )
		dw_menu.Modify("text02.Color =" + String(RGB(0, 0, 0)) )
		dw_menu.Modify("text03.Color =" + String(RGB(0, 0, 0)) )
		dw_menu.Modify("text04.Color =" + String(RGB(0, 0, 0)) )
		
		dw_menu.object.text01.Font.weight = 700
		dw_menu.object.text02.Font.weight = 600
		dw_menu.object.text03.Font.weight = 600
		dw_menu.object.text04.Font.weight = 600
		
	CASE 'back02'
				
		tv_menu.settransobject(sqlca)
		//tv_menu.retrieve('2' + gstr_userenv.user_id)
			
		tv_menu.object.t_1.text = '자동전표'
			
		tv_menu.object.t_1.Font.height = -14
				
		dw_menu.Modify("text01.Color =" + String(RGB(0, 0, 0)) )
		//dw_menu.Modify("t_2.Color =" + String(RGB(0, 120, 210)) )
		dw_menu.Modify("text02.Color =" + String(RGB(36, 36, 255)) )
		dw_menu.Modify("text03.Color =" + String(RGB(0, 0, 0)) )
		dw_menu.Modify("text04.Color =" + String(RGB(0, 0, 0)) )
		
		dw_menu.object.text01.Font.weight = 600
		dw_menu.object.text02.Font.weight = 700
		dw_menu.object.text03.Font.weight = 600
		dw_menu.object.text04.Font.weight = 600
		
		
	CASE 'back03'
				
		tv_menu.settransobject(sqlca)
		//tv_menu.retrieve('3' + gstr_userenv.user_id)
			
		tv_menu.object.t_1.text = '예산관리'

		tv_menu.object.t_1.Font.height = -14
		
		dw_menu.Modify("text01.Color =" + String(RGB(0, 0, 0)) )		
		dw_menu.Modify("text02.Color =" + String(RGB(0, 0, 0)) )
		//dw_menu.Modify("t_3.Color =" + String(RGB(0, 120, 210)) )
		dw_menu.Modify("text03.Color =" + String(RGB(36, 36, 255)) )
		dw_menu.Modify("text04.Color =" + String(RGB(0, 0, 0)) )
		
		dw_menu.object.text01.Font.weight = 600
		dw_menu.object.text02.Font.weight = 600
		dw_menu.object.text03.Font.weight = 700
		dw_menu.object.text04.Font.weight = 600
		
		
	CASE 'back04'
				
		tv_menu.settransobject(sqlca)
		//tv_menu.retrieve('4' + gstr_userenv.user_id)
			
		tv_menu.object.t_1.text = '관리자'

		tv_menu.object.t_1.Font.height = -14
		
		dw_menu.Modify("text01.Color =" + String(RGB(0, 0, 0)) )
		dw_menu.Modify("text02.Color =" + String(RGB(0, 0, 0)) )
		dw_menu.Modify("text03.Color =" + String(RGB(0, 0, 0)) )
		//dw_menu.Modify("t_4.Color =" + String(RGB(0, 120, 210)) )
		dw_menu.Modify("text04.Color =" + String(RGB(36, 36, 255)) )
		
		dw_menu.object.text01.Font.weight = 600
		dw_menu.object.text02.Font.weight = 600
		dw_menu.object.text03.Font.weight = 600
		dw_menu.object.text04.Font.weight = 700
		
				
END CHOOSE
end event

event constructor;insertrow(1)
end event

type uo_tab from u_tab within w_mainmdi_bak
integer x = 1189
integer y = 292
integer width = 6016
integer taborder = 40
end type

event selectionchanged;call super::selectionchanged;
Window lw_sheet

gs_window = Control[newindex].Tag

wf_chk_menu_fun_id(gs_window)


end event

type tv_menu from datawindow within w_mainmdi_bak
integer x = 5
integer y = 280
integer width = 1179
integer height = 3208
integer taborder = 30
string title = "none"
string dataobject = "d_treeview_g"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;insertrow(1)
end event

event doubleclicked;Window lw_sheet
String ls_window, ls_title

return

if row < 1 then return

ls_title = tv_menu.object.adm_menu_cs_menuname[row]

ls_window = tv_menu.object.adm_menu_cs_screen_id[row]

/*
return

ls_title  = '제목없음'

if tv_menu.DataObject = 'd_test21' then
	
	ls_window = 'w_test2'
	if dwo.name = 't_2' then
		ls_title  = '대사총괄현황(회계)'
	elseif dwo.name = 't_3' then
		ls_title  = '대사총괄현황(추심)'
	elseif dwo.name = 't_4' then
		ls_title  = '현금대사내역조정-도공영업소'
	elseif dwo.name = 't_5' then
		ls_title  = '현금대사내역조정-고속도로휴게소'
	elseif dwo.name = 't_6' then
		ls_title  = '현금대사내역조정-대체영업소'
	elseif dwo.name = 't_7' then
		ls_title  = '현금대사내역조정-CD/ATM(은행)'
	elseif dwo.name = 't_8' then
		ls_title  = '현금대사내역조정-CD/ATM(은행외)'
	elseif dwo.name = 't_9' then
		ls_title  = '현금대사내역조정-홈페이지 충전'
	elseif dwo.name = 't_10' then
		ls_title  = '현금대사내역조정-홈페이지 카드신청'
	elseif dwo.name = 't_11' then
		ls_title  = '현금대사내역조정-현금조정내역조회'
	elseif dwo.name = 't_12' then
		ls_title  = '페이대사내역조정-카카오페이'
	elseif dwo.name = 't_13' then
		ls_title  = '신용대사내역조정(승인)-영업소(휴게소)'
	elseif dwo.name = 't_14' then
		ls_title  = '신용대사내역조정(승인)-영업소(휴게소)_현금IC'
	elseif dwo.name = 't_15' then
		ls_title  = '신용대사내역조정(승인)-무인충전기'
	elseif dwo.name = 't_16' then
		ls_title  = '신용대사내역조정(승인)-무인충전기_현금IC'
	elseif dwo.name = 't_17' then
		ls_title  = '신용대사내역조정(승인)-인터넷충전'
	elseif dwo.name = 't_18' then
		ls_title  = '신용대사내역조정(승인)-과승인 처리'
	elseif dwo.name = 't_19' then
		ls_title  = '신용대사내역조정(입금)-영업소(휴게소)'
	elseif dwo.name = 't_20' then
		ls_title  = '신용대사내역조정(입금)-영업소(휴게소)_현금IC'
	elseif dwo.name = 't_21' then
		ls_title  = '신용대사내역조정(입금)-무인충전기'
	elseif dwo.name = 't_22' then
		ls_title  = '신용대사내역조정(입금)-인터넷충전'
	elseif dwo.name = 't_23' then
		ls_title  = '신용대사내역조정(입금)-무인충전기(백업)'
	elseif dwo.name = 't_24' then
		ls_title  = '신용대사내역조정(입금)-신용조정내역조회'
	elseif dwo.name = 't_25' then
		ls_title  = '자동충전카드-충전대사'
	elseif dwo.name = 't_26' then
		ls_title  = '자동충전카드-입금대사(계좌)'
	elseif dwo.name = 't_27' then
		ls_title  = '자동충전카드-입금대사(신용)'
	elseif dwo.name = 't_28' then
		ls_title  = '자동충전카드-입금대사(다날)'
	elseif dwo.name = 't_29' then
		ls_title  = '자동충전카드-자충조정내역조회'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test2' then	
	
	ls_window = 'w_test1'
	if dwo.name = 't_2' then
		ls_title  = '계좌거래내역대사'
	elseif dwo.name = 't_3' then
		ls_title  = '가상계좌내역대사'
	elseif dwo.name = 't_4' then
		ls_title  = '입금대사결과확정'
	elseif dwo.name = 't_5' then
		ls_title  = '계좌거래내역대사(신)'
	elseif dwo.name = 't_6' then
		ls_title  = '도공영업소현금'
	elseif dwo.name = 't_7' then
		ls_title  = '신용카드'
	elseif dwo.name = 't_8' then
		ls_title  = '인터넷계좌이체'
	elseif dwo.name = 't_9' then
		ls_title  = '자료검증완료처리'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test22' then
	
	ls_window = 'w_test1'
	if dwo.name = 't_2' then
		ls_title  = '월별미수금내역조회'
	elseif dwo.name = 't_3' then
		ls_title  = '미수금조정내역조회'
	elseif dwo.name = 't_4' then
		ls_title  = '기초미수금관리'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test23' then
	
	ls_window = 'w_test1'
	if dwo.name = 't_2' then
		ls_title  = '자금수지'
	elseif dwo.name = 't_3' then
		ls_title  = '일일입금내역'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test24' then
	
	ls_window = 'w_test1'
	if dwo.name = 't_2' then
		ls_title  = '실계좌내역조회'
	elseif dwo.name = 't_3' then
		ls_title  = '가상계좌내역조회'
	elseif dwo.name = 't_4' then
		ls_title  = '발렉스실입금확인'
	elseif dwo.name = 't_5' then
		ls_title  = '신용카드결제변경'
	elseif dwo.name = 't_6' then
		ls_title  = '이월입금예정액조회'
	elseif dwo.name = 't_7' then
		ls_title  = '가맹점별입금액조회'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test25' then
	
	ls_window = 'w_test3'
	if dwo.name = 't_2' then
		ls_title  = '사용자관리'
	elseif dwo.name = 't_3' then
		ls_title  = '부서관리'
	elseif dwo.name = 't_4' then
		ls_title  = '가맹점코드관리'
	elseif dwo.name = 't_5' then
		ls_title  = '외부거래처코드관리'
	elseif dwo.name = 't_6' then
		ls_title  = '입금채널코드관리'
	elseif dwo.name = 't_7' then
		ls_title  = '계좌내역자동구분조건'
	elseif dwo.name = 't_8' then
		ls_title  = '가상계좌원장관리'
	elseif dwo.name = 't_9' then
		ls_title  = '신용카드가맹점관리'
	elseif dwo.name = 't_10' then
		ls_title  = '공지사항'
	elseif dwo.name = 't_11' then
		ls_title  = '시스템영업일자관리'
	else
		return
	end if
	
elseif tv_menu.DataObject = 'd_test26' then
	
	ls_window = 'w_test1'	
	if dwo.name = 't_2' then
		ls_title  = '비밀번호변경'
		ls_window = 'w_pwchg'	
	else
		return
	end if
	
else
	return	
end if

Close(w_mainmdi.GetActiveSheet())

w_mainmdi.SetRedraw(FALSE)

OpenSheetWithParm(lw_sheet, ls_title, ls_window, w_mainmdi, 1, Layered!)

w_mainmdi.Post SetRedraw(TRUE)
*/

w_mainmdi.SetRedraw(FALSE)

lw_sheet = w_mainmdi.GetFirstSheet()

DO WHILE IsValid(lw_sheet)

	IF lw_sheet.ClassName() = ls_window THEN

		lw_sheet.BringToTop = TRUE
		lw_sheet.Post SetFocus()

		w_mainmdi.Post SetRedraw(TRUE)
		
		RETURN

	END IF
	
	lw_sheet = w_mainmdi.GetNextSheet(lw_sheet)
	
LOOP

OpenSheetWithParm(lw_sheet, ls_title, ls_window, w_mainmdi, 1, Layered!)

gs_window = ls_window
gs_title = ls_title

w_mainmdi.Post SetRedraw(TRUE)


end event

event clicked;Window lw_sheet
String dw_band, ls_window, ls_title
String ls_fun, ls_fun1, ls_fun2, ls_fun3, ls_fun4, ls_fun5, ls_fun6, ls_fun7, ls_fun8
Long ll_row, pos
ClassDefinition cdf

if string(dwo.name) = 'datawindow' then return

if string(dwo.band) = 'tree.level.1' then
	
	dw_band = this.GetBandAtPointer()
	
	pos = pos(dw_band, "~t")
	
	if pos > 0 then
		
		ll_row = long(mid(dw_band, pos + 1, len(dw_band)))
		
		if this.isexpanded(ll_row, 1) = false then
			
			this.expand(ll_row, 1) 
			
		else
			
			this.collapse(ll_row, 1) 
			
		end if
		
	end if
	
end if

if row < 1 then return

ls_window = tv_menu.object.adm_menu_cs_screen_id[row]
ls_title = tv_menu.object.adm_menu_cs_menuname[row]

cdf = FindClassDefinition(ls_window)

if isValid(cdf) then
else
	messagebox("확인", "[" + ls_window + "] 윈도우가 없습니다.")
	return
end if

gs_title = ls_title
gs_window = ls_window

w_mainmdi.SetRedraw(FALSE)

lw_sheet = w_mainmdi.GetFirstSheet()

DO WHILE IsValid(lw_sheet)

	IF lw_sheet.ClassName() = gs_window THEN
		
		lw_sheet.BringToTop = TRUE
		lw_sheet.Post SetFocus()

		w_mainmdi.Post SetRedraw(TRUE)

		//uo_tab.SelectedTab = ll_row
		
		lw_sheet.Width = w_mainmdi.mdi_1.Width
		
		wf_chk_menu_fun_id(ls_fun)

		gf_window_control('activate', gs_window, gs_title)	
		
		//messagebox("lw_sheet.ClassName()", lw_sheet.ClassName())
		
		//lw_sheet.Post resize(1,1)

		RETURN

	END IF
	
	lw_sheet = w_mainmdi.GetNextSheet(lw_sheet)
	
LOOP

OpenSheetWithParm(lw_sheet, gs_title, gs_window, w_mainmdi, 1, Layered!)

w_mainmdi.Post SetRedraw(TRUE)




end event

