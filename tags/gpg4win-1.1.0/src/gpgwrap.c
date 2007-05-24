/* gpgwrap.c - Wrapper to call gpg udner Windows.
 * Copyright (C) 2007 g10 Code GmbH
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
      *(p++) = ' ';
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
      fprintf (stderr, "gpgwrap: error getting my own name: rc=%d\n",
               GetLastError());
      return 2;
    }

  /* Remove one directory part of the file name.  */
  p = strrchr (pgm, '\\');
  if (!p)
    goto leave;
  *p = 0;
  p0 = strrchr (pgm, '\\');
  *p = '\\';
  if (!p0)
    goto leave;
  while (*p)
    *p0++ = *p++;
  *p0 = 0;

  /* Hack to output our own version along with the real file name
     before the actual, we require that the --version option is given
     twice. */
  if (argc > 2
      && !strcmp(argv[1], "--version")
      && !strcmp(argv[2], "--version"))
    {
      fputs ("gpgwrap (Gpg4win) " PACKAGE_VERSION " ;", stdout);
      fputs (pgm, stdout);
      fputc ('\n', stdout);
      fflush (stdout);
    }

  argv_quoted = build_commandline (argv);
  if (!argv_quoted)
    goto leave;

  execv (pgm, (const char **) argv_quoted);
  fprintf (stderr, "gpgwrap: executing `%s' failed: %s\n",
           pgm, strerror (errno));
  return 2;
 leave:
  fprintf (stderr, "gpgwrap: internal error parsing my own name `%s'\n",
           pgm);
  return 2;
}
