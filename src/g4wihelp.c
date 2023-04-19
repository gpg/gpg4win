/* g4wihelp.c - NSIS Helper DLL used with gpg4win. -*- coding: latin-1; -*-
 * Copyright (C) 2005 g10 Code GmbH
 * Copyright (C) 2001 Justin Frankel
 * Copyright (C) 2016, 2017 Intevation GmbH
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
 * The code for the splash screen has been taken from the Splash
 * plugin of the NSIS 2.04 distribution.  That code comes without
 * explicit copyright notices in tyhe source files or author names, it
 * seems that it has been written by Justin Frankel; not sure about
 * the year, though. [wk 2005-11-28]
 */

#include <windows.h>
#include <stdio.h>
#include <tlhelp32.h>
#include <psapi.h>
#include "exdll.h"

static HINSTANCE g_hInstance; /* Our Instance. */
static HWND g_hwndParent;     /* Handle of parent window or NULL. */
static HBITMAP g_hbm;         /* Handle of the splash image. */
static int sleepint;          /* Milliseconds to show the spals image. */

void
slide_stop(HWND hwndParent, int string_size, TCHAR *variables, stack_t **stacktop);

/* Standard entry point for DLLs. */
int WINAPI
DllMain (HANDLE hinst, DWORD reason, LPVOID reserved)
{
   if (reason == DLL_PROCESS_ATTACH)
     g_hInstance = hinst;
   else if (reason == DLL_PROCESS_DETACH)
     slide_stop(NULL, 0, NULL, NULL);
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
  LPCTSTR result;

  g_hwndParent = hwndParent;
  EXDLL_INIT();

  CreateMutexA (NULL, 0, "gpg4win");
  result = GetLastError ()? L"1" : L"0";
  OutputDebugStringA ("Runonce returns:");
  OutputDebugStringW (result);
  setuservariable (INST_R0, result);
}


#include <stdio.h>

/* Extract config file parameters.  FIXME: Not particularly robust.
   We expect some reasonable formatting.  The parser below is very
   limited.  It expects a command line option /c=FILE or /C=FILE,
   where FILE must be enclosed in double-quotes if it contains spaces.
   That file should contain a single section [gpg4win] and KEY=VALUE
   pairs for each additional configuration file to install.  Comments
   are supported only on lines by themselves.  VALUE can be quoted in
   double-quotes, but does not need to be, unless it has whitespace at
   the beginning or end.  KEY can, for example, be "gpg.conf" (without
   the quotes).  */
