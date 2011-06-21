/* nsis-msgfmt.c - Replacement for msgfmt for NSIS projects.
   Copyright (C) 2007 g10 Code GmbH
  
   This file is part of Gpg4win.
  
   Gpg4win is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
  
   Gpg4win is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
  
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.  */

#include <stdio.h>
#include <string.h>
#include <error.h>
#include <errno.h>

/* This file does NOT include config.h, as that one is for the host
   target and not the build target.  But this file is run on the build
   architecture at (cross-) compile time.  */
#include <gettext-po.h>

char *program_name;

/* Set to TRUE if Modern UI is used.  */
int modern_ui = 1;


/* Map an ISO 639 two letter language code to an NSIS language
   name.  */
void
iso639_to_nsis (const char *ll, char **lang, char **nlf)
{
  static struct
  {
    /* The ISO639 extended language code.  */
    char *ll;
    /* The LANG_* NSIS identifier.  */
    char *lang;
    /* The NSIS language file, if exists.  */
    char *nlf;
  } codes[] =
    { { "af", "LANG_AFRIKAANS", NULL },
      { "sq", "LANG_ALBANIAN", "Albanian" },
      { "ar", "LANG_ARABIC", "Arabic" },
      { "ar_SA", "SUBLANG_ARABIC_SAUDI_ARABIA", NULL },
      { "ar_IQ", "SUBLANG_ARABIC_IRAQ", NULL },
      { "ar_EG", "SUBLANG_ARABIC_EGYPT", NULL },
      { "ar_LY", "SUBLANG_ARABIC_LIBYA", NULL },
      { "ar_DZ", "SUBLANG_ARABIC_ALGERIA", NULL },
      { "ar_MA", "SUBLANG_ARABIC_MOROCCO", NULL },
      { "ar_TN", "SUBLANG_ARABIC_TUNISIA", NULL },
      { "ar_OM", "SUBLANG_ARABIC_OMAN", NULL },
      { "ar_YE", "SUBLANG_ARABIC_YEMEN", NULL },
      { "ar_SY", "SUBLANG_ARABIC_SYRIA", NULL },
      { "ar_JO", "SUBLANG_ARABIC_JORDAN", NULL },
      { "ar_LB", "SUBLANG_ARABIC_LEBANON", NULL },
      { "ar_KW", "SUBLANG_ARABIC_KUWAIT", NULL },
      { "ar_AE", "SUBLANG_ARABIC_UAE", NULL },
      { "ar_BH", "SUBLANG_ARABIC_BAHRAIN", NULL },
      { "ar_QA", "SUBLANG_ARABIC_QATAR", NULL },
      { "hy", "LANG_ARMENIAN", NULL },
      { "as", "LANG_ASSAMESE", NULL },
      { "az", "LANG_AZERI", NULL },
      { "az_AZ", "SUBLANG_AZERI_LATIN", NULL },
      { "az_??", "SUBLANG_AZERI_CYRILLIC", NULL },
      { "eu", "LANG_BASQUE", "Basque" },
      { "be", "LANG_BELARUSIEN", "Belarusian" },
      { "bn", "LANG_BENGALI", NULL },
      { "bs", "LANG_BOSNIAN", "Bosnian" },
      { "br", "LANG_BRETON", "Breton" },
      { "bg", "LANG_BULGARIAN", "Bulgarian" },
      { "ca", "LANG_CATALAN", "Catalan" },
      { "zh", "LANG_CHINESE", NULL },
      { "zh_??", "SUBLANG_CHINESE_SIMPLIFIED", "SimpChinese" },
      { "zh_??", "SUBLANG_CHINESE_TRADITIONAL", "TradChinese" },
      { "zh_HK", "SUBLANG_CHINESE_HONGKONG", NULL },
      { "zh_SG", "SUBLANG_CHINESE_SINGAPORE", NULL },
      { "zh_MO", "SUBLANG_CHINESE_MACAU", NULL },
      { "hr", "LANG_CROATIAN", "Croatian" },
      { "cz", "LANG_CZECH", "Czech" },
      { "da", "LANG_DANISH", "Danish" },
      { "dv", "LANG_DIVEHI", NULL },
      { "nl", "LANG_DUTCH", "Dutch" },
      { "nl_NL", "SUBLANG_DUTCH", NULL },
      { "nl_BE", "SUBLANG_DUTCH_BELGIAN", NULL },
      { "en", "LANG_ENGLISH", "English" },
      { "en_US", "SUBLANG_ENGLISH_US", NULL },
      { "en_UK", "SUBLANG_ENGLISH_UK", NULL },
      { "en_AU", "SUBLANG_ENGLISH_AUS", NULL },
      { "en_CA", "SUBLANG_ENGLISH_CAN", NULL },
      { "en_NZ", "SUBLANG_ENGLISH_NZ", NULL },
      { "en_IE", "SUBLANG_ENGLISH_EIRE", NULL },
      { "en_ZA", "SUBLANG_ENGLISH_SOUTH_AFRICA", NULL },
      { "en_JM", "SUBLANG_ENGLISH_JAMAICA", NULL },
      { "en_??", "SUBLANG_ENGLISH_CARIBBEAN", NULL },
      { "en_BZ", "SUBLANG_ENGLISH_BELIZE", NULL },
      { "en_TT", "SUBLANG_ENGLISH_TRINIDAD", NULL },
      { "en_ZW", "SUBLANG_ENGLISH_ZIMBABWE", NULL },
      { "en_PH", "SUBLANG_ENGLISH_PHILIPPINES", NULL },
      { "et", "LANG_ESTONIAN", "Estonian" },
      { NULL, "LANG_FARSI", "Farsi" },
      { "fi", "LANG_FINNISH", "Finnisch" },
      { "fr", "LANG_FRENCH", "French" },
      { "fr_FR", "SUBLANG_FRENCH", "French" },
      { "fr_BE", "SUBLANG_FRENCH_BELGIAN", NULL },
      { "fr_CA", "SUBLANG_FRENCH_CANADAN", NULL },
      { "fr_CH", "SUBLANG_FRENCH_SWISS", NULL },
      { "fr_LU", "SUBLANG_FRENCH_LUXEMBOURG", NULL },
      { "fr_MC", "SUBLANG_FRENCH_MONACO", NULL },
      { "gl", "LANG_GALICIAN", NULL },
      { "ka", "LANG_GEORGIAN", NULL },
      { "de", "LANG_GERMAN", "German" },
      { "de_DE", "SUBLANG_GERMAN", NULL },
      { "de_CH", "SUBLANG_GERMAN_SWISS", NULL },
      { "de_AT", "SUBLANG_GERMAN_AUSTRIAN", NULL },
      { "de_LU", "SUBLANG_GERMAN_LUXEMBOURG", NULL },
      { "de_LI", "SUBLANG_GERMAN_LIECHTENSTEIN", NULL },
      { "el", "LANG_GREEK", "Greek" },
      { "gu", "LANG_GUJARATI", NULL },
      { "he", "LANG_HEBREW", "Hebrew" },
      { "hi", "LANG_HINDI", NULL },
      { "hu", "LANG_HUNGARIAN", "Hungarian" },
      { "is", "LANG_ICELANDIC", "Icelandic" },
      { "id", "LANG_INDONESIAN", "Indonesian" },
      { "ga", NULL, "Irish" },
      { "it", "LANG_ITALIAN", "Italian" },
      { "it_IT", "SUBLANG_ITALIAN", NULL },
      { "it_CH", "SUBLANG_ITALIAN_SWISS", NULL },
      { "ja", "LANG_JAPANESE", "Japanese" },
      { "kn", "LANG_KANNADA", NULL },
      { "ks", "LANG_KASHMIRI", NULL },
      { "ks_IN", "SUBLANG_KASHMIRI_INDIA", NULL },
      { "kk", "LANG_KAZAK", NULL },
      { "ko", "LANG_KOREAN", "Korean" },
      { NULL, "SUBLANG_KOREAN", NULL },
      { "kok", "LANG_KONKANI", NULL },
      { "ku", NULL, "Kurdish" },
      { NULL, "LANG_KYRGYZ", NULL },
      { "lv", "LANG_LATVIAN", "Latvian" },
      { "lt", "LANG_LITHUANIAN", "Lithuanian" },
      { "lt_LT", "SUBLANG_LITHUANIAN", NULL },
      { "lb", NULL, "Luxembourgish" },
      { "mk", "LANG_MACEDONIAN", "Macedonian" },
      { "ms", "LANG_MALAY", "Malay" },
      { "ms_MY", "SUBLANG_MALAY_MALAYSIA", NULL },
      { "ms_??", "SUBLANG_MALAY_BRUNEI_DARUSSALAM", NULL },
      { "ml", "LANG_MALAYALAM", NULL },
      { "mni", "LANG_MANIPURI", NULL },
      { "mr", "LANG_MARATHI", NULL },
      { "mn", "LANG_MONGOLIAN", "Mongolian" },
      { "ne", "LANG_NEPALI", NULL },
      { "ne_IN", "SUBLANG_NEPALI_INDIA", NULL },
      { "no", "LANG_NORWEGIAN", "Norwegian" },
      { "nb", "SUBLANG_NORWEGIAN_BOKMAL", NULL },
      { "nn", "SUBLANG_NORWEGIAN_NYNORSK", "NorwegianNynorsk" },
      { "or", "LANG_ORIYA", NULL },
      { "pa", "LANG_PUNJABI", NULL },
      { "pl", "LANG_POLISH", "Polish" },
      { "pt", "LANG_PORTUGUESE", "Portuguese" },
      { "pt_PT", "SUBLANG_PORTUGUESE", NULL },
      { "pt_BR", "SUBLANG_PORTUGUESE_BRAZILIAN", "PortugueseBR" },
      { "ro", "LANG_ROMANIAN", "Romanian" },
      { "ru", "LANG_RUSSIAN", "Russian" },
      { "sa", "LANG_SANSKRIT", NULL },
      { "sr_??", "SUBLANG_SERBIAN_LATIN", "SerbianLatin" },
      { "sr", "LANG_SERBIAN", "Serbian" },
      { "sr_??", "SUBLANG_SERBIAN_LATIN", NULL },
      { "sr_??", "SUBLANG_SERBIAN_CYRILLIC", NULL },
      { "sd", "LANG_SINDHI", NULL },
      { "sk", "LANG_SLOVAK", "Slovak" },
      { "sl", "LANG_SLOVENIAN", "Slovenian" },
      { "es", "LANG_SPANISH", "Spanish" },
      { "es_??", "SUBLANG_SPANISH", NULL },
      { "es_MX", "SUBLANG_SPANISH_MEXICAN", NULL },
      { "es_??", "SUBLANG_SPANISH_MODERN", NULL },
      { "es_GT", "SUBLANG_SPANISH_GUATEMALA", NULL },
      { "es_??", "SUBLANG_SPANISH_COSTA_RICA", NULL },
      { "es_PA", "SUBLANG_SPANISH_PANAMA", NULL },
      { "es_DO", "SUBLANG_SPANISH_DOMINICAN_REPUBLIC", NULL },
      { "es_VE", "SUBLANG_SPANISH_VENEZUELA", NULL },
      { "es_CO", "SUBLANG_SPANISH_COLOMBIA", NULL },
      { "es_PE", "SUBLANG_SPANISH_PERU", NULL },
      { "es_AR", "SUBLANG_SPANISH_ARGENTINA", NULL },
      { "es_EC", "SUBLANG_SPANISH_ECUADOR", NULL },
      { "es_CL", "SUBLANG_SPANISH_CHILE", NULL },
      { "es_UY", "SUBLANG_SPANISH_URUGAY", NULL },
      { "es_PY", "SUBLANG_SPANISH_PARAGUAY", NULL },
      { "es_BO", "SUBLANG_SPANISH_BOLIVIA", NULL },
      { "es_SV", "SUBLANG_SPANISH_EL_SALVADOR", NULL },
      { "es_HN", "SUBLANG_SPANISH_HONDURAS", NULL },
      { "es_NI", "SUBLANG_SPANISH_NICARAGUA", NULL },
      { "es_PR", "SUBLANG_SPANISH_PUERTO_RICO", NULL },
      { "sw", "LANG_SWAHILI", NULL },
      { NULL, "LANG_SYRIAC", NULL },
      { "sv", "LANG_SWEDISH", "Swedish" },
      { "sv_SE", "SUBLANG_SWEDISH", NULL },
      { "sv_FI", "SUBLANG_SWEDISH_FINLAND", NULL },
      { "ta", "LANG_TAMIL", NULL },
      { "tt", "LANG_TATAR", NULL },
      { "te", "LANG_TELUGU", NULL },
      { "th", "LANG_THAI", "Thai" },
      { "tr", "LANG_TURKISH", "Turkish" },
      { "uk", "LANG_UKRAINIAN", "Ukrainian" },
      { "ur", "LANG_URDU", NULL },
      { "ur_PK", "SUBLANG_URDU_PAKISTAN", NULL },
      { "ur_IN", "SUBLANG_URDU_INDIA", NULL },
      { "uz", "LANG_UZBEK", NULL },
      { "uz_UZ", "LANG_UZBEK_LATIN", NULL },
      { "uz_??", "LANG_UZBEK_CYRILLIC", NULL },
      { "vi", "LANG_VIETNAMESE", NULL },
      { NULL, NULL, "Welsh" },
      { NULL, NULL, NULL } };

  int i = 0;
  *lang = NULL;
  *nlf = NULL;
  while (codes[i].ll || codes[i].lang || codes[i].nlf)
    {
      if (codes[i].ll && codes[i].lang
	  && !strcmp (ll, codes[i].ll))
	{
	  *lang = codes[i].lang;
	  *nlf = codes[i].nlf;
	  return;
	}
      i++;
    }
}


