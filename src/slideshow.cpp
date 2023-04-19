/* slideshow.cpp - NSIS Helper DLL for a slideshow. -*- coding: latin-1; -*-
 * Copyright (C) 2016 Intevation GmbH
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any
 * damages arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any
 * purpose, including commercial applications, and to alter it and
 * redistribute it freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must
 *    not claim that you wrote the original software. If you use this
 *    software in a product, an acknowledgment in the product
 *    documentation would be appreciated but is not required.
 *
 * 2. Altered source versions must be plainly marked as such, and must
 *    not be misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source
 *    distribution.
 ************************************************************
 * The code is heavily based on the Slideshow
 * plugin from http://wiz0u.free.fr/prog/nsisSlideshow
 *
 * It was slightly modified and adapted by:
 * 2016 Andre Heinecke <aheinecke@intevation.de>
 *
 * Version 1.7 was Licensed at the time of copying (28.6.2016) as:
 * Copyright (c) 2009-2011 Olivier Marcoux
 *
 * This software is provided 'as-is', without any express or implied warranty. In no
 * event will the authors be held liable for any damages arising from the use of this
 * software.
 *
 * Permission is granted to anyone to use this software for any purpose, including
 * commercial applications, and to alter it and redistribute it freely, subject to the
 * following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not claim
 * that you wrote the original software. If you use this software in a product, an
 * acknowledgment in the product documentation would be appreciated but is not
 * required.
 *
 * 2. Altered source versions must be plainly marked as such, and must not be
 * misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source distribution.
 ************************************************************
 */

#include <windows.h>
#include <shlwapi.h>
#include <iimgctx.h>
#include <stdio.h>
#include "exdll.h"
#include <initguid.h>

static unsigned int timerid = 0xBEEF;

#ifndef _countof
#define _countof(A) (sizeof(A)/sizeof((A)[0]))
#endif

#ifndef INITGUID
#define INITGUID
#endif

__CRT_UUID_DECL(IImgCtx,
                0x3050f3d7, 0x98b5, 0x11cf,
                0xbb, 0x82, 0x00, 0xaa, 0x00, 0xbd, 0xce, 0x0b);

DEFINE_GUID(IID_IImgCtx,
            0x3050f3d7, 0x98b5, 0x11cf,
            0xbb, 0x82, 0x00, 0xaa, 0x00, 0xbd, 0xce, 0x0b);

DEFINE_GUID(CLSID_IImgCtx,
            0x3050f3d6, 0x98b5, 0x11cf,
            0xbb, 0x82, 0x00, 0xaa, 0x00, 0xbd, 0xce, 0x0b);

#undef INITGUID

/* array of precalculated alpha values for a linear crossfade in 15 steps */
const BYTE SCA_Steps[15] = { 17, 18, 20, 21, 23, 26, 28, 32, 36, 43, 51, 64, 85, 127, 255 };
int     g_step = 0;
HWND    g_hWnd = NULL;
HDC     g_hdcMem = NULL;
HBITMAP g_hbmMem = NULL;
TCHAR   g_autoPath[MAX_PATH];
LPTSTR  g_autoBuffer = NULL;
LPTSTR  g_autoNext = NULL;
int     g_autoDelay = 0;
RECT    rDest;
int     wDest, hDest;
WNDPROC lpPrevWndFunc = NULL;
enum HAlign {
    HALIGN_CENTER = 0,
    HALIGN_LEFT,
    HALIGN_RIGHT
} iHAlign;
enum VAlign {
    VALIGN_CENTER = 0,
    VALIGN_TOP,
    VALIGN_BOTTOM
} iVAlign;
enum Fit {
    FIT_STRETCH = 0,
    FIT_WIDTH,
    FIT_HEIGHT,
    FIT_BOTH
} iFit;
COLORREF captionColor;

static LRESULT CALLBACK slide_WndProc(HWND, UINT, WPARAM, LPARAM);

/*****************************************************
 * Abort: stops current processing, detach from slide_WndProc and release resources
 *****************************************************/
static void
slide_abort(bool stayAuto = false)
{
  KillTimer(g_hWnd, timerid);
  if (!stayAuto)
    {
      if (lpPrevWndFunc != NULL && IsWindow(g_hWnd))
        {
          if ((WNDPROC) GetWindowLong(g_hWnd, GWL_WNDPROC) == slide_WndProc)
            SetWindowLongPtr(g_hWnd, GWL_WNDPROC, (long)lpPrevWndFunc);
        }
      lpPrevWndFunc = NULL;
      GlobalFree(g_autoBuffer);
      g_autoBuffer = NULL;
      g_autoNext = NULL;
      g_autoDelay = false;
    }
  DeleteDC(g_hdcMem);
  g_hdcMem = NULL;
  DeleteObject(g_hbmMem);
  g_hbmMem = NULL;
}

