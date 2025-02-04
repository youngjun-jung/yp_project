$PBExportHeader$u_transaction.sru
$PBExportComments$Transaction
forward
global type u_transaction from transaction
end type
end forward

global type u_transaction from transaction
end type
global u_transaction u_transaction

type prototypes
SUBROUTINE SP_LOGIN(String a, String b, ref String c, ref String d, ref String e, ref String f, ref String g, ref String h, ref String i, ref String j) RPCFUNC;
SUBROUTINE SP_PASSWORD_CHECK_KDS_CS(String a, String b, String c, String d, String e, String f, ref String g, ref String h) RPCFUNC;
SUBROUTINE SP_USER_CREATE(String a, String b, String c, String d, String e, String f, ref String g, ref String h) RPCFUNC;
SUBROUTINE SP_USER_ERP_UPDATE(String a, ref String b) RPCFUNC;
SUBROUTINE SP_REG_FI_DOCU(String a, String b, String c, String d, String e, String f, String g, ref String h) RPCFUNC;
end prototypes

on u_transaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_transaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

