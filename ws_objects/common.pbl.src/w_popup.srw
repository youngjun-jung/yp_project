$PBExportHeader$w_popup.srw
$PBExportComments$Popup
forward
global type w_popup from window
end type
type st_1 from statictext within w_popup
end type
type pb_search from picturebutton within w_popup
end type
type cb_cancel from commandbutton within w_popup
end type
type cb_ok from commandbutton within w_popup
end type
type sle_search from singlelineedit within w_popup
end type
type dw_1 from datawindow within w_popup
end type
end forward

global type w_popup from window
integer width = 1650
integer height = 2028
boolean titlebar = true
string title = "팝업"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = ".\Res\Popup.ico"
boolean center = true
st_1 st_1
pb_search pb_search
cb_cancel cb_cancel
cb_ok cb_ok
sle_search sle_search
dw_1 dw_1
end type
global w_popup w_popup

type variables
String is_orgsql, is_group

str_popup istr_popup

Constant ULong WM_MOUSEHOVER = 673
Constant ULong WM_MOUSELEAVE = 675
Constant Long  ROW_STRESS    = 15269887
Constant Long  ROW_MOUSEMOVE = 16775408
end variables

forward prototypes
public subroutine wf_set_section ()
public subroutine wf_resize ()
end prototypes

public subroutine wf_set_section ();  Long ll_pos
String ls_table, ls_pbtcmnt, ls_where

ls_table = istr_popup.table
ls_where = Upper(istr_popup.where)

//SELECT pbt_cmnt
//  INTO :ls_pbtcmnt
//  FROM PBCATTBL
// WHERE (pbt_tnam = :ls_table)
// USING SQLCA;
// 
//IF SQLCA.SQLCode = -1 THEN
//	MessageBox("오류", SQLCA.SQLErrText)
//	RETURN
//END IF
//
//Title = ls_pbtcmnt + '팝업'

dw_1.DataObject = 'd_' + ls_table + '_popup'
dw_1.SetTransObject(SQLCA)

dw_1.Modify("DataWindow.Grid.ColumnMove = No")

is_orgsql = Upper(dw_1.GetSqlSelect())

ll_pos = Pos(is_orgsql, 'GROUP BY')

IF ll_pos > 0 THEN
	
	is_group  =  Mid(is_orgsql, ll_pos - 1)
	is_orgsql = Left(is_orgsql, ll_pos - 1)
	
ELSE
	
	is_group = ''
	
END IF

IF NOT gf_chk_null(istr_popup.where) THEN

	ll_pos = Pos(is_orgsql, 'WHERE')
	
	IF ll_pos > 0 THEN
		ls_where = " and (" + ls_where + ")"
	ELSE
		ls_where = " where (" + ls_where + ")"
	END IF
	
	is_orgsql = is_orgsql + ls_where
	
END IF
end subroutine

public subroutine wf_resize ();CONSTANT Integer MINSIZE = 1641
CONSTANT Integer MAXSIZE = 5000
CONSTANT Integer MARGIN  = 103

Integer i, li_colcnt, li_visible, li_x, li_width, li_size

li_colcnt = Integer(dw_1.Describe("DataWindow.Column.Count"))

FOR i = 1 TO li_colcnt
	
	li_visible = Integer(dw_1.Describe("#" + String(i) + ".X"))
	
	IF li_visible > li_x THEN
		li_x     = li_visible
		li_width = Integer(dw_1.Describe("#" + String(i) + ".Width"))
	END IF
	
NEXT

li_size = li_x + li_width + MARGIN

IF li_size <= MINSIZE THEN RETURN
IF li_size >  MAXSIZE THEN li_size = MAXSIZE

This.Width = li_size + 30
dw_1.Width = li_size

cb_ok.X     += li_size - MINSIZE
cb_cancel.X += li_size - MINSIZE
pb_search.X += li_size - MINSIZE

sle_search.Width += li_size - MINSIZE
end subroutine

on w_popup.create
this.st_1=create st_1
this.pb_search=create pb_search
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_search=create sle_search
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.pb_search,&
this.cb_cancel,&
this.cb_ok,&
this.sle_search,&
this.dw_1}
end on

