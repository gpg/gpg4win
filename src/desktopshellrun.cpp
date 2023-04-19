/* Copyright (C) 2014 by Bundesamt für Sicherheit in der Informationstechnik
 * Copyright (C) 2016 Intevation GmbH
 * Software engineering by Intevation GmbH
 *
 * This file is Free Software under the GNU GPL (v>=2)
 * and comes with ABSOLUTELY NO WARRANTY!
 */

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <initguid.h>
#include <mstask.h>
#include <wchar.h>
#include <ole2.h>
#include <shldisp.h>
#include <shobjidl.h>
#include <exdisp.h>
#include <shlguid.h>

#include "exdll.h"
#ifndef INITGUID
#define INITGUID
#endif

/* Some declarations missing in mingw-w64 3.1.0 taken from msdn */
#if ! defined (__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 5
__CRT_UUID_DECL(IShellWindows, 0x85CB6900, 0x4D95, 0x11CF,
                0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85);

DEFINE_GUID(IID_IShellWindows,
            0x85CB6900, 0x4D95, 0x11CF,
            0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85);
DEFINE_GUID(CLSID_ShellWindows,
            0x9BA05972, 0xF6A8, 0x11CF,
            0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39);


__CRT_UUID_DECL(IShellDispatch2, 0xA4C6892C, 0x3BA9, 0x11d2,
                0x9D, 0xEA, 0x00, 0xC0, 0x4F, 0xB1, 0x61, 0x62);
__CRT_UUID_DECL(IShellFolderViewDual,  0xe7a1af80, 0x4d96,
                0x11cf, 0x96, 0x0c, 0x00, 0x80, 0xc7, 0xf4, 0xee, 0x85);
#endif

#ifndef SWC_DESKTOP /* Will probably be addedd in future mingw */
#define SWC_DESKTOP 0x00000008
/* from http://msdn.microsoft.com/en-us/library/windows/desktop/cc836581%28v=vs.85%29.aspx */
#endif

#define UNUSED(x) (void)(x)

/** @brief the actual execuation call on the shell dispatcher
 *
 * @param[in] disp The shell dispatcher to use for shell execute.
 * @param[in] fName The file that should be exectued.
 * @param[in] param Optinal parameters to add.
 *
 * @returns true on success.
 */
static bool
shellexecute(IShellDispatch2 *disp, wchar_t *fName, wchar_t *param)
{
  BSTR bName = NULL,
       bParam = NULL,
       bDir = NULL,
       bOp = NULL;
  VARIANT vParams[4];
  HRESULT hr;

  if (!fName || !disp)
    {
      ERRORPRINTF ("Invalid call to shellexecute.");
      return false;
    }

  bName = SysAllocString(fName);
  bParam = SysAllocString(param ? param : L"");
  bDir = SysAllocString(L"");
  bOp = SysAllocString(L"");

  if (!bName || !bParam || !bDir || !bOp)
    {
      /* Out of memory */
      ERRORPRINTF ("Failed to allocate bstr values ");
      return false;
    }

  vParams[0].vt = VT_BSTR;
  vParams[0].bstrVal = bParam;
  vParams[1].vt = VT_BSTR;
  vParams[1].bstrVal = bDir;
  vParams[2].vt = VT_BSTR;
  vParams[2].bstrVal = bOp;
  vParams[3].vt = VT_INT;
  vParams[3].intVal = SW_SHOWNORMAL;

  hr = disp->ShellExecute(bName, vParams[0], vParams[1], vParams[2], vParams[3]);

  SysFreeString(bName);
  SysFreeString(bParam);
  SysFreeString(bOp);
  SysFreeString(bDir);

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to execute.");
      return false;
    }
  return true;
}

