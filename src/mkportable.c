/* mkportable.c - Tool to create portable version of Gpg4win
 * Copyright (C) 2013 g10 Code GmbH
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3, or (at your option) any
 * later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

/* History:
   2013-08-07 wk  Written.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>
#include <errno.h>
#include <dirent.h>
#include <unistd.h>
#if _WIN32
# include <windows.h>
# define MKDIR_MODE_PRIVATE
# define MKDIR_MODE_PERMISSIVE
#else
# include <sys/stat.h>
# include <sys/types.h>
# define MKDIR_MODE_PRIVATE     , 0700
# define MKDIR_MODE_PERMISSIVE  , 0755
#endif


#define VERSION "1.0"
#define PGM "mkportable"

/* We use 3 complete lists for the 3 installation types.  Given that
   gcc only writes one copy of a constant string, this doesn't
   require too much extra space.

   The lists have initially been created by running

     find . -type f | sed 's,^./,  ",' | awk '{print $0 "\","}'

   in a Unix mounted Windows installation directory.  Non-required
   files have then been removed and some common pattern replaced by
   wildcards.  Note that using a wildcard makes the presence of a
   source file optional.  */
#include "mkportable-vanilla.h"
#include "mkportable-light.h"
#include "mkportable-full.h"

static int verbose;
static enum { iVANILLA = 0, iLIGHT, iFULL } install_type;
static const char *install_name;
static const char *target_dir;
static const char * const *filelist;

static void
die (const char *format, ...)
{
  va_list arg_ptr;

  fflush (stdout);
  fprintf (stderr, "%s: ", PGM);

  va_start (arg_ptr, format);
  vfprintf (stderr, format, arg_ptr);
  va_end (arg_ptr);
  putc ('\n', stderr);

  exit (1);
}


static void
err (const char *format, ...)
{
  va_list arg_ptr;

  fflush (stdout);
  fprintf (stderr, "%s: ", PGM);

  va_start (arg_ptr, format);
  vfprintf (stderr, format, arg_ptr);
  va_end (arg_ptr);
  putc ('\n', stderr);
}


static void
inf (const char *format, ...)
{
  va_list arg_ptr;

  if (!verbose)
    return;

  fflush (stdout);
  fprintf (stdout, "%s: ", PGM);

  va_start (arg_ptr, format);
  vfprintf (stdout, format, arg_ptr);
  va_end (arg_ptr);
  putc ('\n', stdout);
}

#if _WIN32
static const char *
w32_strerror (int ec)
{
  static char strerr[256];

  if (ec == -1)
    ec = (int)GetLastError ();
  FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM, NULL, ec,
                 MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
                 strerr, sizeof (strerr)-1, NULL);
  return strerr;
}
#endif /*_WIN32*/

static void *
xmalloc (size_t n)
{
  void *p = malloc (n);
  if (!p)
    die ("out of core");
  return p;
}


static char *
fix_backslashes (char *buffer)
{
#if _WIN32
  char *p;

  for (p=buffer; *p; p++)
    if (*p == '\\')
      *p = '/';
#endif
  return buffer;
}


#if _WIN32
static char *
unfix_backslashes (char *buffer)
{
  char *p;

  for (p=buffer; *p; p++)
    if (*p == '/')
      *p = '\\';
  return buffer;
}
#endif


/* Determine the root directory of the gnupg installation on Windows.  */
static const char *
get_sourcedir (void)
{
#if _WIN32
  static int got_dir;
  static char dir[MAX_PATH+5];

  if (!got_dir)
    {
      char *p;
      int rc;

      rc = GetModuleFileName (NULL, dir, MAX_PATH);
      if (!rc)
        die ("GetModuleFileName failed: %s\n", w32_strerror (-1));
      got_dir = 1;
      p = strrchr (dir, '\\');
      if (p)
        {
          *p = 0;

          /* If we are installed below "bin" we strip that and use
             the top directory instead.  */
          p = strrchr (dir, '\\');
          if (p && !strcmp (p+1, "bin"))
            *p = 0;
        }
      if (!p)
        die ("bad filename '%s' returned for this process\n", dir);
      fix_backslashes (dir);
    }

  if (*dir)
    return dir;
#endif /*_WIN32*/
  /* Fallback to the current directory. */
  return ".";
}