void
xerror (int severity, po_message_t message,
	const char *filename, size_t lineno, size_t column,
	int multiline_p, const char *message_text)
{
  fflush (stdout);
  if (filename != NULL)
    {
      if (lineno != (size_t)(-1))
	{
	  if (column != (size_t)(-1))
	    fprintf (stderr, "%s:%ld:%ld: %s\n", filename,
		     (long) lineno, (long) column, message_text);
	  else
	    fprintf (stderr, "%s:%ld: %s\n", filename, (long) lineno,
		     message_text);
	}
      else
	fprintf (stderr, "%s: %s\n", filename, message_text);
    }
  else
    fprintf (stderr, "%s: %s\n", program_name, message_text);

  if (severity >= PO_SEVERITY_ERROR)
    exit (EXIT_FAILURE);
}


void
xerror2 (int severity, po_message_t message1,
	 const char *filename1, size_t lineno1, size_t column1,
	 int multiline_p1, const char *message_text1,
	 po_message_t message2,
	 const char *filename2, size_t lineno2, size_t column2,
	 int multiline_p2, const char *message_text2)
{
  fflush (stdout);
  if (filename1 != NULL)
    {
      if (lineno1 != (size_t)(-1))
	{
	  if (column1 != (size_t)(-1))
	    fprintf (stderr, "%s:%ld:%ld: %s...\n", filename1,
		     (long) lineno1, (long) column1, message_text1);
	  else
	    fprintf (stderr, "%s:%ld: %s...", filename1, (long) lineno1,
		     message_text1);
	}
      else
	fprintf (stderr, "%s: %s...", filename1, message_text1);
    }
  else
    fprintf (stderr, "%s: %s...", program_name, message_text1);
  
  if (filename2 != NULL)
    {
      if (lineno2 != (size_t)(-1))
	{
	  if (column2 != (size_t)(-1))
	    fprintf (stderr, "%s:%ld:%ld: ...%s\n", filename2,
		     (long) lineno2, (long) column2, message_text2);
	  else
	    fprintf (stderr, "%s:%ld: ...%s", filename2, (long) lineno2,
		     message_text2);
	}
      else
	fprintf (stderr, "%s: ...%s", filename2, message_text2);
    }
  else
    fprintf (stderr, "%s: ...%s", program_name, message_text2);

  if (severity >= PO_SEVERITY_ERROR)
    exit (EXIT_FAILURE);
}