static void
slide_NewImage(LPCTSTR imgPath, LPCTSTR caption, int duration)
{
#ifdef UNICODE
  LPCWSTR imgPathW = imgPath;
#else
  WCHAR imgPathW[MAX_PATH];
  MultiByteToWideChar(CP_ACP, 0, imgPath, -1, imgPathW, _countof(imgPathW));
#endif
  IImgCtx *pImage = NULL;
  SIZE imgSize = {0, 0};
  if (SUCCEEDED(CoCreateInstance(CLSID_IImgCtx, NULL, CLSCTX_ALL, IID_IImgCtx, (void**)&pImage)))
    {
      if (SUCCEEDED(pImage->Load(imgPathW, 0)))
        {
          DWORD dwState;
          while (SUCCEEDED(pImage->GetStateInfo(&dwState, NULL, true)) && (dwState & (IMGLOAD_COMPLETE|IMGLOAD_ERROR)) == 0)
            Sleep(20);
          pImage->GetStateInfo(&dwState, &imgSize, true);
        }
      if (imgSize.cx == 0 || imgSize.cy == 0) // error path or format (IMGLOAD_ERROR)
        {
          pImage->Release();
          pImage = NULL;
        }
    }
  if (pImage == NULL)
    return;

  // fit image
  wDest = rDest.right - rDest.left;
  hDest = rDest.bottom - rDest.top;
  if (iFit == FIT_BOTH)
    iFit = (wDest*imgSize.cy > imgSize.cx*hDest) ? FIT_HEIGHT : FIT_WIDTH;
  if (iFit == FIT_HEIGHT)
    wDest = (imgSize.cx * hDest) / imgSize.cy;
  else if (iFit == FIT_WIDTH)
    hDest = (imgSize.cy * wDest) / imgSize.cx;

  // align image
  if (iHAlign == HALIGN_CENTER) rDest.left = (rDest.left + rDest.right - wDest) / 2;
  else if (iHAlign == HALIGN_RIGHT) rDest.left = rDest.right - wDest;
  if (iVAlign == VALIGN_CENTER) rDest.top  = (rDest.top + rDest.bottom - hDest) / 2;
  else if (iVAlign == VALIGN_BOTTOM) rDest.top = rDest.bottom - hDest;
  rDest.right = rDest.left + wDest;
  rDest.bottom = rDest.top + hDest;

  // create memory DC & Bitmap compatible with window's DC
  HDC hWndDC = GetDC(g_hWnd);
  g_hdcMem = CreateCompatibleDC(hWndDC);
  g_hbmMem = CreateCompatibleBitmap(hWndDC, wDest, hDest);
  ReleaseDC(g_hWnd, hWndDC);
  SelectObject(g_hdcMem, g_hbmMem);

  // paint image in memory DC
  RECT bounds = { 0, 0, wDest, hDest };
  pImage->Draw(g_hdcMem, &bounds);
  pImage->Release(); // we don't need the image anymore

  if (caption[0] != '\0')
    {
      LOGFONT lf;
      GetObject((HFONT) ::SendMessage(g_hWnd, WM_GETFONT, 0, 0), sizeof(lf), &lf);
      lf.lfHeight += lf.lfHeight/2;
      HFONT hFont = CreateFontIndirect(&lf);
      HGDIOBJ hOldFont = SelectObject(g_hdcMem, hFont);
      SetTextColor(g_hdcMem, captionColor);
      SetBkMode(g_hdcMem, TRANSPARENT);
      SetTextAlign(g_hdcMem, TA_BOTTOM|TA_CENTER|TA_NOUPDATECP);
      TextOut(g_hdcMem, wDest/2, hDest-10, caption, lstrlen(caption));
      DeleteObject(SelectObject(g_hdcMem, hOldFont));
    }

  // replace windows procedure, start time and initiate first step
  if (lpPrevWndFunc == NULL)
    lpPrevWndFunc = (WNDPROC) SetWindowLongPtr(g_hWnd, GWL_WNDPROC, (long) slide_WndProc);
  if (duration == 0)
    {
      g_step = _countof(SCA_Steps);
      InvalidateRect(g_hWnd, NULL, FALSE); // no duration => force a WM_PAINT for immediate draw of picture
      if (g_autoNext && g_autoDelay)
        SetTimer(g_hWnd, timerid, g_autoDelay, NULL);
    }
  else
    {
      g_step = 0;
      slide_WndProc(g_hWnd, WM_TIMER, timerid, 0); // first iteration right now
      SetTimer(g_hWnd, timerid, duration/_countof(SCA_Steps), NULL);
    }
}