on w_popup.destroy
destroy(this.st_1)
destroy(this.pb_search)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_search)
destroy(this.dw_1)
end on

event open;IF IsValid(Message.PowerObjectParm) = FALSE THEN
	MessageBox("확인", "전달 받은 인수가 없습니다.")
	Close(This)
	RETURN
END IF

istr_popup = Message.PowerObjectParm

wf_set_section()
wf_resize()

sle_search.Text = istr_popup.data

pb_search.Event Clicked()

CHOOSE CASE dw_1.RowCount()
		
	CASE 0
		
		IF gf_chk_null(istr_popup.data) THEN
			sle_search.SetFocus()
		END IF
		
	CASE ELSE
		
		dw_1.SetFocus()
		
END CHOOSE

end event

event mousemove;//dw_1.Modify("DataWindow.Detail.Color = '536870912'")
end event

type st_1 from statictext within w_popup
integer x = 5
integer y = 1848
integer width = 174
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "검색"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_search from picturebutton within w_popup
integer x = 887
integer y = 1808
integer width = 137
integer height = 120
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = ".\Res\Search.gif"
alignment htextalign = left!
end type

event clicked;  Long ll_i     , ll_colcount, ll_pos  , ll_rowcnt, ll_pos1
String ls_column, ls_split[] , ls_where, ls_from  , ls_tag, ls_coltype, ls_visible

IF NOT gf_chk_null(Trim(sle_search.Text)) THEN
	
	ll_colcount = Long(dw_1.Describe("DataWindow.Column.Count"))
	
	FOR ll_i = 1 TO Min(ll_colcount, 10)
		
		ls_visible = dw_1.Describe("#" + String(ll_i) + ".Visible")
		ls_coltype = dw_1.Describe("#" + String(ll_i) + ".Coltype")
		ls_tag     = dw_1.Describe("#" + String(ll_i) + ".Tag"    )
		
		IF ls_visible                     = '0' THEN CONTINUE
		IF Pos(Lower(ls_coltype), 'char') = 0   THEN CONTINUE
		IF Pos(Lower(ls_tag    ), 'ex'  ) > 0   THEN CONTINUE
		
		ls_column = Upper(dw_1.Describe("#" + String(ll_i) + ".Name"))
		
		ll_pos = Pos(is_orgsql, ls_column)
		
		IF ll_pos > 0 THEN
			IF Mid(is_orgsql, ll_pos - 1, 1) = '.' THEN
				ls_column = Mid(is_orgsql, ll_pos - 2, 2) + ls_column
			END IF
		END IF
		
		IF ls_tag = '=' THEN
			ls_where = ls_where + ls_column + " = '" + sle_search.Text + "' or "
		ELSE
			ls_where = ls_where + ls_column + " like '%" + sle_search.Text + "%' or "
		END IF

	NEXT
	
	ls_from = is_orgsql
	
	DO WHILE Pos(ls_from, ' FROM ') > 0
		ls_from = Mid(ls_from, Pos(ls_from, ' FROM ') + 5)
	LOOP
	
	ll_pos  = Pos(Upper(ls_from ), 'WHERE')
	ll_pos1 = Pos(Upper(ls_where), 'WHERE')
	
	IF ll_pos > 0 OR ll_pos1 > 0 THEN

		ls_where = " and (" + Left(ls_where, Len(ls_where) - 4) + ")"

	ELSE

		ls_where = " where (" + Left(ls_where, Len(ls_where) - 4) + ")"

	END IF
	
END IF

IF gf_chk_null(ls_where) THEN
	dw_1.SetSqlSelect(is_orgsql + is_group)
ELSE
	dw_1.SetSqlSelect(is_orgsql + ls_where + is_group)
END IF

dw_1.SetTransObject(SQLCA)

IF dw_1.Retrieve() = 0 THEN
		
	sle_search.SetFocus()
	sle_search.SelectText(1, Len(sle_search.Text))
	
ELSE
		
	dw_1.SetFocus()
	
END IF
end event

type cb_cancel from commandbutton within w_popup
integer x = 1330
integer y = 1808
integer width = 293
integer height = 120
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "취소"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_popup
integer x = 1042
integer y = 1808
integer width = 293
integer height = 120
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "확인"
end type