#ifdef __cplusplus
extern "C" {
#endif

/** @brief Execute a command with the current running shell.
 *
 * This function is intended to be called when you want to
 * make sure that your application is not executed with higher
 * privileges then the normal desktop session.
 *
 * The code is based on the idea:
 * http://blogs.msdn.com/b/oldnewthing/archive/2013/11/18/10468726.aspx
 *
 * The function signature is explained by NSIS.
 */
void __declspec(dllexport) __cdecl DesktopShellRun(HWND hwndParent,
                                                   int string_size,
                                                   char *variables,
                                                   stack_t **stacktop)
{
  UNUSED(hwndParent);
  UNUSED(string_size);
  HRESULT hr;
  wchar_t *wbuf = NULL;
  IShellWindows *shellWindows = NULL;
  IShellBrowser *shellBrowser = NULL;
  IShellView *shellView = NULL;
  IShellFolderViewDual *folderView = NULL;
  IShellDispatch2 *shellDispatch = NULL;
  IServiceProvider *serviceProv = NULL;
  HWND hwnd;
  IDispatch *disp = NULL,
             *bgDisp = NULL,
              *sDisp = NULL;
  VARIANT vEmpty = {};

  if (!stacktop || !*stacktop || !(*stacktop)->text)
    {
      ERRORPRINTF ("Invalid call to exec :");
      return;
    }

  /* Initialize com ctx */
  hr = CoInitialize(NULL);
  if(FAILED(hr))
    {
      ERRORPRINTF ("CoInitializeEx failed. error = 0x%lx.", hr);
      return;
    }

  /* Get the shell interface */
  hr = CoCreateInstance(CLSID_ShellWindows,
                        NULL, CLSCTX_LOCAL_SERVER,
                        IID_PPV_ARGS(&shellWindows));
  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get shell interface.");
      goto done;
    }

  /* Get the desktop shell window */
  hr = shellWindows->FindWindowSW(&vEmpty,
                                  &vEmpty,
                                  SWC_DESKTOP,
                                  (long*)&hwnd,
                                  SWFO_NEEDDISPATCH,
                                  &disp);
  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to find the desktop dispatcher.");
      goto done;
    }

  hr = disp->QueryInterface(IID_PPV_ARGS(&serviceProv));

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get the service provider.");
      goto done;
    }

  /* Get the shell browser */
  hr = serviceProv->QueryService(SID_STopLevelBrowser, IID_PPV_ARGS(&shellBrowser));
  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to find the top level browser.");
      goto done;
    }

  hr = shellBrowser->QueryActiveShellView(&shellView);

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to find the active view.");
      goto done;
    }

  hr = shellView->GetItemObject(SVGIO_BACKGROUND, IID_PPV_ARGS(&bgDisp));

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get the views background.");
      goto done;
    }

  hr = bgDisp->QueryInterface(IID_PPV_ARGS(&folderView));

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get the folder view.");
      goto done;
    }


  hr = folderView->get_Application(&sDisp);

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get the shell dispatch.");
      goto done;
    }

  hr = sDisp->QueryInterface(IID_PPV_ARGS(&shellDispatch));

  if (FAILED(hr))
    {
      ERRORPRINTF ("Failed to get the shell dispatch interface.");
      goto done;
    }

  /* For unicodensis this has to be utf8 to wchar */

  wbuf = wcsdup ((*stacktop)->text);
  if (!wbuf)
    {
      ERRORPRINTF ("Failed to convert argument to wchar. error = 0x%lx.", hr);
      goto done;
    }

  if (!shellexecute(shellDispatch, wbuf, NULL))
    {
      ERRORPRINTF ("Failed to execute.");
    }
  if (wbuf)
    free(wbuf);
done:
  if (folderView)
    {
      folderView->Release();
    }
  if (disp)
    {
      disp->Release();
    }
  if (shellBrowser)
    {
      shellBrowser->Release();
    }
  if (shellWindows)
    {
      shellWindows->Release();
    }
  if (shellView)
    {
      shellView->Release();
    }
  if (sDisp)
    {
      sDisp->Release();
    }
  if (shellDispatch)
    {
      shellDispatch->Release();
    }
  if (serviceProv)
    {
      serviceProv->Release();
    }
  CoUninitialize();
  return;
}

#ifdef __cplusplus
}
#endif
