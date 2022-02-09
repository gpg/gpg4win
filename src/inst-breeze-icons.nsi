# inst-breeze-icons.nsi - Snippet for breeze-icons.   -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007, 2008 g10 Code GmbH
#
# This file is part of GPG4Win.
#
# GPG4Win is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# GPG4Win is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA


!ifdef prefix
!undef prefix
!endif
!define prefix ${ipdir}/breeze-icons-${gpg4win_pkg_breeze_icons_version}

!ifdef DEBUG
Section "breeze-icons" SEC_breeze_icons
!else
Section "-breeze-icons" SEC_breeze_icons
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_breeze_icons}"
!else

  #
  # Note: You may want to use the pkg-to-nsi.pl script to create the
  # list of icons.
  #
  SetOutPath "$INSTDIR\share\icons\breeze\actions\16"

  File ${prefix}/share/icons/breeze/actions/16/application-exit.svg
  File ${prefix}/share/icons/breeze/actions/16/arrow-down.svg
  File ${prefix}/share/icons/breeze/actions/16/arrow-up.svg
  File ${prefix}/share/icons/breeze/actions/16/configure-shortcuts.svg
  File ${prefix}/share/icons/breeze/actions/16/configure-toolbars.svg
  File ${prefix}/share/icons/breeze/actions/16/configure.svg
  File ${prefix}/share/icons/breeze/actions/16/cell_edit.svg
  File ${prefix}/share/icons/breeze/actions/16/dvipdf.svg
  File ${prefix}/share/icons/breeze/actions/16/dialog-cancel.svg
  File ${prefix}/share/icons/breeze/actions/16/dialog-close.svg
  File ${prefix}/share/icons/breeze/actions/16/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze/actions/16/dialog-ok.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-sign.svg
  File ${prefix}/share/icons/breeze/actions/16/document-edit-verify.svg
  File ${prefix}/share/icons/breeze/actions/16/document-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/16/document-sign.svg
  File ${prefix}/share/icons/breeze/actions/16/document-open.svg
  File ${prefix}/share/icons/breeze/actions/16/document-print.svg
  File ${prefix}/share/icons/breeze/actions/16/document-revert.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-arrow-down.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-arrow-up.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-clear-locationbar-rtl.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-delete.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-find.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-paste.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-redo.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-rename.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-undo.svg
  File ${prefix}/share/icons/breeze/actions/16/editor.svg
  File ${prefix}/share/icons/breeze/actions/16/go-bottom.svg
  File ${prefix}/share/icons/breeze/actions/16/go-down.svg
  File ${prefix}/share/icons/breeze/actions/16/go-first.svg
  File ${prefix}/share/icons/breeze/actions/16/go-last.svg
  File ${prefix}/share/icons/breeze/actions/16/go-next.svg
  File ${prefix}/share/icons/breeze/actions/16/go-previous.svg
  File ${prefix}/share/icons/breeze/actions/16/go-top.svg
  File ${prefix}/share/icons/breeze/actions/16/go-up.svg
  File ${prefix}/share/icons/breeze/actions/16/help-contents.svg
  File ${prefix}/share/icons/breeze/actions/16/help-contextual.svg
  File ${prefix}/share/icons/breeze/actions/16/list-add.svg
  File ${prefix}/share/icons/breeze/actions/16/list-remove.svg
  File ${prefix}/share/icons/breeze/actions/16/process-stop.svg
  File ${prefix}/share/icons/breeze/actions/16/run-build-configure.svg
  File ${prefix}/share/icons/breeze/actions/16/settings-configure.svg
  File ${prefix}/share/icons/breeze/actions/16/tab-close.svg
  File ${prefix}/share/icons/breeze/actions/16/tab-duplicate.svg
  File ${prefix}/share/icons/breeze/actions/16/tab-new-background.svg
  File ${prefix}/share/icons/breeze/actions/16/tools-report-bug.svg
  File ${prefix}/share/icons/breeze/actions/16/view-refresh.svg
  File ${prefix}/share/icons/breeze/actions/16/window-close.svg
  File ${prefix}/share/icons/breeze/actions/16/visibility.svg
  File ${prefix}/share/icons/breeze/actions/16/hint.svg
  File ${prefix}/share/icons/breeze/actions/16/resource-group-new.svg
  File ${prefix}/share/icons/breeze/actions/16/password-generate.svg

  SetOutPath "$INSTDIR\share\icons\breeze\actions\22"

  File ${prefix}/share/icons/breeze/actions/22/application-exit.svg
  File ${prefix}/share/icons/breeze/actions/22/arrow-down.svg
  File ${prefix}/share/icons/breeze/actions/22/arrow-up.svg
  File ${prefix}/share/icons/breeze/actions/22/cell_edit.svg
  File ${prefix}/share/icons/breeze/actions/22/dvipdf.svg
  File ${prefix}/share/icons/breeze/actions/22/configure-shortcuts.svg
  File ${prefix}/share/icons/breeze/actions/22/configure-toolbars.svg
  File ${prefix}/share/icons/breeze/actions/22/configure.svg
  File ${prefix}/share/icons/breeze/actions/22/dialog-cancel.svg
  File ${prefix}/share/icons/breeze/actions/22/dialog-close.svg
  File ${prefix}/share/icons/breeze/actions/22/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze/actions/22/dialog-ok.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-sign.svg
  File ${prefix}/share/icons/breeze/actions/22/document-edit-verify.svg
  File ${prefix}/share/icons/breeze/actions/22/document-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/22/document-sign.svg
  File ${prefix}/share/icons/breeze/actions/22/document-open.svg
  File ${prefix}/share/icons/breeze/actions/22/document-print.svg
  File ${prefix}/share/icons/breeze/actions/22/document-revert.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-arrow-down.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-arrow-up.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-clear-locationbar-rtl.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-delete.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-find.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-paste.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-redo.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-rename.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-undo.svg
  File ${prefix}/share/icons/breeze/actions/22/edittext.svg
  File ${prefix}/share/icons/breeze/actions/22/editor.svg
  File ${prefix}/share/icons/breeze/actions/22/go-bottom.svg
  File ${prefix}/share/icons/breeze/actions/22/go-down.svg
  File ${prefix}/share/icons/breeze/actions/22/go-first.svg
  File ${prefix}/share/icons/breeze/actions/22/go-last.svg
  File ${prefix}/share/icons/breeze/actions/22/go-next.svg
  File ${prefix}/share/icons/breeze/actions/22/go-previous.svg
  File ${prefix}/share/icons/breeze/actions/22/go-top.svg
  File ${prefix}/share/icons/breeze/actions/22/go-up.svg
  File ${prefix}/share/icons/breeze/actions/22/help-contents.svg
  File ${prefix}/share/icons/breeze/actions/22/help-contextual.svg
  File ${prefix}/share/icons/breeze/actions/22/list-add.svg
  File ${prefix}/share/icons/breeze/actions/22/list-remove.svg
  File ${prefix}/share/icons/breeze/actions/22/process-stop.svg
  File ${prefix}/share/icons/breeze/actions/22/run-build-configure.svg
  File ${prefix}/share/icons/breeze/actions/22/settings-configure.svg
  File ${prefix}/share/icons/breeze/actions/22/tab-close.svg
  File ${prefix}/share/icons/breeze/actions/22/tab-duplicate.svg
  File ${prefix}/share/icons/breeze/actions/22/tab-new-background.svg
  File ${prefix}/share/icons/breeze/actions/22/tools-report-bug.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-add.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-export-secret.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-export-server.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-export.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-import.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-server-configure.svg
  File ${prefix}/share/icons/breeze/actions/22/view-certificate-sign.svg
  File ${prefix}/share/icons/breeze/actions/22/view-refresh.svg
  File ${prefix}/share/icons/breeze/actions/22/window-close.svg
  File ${prefix}/share/icons/breeze/actions/22/question.svg
  File ${prefix}/share/icons/breeze/actions/22/kt-add-filters.svg
  File ${prefix}/share/icons/breeze/actions/22/kt-remove-filters.svg
  File ${prefix}/share/icons/breeze/actions/22/resource-group-new.svg
  File ${prefix}/share/icons/breeze/actions/22/password-generate.svg
  File ${prefix}/share/icons/breeze/actions/22/note.svg
  File ${prefix}/share/icons/breeze/actions/22/group.svg

  SetOutPath "$INSTDIR\share\icons\breeze\actions\32"

  File ${prefix}/share/icons/breeze/actions/32/application-exit.svg
  File ${prefix}/share/icons/breeze/actions/32/configure.svg
  File ${prefix}/share/icons/breeze/actions/32/dialog-cancel.svg
  File ${prefix}/share/icons/breeze/actions/32/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze/actions/32/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze/actions/32/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze/actions/32/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/32/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze/actions/32/document-edit-sign.svg
  File ${prefix}/share/icons/breeze/actions/32/document-open.svg
  File ${prefix}/share/icons/breeze/actions/32/document-print.svg
  File ${prefix}/share/icons/breeze/actions/32/document-revert.svg
  File ${prefix}/share/icons/breeze/actions/32/edit-delete.svg
  File ${prefix}/share/icons/breeze/actions/32/edit-redo.svg
  File ${prefix}/share/icons/breeze/actions/32/edit-undo.svg
  File ${prefix}/share/icons/breeze/actions/32/editor.svg
  File ${prefix}/share/icons/breeze/actions/32/view-refresh.svg
  File ${prefix}/share/icons/breeze/actions/32/window-close.svg

  SetOutPath "$INSTDIR\share\icons\breeze\apps\22"

  File ${prefix}/share/icons/breeze/apps/22/kde.svg

  SetOutPath "$INSTDIR\share\icons\breeze\preferences\32"

  File ${prefix}/share/icons/breeze/preferences/32/preferences-desktop-locale.svg
  File ${prefix}/share/icons/breeze/preferences/32/preferences-system-network.svg

  SetOutPath "$INSTDIR\share\icons\breeze\apps\48"

  File ${prefix}/share/icons/breeze/apps/48/internet-mail.svg
  File ${prefix}/share/icons/breeze/apps/48/telepathy-kde.svg
  File ${prefix}/share/icons/breeze/apps/48/usb-creator-kde.svg

  SetOutPath "$INSTDIR\share\icons\breeze\categories\32"

  File ${prefix}/share/icons/breeze/categories/32/applications-graphics.svg

  SetOutPath "$INSTDIR\share\icons\breeze"

  File ${prefix}/share/icons/breeze/index.theme
  File ${prefix}/share/icons/breeze/icon-theme.cache

  SetOutPath "$INSTDIR\share\icons\breeze\places\16"

  File ${prefix}/share/icons/breeze/places/16/start-here-kde.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\22"

  File ${prefix}/share/icons/breeze/places/22/start-here-kde.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\64"

  File ${prefix}/share/icons/breeze/places/64/start-here-kde.svg

  SetOutPath "$INSTDIR\share\icons\breeze\status\16"


  SetOutPath "$INSTDIR\share\icons\breeze\status\22"

  File ${prefix}/share/icons/breeze/status/22/security-high.svg
  File ${prefix}/share/icons/breeze/status/22/security-low.svg
  File ${prefix}/share/icons/breeze/status/22/security-medium.svg
  File ${prefix}/share/icons/breeze/status/22/auth-sim-locked.svg

  SetOutPath "$INSTDIR\share\icons\breeze\status\24"


  SetOutPath "$INSTDIR\share\icons\breeze\status\64"

  File ${prefix}/share/icons/breeze/status/64/dialog-error.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-password.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-warning.svg
  File ${prefix}/share/icons/breeze/status/64/security-high.svg
  File ${prefix}/share/icons/breeze/status/64/security-low.svg
  File ${prefix}/share/icons/breeze/status/64/security-medium.svg

  SetOutPath "$INSTDIR\share\icons\breeze\emblems\8"
  File ${prefix}/share/icons/breeze/emblems/8/emblem-information.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-warning.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-success.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-error.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-question.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-unavailable.svg

  SetOutPath "$INSTDIR\share\icons\breeze\actions\symbolic"
  File ${prefix}/share/icons/breeze/actions/symbolic/send-to-symbolic.svg
  File ${prefix}/share/icons/breeze/actions/symbolic/contact-new-symbolic.svg

!endif
SectionEnd