/* Return 0 if the target directory is suitable.  */
static int
check_target_dir (int force)
{
  int count = 0;

#if _WIN32
  {
    char *fname;
    HANDLE hd = INVALID_HANDLE_VALUE;
    WIN32_FIND_DATAA fi;

    fname = xmalloc (strlen (target_dir) + 2 + 2 + 1);
    if (!strcmp (target_dir, "/"))
      strcpy (fname, "/*"); /* Trailing slash is not allowed.  */
    else if (!strcmp (target_dir, "."))
      strcpy (fname, "*");
    else if (*target_dir && target_dir[strlen (target_dir)-1] == '/')
      {
        strcpy (fname, target_dir);
        strcat (fname, "*");
      }
    else if (*target_dir && target_dir[strlen (target_dir)-1] != '*')
      {
        strcpy (fname, target_dir);
        strcat (fname, "/*");
      }
    else
      strcpy (fname, target_dir);

    inf ("finding files in '%s'", fname);

    unfix_backslashes (fname);
    hd = FindFirstFileA (fname, &fi);
    if (hd == INVALID_HANDLE_VALUE)
      {
        err ("error reading target directory '%s': %s",
             target_dir, w32_strerror (-1));
        free (fname);
        return 1;
      }
    do
      {
        if (!strcmp (fi.cFileName, "." ) || !strcmp (fi.cFileName, ".."))
          ;
        else
          count++;
      }
    while (FindNextFileA (hd, &fi));
    FindClose (hd);
    free (fname);
  }
#else /*!_WIN32*/
  {
    DIR *dir;
    struct dirent *de;

    dir = opendir (target_dir);
    if (!dir)
      {
        err ("error reading read target directory '%s': %s",
             target_dir, strerror (errno));
        return 1;
      }
    while ((de = readdir (dir)))
      {
        if (!strcmp (de->d_name, "." ) || !strcmp (de->d_name, ".."))
          continue; /* Skip self and parent dir entry.  */
        count++;
      }
    closedir (dir);
  }
#endif /*!_WIN32*/

  if (count)
    inf ("number of files in target directory: %d", count);
  if (count)
    {
      err ("target directory '%s' is not empty%s",
           target_dir, force? " - continuing anyway":"");
      if (!force)
        return 1;
    }

  return 0;
}


static char *
make_sourcename (const char *name)
{
  const char *sdir = get_sourcedir ();
  char *fname;

  fname = xmalloc (strlen (sdir) + 1 + strlen (name) + 1);
  strcpy (fname, sdir);
  if (*fname && fname[strlen (fname)-1] != '/')
    strcat (fname, "/");
  strcat (fname, name);
  return fname;
}

static char *
make_targetname (const char *name)
{
  const char *tdir = target_dir;
  char *fname;

  fname = xmalloc (strlen (tdir) + 1 + strlen (name) + 1);
  strcpy (fname, tdir);
  if (*fname && fname[strlen (fname)-1] != '/')
    strcat (fname, "/");
  strcat (fname, name);
  return fname;
}


/* Call access for a file NAME in the installation directory.  */
static int
access_sourcename (const char *name)
{
  char *fname = make_sourcename (name);
  int rc = access (fname, F_OK);
  free (fname);
  return rc;
}


/* Check that all source files are available.  Return 0 on success.
   We do this so that we don't start to copy files and only later
   realize that some files are missing.  This is in particular useful
   because we require an empty target directory.  */
static int
check_all_files (void)
{
  const char *name;
  int bad = 0;
  int i;

  /* First a quick check for gpgconf.  */
  name = "gpgconf.exe";
  if (access_sourcename (name))
    {
      err ("file '%s' not found in the source directory", name);
      return 1;
    }

  for (i=0; (name = filelist[i]); i++)
    {
      if (strchr (filelist[i], '*'))
        continue;
      if (access_sourcename (name))
        {
          err ("file '%s' not found in the source directory", name);
          bad++;
        }
    }

  if (bad)
    inf ("number of missing files: %d", bad);

  return !!bad;
}

/* Try to make intermediate directories.  */
static void
make_dirs (const char *name)
{
  char *fname, *p;

  fname = make_targetname (name);
  p = fname + strlen (fname) - strlen (name);
  while ((p = strchr (p, '/')))
    {
      *p = 0;
      mkdir (fname MKDIR_MODE_PERMISSIVE);
      *p++ = '/';
    }
  free (fname);
}


/****************
 * Copy the option file skeleton to the given directory.
 */
