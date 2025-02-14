$PBExportHeader$w_30010001.srw
forward
global type w_30010001 from w_ancestor_08
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_6 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_7 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_8 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
type tabpage_9 from userobject within tab_1
end type
end forward

global type w_30010001 from w_ancestor_08
end type
global w_30010001 w_30010001

forward prototypes
public subroutine wf_resize ()
end prototypes

public subroutine wf_resize ();

				
end subroutine

on w_30010001.create
int iCurrent
call super::create
end on

on w_30010001.destroy
call super::destroy
end on

event resize;call super::resize;if gs_width_chk <> '0' then return

//wf_resize()

sle_id.x = tab_1.x
sle_id.y = tab_1.y + tab_1.height + 60

dw_cdt.Width = 	w_mainmdi.mdi_1.Width - 400

tab_1.x = dw_cdt.x
tab_1.y = dw_cdt.y + dw_cdt.Height + 100
tab_1.Width = 	w_mainmdi.mdi_1.Width - 400			
tab_1.Height = w_mainmdi.mdi_1.Height - 1200

//tab_1.tabpage_1.dw_1.x = tab_1.tabpage_1. x
//tab_1.tabpage_1.dw_1.y = tab_1.tabpage_1. y
tab_1.tabpage_1.dw_1.Width = tab_1.Width - 60
tab_1.tabpage_1.dw_1.Height = tab_1.Height -150
end event

event open;call super::open;Date ld_toyear
ld_toyear = Today()

dw_cdt.object.toyear[1] = String(ld_toyear, "yyyy")

end event

type sle_id from w_ancestor_08`sle_id within w_30010001
end type

type tab_1 from w_ancestor_08`tab_1 within w_30010001
integer textsize = -10
integer weight = 400
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from w_ancestor_08`tabpage_1 within tab_1
integer y = 112
integer height = 1864
string text = "주요내역"
string picturename = ".\res\Circle1.gif"
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_cdt from w_ancestor_08`dw_cdt within w_30010001
string dataobject = "d_30010001_cdt"
end type

event dw_cdt::ue_dddw_retrieve;call super::ue_dddw_retrieve;Long i

CHOOSE CASE column
		
	CASE 'toyear'		

		FOR i = 1 TO 99
			dddw.InsertRow(i)
			dddw.SetItem(i, 1, String(2019 + i))
		NEXT
				
END CHOOSE
end event

type st_1 from w_ancestor_08`st_1 within w_30010001
end type

type dw_1 from datawindow within tabpage_1
integer x = 9
integer y = 8
integer width = 2633
integer height = 1844
integer taborder = 10
string title = "none"
boolean border = false
boolean livescroll = true
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "제품별"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle2.gif"
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "M.bal"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle3.gif"
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "아연"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle4.gif"
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "종류별"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle5.gif"
long picturemaskcolor = 536870912
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "TSL"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle6.gif"
long picturemaskcolor = 536870912
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "TSL 종합"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle7.gif"
long picturemaskcolor = 536870912
end type

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "부산물"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle8.gif"
long picturemaskcolor = 536870912
end type

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 5527
integer height = 1864
string text = "Plug"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
string picturename = ".\res\Circle9.gif"
long picturemaskcolor = 536870912
end type

