/* kleowrap.c - Wrapper to call gpg under Windows.
 * Copyright (C) 2007, 2008 g10 Code GmbH
 *
 * This file is part of Gpg4win.
 *
 * Gpg4win is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Gpg4win is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <process.h>
#include <windows.h>
#include <errno.h>


#define DEBUG_W32_SPAWN 0


static HANDLE
w32_open_null (int for_write)
{
  HANDLE hfile;

  hfile = CreateFile ("nul",
                      for_write ? GENERIC_WRITE : GENERIC_READ,
                      FILE_SHARE_READ | FILE_SHARE_WRITE,
                      NULL, OPEN_EXISTING, 0, NULL);
  return hfile;
}


char *
stpcpy(char *a,const char *b)
{
    while( *b )
	*a++ = *b++;
    *a = 0;

    return (char*)a;
}


/* Helper function to build_w32_commandline. */
static char *
build_w32_commandline_copy (char *buffer, const char *string)
{
  char *p = buffer;
  const char *s;

  if (!*string) /* Empty string. */
    p = stpcpy (p, "\"\"");
  else if (strpbrk (string, " \t\n\v\f\""))
    {
      /* Need top do some kind of quoting.  */
      p = stpcpy (p, "\"");
      for (s=string; *s; s++)
        {
          *p++ = *s;
          if (*s == '\"')
            *p++ = *s;
        }
      *p++ = '\"';
      *p = 0;
    }
  else
    p = stpcpy (p, string);

  return p;
}


/* Build a command line for use with W32's CreateProcess.  On success
   CMDLINE gets the address of a newly allocated string.  */
static char *
build_w32_commandline (const char *pgmname, const char * const *argv)
{
  int i, n;
  const char *s;
  char *buf, *p;

  n = 0;
  s = pgmname;
  n += strlen (s) + 1 + 2;  /* (1 space, 2 quoting */
  for (; *s; s++)
    if (*s == '\"')
      n++;  /* Need to double inner quotes.  */
  for (i=0; (s=argv[i]); i++)
    {
      n += strlen (s) + 1 + 2;  /* (1 space, 2 quoting */
      for (; *s; s++)
        if (*s == '\"')
          n++;  /* Need to double inner quotes.  */
    }
  n++;

  buf = p = malloc (n);
  if (! buf)
    return NULL;

  p = build_w32_commandline_copy (p, pgmname);
  for (i = 0; argv[i]; i++) 
    {
      *p++ = ' ';
      p = build_w32_commandline_copy (p, argv[i]);
    }

  return buf;
}


int
spawn_process_and_wait (const char *pgmname, const char * const *argv)
{
  int err;
  SECURITY_ATTRIBUTES sec_attr;
  PROCESS_INFORMATION pi = 
    {
      NULL,      /* Returns process handle.  */
      0,         /* Returns primary thread handle.  */
      0,         /* Returns pid.  */
      0          /* Returns tid.  */
    };
  STARTUPINFO si;
  int cr_flags;
  char *cmdline;
  HANDLE proc;
  int code;
  DWORD exc;

  /* Prepare security attributes.  */
  memset (&sec_attr, 0, sizeof sec_attr);
  sec_attr.nLength = sizeof sec_attr;
  sec_attr.bInheritHandle = FALSE;
  
  /* Build the command line.  */
  cmdline = build_w32_commandline (pgmname, argv);
  if (! cmdline)
    return -1; 

  /* Start the process.  Note that we can't run the PREEXEC function
     because this would change our own environment. */
  memset (&si, 0, sizeof si);
  si.cb = sizeof (si);
  si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
  si.wShowWindow = DEBUG_W32_SPAWN ? SW_SHOW : SW_MINIMIZE;
  si.hStdInput = w32_open_null (0);
  si.hStdOutput = w32_open_null (1);
  si.hStdError = w32_open_null (1);

  cr_flags = (CREATE_DEFAULT_ERROR_MODE
              | DETACHED_PROCESS
              | GetPriorityClass (GetCurrentProcess ())
              | CREATE_SUSPENDED); 
  if (!CreateProcess (pgmname,       /* Program to start.  */
                      cmdline,       /* Command line arguments.  */
                      &sec_attr,     /* Process security attributes.  */
                      &sec_attr,     /* Thread security attributes.  */
                      TRUE,          /* Inherit handles.  */
                      cr_flags,      /* Creation flags.  */
                      NULL,          /* Environment.  */
                      NULL,          /* Use current drive/directory.  */
                      &si,           /* Startup information. */
                      &pi            /* Returns process information.  */
                      ))
    {
      free (cmdline);
      CloseHandle (si.hStdInput);
      CloseHandle (si.hStdOutput);
      CloseHandle (si.hStdError);
      return -1;
    }
  free (cmdline);
  cmdline = NULL;

  /* Process has been created suspended; resume it now. */
  ResumeThread (pi.hThread);
  CloseHandle (pi.hThread); 

  /* Wait for it to finish.  */

  proc = pi.hProcess;
  err = 0;

  code = WaitForSingleObject (proc, INFINITE);
  switch (code) 
    {
      case WAIT_OBJECT_0:
        if (! GetExitCodeProcess (proc, &exc))
	  err = -1;
	else
	  err = exc;
	break;

      default:
	err = -1;
        break;
    }

  CloseHandle (proc);

  return err;
}


/* Assumes that the current working directory is the Gpg4win INSTDIR
   installation directory.  */
