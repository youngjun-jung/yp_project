$PBExportHeader$n_svc_dw_base.sru
forward
global type n_svc_dw_base from n_svc_base
end type
end forward

global type n_svc_dw_base from n_svc_base
end type
global n_svc_dw_base n_svc_dw_base

type variables
u_dw_grid idw_client

end variables

forward prototypes
public subroutine of_register (u_dw_grid adw_client)
end prototypes

public subroutine of_register (u_dw_grid adw_client);// -----------------------------------------------------------------------------
// SCRIPT:     n_svc_dw_base.of_Register
//
// PURPOSE:    This function saves a reference to the client datawindow.
//
// ARGUMENTS:  adw_client - The client datawindow.
//
// DATE        CHANGED BY	DESCRIPTION OF CHANGE / REASON
// ----------  ----------  -----------------------------------------------------
// 11/03/2006  Roland S		Initial creation
// -----------------------------------------------------------------------------

// save reference to datawindowl
idw_client = adw_client

// call descendant initialization
of_Initialize()

end subroutine

on n_svc_dw_base.create
call super::create
end on

on n_svc_dw_base.destroy
call super::destroy
end on

