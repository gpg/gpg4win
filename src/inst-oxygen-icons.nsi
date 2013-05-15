# inst-oxygen-icons.nsi - Snippet for oxygen-icons.   -*- coding: latin-1; -*-
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
!define prefix ${ipdir}/oxygen-icons-${gpg4win_pkg_oxygen_icons_version}

!ifdef DEBUG
Section "oxygen-icons" SEC_oxygen_icons
!else
Section "-oxygen-icons" SEC_oxygen_icons
!endif
  SetOutPath "$INSTDIR"
!ifdef SOURCES
  File "${gpg4win_pkg_oxygen_icons_src}"
!else

  #
  # Note: You may want to use the pkg-to-nsi.pl script to create the
  # list of icons.
  #
  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\actions"

  File ${prefix}/share/icons/oxygen/128x128/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/128x128/actions/configure.png
  File ${prefix}/share/icons/oxygen/128x128/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/128x128/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/128x128/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-down.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-first.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-last.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-next.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-top.png
  File ${prefix}/share/icons/oxygen/128x128/actions/go-up.png
  File ${prefix}/share/icons/oxygen/128x128/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/128x128/actions/tools-report-bug.png

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\apps"

  File ${prefix}/share/icons/oxygen/128x128/apps/kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\categories"

  File ${prefix}/share/icons/oxygen/128x128/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/128x128/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\devices"

  File ${prefix}/share/icons/oxygen/128x128/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\128x128\status"

  File ${prefix}/share/icons/oxygen/128x128/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/128x128/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/128x128/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/128x128/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/128x128/status/security-high.png
  File ${prefix}/share/icons/oxygen/128x128/status/security-low.png
  File ${prefix}/share/icons/oxygen/128x128/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\actions"

  File ${prefix}/share/icons/oxygen/16x16/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/16x16/actions/arrow-down.png
  File ${prefix}/share/icons/oxygen/16x16/actions/arrow-up.png
  File ${prefix}/share/icons/oxygen/16x16/actions/configure-shortcuts.png
  File ${prefix}/share/icons/oxygen/16x16/actions/configure-toolbars.png
  File ${prefix}/share/icons/oxygen/16x16/actions/configure.png
  File ${prefix}/share/icons/oxygen/16x16/actions/dialog-cancel.png
  File ${prefix}/share/icons/oxygen/16x16/actions/dialog-close.png
  File ${prefix}/share/icons/oxygen/16x16/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/16x16/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-decrypt-verify.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-decrypt.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-encrypt.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-sign-encrypt.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-sign.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-edit-verify.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-encrypt.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-open.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-print.png
  File ${prefix}/share/icons/oxygen/16x16/actions/document-revert.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-clear-locationbar-rtl.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-delete.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-redo.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-rename.png
  File ${prefix}/share/icons/oxygen/16x16/actions/edit-undo.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-down.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-first.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-last.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-next.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-top.png
  File ${prefix}/share/icons/oxygen/16x16/actions/go-up.png
  File ${prefix}/share/icons/oxygen/16x16/actions/help-contents.png
  File ${prefix}/share/icons/oxygen/16x16/actions/help-contextual.png
  File ${prefix}/share/icons/oxygen/16x16/actions/list-add.png
  File ${prefix}/share/icons/oxygen/16x16/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/16x16/actions/process-stop.png
  File ${prefix}/share/icons/oxygen/16x16/actions/tab-close.png
  File ${prefix}/share/icons/oxygen/16x16/actions/tab-duplicate.png
  File ${prefix}/share/icons/oxygen/16x16/actions/tab-new-background.png
  File ${prefix}/share/icons/oxygen/16x16/actions/tools-report-bug.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-add.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-export-secret.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-export-server.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-export.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-import.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-server-configure.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-certificate-sign.png
  File ${prefix}/share/icons/oxygen/16x16/actions/view-refresh.png
  File ${prefix}/share/icons/oxygen/16x16/actions/window-close.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\animations"

  File ${prefix}/share/icons/oxygen/16x16/animations/process-working-kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\apps"

  File ${prefix}/share/icons/oxygen/16x16/apps/kde.png
  File ${prefix}/share/icons/oxygen/16x16/apps/internet-mail.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\categories"

  File ${prefix}/share/icons/oxygen/16x16/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/16x16/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\devices"

  File ${prefix}/share/icons/oxygen/16x16/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\16x16\status"

  File ${prefix}/share/icons/oxygen/16x16/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/16x16/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/16x16/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/16x16/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/16x16/status/security-high.png
  File ${prefix}/share/icons/oxygen/16x16/status/security-low.png
  File ${prefix}/share/icons/oxygen/16x16/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\actions"

  File ${prefix}/share/icons/oxygen/22x22/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/22x22/actions/arrow-down.png
  File ${prefix}/share/icons/oxygen/22x22/actions/arrow-up.png
  File ${prefix}/share/icons/oxygen/22x22/actions/configure-shortcuts.png
  File ${prefix}/share/icons/oxygen/22x22/actions/configure-toolbars.png
  File ${prefix}/share/icons/oxygen/22x22/actions/configure.png
  File ${prefix}/share/icons/oxygen/22x22/actions/dialog-cancel.png
  File ${prefix}/share/icons/oxygen/22x22/actions/dialog-close.png
  File ${prefix}/share/icons/oxygen/22x22/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/22x22/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-decrypt-verify.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-decrypt.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-encrypt.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-sign-encrypt.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-sign.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-edit-verify.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-encrypt.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-open.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-print.png
  File ${prefix}/share/icons/oxygen/22x22/actions/document-revert.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-clear-locationbar-rtl.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-delete.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-redo.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-rename.png
  File ${prefix}/share/icons/oxygen/22x22/actions/edit-undo.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-down.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-first.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-last.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-next.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-top.png
  File ${prefix}/share/icons/oxygen/22x22/actions/go-up.png
  File ${prefix}/share/icons/oxygen/22x22/actions/help-contents.png
  File ${prefix}/share/icons/oxygen/22x22/actions/help-contextual.png
  File ${prefix}/share/icons/oxygen/22x22/actions/list-add.png
  File ${prefix}/share/icons/oxygen/22x22/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/22x22/actions/process-stop.png
  File ${prefix}/share/icons/oxygen/22x22/actions/tab-close.png
  File ${prefix}/share/icons/oxygen/22x22/actions/tab-duplicate.png
  File ${prefix}/share/icons/oxygen/22x22/actions/tab-new-background.png
  File ${prefix}/share/icons/oxygen/22x22/actions/tools-report-bug.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-add.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-export-secret.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-export-server.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-export.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-import.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-server-configure.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-certificate-sign.png
  File ${prefix}/share/icons/oxygen/22x22/actions/view-refresh.png
  File ${prefix}/share/icons/oxygen/22x22/actions/window-close.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\animations"

  File ${prefix}/share/icons/oxygen/22x22/animations/process-working-kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\apps"

  File ${prefix}/share/icons/oxygen/22x22/apps/kde.png
  File ${prefix}/share/icons/oxygen/22x22/apps/internet-mail.png
  File ${prefix}/share/icons/oxygen/22x22/apps/preferences-desktop-locale.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\categories"

  File ${prefix}/share/icons/oxygen/22x22/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/22x22/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\devices"

  File ${prefix}/share/icons/oxygen/22x22/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\22x22\status"

  File ${prefix}/share/icons/oxygen/22x22/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/22x22/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/22x22/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/22x22/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/22x22/status/security-high.png
  File ${prefix}/share/icons/oxygen/22x22/status/security-low.png
  File ${prefix}/share/icons/oxygen/22x22/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen\256x256\categories"

  File ${prefix}/share/icons/oxygen/256x256/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/256x256/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\256x256\devices"

  File ${prefix}/share/icons/oxygen/256x256/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\actions"

  File ${prefix}/share/icons/oxygen/32x32/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/32x32/actions/arrow-down.png
  File ${prefix}/share/icons/oxygen/32x32/actions/arrow-up.png
  File ${prefix}/share/icons/oxygen/32x32/actions/configure-shortcuts.png
  File ${prefix}/share/icons/oxygen/32x32/actions/configure-toolbars.png
  File ${prefix}/share/icons/oxygen/32x32/actions/configure.png
  File ${prefix}/share/icons/oxygen/32x32/actions/dialog-cancel.png
  File ${prefix}/share/icons/oxygen/32x32/actions/dialog-close.png
  File ${prefix}/share/icons/oxygen/32x32/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/32x32/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-decrypt-verify.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-decrypt.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-encrypt.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-sign-encrypt.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-sign.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-edit-verify.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-encrypt.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-open.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-print.png
  File ${prefix}/share/icons/oxygen/32x32/actions/document-revert.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-clear-locationbar-rtl.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-delete.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-redo.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-rename.png
  File ${prefix}/share/icons/oxygen/32x32/actions/edit-undo.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-down.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-first.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-last.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-next.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-top.png
  File ${prefix}/share/icons/oxygen/32x32/actions/go-up.png
  File ${prefix}/share/icons/oxygen/32x32/actions/help-contents.png
  File ${prefix}/share/icons/oxygen/32x32/actions/help-contextual.png
  File ${prefix}/share/icons/oxygen/32x32/actions/list-add.png
  File ${prefix}/share/icons/oxygen/32x32/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/32x32/actions/process-stop.png
  File ${prefix}/share/icons/oxygen/32x32/actions/tab-close.png
  File ${prefix}/share/icons/oxygen/32x32/actions/tab-duplicate.png
  File ${prefix}/share/icons/oxygen/32x32/actions/tab-new-background.png
  File ${prefix}/share/icons/oxygen/32x32/actions/tools-report-bug.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-add.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-export-secret.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-export-server.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-export.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-import.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-server-configure.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-certificate-sign.png
  File ${prefix}/share/icons/oxygen/32x32/actions/view-refresh.png
  File ${prefix}/share/icons/oxygen/32x32/actions/window-close.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\animations"

  File ${prefix}/share/icons/oxygen/32x32/animations/process-working-kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\apps"

  File ${prefix}/share/icons/oxygen/32x32/apps/kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\categories"

  File ${prefix}/share/icons/oxygen/32x32/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/32x32/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\devices"

  File ${prefix}/share/icons/oxygen/32x32/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\32x32\status"

  File ${prefix}/share/icons/oxygen/32x32/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/32x32/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/32x32/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/32x32/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/32x32/status/security-high.png
  File ${prefix}/share/icons/oxygen/32x32/status/security-low.png
  File ${prefix}/share/icons/oxygen/32x32/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\actions"

  File ${prefix}/share/icons/oxygen/48x48/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/48x48/actions/arrow-down.png
  File ${prefix}/share/icons/oxygen/48x48/actions/arrow-up.png
  File ${prefix}/share/icons/oxygen/48x48/actions/configure-shortcuts.png
  File ${prefix}/share/icons/oxygen/48x48/actions/configure-toolbars.png
  File ${prefix}/share/icons/oxygen/48x48/actions/configure.png
  File ${prefix}/share/icons/oxygen/48x48/actions/dialog-cancel.png
  File ${prefix}/share/icons/oxygen/48x48/actions/dialog-close.png
  File ${prefix}/share/icons/oxygen/48x48/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/48x48/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-decrypt-verify.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-decrypt.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-encrypt.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-sign-encrypt.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-sign.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-edit-verify.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-encrypt.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-open.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-print.png
  File ${prefix}/share/icons/oxygen/48x48/actions/document-revert.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-clear-locationbar-rtl.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-delete.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-redo.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-rename.png
  File ${prefix}/share/icons/oxygen/48x48/actions/edit-undo.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-down.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-first.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-last.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-next.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-top.png
  File ${prefix}/share/icons/oxygen/48x48/actions/go-up.png
  File ${prefix}/share/icons/oxygen/48x48/actions/help-contents.png
  File ${prefix}/share/icons/oxygen/48x48/actions/help-contextual.png
  File ${prefix}/share/icons/oxygen/48x48/actions/list-add.png
  File ${prefix}/share/icons/oxygen/48x48/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/48x48/actions/process-stop.png
  File ${prefix}/share/icons/oxygen/48x48/actions/tab-close.png
  File ${prefix}/share/icons/oxygen/48x48/actions/tab-duplicate.png
  File ${prefix}/share/icons/oxygen/48x48/actions/tab-new-background.png
  File ${prefix}/share/icons/oxygen/48x48/actions/tools-report-bug.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-add.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-export-secret.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-export-server.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-export.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-import.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-server-configure.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-certificate-sign.png
  File ${prefix}/share/icons/oxygen/48x48/actions/view-refresh.png
  File ${prefix}/share/icons/oxygen/48x48/actions/window-close.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\animations"

  File ${prefix}/share/icons/oxygen/48x48/animations/process-working-kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\apps"

  File ${prefix}/share/icons/oxygen/48x48/apps/kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\categories"

  File ${prefix}/share/icons/oxygen/48x48/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/48x48/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\devices"

  File ${prefix}/share/icons/oxygen/48x48/devices/secure-card.png

  SetOutPath "$INSTDIR\share\icons\oxygen\48x48\status"

  File ${prefix}/share/icons/oxygen/48x48/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/48x48/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/48x48/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/48x48/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/48x48/status/security-high.png
  File ${prefix}/share/icons/oxygen/48x48/status/security-low.png
  File ${prefix}/share/icons/oxygen/48x48/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\actions"

  File ${prefix}/share/icons/oxygen/64x64/actions/application-exit.png
  File ${prefix}/share/icons/oxygen/64x64/actions/configure.png
  File ${prefix}/share/icons/oxygen/64x64/actions/dialog-ok-apply.png
  File ${prefix}/share/icons/oxygen/64x64/actions/dialog-ok.png
  File ${prefix}/share/icons/oxygen/64x64/actions/edit-find.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-bottom.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-down.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-first.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-last.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-next.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-previous.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-top.png
  File ${prefix}/share/icons/oxygen/64x64/actions/go-up.png
  File ${prefix}/share/icons/oxygen/64x64/actions/list-remove.png
  File ${prefix}/share/icons/oxygen/64x64/actions/tools-report-bug.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\apps"

  File ${prefix}/share/icons/oxygen/64x64/apps/kde.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\categories"

  File ${prefix}/share/icons/oxygen/64x64/categories/applications-graphics.png
  File ${prefix}/share/icons/oxygen/64x64/categories/preferences-system-network.png

  SetOutPath "$INSTDIR\share\icons\oxygen\64x64\status"

  File ${prefix}/share/icons/oxygen/64x64/status/dialog-error.png
  File ${prefix}/share/icons/oxygen/64x64/status/dialog-information.png
  File ${prefix}/share/icons/oxygen/64x64/status/dialog-password.png
  File ${prefix}/share/icons/oxygen/64x64/status/dialog-warning.png
  File ${prefix}/share/icons/oxygen/64x64/status/security-high.png
  File ${prefix}/share/icons/oxygen/64x64/status/security-low.png
  File ${prefix}/share/icons/oxygen/64x64/status/security-medium.png

  SetOutPath "$INSTDIR\share\icons\oxygen"

  File ${prefix}/share/icons/oxygen/index.theme


!endif
SectionEnd
