$PBExportHeader$w_calculator.srw
$PBExportComments$Calculator
forward
global type w_calculator from window
end type
type st_2 from statictext within w_calculator
end type
type cbx_2 from checkbox within w_calculator
end type
type cb_1 from commandbutton within w_calculator
end type
type st_1 from statictext within w_calculator
end type
type p_percent from picture within w_calculator
end type
type p_enter from picture within w_calculator
end type
type p_multiply from picture within w_calculator
end type
type p_subtract from picture within w_calculator
end type
type p_add from picture within w_calculator
end type
type p_clear from picture within w_calculator
end type
type p_divide from picture within w_calculator
end type
type p_dot from picture within w_calculator
end type
type p_0 from picture within w_calculator
end type
type em_value from editmask within w_calculator
end type
type ddlb_3 from dropdownlistbox within w_calculator
end type
type ddlb_2 from dropdownlistbox within w_calculator
end type
type ddlb_1 from dropdownlistbox within w_calculator
end type
type dw_1 from datawindow within w_calculator
end type
type cbx_1 from checkbox within w_calculator
end type
type mle_display from multilineedit within w_calculator
end type
type p_1 from picture within w_calculator
end type
type p_2 from picture within w_calculator
end type
type p_6 from picture within w_calculator
end type
type p_5 from picture within w_calculator
end type
type p_4 from picture within w_calculator
end type
type p_7 from picture within w_calculator
end type
type p_8 from picture within w_calculator
end type
type p_9 from picture within w_calculator
end type
type gb_1 from groupbox within w_calculator
end type
type gb_2 from groupbox within w_calculator
end type
type gb_3 from groupbox within w_calculator
end type
type p_3 from picture within w_calculator
end type
end forward

global type w_calculator from window
integer width = 1966
integer height = 1396
boolean titlebar = true
string title = "계산기"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = ".\Res\calc.ico"
boolean center = true
st_2 st_2
cbx_2 cbx_2
cb_1 cb_1
st_1 st_1
p_percent p_percent
p_enter p_enter
p_multiply p_multiply
p_subtract p_subtract
p_add p_add
p_clear p_clear
p_divide p_divide
p_dot p_dot
p_0 p_0
em_value em_value
ddlb_3 ddlb_3
ddlb_2 ddlb_2
ddlb_1 ddlb_1
dw_1 dw_1
cbx_1 cbx_1
mle_display mle_display
p_1 p_1
p_2 p_2
p_6 p_6
p_5 p_5
p_4 p_4
p_7 p_7
p_8 p_8
p_9 p_9
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
p_3 p_3
end type
global w_calculator w_calculator

type variables
Boolean ib_enter = TRUE

DataStore ds_calc
end variables

forward prototypes
public subroutine wf_calc (double ad_value)
end prototypes

public subroutine wf_calc (double ad_value);String ls_expression

IF ad_value = 0 THEN RETURN

ds_calc.Reset()
ds_calc.InsertRow(1)

mle_display.SetRedraw(FALSE)

ls_expression = mle_display.Text

IF gf_chk_null(ls_expression) THEN

	ls_expression = String(ad_value)

ELSE
	
	IF IsNumber(Right(Trim(ls_expression), 1)) THEN
		ls_expression += ddlb_1.Text + String(ad_value)
	ELSE
		ls_expression = Trim(ls_expression) + " " + String(ad_value)
	END IF

END IF

ds_calc.Modify("compute_value.Expression = '" + ls_expression + "'")

mle_display.Text = ls_expression
em_value   .Text = String(ds_calc.GetItemNumber(1, 'compute_value'), '#,##0.##########')

mle_display.Scroll(mle_display.LineCount())

IF ib_enter THEN ib_enter = FALSE

mle_display.SetRedraw(TRUE)
end subroutine