static int
copy_file (const char *name)
{
  char *srcname, *dstname;
  FILE *srcfp, *dstfp;
  int tried_mkdir = 0;
  char buffer[4096];

  if (verbose > 1)
    inf ("copying '%s'", name);

  srcname = make_sourcename (name);
  dstname = make_targetname (name);

  srcfp = fopen (srcname, "rb");
  if (!srcfp)
    {
      err ("failed to open '%s': %s\n", srcname, strerror (errno));
      free (srcname);
      free (dstname);
      return 1;
    }

 again:
  dstfp = fopen (dstname, "wb");
  if (!dstfp)
    {
      if (!tried_mkdir && errno == ENOENT && strchr (name, '/'))
        {
          tried_mkdir = 1;
          make_dirs (name);
          goto again;
        }

      err ("failed to create '%s': %s\n", dstname, strerror (errno));
      fclose (srcfp);
      free (srcname);
      free (dstname);
      return 1;
    }

  while (!feof (srcfp))
    {
      size_t n;

      n = fread (buffer, 1, sizeof buffer, srcfp);
      if (n < sizeof buffer && ferror (srcfp))
        {
          err ("error reading '%s'\n", srcname);
          fclose (srcfp);
          fclose (dstfp);
          free (srcname);
          free (dstname);
          return 1;
        }

      errno = 0;
      if (fwrite (buffer, 1, n, dstfp) != n)
        {
          err ("error writing to '%s': %s\n", dstname, strerror (errno));
          fclose (srcfp);
          fclose (dstfp);
          free (srcname);
          free (dstname);
          return 1;
        }
    }

  if (fflush (dstfp) == EOF)
    {
      err ("error writing to '%s': %s\n", dstname, strerror (errno));
      fclose (srcfp);
      fclose (dstfp);
      free (srcname);
      free (dstname);
      return 1;
    }
  if (fclose (dstfp) == EOF)
    {
      err ("error closing '%s': %s\n", dstname, strerror (errno));
      fclose (srcfp);
      fclose (dstfp);
      free (srcname);
      free (dstname);
      return 1;
    }

  fclose  (srcfp);

  free (srcname);
  free (dstname);
  return 0;
}


/* Copy files which contain one '*' wildcard. */
static int
wildcard_copy_file (const char *name)
{
  int res = 0;
  char *fname;
  size_t srcpos;

  if (verbose > 1)
    inf ("globing '%s'", name);

  fname = make_sourcename (name);
  srcpos = strlen (fname) - strlen (name);

#if _WIN32
  {
    HANDLE hd = INVALID_HANDLE_VALUE;
    WIN32_FIND_DATAA fi;
    char *p, *tail;
    char *buffer = NULL;

    p = strchr (fname, '*');
    assert (p);
    tail = strchr (p, '/');
    if (tail)
      *tail++ = 0;

    unfix_backslashes (fname);
    hd = FindFirstFileA (fname, &fi);
    fix_backslashes (fname);

    p = strrchr (fname, '/');
    if (p)
      *p = 0;

    if (hd != INVALID_HANDLE_VALUE)
      {
        do
          {
            if (!strcmp (fi.cFileName, "." ) || !strcmp (fi.cFileName, ".."))
              ;
            else
              {
                free (buffer);
                buffer = xmalloc (strlen (fname) + 1
                                  + strlen (fi.cFileName) + 1
                                  + (tail? strlen (tail):0) + 1);
                strcpy (buffer, fname);
                strcat (buffer, "/");
                strcat (buffer, fi.cFileName);
                if (tail)
                  {
                    strcat (buffer, "/");
                    strcat (buffer, tail);
                  }
                if (!access (buffer, F_OK))
                  if (copy_file (buffer + srcpos))
                    {
                      res = 1;
                      goto leave;
                    }

              }
        }
        while (FindNextFileA (hd, &fi));
      leave:
        free (buffer);
        FindClose (hd);
      }
  }
#endif /*_WIN32*/

  free (fname);
  return res;
}


/* Copy all files to the target directory.  */
static int
copy_all_files (void)
{
  int idx;
  const char *name;

  inf ("copying files to '%s'", target_dir);

  for (idx=0; (name = filelist[idx]); idx++)
    {
      if (strchr (name, '*'))
        {
          if (wildcard_copy_file (name))
            return 1;
        }
      else if (copy_file (name))
        return 1;
    }
  return 0;
}


