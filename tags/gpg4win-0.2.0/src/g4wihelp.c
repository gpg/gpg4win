/* g4wihelp.c - NSIS Helper DLL used with gpg4win. -*- coding: latin-1; -*-
 * Copyright (C) 2005 g10 Code GmbH
 * 
 * This file is free software; as a special exception the author gives
 * unlimited permission to copy and/or distribute it, with or without
 * modifications, as long as this notice is preserved.
 *
 * This file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
 * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

#include <windows.h>
#include "exdll.h"

static HINSTANCE g_hInstance;
static HWND g_hwndParent;


/* Standard entry point for DLLs. */
int WINAPI
DllMain (HANDLE hinst, DWORD reason, LPVOID reserved)
{
   if (reason == DLL_PROCESS_ATTACH)
     g_hInstance = hinst;
   return TRUE;
}



/* Dummy function for testing. */
void __declspec(dllexport) 
dummy (HWND hwndParent, int string_size, char *variables, 
       stack_t **stacktop, extra_parameters_t *extra)
{
  g_hwndParent = hwndParent;

  EXDLL_INIT();

  // note if you want parameters from the stack, pop them off in order.
  // i.e. if you are called via exdll::myFunction file.dat poop.dat
  // calling popstring() the first time would give you file.dat,
  // and the second time would give you poop.dat. 
  // you should empty the stack of your parameters, and ONLY your
  // parameters.

  // do your stuff here
  {
    char buf[1024];
    sprintf(buf,"$R0=%s\r\n$R1=%s\r\n",
            getuservariable(INST_R0),
            getuservariable(INST_R1));
    MessageBox(g_hwndParent,buf,0,MB_OK);

    sprintf (buf,
             "autoclose    =%d\r\n"
             "all_user_var =%d\r\n"
             "exec_error   =%d\r\n"
             "abort        =%d\r\n"
             "exec_reboot  =%d\r\n"
             "reboot_called=%d\r\n"
             "silent       =%d\r\n"
             "instdir_error=%d\r\n"
             "rtl          =%d\r\n"
             "errlvl       =%d\r\n",
             extra->exec_flags->autoclose,
             extra->exec_flags->all_user_var,
             extra->exec_flags->exec_error,
             extra->exec_flags->abort,
             extra->exec_flags->exec_reboot,
             extra->exec_flags->reboot_called,
             extra->exec_flags->silent,
             extra->exec_flags->instdir_error,
             extra->exec_flags->rtl,
             extra->exec_flags->errlvl);      
    MessageBox(g_hwndParent,buf,0,MB_OK);
  }
}



void __declspec(dllexport) 
runonce (HWND hwndParent, int string_size, char *variables, 
         stack_t **stacktop, extra_parameters_t *extra)
{
  const char *result;

  g_hwndParent = hwndParent;
  EXDLL_INIT();

  CreateMutexA (NULL, 0, getuservariable(INST_R0));
  result = GetLastError ()? "1":"0";
  setuservariable (INST_R0, result);
}


