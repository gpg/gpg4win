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


int
main (int argc, const char * const *argv)
{
  int rc;
  char pgm[MAX_PATH+100];
  char *p, *p0;

  if ( !GetModuleFileNameA (NULL, pgm, sizeof pgm -1) )
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
      fputs ("gpgwrap (Gpg4win) " PACKAGE_VERSION " ", stdout);
      fputs (pgm, stdout);
      fputc ('\n', stdout);
      fflush (stdout);
    }

  execv (pgm, argv);
  fprintf (stderr, "gpgwrap: executing `%s' failed: %s\n",
           pgm, strerror (errno));
  return 2;
 leave:
  fprintf (stderr, "gpgwrap: internal error parsing my own name `%s'\n",
           pgm);
  return 2;
}