on w_calculator.create
this.st_2=create st_2
this.cbx_2=create cbx_2
this.cb_1=create cb_1
this.st_1=create st_1
this.p_percent=create p_percent
this.p_enter=create p_enter
this.p_multiply=create p_multiply
this.p_subtract=create p_subtract
this.p_add=create p_add
this.p_clear=create p_clear
this.p_divide=create p_divide
this.p_dot=create p_dot
this.p_0=create p_0
this.em_value=create em_value
this.ddlb_3=create ddlb_3
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.cbx_1=create cbx_1
this.mle_display=create mle_display
this.p_1=create p_1
this.p_2=create p_2
this.p_6=create p_6
this.p_5=create p_5
this.p_4=create p_4
this.p_7=create p_7
this.p_8=create p_8
this.p_9=create p_9
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.p_3=create p_3
this.Control[]={this.st_2,&
this.cbx_2,&
this.cb_1,&
this.st_1,&
this.p_percent,&
this.p_enter,&
this.p_multiply,&
this.p_subtract,&
this.p_add,&
this.p_clear,&
this.p_divide,&
this.p_dot,&
this.p_0,&
this.em_value,&
this.ddlb_3,&
this.ddlb_2,&
this.ddlb_1,&
this.dw_1,&
this.cbx_1,&
this.mle_display,&
this.p_1,&
this.p_2,&
this.p_6,&
this.p_5,&
this.p_4,&
this.p_7,&
this.p_8,&
this.p_9,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.p_3}
end on

on w_calculator.destroy
destroy(this.st_2)
destroy(this.cbx_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.p_percent)
destroy(this.p_enter)
destroy(this.p_multiply)
destroy(this.p_subtract)
destroy(this.p_add)
destroy(this.p_clear)
destroy(this.p_divide)
destroy(this.p_dot)
destroy(this.p_0)
destroy(this.em_value)
destroy(this.ddlb_3)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.dw_1)
destroy(this.cbx_1)
destroy(this.mle_display)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.p_6)
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_7)
destroy(this.p_8)
destroy(this.p_9)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.p_3)
end on

event open;SetPosition(TopMost!)

ds_calc = CREATE DataStore

ds_calc.DataObject = 'd_calculator2'

ddlb_1.SelectItem(1)
ddlb_2.SelectItem(1)
ddlb_3.SelectItem(1)

mle_display.SetFocus()
end event

event key;//CHOOSE CASE key
////
////	CASE Key0!, KeyNumPad0!
////		IF keyflags = 0 THEN pb_0.Event Clicked()
////	CASE Key1!, KeyNumPad1!
////		IF keyflags = 0 THEN pb_1.Event Clicked()
////	CASE Key2!, KeyNumPad2!
////		IF keyflags = 0 THEN pb_2.Event Clicked()
////	CASE Key3!, KeyNumPad3!
////		IF keyflags = 0 THEN pb_3.Event Clicked()
////	CASE Key4!, KeyNumPad4!
////		IF keyflags = 0 THEN pb_4.Event Clicked()
////	CASE Key5!, KeyNumPad5!
////		IF keyflags = 0 THEN pb_5.Event Clicked()
////	CASE Key6!, KeyNumPad6!
////		IF keyflags = 0 THEN pb_6.Event Clicked()
////	CASE Key7!, KeyNumPad7!
////		IF keyflags = 0 THEN pb_7.Event Clicked()
////	CASE Key8!, KeyNumPad8!
////		IF keyflags = 0 THEN
////			pb_8.Event Clicked()
////		ELSEIF keyflags = 1 THEN
////			pb_multiply.Event Clicked()
////		END IF
////	CASE Key9!, KeyNumPad9!
////		IF keyflags = 0 THEN	pb_9.Event Clicked()
////	CASE KeyAdd!
////		IF keyflags = 0 THEN pb_add.Event Clicked()
////	CASE KeySubtract!
////		IF keyflags = 0 THEN pb_subtract.Event Clicked()
////	CASE KeyMultiply!
////		IF keyflags = 0 THEN pb_multiply.Event Clicked()
////	CASE KeyDivide!
////		IF keyflags = 0 THEN pb_divide.Event Clicked()
//	CASE KeyEqual!, KeyEnter!
//		IF keyflags = 0 THEN	pb_enter.Event Clicked()
////	CASE KeyDash!
////		IF keyflags = 0 THEN pb_subtract.Event Clicked()
////	CASE KeySlash!
////		IF keyflags = 0 THEN pb_divide.Event Clicked()
////		
//END CHOOSE
//
//RETURN 1
end event

event activate;String ls_expression

ls_expression = mle_display.Text

mle_display.SelectText(Len(ls_expression), 0)
end event

type st_2 from statictext within w_calculator
integer x = 1339
integer y = 1088
integer width = 590
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 67108864
string text = "이전 계산 값 가져오기"
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_calculator
integer x = 1257
integer y = 1080
integer width = 91
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean checked = true
end type