static bool
slide_NextAuto()
{
  LPTSTR scan;
  if (g_autoNext == NULL)
    return false;
  if (*g_autoNext == '.')
    {
      g_autoNext = g_autoBuffer;
      return false;
    }
  bool result = false;
  if (*g_autoNext == '=')
    g_autoNext++;
  for (scan = g_autoNext; *scan; scan++)
    if (*scan == ',') break;
  if (*scan)
    {
      TCHAR imgPath[MAX_PATH];
      *scan = '\0';
      PathCombine(imgPath, g_autoPath, g_autoNext);
      *scan = ',';
      g_autoNext = scan+1;

      int duration = StrToInt(g_autoNext);
      for (scan = g_autoNext; *scan; scan++)
        if (*scan == ',') break;
      if (*scan)
        {
          g_autoNext = scan+1;
          g_autoDelay = StrToInt(g_autoNext);
          for (scan = g_autoNext; *scan; scan++)
            if (*scan == ',') break;
          if (*scan && (scan[1] == '"'))
            {
              g_autoNext = scan+2;
              for (scan = g_autoNext; *scan; scan++)
                if (*scan == '"') break;
              if (*scan)
                {
                  TCHAR caption[MAX_PATH];
                  lstrcpyn(caption, g_autoNext, scan-g_autoNext+1);
                  g_autoNext = scan+1;
                  slide_NewImage(imgPath, caption, duration);
                  result = true;
                }
            }
        }
    }
  g_autoNext += lstrlen(g_autoNext);
  g_autoNext++;
  if (*g_autoNext == '\0')
    g_autoNext = g_autoBuffer;
  return result;
}

/*****************************************************
 * overriden WndProc for NSIS wizard pane
 *****************************************************/
static LRESULT CALLBACK slide_WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
  switch (uMsg)
    {
    case WM_TIMER:
      if (wParam == timerid)
        {
          if (g_step == _countof(SCA_Steps))
            {
              slide_abort(true);
              if (!slide_NextAuto())
                {
                  slide_abort();
                }
              return 0;
            }
          HDC hDC = GetDC(hWnd);
          const BLENDFUNCTION ftn = { AC_SRC_OVER, 0, SCA_Steps[g_step++], 0 };
          AlphaBlend(hDC, rDest.left, rDest.top, wDest, hDest, g_hdcMem, 0, 0, wDest, hDest, ftn);
          ReleaseDC(hWnd, hDC);
          if (g_step == _countof(SCA_Steps))
            {
              if (g_autoNext && g_autoDelay)
                SetTimer(hWnd, timerid, g_autoDelay, NULL);
              else
                KillTimer(hWnd, timerid);
            }
          return 0;
        }
    case WM_PAINT:
      if (g_hdcMem)
        {
          PAINTSTRUCT ps;
          HDC hDC = BeginPaint(hWnd, &ps);
          CallWindowProc(lpPrevWndFunc, hWnd, uMsg, wParam, lParam);
          BitBlt(hDC, rDest.left, rDest.top, wDest, hDest, g_hdcMem, 0, 0, SRCCOPY);
          EndPaint(hWnd, &ps);
          return 0;
        }
      break;

    case WM_CLOSE:
      slide_abort();
      break;
    case WM_COMMAND:
      if(LOWORD(wParam) == IDCANCEL || LOWORD(wParam) == IDOK || LOWORD(wParam) == IDABORT)
        slide_abort();
      break;

    default:
      break;
    }
  return CallWindowProc(lpPrevWndFunc, hWnd, uMsg, wParam, lParam);
}

/*****************************************************
 * NSIS Plugin "stop" entrypoint
 *****************************************************/