int
run_kbuildsycoca (void)
{
  const char *argv[1];
  int rc;

  if (! SetEnvironmentVariable ("XDG_DATA_DIRS", "share")
      || ! SetEnvironmentVariable ("XDG_CONFIG_DIRS", "etc\\xdg"))
    {
      fprintf (stderr, "Executing kbuildsycoca4.exe failed: "
	       "Could not set XDG environment variables\n");
      return -1;
    }

  argv[0] = NULL;
  rc = spawn_process_and_wait ("bin\\kbuildsycoca4.exe", argv);
  if (rc)
    fprintf (stderr, "Executing bin\\kbuildsycoca4.exe failed: %i\n", rc);

  return rc;
}


/* Return a copy of ARGV, but with proper quoting.  To release the
   copy, you have to free argv_quoted[0] and argv_quoted.  */
static char **
build_commandline (const char * const *argv)
{
  int i;
  int j;
  int n = 0;
  char *buf;
  char *p;
  char **argv_quoted;

  /* We have to quote some things because under Windows the program
     parses the commandline and does some unquoting.  We enclose the
     whole argument in double-quotes, and escape literal double-quotes
     as well as backslashes with a backslash.  We end up with a
     trailing space at the end of the line, but that is harmless.  */
  for (i = 0; argv[i]; i++)
    {
      p = (char *) argv[i];
      /* The leading double-quote.  */
      n++;
      while (*p)
	{
	  /* An extra one for each literal that must be escaped.  */
	  if (*p == '\\' || *p == '"')
	    n++;
	  n++;
	  p++;
	}
      /* The trailing double-quote and the delimiter.  */
      n += 2;
    }
  /* And a trailing zero.  */
  n++;

  /* Allocate a new vector.  */
  argv_quoted = malloc (sizeof (char *) * (i + 1));
  if (!argv_quoted)
    return NULL;

  buf = p = malloc (n);
  if (!buf)
    {
      free (argv_quoted);
      return NULL;
    }

  for (i = 0; argv[i]; i++)
    {
      const char *argvp = argv[i];

      argv_quoted[i] = p;

      *(p++) = '"';
      while (*argvp)
	{
	  if (*argvp == '\\' || *argvp == '"')
	    *(p++) = '\\';
	  *(p++) = *(argvp++);
	}
      *(p++) = '"';
      *(p++) = 0;
    }
  *(p++) = 0;
  argv_quoted[i] = NULL;

  return argv_quoted;
}

static void
kleowrap_set_dll_directory (const char *path)
{
  /* Set DLL directory is only necessary on Windows XP after SP2
     but it is also only available on those systems */
  typedef BOOL (CALLBACK* LPFNSETDLLDIRECTORY)(LPCTSTR);
  LPFNSETDLLDIRECTORY my_set_dll_directory;

  HMODULE hmod;

  if (!(hmod = GetModuleHandle ("kernel32.dll")))
    {
      fprintf (stderr, "kleowrap: failed to get kernel32.dll handle: rc=%d\n",
               GetLastError());
      return;
    }

  my_set_dll_directory =
    (LPFNSETDLLDIRECTORY) GetProcAddress (hmod, "SetDllDirectoryA");

  if (!my_set_dll_directory)
    {
      /* Not supported and so not necessary */
      return;
    }

  if (!my_set_dll_directory (path))
    {
      fprintf (stderr, "kleowrap: failed to set module handle",
               GetLastError());
      return;
    }
}

int
main (int argc, const char * const *argv)
{
  int rc;
  char pgm[MAX_PATH+100];
  char *p, *p0;
  char **argv_quoted;


  if (!GetModuleFileNameA (NULL, pgm, sizeof (pgm) - 1))
    {
      fprintf (stderr, "kleowrap: error getting my own name: rc=%d\n",
               GetLastError());
      return 2;
    }

  /* Switch directory and insert bin directory.  */
  p = strrchr (pgm, '\\');
  if (!p)
    goto leave;
  *p = '\0';
  chdir (pgm);
  kleowrap_set_dll_directory (pgm);
  *(p++) = '\\';
  memmove (p + 4, p, strlen (p) + 1);
  strncpy (p, "bin\\", 4);

  /* Hack to output our own version along with the real file name
     before the actual, we require that the --version option is given
     twice. */
  if (argc > 2
      && !strcmp(argv[1], "--version")
      && !strcmp(argv[2], "--version"))
    {
      fputs ("kleowrap (Gpg4win) " PACKAGE_VERSION " ;", stdout);
      fputs (pgm, stdout);
      fputc ('\n', stdout);
      fflush (stdout);
    }

  argv_quoted = build_commandline (argv);
  if (! argv_quoted)
    goto leave;

  /* Now that the current working is INSTDIR, try to run kbuildsycoca
     (create/update plugin cache).  We don't check the return value,
     as kbuildsycoca is allowed to fail (and will if kleopatra is
     already running).  */
  run_kbuildsycoca();

  /* Using execv does not replace the existing program image, but
     spawns a new one and daemonizes it, confusing the command line
     interpreter.  So we have to use spawnv.  */
  rc = _spawnv (_P_NOWAIT, pgm, (const char **) argv_quoted);
  if (rc < 0)
    {
      fprintf (stderr, "kleowrap: executing `%s' failed: %s\n",
	       pgm, strerror (errno));
      return 2;
    }

  return rc;

 leave:
  fprintf (stderr, "kleowrap: internal error parsing my own name `%s'\n",
           pgm);
  return 2;
}