type cb_1 from commandbutton within w_calculator
integer x = 832
integer y = 1060
integer width = 402
integer height = 104
integer taborder = 31
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "신규계산"
end type

event clicked;IF cbx_2.Checked THEN
	mle_display.Text = String(Dec(em_value.Text))
ELSE
	mle_display.Text = ""
END IF

em_value.Text = '0'

dw_1.SelectRow(0, FALSE)
end event

type st_1 from statictext within w_calculator
integer x = 942
integer y = 1220
integer width = 187
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "항상위"
boolean focusrectangle = false
end type

type p_percent from picture within w_calculator
integer x = 640
integer y = 960
integer width = 155
integer height = 108
string picturename = ".\Res\percent.gif"
boolean focusrectangle = false
end type

type p_enter from picture within w_calculator
integer x = 640
integer y = 1072
integer width = 155
integer height = 220
string picturename = ".\Res\enter.gif"
boolean focusrectangle = false
end type

event clicked;Long   ll_newrow
String ls_expression

IF ib_enter THEN RETURN

ls_expression = mle_display.Text

IF gf_chk_null(ls_expression) THEN RETURN

dw_1.SetRedraw(FALSE)

ll_newrow = dw_1.InsertRow(0)

dw_1.SetItem(ll_newrow, 'expression', ls_expression)

dw_1.Modify("compute_value.Expression = '" + ls_expression + "'")

em_value.Text = String(dw_1.GetItemNumber(ll_newrow, 'compute_value'), '#,##0.#########')

dw_1.Event RowFocusChanged(ll_newrow)

dw_1.SetRedraw(TRUE)

IF NOT ib_enter THEN ib_enter = TRUE

dw_1.SelectRow(0, FALSE)
end event

type p_multiply from picture within w_calculator
integer x = 480
integer y = 960
integer width = 155
integer height = 108
string picturename = ".\Res\multiply.gif"
boolean focusrectangle = false
end type

event clicked;String ls_expression

ls_expression = mle_display.Text

IF NOT gf_chk_null(ls_expression) THEN
	
	IF IsNumber(Right(Trim(ls_expression), 1)) THEN
		mle_display.Text = Trim(ls_expression) + ' * '
		mle_display.SelectText(Len(mle_display.Text) + 3, 0)
	END IF

END IF

mle_display.SetFocus()
end event

type p_subtract from picture within w_calculator
integer x = 480
integer y = 1072
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\subtract.gif"
boolean focusrectangle = false
end type

event clicked;String ls_expression

ls_expression = mle_display.Text

IF NOT gf_chk_null(ls_expression) THEN
	
	IF IsNumber(Right(Trim(ls_expression), 1)) THEN
		mle_display.Text = Trim(ls_expression) + ' - '
		mle_display.SelectText(Len(mle_display.Text) + 3, 0)
	END IF

END IF

mle_display.SetFocus()
end event

type p_add from picture within w_calculator
integer x = 480
integer y = 1184
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\add.gif"
boolean focusrectangle = false
end type

event clicked;String ls_expression

ls_expression = mle_display.Text

IF NOT gf_chk_null(ls_expression) THEN
	
	IF IsNumber(Right(Trim(ls_expression), 1)) THEN
		mle_display.Text = Trim(ls_expression) + ' + '
		mle_display.SelectText(Len(mle_display.Text) + 3, 0)
	END IF

END IF

mle_display.SetFocus()
end event

type p_clear from picture within w_calculator
integer x = 640
integer y = 848
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\clear.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text = ''
em_value   .Text = ''

IF NOT ib_enter THEN ib_enter = TRUE

dw_1.SelectRow(0, FALSE)
end event

type p_divide from picture within w_calculator
integer x = 480
integer y = 848
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\divide.gif"
boolean focusrectangle = false
end type

event clicked;String ls_expression

ls_expression = mle_display.Text

IF NOT gf_chk_null(ls_expression) THEN
	
	IF IsNumber(Right(Trim(ls_expression), 1)) THEN
		mle_display.Text = Trim(ls_expression) + ' / '
		mle_display.SelectText(Len(mle_display.Text) + 3, 0)
	END IF

END IF

mle_display.SetFocus()
end event