struct po_xerror_handler err_handler = { xerror, xerror2 };


char *
convert_newline (const char *msg)
{
  int i;
  int j = 0;
  char *new_msg;

  for (i = 0; msg[i]; i++)
    if (msg[i] == '\n')
      j++;

  new_msg = malloc (i + 5 * j + 1);
  if (!new_msg)
    error (EXIT_FAILURE, errno, "couldn't allocate memory");

  i = 0;
  while (*msg)
    {
      if (*msg == '\n')
	{
	  new_msg[i++] = '$';
	  new_msg[i++] = '\\';
	  new_msg[i++] = 'r';
	  new_msg[i++] = '$';
	  new_msg[i++] = '\\';
	  new_msg[i++] = 'n';
	}
      else
	new_msg[i++] = *msg;
      msg++;
    }
  new_msg[i] = '\0';
  return new_msg;
}


void
fmt_one (char *filename)
{
  po_file_t file;
  const char * const *domains;
  const char * const *domainp;
  char *ll;
  char *llp;
  char *lang;
  char *nlf;

  /* Grok the language code from the filename.  */
  ll = strrchr (filename, '/');
  if (ll)
    ll++;
  else
    ll = filename;
  ll = strdup (ll);
  if (!ll)
    error (EXIT_FAILURE, errno, "could not allocate memory");
  llp = strchr (ll, '.');
  if (llp)
    *llp = '\0';
  iso639_to_nsis (ll, &lang, &nlf);
  if (!lang)
    error (EXIT_FAILURE, errno, "%s: could not determine language %s of %s\n",
	   program_name, ll, filename);
  printf ("!ifdef PO_HEADER\n");
  if (!nlf)
    {
      fflush (stdout);
      fprintf (stderr, "%s: warning: no NSIS Language File (.nlf) for %s\n",
	       program_name, lang);
    }
  else
    {
      if (modern_ui)
	/* FIXME: Should test if file exists.  NSISDIR is available
	   via makensis -HDRINFO.  Files are in
	   "NSISDIR/Contrib/Modern UI/Language files".  */
	printf ("!insertmacro MUI_LANGUAGE \"%s\"\n", nlf);
      else
	/* FIXME: Should test if file exists.  NSISDIR is available via
	   makensis -HDRINFO.  */
	printf ("LoadLanguageFile "
		"\"${NSISDIR}\\Contrib\\Language files\\%s.nlf\"\n", nlf);
    }
  printf ("!else\n");

  file = po_file_read (filename, &err_handler);
  if (file == NULL)
    error (EXIT_FAILURE, errno, "couldn't open the PO file %s", filename);

  domains = po_file_domains (file);
  for (domainp = domains; *domainp; domainp++)
    {
      const char *domain = *domainp;
      po_message_iterator_t iterator = po_message_iterator (file, domain);

      for (;;)
	{
	  po_message_t message = po_next_message (iterator);
	  const char *msgid;
	  const char *msgstr;
	  const char *msgctx;

	  if (message == NULL)
	    break;

	  msgid = po_message_msgid (message);
	  msgstr = po_message_msgstr (message);
	  msgctx = po_message_msgctxt (message);

	  if (msgctx != NULL)
	    {
	      char *msg = convert_newline ((*msgstr == '\0') ? msgid : msgstr);
	      printf ("LangString %s ${%s} \"%s\"\n", msgctx, lang, msg);
	      free (msg);
	    }
	}
      po_message_iterator_free (iterator);
    }
  printf ("!endif\n");
  po_file_free (file);  
}      


int
main (int argc, char *argv[])
{
  int i;

  program_name = argv[0];

  for (i = 1; i < argc; i++)
    fmt_one (argv[i]);

  return 0;
}