void
config_init (char **keys, char **values, int max)
{
  /* First, parse the command line.  */
  char *cmdline;
  char *begin = NULL;
  char *end = NULL;
  char mark;
  char *fname;
  char *ptr;
  FILE *conf;

  *keys = NULL;
  *values = NULL;

  cmdline = getuservariable (INST_CMDLINE);

  mark = (*cmdline == '"') ? (cmdline++, '"') : ' ';
  while (*cmdline && *cmdline != mark)
    cmdline++;
  if (mark == '"' && *cmdline)
    cmdline++;
  while (*cmdline && *cmdline == ' ')
    cmdline++;

  while (*cmdline)
    {
      /* We are at the beginning of a new argument.  */
      if (cmdline[0] == '/' && (cmdline[1] == 'C' || cmdline[1] == 'c')
	  && cmdline[2] == '=')
	{
	  cmdline += 3;
	  begin = cmdline;
	}

      while (*cmdline && *cmdline != ' ')
	{
	  /* Skip over quoted parts.  */
	  if (*cmdline == '"')
	    {
	      cmdline++;
	      while (*cmdline && *cmdline != '"')
		cmdline++;
	      if (*cmdline)
		cmdline++;
	    }
	  else
	    cmdline++;
	}
      if (begin && !end)
	{
	  end = cmdline - 1;
	  break;
	}
      while (*cmdline && *cmdline == ' ')
	cmdline++;
    }

  if (!begin || begin > end)
    return;

  /* Strip quotes.  */
  if (*begin == '"' && *end == '"')
    {
      begin++;
      end--;
    }
  if (begin > end)
    return;

  fname = malloc (end - begin + 2);
  if (!fname)
    return;

  ptr = fname;
  while (begin <= end)
    *(ptr++) = *(begin++);
  *ptr = '\0';

  conf = fopen (fname, "r");
  free (fname);
  if (!conf)
    return;

  while (max - 1 > 0)
    {
      char line[256];
      char *ptr2;

      if (fgets (line, sizeof (line), conf) == NULL)
	break;
      ptr = &line[strlen (line)];
      while (ptr > line && (ptr[-1] == '\n' || ptr[-1] == '\r'
			    || ptr[-1] == ' ' || ptr[-1] == '\t'))
	ptr--;
      *ptr = '\0';

      ptr = line;
      while (*ptr && (*ptr == ' ' || *ptr == '\t'))
	ptr++;
      /* Ignore comment lines.  */
      /* FIXME: Ignore section markers.  */
      if (*ptr == '\0' || *ptr == ';' || *ptr == '[')
	continue;
      begin = ptr;
      while (*ptr && *ptr != '=' && *ptr != ' ' && *ptr != '\t')
	ptr++;
      end = ptr - 1;
      while (*ptr && (*ptr == ' ' || *ptr == '\t'))
	ptr++;
      if (*ptr != '=')
	continue;
      ptr++;

      if (begin > end)
	continue;

      /* We found a key.  */
      *keys = malloc (end - begin + 2);
      if (!keys)
	return;
      ptr2 = *keys;
      while (begin <= end)
	*(ptr2++) = *(begin++);
      *ptr2 = '\0';

      *values = NULL;

      while (*ptr && (*ptr == ' ' || *ptr == '\t'))
	ptr++;
      begin = ptr;
      /* In this case, end points to the byte after the value, which
	 is OK because that is '\0'.  */
      end = &line[strlen (line)];
      if (begin > end)
	begin = end;

      /* Strip quotes.  */
      if (*begin == '"' && end[-1] == '"')
	{
	  begin++;
	  end--;
	  *end = '\0';
	}
      if (begin > end)
	return;

      *values = malloc (end - begin + 1);
      ptr2 = *values;
      while (begin <= end)
	*(ptr2++) = *(begin++);

      keys++;
      values++;
      max--;
    }

  fclose (conf);
  *keys = NULL;
  *values = NULL;
}


char *
config_lookup (char *key)
{
#define MAX_KEYS 128
  static int initialised = 0;
  static char *keys[MAX_KEYS];
  static char *values[MAX_KEYS];
  int i;

  if (initialised == 0)
    {
      initialised = 1;
      config_init (keys, values, MAX_KEYS);

#if 0
      MessageBox(g_hwndParent, "Configuration File:", 0, MB_OK);
      i = 0;
      while (keys[i])
	{
	  char buf[256];
	  sprintf (buf, "%s=%s\r\n", keys[i], values[i]);
	  MessageBox (g_hwndParent, buf, 0, MB_OK);
	  i++;
	}
#endif
    }

  i = 0;
  while (keys[i])
    {
      if (!strcmp (keys[i], key))
	return values[i];
      i++;
    }

  return NULL;
}


void __declspec(dllexport)
config_fetch (HWND hwndParent, int string_size, char *variables,
	      stack_t **stacktop, extra_parameters_t *extra)
{
  char key[256];
  int err = 0;
  char *value;

  g_hwndParent = hwndParent;
  EXDLL_INIT();

  /* The expected stack layout: key.  */
  if (popstringn (key, sizeof (key)))
    err = 1;
  if (err)
    {
      setuservariable (INST_R0, "");
      return;
    }

  value = config_lookup (key);

  setuservariable (INST_R0, value == NULL ? "" : value);
  return;
}