type p_dot from picture within w_calculator
integer x = 320
integer y = 1184
integer width = 155
integer height = 108
string picturename = ".\Res\dot.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '.'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_0 from picture within w_calculator
integer y = 1184
integer width = 315
integer height = 108
string picturename = ".\Res\0.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '0'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type em_value from editmask within w_calculator
event keydown pbm_keydown
integer y = 760
integer width = 1952
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 25166079
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "###,###,###,###,###,##0.##########"
end type

type ddlb_3 from dropdownlistbox within w_calculator
integer x = 1440
integer y = 920
integer width = 475
integer height = 712
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711935
long backcolor = 16777215
boolean sorted = false
string item[] = {"해당없음","백단위","십단위","원단위","소수1자리","소수2자리","소수3자리","소수4자리","소수5자리","소수6자리","소수7자리","소수8자리","소수9자리"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_2 from dropdownlistbox within w_calculator
integer x = 1143
integer y = 920
integer width = 293
integer height = 304
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 16777215
boolean sorted = false
string item[] = {"일반","반올림","절사"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;IF index = 1 THEN
	
	ddlb_3.SelectItem(1)
	ddlb_3.Enabled = FALSE
	
ELSE
	
	ddlb_3.Enabled = TRUE
	
END IF
end event

type ddlb_1 from dropdownlistbox within w_calculator
integer x = 832
integer y = 920
integer width = 242
integer height = 304
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 16777215
boolean sorted = false
string item[] = {" + "," - "," * "," / "}
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_calculator
event ue_keydown pbm_dwnkey
integer width = 1952
integer height = 552
string title = "none"
string dataobject = "d_calculator"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event losefocus;SelectRow(0, FALSE)
end event

event clicked;String ls_expression

IF row > 0 THEN
	
	SelectRow(0, FALSE)
	SelectRow(row, TRUE)
	
	ls_expression = GetItemString(row, 'expression')
	
	Modify("compute_value.Expression = '" + ls_expression + "'")
	
	mle_display.Text = ls_expression
	em_value   .Text = String(GetItemNumber(row, 'compute_value'), '#,##0.#########')
	
END IF
end event

type cbx_1 from checkbox within w_calculator
integer x = 859
integer y = 1212
integer width = 82
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean checked = true
end type

event clicked;IF Checked THEN
	Parent.SetPosition(TopMost!)
ELSE
	Parent.SetPosition(NoTopMost!)
END IF
end event

type mle_display from multilineedit within w_calculator
event ue_keydown pbm_keydown
integer y = 552
integer width = 1952
integer height = 208
integer taborder = 1
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33521664
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;//CHOOSE CASE key
//		
//	CASE KeyEnter!
//		
//		p_enter.Event Clicked()
//		
//		RETURN 1
//		
//END CHOOSE
end event

event modified;IF ib_enter THEN ib_enter = FALSE
end event

type p_1 from picture within w_calculator
integer y = 1072
integer width = 155
integer height = 108
string picturename = ".\Res\1.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '1'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_2 from picture within w_calculator
integer x = 160
integer y = 1072
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\2.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '2'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_6 from picture within w_calculator
integer x = 320
integer y = 960
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\6.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '6'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_5 from picture within w_calculator
integer x = 160
integer y = 960
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\5.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '5'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_4 from picture within w_calculator
integer y = 960
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\4.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '4'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_7 from picture within w_calculator
integer y = 848
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\7.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '7'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_8 from picture within w_calculator
integer x = 160
integer y = 848
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\8.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '8'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type p_9 from picture within w_calculator
integer x = 320
integer y = 848
integer width = 155
integer height = 108
boolean originalsize = true
string picturename = ".\Res\9.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '9'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

type gb_1 from groupbox within w_calculator
integer x = 800
integer y = 856
integer width = 306
integer height = 176
integer taborder = 11
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "자동부호"
end type

type gb_2 from groupbox within w_calculator
integer x = 1111
integer y = 856
integer width = 837
integer height = 176
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "단수처리"
end type

type gb_3 from groupbox within w_calculator
integer x = 800
integer y = 1012
integer width = 1147
integer height = 176
integer taborder = 21
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
end type

type p_3 from picture within w_calculator
integer x = 320
integer y = 1072
integer width = 155
integer height = 108
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\Res\3.gif"
boolean focusrectangle = false
end type

event clicked;mle_display.Text += '3'

mle_display.SelectText(Len(mle_display.Text) + 1, 0)

IF ib_enter THEN ib_enter = FALSE

mle_display.SetFocus()
end event