event clicked;  Long ll_getrow , i        , ll_colcount, ll_count
String ls_coltype, ls_column

ll_getrow = dw_1.GetRow()

IF ll_getrow < 1 THEN RETURN

ll_colcount = Long(dw_1.Describe("DataWindow.Column.Count"))

FOR i = 1 TO ll_colcount
	
	ll_count++

	ls_column  =       dw_1.Describe("#" + String(i) + ".Name")
	ls_coltype = Lower(dw_1.Describe("#" + String(i) + ".ColType"))
	
	IF Pos(ls_coltype, 'char') > 0 THEN
		istr_popup.rvalue[ll_count] = dw_1.GetItemString(ll_getrow, ls_column)
	ELSEIF Pos(ls_coltype, 'date') > 0 OR Pos(ls_coltype, 'time') > 0 THEN
		istr_popup.rvalue[ll_count] = String(dw_1.GetItemDatetime(ll_getrow, ls_column))
	ELSE
		istr_popup.rvalue[ll_count] = String(dw_1.GetItemDecimal(ll_getrow, ls_column))
	END IF
	
NEXT

CloseWithReturn(Parent, istr_popup)
end event

type sle_search from singlelineedit within w_popup
event ue_enchange pbm_keydown
integer x = 183
integer y = 1832
integer width = 686
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_enchange;IF Key = KeyEnter! THEN
	pb_search.Event Clicked()
	RETURN 1
END IF
end event

event losefocus;cb_ok.Default = TRUE
end event

event getfocus;cb_ok.Default = FALSE
end event

type dw_1 from datawindow within w_popup
event ue_keydown pbm_dwnkey
event ue_mousemove pbm_dwnmousemove
event mouseleave ( )
integer width = 1641
integer height = 1776
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;CHOOSE CASE Key
		
	CASE KeyEnter!
		
		cb_ok.Event Clicked()
		
		RETURN 1
		
END CHOOSE
end event

event ue_mousemove;Object.DataWindow.Detail.Color = "16777215~tif(Getrow() = " + String(row) + ", " + String(ROW_MOUSEMOVE) + ", " + &
														 "if(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215))"
end event

event mouseleave();Object.DataWindow.Detail.Color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"
end event

event doubleclicked;IF row > 0 THEN cb_ok.Event Clicked()

end event

event rbuttondown;  Char lc_sort = 'A'
  Long ll_pos
String ls_dwoname, ls_column, ls_tblsort

ls_dwoname = dwo.Name

IF row < 1 THEN
	
	CHOOSE CASE Lower(dwo.Type)
	
		CASE 'text'
			
			ll_pos = Pos(ls_dwoname, '_t')
			
			IF ll_pos > 0 THEN
			
				ls_column  = Left(ls_dwoname, Len(ls_dwoname) - 2)
				ls_tblsort = Object.DataWindow.Table.Sort
				
				IF ls_tblsort = ls_column + Space(1) + lc_sort THEN
					lc_sort = 'D'
				ELSE
					lc_sort = 'A'
				END IF
				
				SetRedraw(FALSE)
				
				SetSort(ls_column + Space(1) + lc_sort)
				Sort()
				
				SetRedraw(TRUE)
				
			END IF		
	
	END CHOOSE
	
END IF
end event

event rowfocuschanged;IF currentrow > 0 THEN
	
//	Modify("DataWindow.Detail.Color = '536870912~t if ( getrow() = " + String(currentrow) + ", 26738687, 536870912)'")

	SelectRow(0, FALSE)
	SelectRow(currentrow, TRUE)
	
END IF
end event

event retrievestart;SetPointer(HourGlass!)

Reset()
end event

event clicked;IF row > 0 THEN
	IF NOT row = GetRow() THEN SetRow(row)
END IF
end event

event constructor;// Rows Stress

//Object.DataWindow.Detail.Color = "16777215~tif(Mod(GetRow(), 2) = 0, " + String(ROW_STRESS) + ", 16777215)"
end event

event retrieveend;SetPointer(Arrow!)
end event

event other;IF Message.Number = WM_MOUSELEAVE THEN
	Event MouseLeave()
END IF
end event

