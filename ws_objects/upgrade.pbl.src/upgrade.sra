$PBExportHeader$upgrade.sra
$PBExportComments$Generated Application Object
forward
global type upgrade from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables

global type upgrade from application
string appname = "upgrade"
string appruntimeversion = "22.2.0.3397"
end type
global upgrade upgrade

on upgrade.create
appname="upgrade"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on upgrade.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;String ls_parm, ls_appdir, ls_inifile, ls_profile

ls_parm = CommandParm()

ls_appdir = GetCurrentDirectory()

// Profile Database_SQLCA

ls_inifile = ls_appdir + "\corporate_card.ini"
ls_profile = "Database_STATS"

SQLCA.DBMS       = ProfileString(ls_inifile, ls_profile, "DBMS"      , "")
SQLCA.SERVERNAME = ProfileString(ls_inifile, ls_profile, "SERVERNAME", "")
SQLCA.LOGID      = 'HIPLUS_CS'
SQLCA.LOGPASS    = 'CS_HIPLUS'
SQLCA.AUTOCOMMIT = FALSE
SQLCA.DBPARM     = "PBCatalogOwner='" + ProfileString(ls_inifile, ls_profile, "LOGID", "") + "'"
	
CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("데이터베이스 연결 오류", SQLCA.SQLErrText)
	HALT CLOSE
END IF

Open(w_upgrade)
end event

event close;DISCONNECT USING SQLCA;
end event

