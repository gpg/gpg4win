/* kleopatrawrap.c - Wrapper to call gpg udner Windows.
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


/* Assumes that the current working directory is the Gpg4win INSTDIR
   installation directory.  */
int
run_kbuildsycoca (void)
{
  int rc;

  if (! SetEnvironmentVariable ("XDG_DATA_DIRS", "share")
      || ! SetEnvironmentVariable ("XDG_CONFIG_DIRS", "etc\\xdg"))
    {
      fprintf (stderr, "Executing kbuildsycoca4.exe failed: "
	       "Could not set XDG environment variables\n");
      return -1;
    }
  errno = 0;
  rc = _spawnl (_P_WAIT, "kbuildsycoca4", "kbuildsycoca4", NULL);
  if (rc)
    fprintf (stderr, "Executing kbuildsycoca4.exe failed: %s\n",
	     strerror (errno));

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


int
main (int argc, const char * const *argv)
{
  int rc;
  char pgm[MAX_PATH+100];
  char *p, *p0;
  char **argv_quoted;

  if (!GetModuleFileNameA (NULL, pgm, sizeof (pgm) - 1))
    {
      fprintf (stderr, "kleopatrawrap: error getting my own name: rc=%d\n",
               GetLastError());
      return 2;
    }

  /* Switch directory and insert bin directory.  */
  p = strrchr (pgm, '\\');
  if (!p)
    goto leave;
  *p = '\0';
  chdir (pgm);
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
      fputs ("kleopatrawrap (Gpg4win) " PACKAGE_VERSION " ;", stdout);
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
  rc = _spawnv (_P_WAIT, pgm, (const char **) argv_quoted);
  if (rc < 0)
    {
      fprintf (stderr, "kleopatrawrap: executing `%s' failed: %s\n",
	       pgm, strerror (errno));
      return 2;
    }

  return rc;

 leave:
  fprintf (stderr, "kleopatrawrap: internal error parsing my own name `%s'\n",
           pgm);
  return 2;
}
