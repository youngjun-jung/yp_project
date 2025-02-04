$PBExportHeader$w_10010001.srw
forward
global type w_10010001 from w_ancestor_03
end type
type cb_map from commandbutton within w_10010001
end type
type cb_del from commandbutton within w_10010001
end type
type st_2 from statictext within w_10010001
end type
end forward

global type w_10010001 from w_ancestor_03
integer height = 3024
cb_map cb_map
cb_del cb_del
st_2 st_2
end type
global w_10010001 w_10010001

type variables
Long il_chk_cnt
end variables

on w_10010001.create
int iCurrent
call super::create
this.cb_map=create cb_map
this.cb_del=create cb_del
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_map
this.Control[iCurrent+2]=this.cb_del
this.Control[iCurrent+3]=this.st_2
end on

on w_10010001.destroy
call super::destroy
destroy(this.cb_map)
destroy(this.cb_del)
destroy(this.st_2)
end on

event open;call super::open;String ls_date
/*
select to_char(sysdate - 1, 'yyyymmdd')
into :ls_date
from dual;
*/
dw_cdt.object.frdate[1] = ls_date
dw_cdt.object.todate[1] = ls_date
end event

event ue_retrieve;call super::ue_retrieve;String ls_frdate, ls_todate, ls_cardno
Long ll_row

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]
ls_cardno = dw_cdt.object.cardno[1]

if gf_chk_null(ls_cardno) then 
	ls_cardno = '%'
else
	ls_cardno = '%' + ls_cardno + '%'
end if

ll_row = dw_1.insertrow(0)

dw_1.object.menuid[ll_row] = string(ll_row)

//dw_1.retrieve(ls_frdate, ls_todate, ls_cardno, gstr_userenv.user_id)

il_chk_cnt = 0

return true
end event

event resize;call super::resize;if gs_width_chk <> '0' then return

wf_resize()

cb_map.x = dw_1.x + dw_1.Width - cb_map.Width	
cb_map.y = dw_1.y + dw_1.Height + cb_map.Height - 40
cb_del.x = dw_1.x 
cb_del.y = dw_1.y + dw_1.Height + cb_map.Height - 40

sle_id.x = cb_del.x
sle_id.y = cb_del.y + cb_del.height + 60
end event

event ue_preview;call super::ue_preview;string ls_url, ls_frdate, ls_todate, ls_card_num

dw_cdt.accepttext()

ls_frdate = dw_cdt.object.frdate[1]
ls_todate = dw_cdt.object.todate[1]
ls_card_num = dw_cdt.object.cardno[1]

if gf_chk_null(ls_card_num) then 
	ls_url = "http://nreport.hipluscard.co.kr/ClipReport5/corpcardForm.jsp?report=use_row.crf&runvar=@AS_FRDATE@"+ls_frdate+"@AS_TODATE@"+ls_todate
else
	ls_url = "http://nreport.hipluscard.co.kr/ClipReport5/corpcardForm.jsp?report=use_row.crf&runvar=@AS_FRDATE@"+ls_frdate+"@AS_TODATE@"+ls_todate+"@AS_CARD_NUM@"+ls_card_num
end if

gf_print_open(ls_url)

//gf_preview(ls_url)
end event

type dw_1 from w_ancestor_03`dw_1 within w_10010001
string dataobject = "d_hpc_menu"
boolean ib_selectrow = true
end type

event dw_1::clicked;call super::clicked;CHOOSE CASE dwo.Name
		
	CASE 'chk'
						
		if dw_1.object.chk[row] = 'N' then
			
			if il_chk_cnt= 9 then
				
				messagebox("확인", "9개까지만 표출 가능합니다")
				return
				
			end if
			
			dw_1.object.chk[row] = 'Y'
			il_chk_cnt = il_chk_cnt + 1
			
		elseif dw_1.object.chk[row] = 'Y' then
			
			dw_1.object.chk[row] = 'N'
			il_chk_cnt = il_chk_cnt - 1
			
		end if
													
END CHOOSE

end event

type sle_id from w_ancestor_03`sle_id within w_10010001
end type

type dw_cdt from w_ancestor_03`dw_cdt within w_10010001
string dataobject = "d_10010001_cdt"
end type

type st_1 from w_ancestor_03`st_1 within w_10010001
end type

type cb_map from commandbutton within w_10010001
integer x = 5435
integer y = 2424
integer width = 352
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "지도보기"
end type

event clicked;s_daum ls_daum
Long i, j, ll_rowcnt, ll_chk
String ls_chk, ls_addr[9], ls_reg_addr

ll_rowcnt = dw_1.rowcount()

if ll_rowcnt = 0 then return

ll_chk = 0

for i = 0 to ll_rowcnt - 1

	if dw_1.object.chk[i+1] = 'Y' then
		
		if not(isnull(dw_1.object.addr[i+1]) or dw_1.object.addr[i+1] = '') and not(isnull(dw_1.object.merc_name[i+1]) or dw_1.object.merc_name[i+1] = '') then
			
			ls_chk = 'N'
			ls_reg_addr = dw_1.object.addr[i+1]
			
			for j = 1 to ll_chk
				
				if ls_addr[j] = ls_reg_addr then ls_chk = 'Y'

			next
			
			if ls_chk = 'N' then
	
				ls_daum.sle2 = "&a" + string(ll_chk) + "1=" + dw_1.object.addr[i+1]  +"&a" + string(ll_chk) + "2=" + dw_1.object.merc_name[i+1]
				ls_daum.sle3 = ls_daum.sle3 + ls_daum.sle2
										
				ll_chk = ll_chk + 1
				ls_addr[ll_chk] = dw_1.object.addr[i+1]
				
			end if
			
		end if
		
	end if;
	
next

ls_daum.sle1 = 'file:///C:\Program Files (x86)\corpcard/aaa.jsp?cnt=' + string(ll_chk)

ls_daum.sle1 = ls_daum.sle1 + ls_daum.sle3

if ll_chk = 0 then return

messagebox("ls_daum.sle1", ls_daum.sle1)

openwithparm(w_daum, ls_daum)
end event

type cb_del from commandbutton within w_10010001
integer x = 215
integer y = 2436
integer width = 352
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "체크초기화"
end type

event clicked;Long i, ll_rowcnt

ll_rowcnt = dw_1.rowcount()

if ll_rowcnt = 0 then return

for i = 1 to ll_rowcnt

	if dw_1.object.chk[i] = 'Y' then
		
		dw_1.object.chk[i] = 'N'
		
	end if;
	
next

il_chk_cnt = 0


end event

type st_2 from statictext within w_10010001
integer x = 219
integer y = 480
integer width = 1303
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217857
string text = "⋇ 정상승인(부분취소포함)건만 합계에 포함됩니다."
boolean focusrectangle = false
end type

