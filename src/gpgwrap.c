/* gpgwrap.c - Wrapper to call gpg with windows subsystem.
 * Copyright (C) 2007 g10 Code GmbH
 * Copyright (C) 2020 g10 Code GmbH
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
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <process.h>
#include <windows.h>
#include <assert.h>

#define GPGWRAP_SUFFIX "-w32.exe"
#define PGM_SUFFIX ".exe"

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
  char *p;
  char **argv_quoted;

  /* Note: We decrement by one to allow inserting one character.  */
  if (!GetModuleFileNameA (NULL, pgm, sizeof (pgm) - 1 - 1))
    {
      fprintf (stderr, "gpgwrap: error getting my own name: rc=%d\n",
               GetLastError());
      return 2;
    }

  assert (strlen (GPGWRAP_SUFFIX) > strlen (PGM_SUFFIX));

  /* Remove our suffix from the filename.  */
  p = strstr (pgm, GPGWRAP_SUFFIX);
  if (!p)
    goto leave;
  *p = '\0';

  /* Add the PGM SUFFIX */
  strcat (pgm, PGM_SUFFIX);

  /* Hack to output our own version along with the real file name
     before the actual, we require that the --version option is given
     twice. */
  if (argc > 2
      && !strcmp(argv[1], "--version")
      && !strcmp(argv[2], "--version"))
    {
      fputs ("gpgwrap" PGM_SUFFIX " (Gpg4win) " PACKAGE_VERSION " ;", stdout);
      fputs (pgm, stdout);
      fputc ('\n', stdout);
      fflush (stdout);
    }

  argv_quoted = build_commandline (argv);
  if (!argv_quoted)
    goto leave;

  /* Using execv does not replace the existing program image, but
     spawns a new one and daemonizes it, confusing the command line
     interpreter.  So we have to use spawnv.  */
  rc = _spawnv (_P_WAIT, pgm, (const char **) argv_quoted);
  if (rc < 0)
    {
      fprintf (stderr, "gpgwrap: executing `%s' failed: %s\n",
               pgm, strerror (errno));
      return 2;
    }

  return rc;

 leave:
  fprintf (stderr, "gpgwrap: internal error parsing my own name `%s'\n",
           pgm);
  return 2;
}