/* Create the new home directory.  */
static int
make_home_dir (void)
{
  char *name;

  name = make_targetname ("home");
  if (mkdir (name MKDIR_MODE_PRIVATE))
    {
      if (errno == EEXIST)
        inf ("portable home directory '%s' already exists - fine", name);
      else
        {
          err ("error creating portable home directory '%s': %s",
               name, strerror (errno));
          free (name);
          return 1;
        }
    }
  else
    inf ("portable home directory '%s' created", name);
  free (name);
  return 0;
}



/* Write the gpgconf.ctl file which is used by GnuPG to put itself
   into portable mode.  */
static int
write_ctl_file (void)
{
  char *name;
  FILE *fp;

  name = make_targetname ("gpgconf.ctl");
  fp = fopen (name, "wb");
  if (!fp)
    {
      err ("failed to create '%s': %s\n", name, strerror (errno));
      free (name);
      return 1;
    }

  fprintf (fp,
           "# The presence of this file switches GnuPG into portable mode.\n"
           "#\n"
           "# Install type is: %s\n"
           "# (created by %s version %s)\n",
           install_name, PGM, VERSION);

   if (fflush (fp) == EOF)
    {
      err ("error writing to '%s': %s\n", name, strerror (errno));
      fclose (fp);
      free (name);
      return 1;
    }
  if (fclose (fp) == EOF)
    {
      err ("error closing '%s': %s\n", name, strerror (errno));
      free (name);
      return 1;
    }

  free (name);
  return 0;
}


static void
usage (int mode)
{
  FILE *fp = mode > 0? stderr : stdout;

  if (mode <= 0)
    fputs (PGM " "VERSION"\n"
           "Copyright (C) 2013 g10 Code GmbH\n"
           "License GPLv3+: GNU GPL version 3 or later "
           "<http://gnu.org/licenses/gpl.html>.\n"
           "This is free software: you are free to change "
           "and redistribute it.\n"
           "There is NO WARRANTY, to the extent permitted by law.\n\n",
           fp);

  if (mode < 0)
    exit (0);

  fputs ("Usage: mkportable [OPTIONS] TARGETDIR\n", fp);
  if (mode > 0)
    exit (1);

  fputs ("Create a portable version of Gpg4win by copying the required\n"
         "files to TARGETDIR\n"
         "\n"
         "Options:\n"
         "  --vanilla   create a bare GnuPG version [default]\n"
         "  --light     create a light version\n"
         "  --full      create a full version\n"
         "  --verbose   enable extra informational output\n"
         "  --force     force installation to a non-empty directory\n"
         "  --version   print version of this program and exit\n"
         "  --help      print this help and exit\n",
         fp);

  exit (0);
}

int
main (int argc, char **argv)
{
  int last_argc = -1;
  int force = 0;

  if (argc)
    {
      argc--; argv++;
    }

  while (argc && last_argc != argc )
    {
      last_argc = argc;
      if (!strcmp (*argv, "--"))
        {
          argc--; argv++;
          break;
        }
      else if (!strcmp (*argv, "--version"))
        usage (-1);
      else if (!strcmp (*argv, "--help"))
        usage (0);
      else if (!strcmp (*argv, "--verbose"))
        {
          verbose++;
          argc--; argv++;
        }
      else if (!strcmp (*argv, "--force"))
        {
          force = 1;
          argc--; argv++;
        }
      else if (!strcmp (*argv, "--vanilla"))
        {
          install_type = iVANILLA;
          argc--; argv++;
        }
      else if (!strcmp (*argv, "--light"))
        {
          install_type = iLIGHT;
          argc--; argv++;
        }
      else if (!strcmp (*argv, "--full"))
        {
          install_type = iFULL;
          argc--; argv++;
        }
      else if (!strncmp (*argv, "--", 2))
        die ("unknown option '%s'", *argv);
    }

  if (argc != 1 || !*argv[0])
    usage (1);
  target_dir = fix_backslashes (argv[0]);

  inf ("source directory is '%s'", get_sourcedir ());
  inf ("target directory is '%s'", target_dir);

  switch (install_type)
    {
    case iVANILLA: filelist = vanilla_files; install_name = "vanilla"; break;
    case iLIGHT:   filelist = light_files;   install_name = "light"; break;
    case iFULL:    filelist = full_files;    install_name = "full"; break;
    default:  assert (!"bug");
    }

  if (check_target_dir (force))
    return 1;

  if (check_all_files ())
    return 1;

  if (copy_all_files ())
    return 1;

  if (make_home_dir ())
    return 1;

  if (write_ctl_file ())
    return 1;

  inf ("ready");

  return 0;
}