#ifdef __cplusplus
extern "C" {
#endif
void __declspec(dllexport)
slide_stop(HWND hwndParent, int string_size, TCHAR *variables, stack_t **stacktop)
{
  slide_abort();
}

/*****************************************************
 * NSIS Plugin "show" entrypoint
 *****************************************************/
void __declspec(dllexport)
slide_show(HWND hwndParent, int string_size, TCHAR *variables, stack_t **stacktop)
{
  EXDLL_INIT();
  slide_abort();

  // argument default values
  iHAlign = HALIGN_CENTER;
  iVAlign = VALIGN_CENTER;
  iFit    = FIT_BOTH;
  g_hWnd = NULL;
  captionColor = RGB(255,255,255);
  int duration = 1000; // transition duration in ms (default = 1s)
  TCHAR caption[MAX_PATH];
  caption[0] = '\0';

  // parse arguments
  TCHAR arg[MAX_PATH];
  LPTSTR argValue;
  while(!popstringn(arg, sizeof arg) && *arg == '/' && (argValue = StrChr(arg, '=')) != NULL)
    {
      *argValue++ = '\0';     // replace '=' by '\0'
      if(lstrcmpi(arg, TEXT("/hwnd")) == 0)
        StrToIntEx(argValue, STIF_SUPPORT_HEX, (int*) &g_hWnd);
      else if(lstrcmpi(arg, TEXT("/fit")) == 0)
        {
          if(lstrcmpi(argValue, TEXT("height")) == 0)		iFit = FIT_HEIGHT;
          else if(lstrcmpi(argValue, TEXT("width")) == 0)	iFit = FIT_WIDTH;
          else if(lstrcmpi(argValue, TEXT("stretch")) == 0)	iFit = FIT_STRETCH;
        }
      else if(lstrcmpi(arg, TEXT("/halign")) == 0)
        {
          if(lstrcmpi(argValue, TEXT("left")) == 0) iHAlign = HALIGN_LEFT;
          else if(lstrcmpi(argValue, TEXT("right")) == 0) iHAlign = HALIGN_RIGHT;
        }
      else if(lstrcmpi(arg, TEXT("/valign")) == 0)
        {
          if(lstrcmpi(argValue, TEXT("top")) == 0) iVAlign = VALIGN_TOP;
          else if(lstrcmpi(argValue, TEXT("bottom")) == 0) iVAlign = VALIGN_BOTTOM;
        }
      else if(lstrcmpi(arg, TEXT("/duration")) == 0)
        StrToIntEx(argValue, STIF_SUPPORT_HEX, &duration);
      else if(lstrcmpi(arg, TEXT("/caption")) == 0)
        lstrcpy(caption, argValue);
      else if(lstrcmpi(arg, TEXT("/ccolor")) == 0)
        StrToIntEx(argValue, STIF_SUPPORT_HEX, (int*) &captionColor);
      else if(lstrcmpi(arg, TEXT("/auto")) == 0)
        {
          lstrcpy(g_autoPath, argValue);
          PathRemoveFileSpec(g_autoPath);
          HGLOBAL hMem = GlobalAlloc(GMEM_FIXED, 32767*sizeof(TCHAR));
          DWORD count = GetPrivateProfileSection(getuservariable(INST_LANG), LPTSTR(hMem), 32767, argValue);
          if (count == 0)
            {
              count = GetPrivateProfileSection(TEXT("1033"), LPTSTR(hMem), 32767, argValue);
              if (count == 0)
                count = GetPrivateProfileSection(TEXT("0"), LPTSTR(hMem), 32767, argValue);
            }
          if (count)
            {
              g_autoBuffer = LPTSTR(GlobalReAlloc(hMem, (count+1)*sizeof(TCHAR), 0));
              g_autoNext = g_autoBuffer;
            }
          else
            GlobalFree(hMem);
        }
    }

  // if target window not defined we'll search for default (the details listview)
  if (g_hWnd == NULL)
    {
      g_hWnd = FindWindowEx(hwndParent, NULL, TEXT("#32770"), NULL);
      if (g_hWnd == NULL)
        return;
      hwndParent = FindWindowEx(hwndParent, g_hWnd, TEXT("#32770"), NULL);
      if (hwndParent != NULL && !IsWindowVisible(hwndParent))
        g_hWnd = hwndParent;
      if (g_hWnd == NULL)
        return;
      HWND hWnd = GetDlgItem(g_hWnd, 1016);
      GetWindowRect(hWnd, &rDest);
      ScreenToClient(g_hWnd, (LPPOINT) &rDest.left);
      ScreenToClient(g_hWnd, (LPPOINT) &rDest.right);
    }
  else
    GetClientRect(g_hWnd, &rDest);

  // load new image
  if (arg[0] == '\0')
    return; // stop here if no filename

  if (g_autoNext != NULL)
    slide_NextAuto();
  else
    slide_NewImage(arg, caption, duration);
}

#ifdef __cplusplus
}
#endif