void __declspec(dllexport)
config_fetch_bool (HWND hwndParent, int string_size, char *variables,
		   stack_t **stacktop, extra_parameters_t *extra)
{
  char key[256];
  int err = 0;
  char *value;
  int result;

  g_hwndParent = hwndParent;
  EXDLL_INIT();

  /* The expected stack layout: key.  */
  if (popstringn (key, sizeof (key)))
    err = 1;
  if (err)
    {
      setuservariable (INST_R0, "");
      return;
    }

  value = config_lookup (key);
  if (value == NULL || *value == '\0')
    {
      setuservariable (INST_R0, "");
      return;
    }

  result = 0;
  if (!strcasecmp (value, "true")
      || !strcasecmp (value, "yes")
      || atoi (value) != 0)
    result = 1;

  setuservariable (INST_R0, result == 0 ? "0" : "1");
  return;
}


/* Return a string from the Win32 Registry or NULL in case of error.
   Caller must release the return value.  A NULL for root is an alias
   for HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE in turn.  */
char *
read_w32_registry_string (HKEY root, const char *dir, const char *name)
{
  HKEY root_key;
  HKEY key_handle;
  DWORD n1, nbytes, type;
  char *result = NULL;

  root_key = root;
  if (! root_key)
    root_key = HKEY_CURRENT_USER;

  if( RegOpenKeyEx( root_key, dir, 0, KEY_READ, &key_handle ) )
    {
      if (root)
	return NULL; /* no need for a RegClose, so return direct */
      /* It seems to be common practise to fall back to HKLM. */
      if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, dir, 0, KEY_READ, &key_handle) )
	return NULL; /* still no need for a RegClose, so return direct */
    }

  nbytes = 1;
  if( RegQueryValueEx( key_handle, name, 0, NULL, NULL, &nbytes ) ) {
    if (root)
      goto leave;
    /* Try to fallback to HKLM also vor a missing value.  */
    RegCloseKey (key_handle);
    if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, dir, 0, KEY_READ, &key_handle) )
      return NULL; /* Nope.  */
    if (RegQueryValueEx( key_handle, name, 0, NULL, NULL, &nbytes))
      goto leave;
  }

  result = malloc( (n1=nbytes+1) );

  if( !result )
    goto leave;
  if( RegQueryValueEx( key_handle, name, 0, &type, result, &n1 ) ) {
    free(result); result = NULL;
    goto leave;
  }
  result[nbytes] = 0; /* make sure it is really a string  */

 leave:
  RegCloseKey( key_handle );
  return result;
}


/** @brief Kill processes with the name name.
 *
 * This function tries to kill a process using ExitProcess.
 *
 * If it does not work it does not work. No return values.
 * The intention is to make an effort to kill something during
 * installation / uninstallation.
 *
 * The function signature is explained by NSIS.
 */
void __declspec(dllexport) __cdecl KillProc(HWND hwndParent,
                                            int string_size,
                                            char *variables,
                                            stack_t **stacktop)
{
  HANDLE h;
  PROCESSENTRY32 pe32;

  if (!stacktop || !*stacktop || !(*stacktop)->text)
    {
      ERRORPRINTF ("Invalid call to KillProc.");
      return;
    }


  h = CreateToolhelp32Snapshot (TH32CS_SNAPPROCESS, 0);
  if (h == INVALID_HANDLE_VALUE)
    {
      ERRORPRINTF ("Failed to create Toolhelp snapshot");
      return;
    }
  pe32.dwSize = sizeof (PROCESSENTRY32);

  if (!Process32First (h, &pe32))
    {
      ERRORPRINTF ("Failed to get first process");
      CloseHandle (h);
      return;
    }

  do
    {
      if (!strcmp ((*stacktop)->text, pe32.szExeFile))
        {
          HANDLE hProc = OpenProcess (PROCESS_ALL_ACCESS, FALSE,
                                      pe32.th32ProcessID);
          if (!hProc)
            {
              ERRORPRINTF ("Failed to open process handle.");
              continue;
            }
          if (!TerminateProcess (hProc, 1))
            {
              ERRORPRINTF ("Failed to terminate process.");
            }
          CloseHandle (hProc);
        }
    }
  while (Process32Next (h, &pe32));
  CloseHandle (h);
}
