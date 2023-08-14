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
  # Note: You may want to use the findicton.sh script to create the
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
  File ${prefix}/share/icons/breeze/actions/16/draw-text.svg
  File ${prefix}/share/icons/breeze/actions/16/view-list-text.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-arrow-down.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-arrow-up.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-clear-locationbar-rtl.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-copy.svg
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
  File ${prefix}/share/icons/breeze/actions/16/go-next-skip.svg
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
  File ${prefix}/share/icons/breeze/actions/16/edit-delete-remove.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-clear-history.svg
  File ${prefix}/share/icons/breeze/actions/16/help-about.svg
  File ${prefix}/share/icons/breeze/actions/16/entry-delete.svg
  File ${prefix}/share/icons/breeze/actions/16/checkmark.svg
  File ${prefix}/share/icons/breeze/actions/16/document-new.svg
  File ${prefix}/share/icons/breeze/actions/16/document-save.svg
  File ${prefix}/share/icons/breeze/actions/16/document-save-as.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-clear-locationbar-ltr.svg

  # From Okular
  File ${prefix}/share/icons/breeze/actions/16/bookmark-new.svg
  File ${prefix}/share/icons/breeze/actions/16/bookmark-remove.svg
  File ${prefix}/share/icons/breeze/actions/16/bookmarks.svg
  File ${prefix}/share/icons/breeze/actions/16/collapse-all.svg
  File ${prefix}/share/icons/breeze/actions/16/collapse.svg
  File ${prefix}/share/icons/breeze/actions/16/color-management.svg
  File ${prefix}/share/icons/breeze/actions/16/color-mode-black-white.svg
  File ${prefix}/share/icons/breeze/actions/16/color-mode-hue-shift-negative.svg
  File ${prefix}/share/icons/breeze/actions/16/color-mode-hue-shift-positive.svg
  File ${prefix}/share/icons/breeze/actions/16/color-mode-invert-image.svg
  File ${prefix}/share/icons/breeze/actions/16/color-mode-invert-text.svg
  File ${prefix}/share/icons/breeze/actions/16/color-picker.svg
  File ${prefix}/share/icons/breeze/actions/16/dialog-text-and-font.svg
  File ${prefix}/share/icons/breeze/actions/16/document-export.svg
  File ${prefix}/share/icons/breeze/actions/16/document-import.svg
  File ${prefix}/share/icons/breeze/actions/16/document-open-folder.svg
  File ${prefix}/share/icons/breeze/actions/16/document-preview.svg
  File ${prefix}/share/icons/breeze/actions/16/document-properties.svg
  File ${prefix}/share/icons/breeze/actions/16/document-share.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-ellipse.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-eraser-delete-objects.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-eraser.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-freehand.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-highlight.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-line.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-polyline.svg
  File ${prefix}/share/icons/breeze/actions/16/draw-rectangle.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-comment.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-line-width.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-opacity.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-select.svg
  File ${prefix}/share/icons/breeze/actions/16/edit-select-text.svg
  File ${prefix}/share/icons/breeze/actions/16/expand-all.svg
  File ${prefix}/share/icons/breeze/actions/16/expand.svg
  File ${prefix}/share/icons/breeze/actions/16/font-face.svg
  File ${prefix}/share/icons/breeze/actions/16/font.svg
  File ${prefix}/share/icons/breeze/actions/16/format-fill-color.svg
  File ${prefix}/share/icons/breeze/actions/16/format-justify-left.svg
  File ${prefix}/share/icons/breeze/actions/16/format-justify-right.svg
  File ${prefix}/share/icons/breeze/actions/16/format-list-unordered.svg
  File ${prefix}/share/icons/breeze/actions/16/format-stroke-color.svg
  File ${prefix}/share/icons/breeze/actions/16/format-text-color.svg
  File ${prefix}/share/icons/breeze/actions/16/format-text-direction-rtl.svg
  File ${prefix}/share/icons/breeze/actions/16/format-text-strikethrough.svg
  File ${prefix}/share/icons/breeze/actions/16/format-text-underline-squiggle.svg
  File ${prefix}/share/icons/breeze/actions/16/format-text-underline.svg
  File ${prefix}/share/icons/breeze/actions/16/go-down-search.svg
  File ${prefix}/share/icons/breeze/actions/16/go-up-search.svg
  File ${prefix}/share/icons/breeze/actions/16/invertimage.svg
  File ${prefix}/share/icons/breeze/actions/16/mail-attachment.svg
  File ${prefix}/share/icons/breeze/actions/16/media-playback-pause.svg
  File ${prefix}/share/icons/breeze/actions/16/media-playback-start.svg
  File ${prefix}/share/icons/breeze/actions/16/media-playback-stop.svg
  File ${prefix}/share/icons/breeze/actions/16/object-rotate-left.svg
  File ${prefix}/share/icons/breeze/actions/16/object-rotate-right.svg
  File ${prefix}/share/icons/breeze/actions/16/object.svg
  File ${prefix}/share/icons/breeze/actions/16/page-2sides.svg
  File ${prefix}/share/icons/breeze/actions/16/page-zoom.svg
  File ${prefix}/share/icons/breeze/actions/16/paper-color.svg
  File ${prefix}/share/icons/breeze/actions/16/pin.svg
  File ${prefix}/share/icons/breeze/actions/16/player-time.svg
  File ${prefix}/share/icons/breeze/actions/16/select-rectangular.svg
  File ${prefix}/share/icons/breeze/actions/16/select.svg
  File ${prefix}/share/icons/breeze/actions/16/sidebar-show-symbolic.svg
  File ${prefix}/share/icons/breeze/actions/16/snap-angle.svg
  File ${prefix}/share/icons/breeze/actions/16/snap.svg
  File ${prefix}/share/icons/breeze/actions/16/table.svg
  File ${prefix}/share/icons/breeze/actions/16/tag.svg
  File ${prefix}/share/icons/breeze/actions/16/text-speak.svg
  File ${prefix}/share/icons/breeze/actions/16/tool-text.svg
  File ${prefix}/share/icons/breeze/actions/16/trim-margins.svg
  File ${prefix}/share/icons/breeze/actions/16/trim-to-selection.svg
  File ${prefix}/share/icons/breeze/actions/16/user-identity.svg
  File ${prefix}/share/icons/breeze/actions/16/user.svg
  File ${prefix}/share/icons/breeze/actions/16/view-filter.svg
  File ${prefix}/share/icons/breeze/actions/16/view-pages-continuous.svg
  File ${prefix}/share/icons/breeze/actions/16/view-pages-facing-first-centered.svg
  File ${prefix}/share/icons/breeze/actions/16/view-pages-facing.svg
  File ${prefix}/share/icons/breeze/actions/16/view-pages-overview.svg
  File ${prefix}/share/icons/breeze/actions/16/view-pages-single.svg
  File ${prefix}/share/icons/breeze/actions/16/view-presentation.svg
  File ${prefix}/share/icons/breeze/actions/16/view-preview.svg
  File ${prefix}/share/icons/breeze/actions/16/view-sidetree.svg
  File ${prefix}/share/icons/breeze/actions/16/view-split-left-right.svg
  File ${prefix}/share/icons/breeze/actions/16/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze/actions/16/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze/actions/16/zoom-original.svg
  File ${prefix}/share/icons/breeze/actions/16/zoom.svg

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
  File ${prefix}/share/icons/breeze/actions/22/edit-copy.svg
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
  File ${prefix}/share/icons/breeze/actions/16/go-next-skip.svg
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
  File ${prefix}/share/icons/breeze/actions/22/edit-clear-history.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-delete-remove.svg
  File ${prefix}/share/icons/breeze/actions/22/entry-delete.svg
  File ${prefix}/share/icons/breeze/actions/22/favorite.svg
  File ${prefix}/share/icons/breeze/actions/22/help-about.svg
  File ${prefix}/share/icons/breeze/actions/22/checkmark.svg
  File ${prefix}/share/icons/breeze/actions/22/document-new.svg
  File ${prefix}/share/icons/breeze/actions/22/document-save.svg
  File ${prefix}/share/icons/breeze/actions/22/document-save-as.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-clear-locationbar-ltr.svg

  # From Okular
  File ${prefix}/share/icons/breeze/actions/22/bookmark-new.svg
  File ${prefix}/share/icons/breeze/actions/22/bookmark-remove.svg
  File ${prefix}/share/icons/breeze/actions/22/bookmarks.svg
  File ${prefix}/share/icons/breeze/actions/22/collapse-all.svg
  File ${prefix}/share/icons/breeze/actions/22/collapse.svg
  File ${prefix}/share/icons/breeze/actions/22/color-management.svg
  File ${prefix}/share/icons/breeze/actions/22/color-mode-black-white.svg
  File ${prefix}/share/icons/breeze/actions/22/color-mode-hue-shift-negative.svg
  File ${prefix}/share/icons/breeze/actions/22/color-mode-hue-shift-positive.svg
  File ${prefix}/share/icons/breeze/actions/22/color-mode-invert-image.svg
  File ${prefix}/share/icons/breeze/actions/22/color-mode-invert-text.svg
  File ${prefix}/share/icons/breeze/actions/22/color-picker.svg
  File ${prefix}/share/icons/breeze/actions/22/document-export.svg
  File ${prefix}/share/icons/breeze/actions/22/document-import.svg
  File ${prefix}/share/icons/breeze/actions/22/document-open-folder.svg
  File ${prefix}/share/icons/breeze/actions/22/document-preview.svg
  File ${prefix}/share/icons/breeze/actions/22/document-properties.svg
  File ${prefix}/share/icons/breeze/actions/22/document-share.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-ellipse.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-eraser.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-freehand.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-highlight.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-line.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-polyline.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-rectangle.svg
  File ${prefix}/share/icons/breeze/actions/22/draw-text.svg
  File ${prefix}/share/icons/breeze/actions/22/view-list-text.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-comment.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-line-width.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-opacity.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-select.svg
  File ${prefix}/share/icons/breeze/actions/22/edit-select-text.svg
  File ${prefix}/share/icons/breeze/actions/22/expand-all.svg
  File ${prefix}/share/icons/breeze/actions/22/expand.svg
  File ${prefix}/share/icons/breeze/actions/22/font.svg
  File ${prefix}/share/icons/breeze/actions/22/format-fill-color.svg
  File ${prefix}/share/icons/breeze/actions/22/format-justify-left.svg
  File ${prefix}/share/icons/breeze/actions/22/format-justify-right.svg
  File ${prefix}/share/icons/breeze/actions/22/format-list-unordered.svg
  File ${prefix}/share/icons/breeze/actions/22/format-stroke-color.svg
  File ${prefix}/share/icons/breeze/actions/22/format-text-color.svg
  File ${prefix}/share/icons/breeze/actions/22/format-text-direction-rtl.svg
  File ${prefix}/share/icons/breeze/actions/22/format-text-strikethrough.svg
  File ${prefix}/share/icons/breeze/actions/22/format-text-underline-squiggle.svg
  File ${prefix}/share/icons/breeze/actions/22/format-text-underline.svg
  File ${prefix}/share/icons/breeze/actions/22/go-down-search.svg
  File ${prefix}/share/icons/breeze/actions/22/go-up-search.svg
  File ${prefix}/share/icons/breeze/actions/22/invertimage.svg
  File ${prefix}/share/icons/breeze/actions/22/mail-attachment.svg
  File ${prefix}/share/icons/breeze/actions/22/media-playback-pause.svg
  File ${prefix}/share/icons/breeze/actions/22/media-playback-start.svg
  File ${prefix}/share/icons/breeze/actions/22/media-playback-stop.svg
  File ${prefix}/share/icons/breeze/actions/22/object-rotate-left.svg
  File ${prefix}/share/icons/breeze/actions/22/object-rotate-right.svg
  File ${prefix}/share/icons/breeze/actions/22/object.svg
  File ${prefix}/share/icons/breeze/actions/22/page-2sides.svg
  File ${prefix}/share/icons/breeze/actions/22/page-zoom.svg
  File ${prefix}/share/icons/breeze/actions/22/paper-color.svg
  File ${prefix}/share/icons/breeze/actions/22/pin.svg
  File ${prefix}/share/icons/breeze/actions/22/player-time.svg
  File ${prefix}/share/icons/breeze/actions/22/select-rectangular.svg
  File ${prefix}/share/icons/breeze/actions/22/select.svg
  File ${prefix}/share/icons/breeze/actions/22/sidebar-show-symbolic.svg
  File ${prefix}/share/icons/breeze/actions/22/snap-angle.svg
  File ${prefix}/share/icons/breeze/actions/22/snap.svg
  File ${prefix}/share/icons/breeze/actions/22/table.svg
  File ${prefix}/share/icons/breeze/actions/22/tag.svg
  File ${prefix}/share/icons/breeze/actions/22/text-speak.svg
  File ${prefix}/share/icons/breeze/actions/22/tool-text.svg
  File ${prefix}/share/icons/breeze/actions/22/transform-browse.svg
  File ${prefix}/share/icons/breeze/actions/22/trim-margins.svg
  File ${prefix}/share/icons/breeze/actions/22/trim-to-selection.svg
  File ${prefix}/share/icons/breeze/actions/22/user-identity.svg
  File ${prefix}/share/icons/breeze/actions/22/user.svg
  File ${prefix}/share/icons/breeze/actions/22/view-filter.svg
  File ${prefix}/share/icons/breeze/actions/22/view-pages-continuous.svg
  File ${prefix}/share/icons/breeze/actions/22/view-pages-facing-first-centered.svg
  File ${prefix}/share/icons/breeze/actions/22/view-pages-facing.svg
  File ${prefix}/share/icons/breeze/actions/22/view-pages-overview.svg
  File ${prefix}/share/icons/breeze/actions/22/view-pages-single.svg
  File ${prefix}/share/icons/breeze/actions/22/view-presentation.svg
  File ${prefix}/share/icons/breeze/actions/22/view-preview.svg
  File ${prefix}/share/icons/breeze/actions/22/view-sidetree.svg
  File ${prefix}/share/icons/breeze/actions/22/view-split-left-right.svg
  File ${prefix}/share/icons/breeze/actions/22/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze/actions/22/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze/actions/22/zoom-original.svg
  File ${prefix}/share/icons/breeze/actions/22/zoom.svg


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
  File ${prefix}/share/icons/breeze/actions/32/go-next-skip.svg
  File ${prefix}/share/icons/breeze/actions/32/view-list-text.svg
  File ${prefix}/share/icons/breeze/actions/32/view-refresh.svg
  File ${prefix}/share/icons/breeze/actions/32/window-close.svg
  File ${prefix}/share/icons/breeze/actions/32/help-about.svg
  File ${prefix}/share/icons/breeze/actions/32/document-new.svg
  File ${prefix}/share/icons/breeze/actions/32/document-save.svg
  File ${prefix}/share/icons/breeze/actions/32/document-save-as.svg

  # From Okular
  File ${prefix}/share/icons/breeze/actions/32/bookmark-new.svg
  File ${prefix}/share/icons/breeze/actions/32/bookmark-remove.svg
  File ${prefix}/share/icons/breeze/actions/32/bookmarks.svg
  File ${prefix}/share/icons/breeze/actions/32/collapse-all.svg
  File ${prefix}/share/icons/breeze/actions/32/collapse.svg
  File ${prefix}/share/icons/breeze/actions/32/color-management.svg
  File ${prefix}/share/icons/breeze/actions/32/color-picker.svg
  File ${prefix}/share/icons/breeze/actions/32/document-export.svg
  File ${prefix}/share/icons/breeze/actions/32/document-import.svg
  File ${prefix}/share/icons/breeze/actions/32/document-open-folder.svg
  File ${prefix}/share/icons/breeze/actions/32/document-preview.svg
  File ${prefix}/share/icons/breeze/actions/32/document-properties.svg
  File ${prefix}/share/icons/breeze/actions/32/document-share.svg
  File ${prefix}/share/icons/breeze/actions/32/edit-select.svg
  File ${prefix}/share/icons/breeze/actions/32/expand-all.svg
  File ${prefix}/share/icons/breeze/actions/32/expand.svg
  File ${prefix}/share/icons/breeze/actions/32/format-stroke-color.svg
  File ${prefix}/share/icons/breeze/actions/32/mail-attachment.svg
  File ${prefix}/share/icons/breeze/actions/32/media-playback-pause.svg
  File ${prefix}/share/icons/breeze/actions/32/media-playback-start.svg
  File ${prefix}/share/icons/breeze/actions/32/media-playback-stop.svg
  File ${prefix}/share/icons/breeze/actions/32/page-zoom.svg
  File ${prefix}/share/icons/breeze/actions/32/select.svg
  File ${prefix}/share/icons/breeze/actions/32/tag.svg
  File ${prefix}/share/icons/breeze/actions/32/trim-margins.svg
  File ${prefix}/share/icons/breeze/actions/32/trim-to-selection.svg
  File ${prefix}/share/icons/breeze/actions/32/view-filter.svg
  File ${prefix}/share/icons/breeze/actions/32/view-preview.svg
  File ${prefix}/share/icons/breeze/actions/32/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze/actions/32/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze/actions/32/zoom-original.svg
  File ${prefix}/share/icons/breeze/actions/32/zoom.svg

  SetOutPath "$INSTDIR\share\icons\breeze\applets\22"
  # From Okular
  File ${prefix}/share/icons/breeze/applets/22/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze\apps\22"

  File ${prefix}/share/icons/breeze/apps/22/kde.svg
  File ${prefix}/share/icons/breeze/apps/22/accessories-text-editor.svg

  SetOutPath "$INSTDIR\share\icons\breeze\preferences\22"
  File ${prefix}/share/icons/breeze/preferences/22/preferences-web-browser-shortcuts.svg

  SetOutPath "$INSTDIR\share\icons\breeze\preferences\32"

  File ${prefix}/share/icons/breeze/preferences/32/preferences-desktop-locale.svg
  File ${prefix}/share/icons/breeze/preferences/32/preferences-system-network.svg
  File ${prefix}/share/icons/breeze/preferences/32/preferences-web-browser-shortcuts.svg
  File ${prefix}/share/icons/breeze/preferences/32/preferences-desktop-accessibility.svg
  File ${prefix}/share/icons/breeze/preferences/32/preferences-system-performance.svg

  SetOutPath "$INSTDIR\share\icons\breeze\apps\48"

  File ${prefix}/share/icons/breeze/apps/48/internet-mail.svg
  File ${prefix}/share/icons/breeze/apps/48/telepathy-kde.svg
  File ${prefix}/share/icons/breeze/apps/48/usb-creator-kde.svg
  File ${prefix}/share/icons/breeze/apps/48/okular.svg
  File ${prefix}/share/icons/breeze/apps/48/accessories-text-editor.svg


  SetOutPath "$INSTDIR\share\icons\breeze\categories\32"

  File ${prefix}/share/icons/breeze/categories/32/applications-graphics.svg

  SetOutPath "$INSTDIR\share\icons\breeze"

  File ${prefix}/share/icons/breeze/index.theme
  File ${prefix}/share/icons/breeze/icon-theme.cache

  # From Okular
  SetOutPath "$INSTDIR\share\icons\breeze\devices\16"
  File ${prefix}/share/icons/breeze/devices/16/input-mouse.svg
  SetOutPath "$INSTDIR\share\icons\breeze\devices\22"
  File ${prefix}/share/icons/breeze/devices/22/input-mouse.svg
  SetOutPath "$INSTDIR\share\icons\breeze\devices\64"
  File ${prefix}/share/icons/breeze/devices/64/input-mouse.svg
  File ${prefix}/share/icons/breeze/devices/64/cpu.svg
  File ${prefix}/share/icons/breeze/devices/64/video-display.svg

  # Mimetypes all from Okular
  SetOutPath "$INSTDIR\share\icons\breeze\mimetypes\16"
  File ${prefix}/share/icons/breeze/mimetypes/16/application-octet-stream.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/application-pdf.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/image-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/text-html.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/text-plain.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/text-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/application-epub+zip.svg
  File ${prefix}/share/icons/breeze/mimetypes/16/text-markdown.svg



  SetOutPath "$INSTDIR\share\icons\breeze\mimetypes\22"
  File ${prefix}/share/icons/breeze/mimetypes/22/application-octet-stream.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/application-pdf.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/image-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/text-html.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/text-plain.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/text-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/application-epub+zip.svg
  File ${prefix}/share/icons/breeze/mimetypes/22/text-markdown.svg


  SetOutPath "$INSTDIR\share\icons\breeze\mimetypes\32"
  File ${prefix}/share/icons/breeze/mimetypes/32/application-octet-stream.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/application-pdf.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/image-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/text-html.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/text-plain.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/text-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/application-epub+zip.svg
  File ${prefix}/share/icons/breeze/mimetypes/32/text-markdown.svg


  SetOutPath "$INSTDIR\share\icons\breeze\mimetypes\64"
  File ${prefix}/share/icons/breeze/mimetypes/64/application-octet-stream.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/application-pdf.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/image-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/text-html.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/text-plain.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/text-x-generic.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/application-epub+zip.svg
  File ${prefix}/share/icons/breeze/mimetypes/64/text-markdown.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\16"

  File ${prefix}/share/icons/breeze/places/16/start-here-kde.svg
  File ${prefix}/share/icons/breeze/places/16/folder.svg

  # From Okular
  File ${prefix}/share/icons/breeze/places/16/network-server.svg
  File ${prefix}/share/icons/breeze/places/16/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\22"

  File ${prefix}/share/icons/breeze/places/22/start-here-kde.svg
  File ${prefix}/share/icons/breeze/places/22/folder.svg
  File ${prefix}/share/icons/breeze/places/22/network-server.svg
  File ${prefix}/share/icons/breeze/places/22/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\48"
  File ${prefix}/share/icons/breeze/places/48/folder.svg
  File ${prefix}/share/icons/breeze/places/48/network-server.svg

  SetOutPath "$INSTDIR\share\icons\breeze\places\64"

  File ${prefix}/share/icons/breeze/places/64/start-here-kde.svg
  File ${prefix}/share/icons/breeze/places/64/folder.svg
  File ${prefix}/share/icons/breeze/places/64/network-server.svg

  SetOutPath "$INSTDIR\share\icons\breeze\status\16"

  File ${prefix}/share/icons/breeze/status/16/dialog-information.svg
  File ${prefix}/share/icons/breeze/status/16/user-away.svg

  SetOutPath "$INSTDIR\share\icons\breeze\status\22"

  File ${prefix}/share/icons/breeze/status/22/dialog-information.svg
  File ${prefix}/share/icons/breeze/status/22/security-high.svg
  File ${prefix}/share/icons/breeze/status/22/security-low.svg
  File ${prefix}/share/icons/breeze/status/22/security-medium.svg
  File ${prefix}/share/icons/breeze/status/22/auth-sim-locked.svg
  File ${prefix}/share/icons/breeze/status/22/dialog-question.svg
  File ${prefix}/share/icons/breeze/status/22/user-away.svg

  SetOutPath "$INSTDIR\share\icons\breeze\status\64"

  File ${prefix}/share/icons/breeze/status/64/dialog-error.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-password.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-warning.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-information.svg
  File ${prefix}/share/icons/breeze/status/64/security-high.svg
  File ${prefix}/share/icons/breeze/status/64/security-low.svg
  File ${prefix}/share/icons/breeze/status/64/security-medium.svg
  File ${prefix}/share/icons/breeze/status/64/dialog-question.svg

  SetOutPath "$INSTDIR\share\icons\breeze\emblems\8"
  File ${prefix}/share/icons/breeze/emblems/8/emblem-information.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-warning.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-success.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-error.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-question.svg
  File ${prefix}/share/icons/breeze/emblems/8/emblem-unavailable.svg
  File ${prefix}/share/icons/breeze/emblems/8/checkmark.svg

  SetOutPath "$INSTDIR\share\icons\breeze\emblems\16"
  File ${prefix}/share/icons/breeze/emblems/16/checkmark.svg

  SetOutPath "$INSTDIR\share\icons\breeze\actions\symbolic"
  File ${prefix}/share/icons/breeze/actions/symbolic/send-to-symbolic.svg
  File ${prefix}/share/icons/breeze/actions/symbolic/contact-new-symbolic.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\actions\16"

  File ${prefix}/share/icons/breeze-dark/actions/16/application-exit.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/arrow-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/arrow-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/configure-shortcuts.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/configure-toolbars.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/cell_edit.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dvipdf.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dialog-cancel.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dialog-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dialog-ok.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-edit-verify.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-open.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-print.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-revert.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-list-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-arrow-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-arrow-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-clear-locationbar-rtl.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-copy.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-delete.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-find.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-paste.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-redo.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-rename.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-undo.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/editor.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-bottom.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-first.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-last.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-next.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-next-skip.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-previous.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-top.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/help-contents.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/help-contextual.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/list-add.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/list-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/process-stop.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/run-build-configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/settings-configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tab-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tab-duplicate.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tab-new-background.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tools-report-bug.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-refresh.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/window-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/visibility.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/hint.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/resource-group-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/password-generate.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-delete-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-clear-history.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/help-about.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/entry-delete.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/checkmark.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-save.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-save-as.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-clear-locationbar-ltr.svg

  # From Okular
  File ${prefix}/share/icons/breeze-dark/actions/16/bookmark-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/bookmark-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/bookmarks.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/collapse-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/collapse.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-management.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-mode-black-white.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-mode-hue-shift-negative.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-mode-hue-shift-positive.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-mode-invert-image.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-mode-invert-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/color-picker.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/dialog-text-and-font.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-export.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-import.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-open-folder.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-properties.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/document-share.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-ellipse.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-eraser-delete-objects.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-eraser.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-freehand.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-highlight.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-line.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-polyline.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/draw-rectangle.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-comment.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-line-width.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-opacity.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-select.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/edit-select-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/expand-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/expand.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/font-face.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/font.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-fill-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-justify-left.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-justify-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-list-unordered.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-stroke-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-text-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-text-direction-rtl.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-text-strikethrough.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-text-underline-squiggle.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/format-text-underline.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-down-search.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-up-search.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/invertimage.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/mail-attachment.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/media-playback-pause.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/media-playback-start.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/media-playback-stop.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/object-rotate-left.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/object-rotate-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/object.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/page-2sides.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/page-zoom.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/paper-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/pin.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/player-time.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/select-rectangular.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/select.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/sidebar-show-symbolic.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/snap-angle.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/snap.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/table.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tag.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/text-speak.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/tool-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/trim-margins.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/trim-to-selection.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/user-identity.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/user.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-filter.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-pages-continuous.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-pages-facing-first-centered.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-pages-facing.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-pages-overview.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-pages-single.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-presentation.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-sidetree.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/view-split-left-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/zoom-original.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/zoom.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\actions\22"

  File ${prefix}/share/icons/breeze-dark/actions/22/application-exit.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/arrow-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/arrow-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/cell_edit.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/dvipdf.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/configure-shortcuts.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/configure-toolbars.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/dialog-cancel.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/dialog-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/dialog-ok.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-edit-verify.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-open.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-print.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-revert.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-arrow-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-arrow-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-clear-locationbar-rtl.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-copy.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-delete.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-find.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-paste.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-redo.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-rename.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-undo.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edittext.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/editor.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-bottom.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-down.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-first.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-last.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-next.svg
  File ${prefix}/share/icons/breeze-dark/actions/16/go-next-skip.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-previous.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-top.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-up.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/help-contents.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/help-contextual.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/list-add.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/list-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/process-stop.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/run-build-configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/settings-configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tab-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tab-duplicate.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tab-new-background.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tools-report-bug.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-add.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-export-secret.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-export-server.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-export.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-import.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-server-configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-certificate-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-refresh.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/window-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/question.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/kt-add-filters.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/kt-remove-filters.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/resource-group-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/password-generate.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/note.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/group.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-clear-history.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-delete-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/entry-delete.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/favorite.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/help-about.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/checkmark.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-save.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-save-as.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-clear-locationbar-ltr.svg

  # From Okular
  File ${prefix}/share/icons/breeze-dark/actions/22/bookmark-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/bookmark-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/bookmarks.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/collapse-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/collapse.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-management.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-mode-black-white.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-mode-hue-shift-negative.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-mode-hue-shift-positive.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-mode-invert-image.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-mode-invert-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/color-picker.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-export.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-import.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-open-folder.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-properties.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/document-share.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-ellipse.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-eraser.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-freehand.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-highlight.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-line.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-polyline.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-rectangle.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/draw-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-list-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-comment.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-line-width.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-opacity.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-select.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/edit-select-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/expand-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/expand.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/font.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-fill-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-justify-left.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-justify-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-list-unordered.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-stroke-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-text-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-text-direction-rtl.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-text-strikethrough.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-text-underline-squiggle.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/format-text-underline.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-down-search.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/go-up-search.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/invertimage.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/mail-attachment.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/media-playback-pause.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/media-playback-start.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/media-playback-stop.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/object-rotate-left.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/object-rotate-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/object.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/page-2sides.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/page-zoom.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/paper-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/pin.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/player-time.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/select-rectangular.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/select.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/sidebar-show-symbolic.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/snap-angle.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/snap.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/table.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tag.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/text-speak.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/tool-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/transform-browse.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/trim-margins.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/trim-to-selection.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/user-identity.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/user.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-filter.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-pages-continuous.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-pages-facing-first-centered.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-pages-facing.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-pages-overview.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-pages-single.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-presentation.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-sidetree.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/view-split-left-right.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/zoom-original.svg
  File ${prefix}/share/icons/breeze-dark/actions/22/zoom.svg


  SetOutPath "$INSTDIR\share\icons\breeze-dark\actions\32"

  File ${prefix}/share/icons/breeze-dark/actions/32/application-exit.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/configure.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/dialog-cancel.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/dialog-ok-apply.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-edit-decrypt-verify.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-edit-decrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-edit-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-edit-sign-encrypt.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-edit-sign.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-open.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-print.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-revert.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/edit-delete.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/edit-redo.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/edit-undo.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/editor.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/go-next-skip.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/view-list-text.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/view-refresh.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/window-close.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/help-about.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-save.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-save-as.svg

  # From Okular
  File ${prefix}/share/icons/breeze-dark/actions/32/bookmark-new.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/bookmark-remove.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/bookmarks.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/collapse-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/collapse.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/color-management.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/color-picker.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-export.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-import.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-open-folder.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-properties.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/document-share.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/edit-select.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/expand-all.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/expand.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/format-stroke-color.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/mail-attachment.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/media-playback-pause.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/media-playback-start.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/media-playback-stop.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/page-zoom.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/select.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/tag.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/trim-margins.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/trim-to-selection.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/view-filter.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/view-preview.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/zoom-fit-best.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/zoom-fit-width.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/zoom-original.svg
  File ${prefix}/share/icons/breeze-dark/actions/32/zoom.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\applets\22"
  # From Okular
  File ${prefix}/share/icons/breeze-dark/applets/22/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\apps\22"

  File ${prefix}/share/icons/breeze-dark/apps/22/kde.svg
  File ${prefix}/share/icons/breeze-dark/apps/22/accessories-text-editor.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\preferences\22"
  File ${prefix}/share/icons/breeze-dark/preferences/22/preferences-web-browser-shortcuts.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\preferences\32"

  File ${prefix}/share/icons/breeze-dark/preferences/32/preferences-desktop-locale.svg
  File ${prefix}/share/icons/breeze-dark/preferences/32/preferences-system-network.svg
  File ${prefix}/share/icons/breeze-dark/preferences/32/preferences-web-browser-shortcuts.svg
  File ${prefix}/share/icons/breeze-dark/preferences/32/preferences-desktop-accessibility.svg
  File ${prefix}/share/icons/breeze-dark/preferences/32/preferences-system-performance.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\apps\48"

  File ${prefix}/share/icons/breeze-dark/apps/48/internet-mail.svg
  File ${prefix}/share/icons/breeze-dark/apps/48/telepathy-kde.svg
  File ${prefix}/share/icons/breeze-dark/apps/48/usb-creator-kde.svg
  File ${prefix}/share/icons/breeze-dark/apps/48/okular.svg
  File ${prefix}/share/icons/breeze-dark/apps/48/accessories-text-editor.svg


  SetOutPath "$INSTDIR\share\icons\breeze-dark\categories\32"

  File ${prefix}/share/icons/breeze-dark/categories/32/applications-graphics.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark"

  File ${prefix}/share/icons/breeze-dark/index.theme
  File ${prefix}/share/icons/breeze-dark/icon-theme.cache

  # From Okular
  SetOutPath "$INSTDIR\share\icons\breeze-dark\devices\16"
  File ${prefix}/share/icons/breeze-dark/devices/16/input-mouse.svg
  SetOutPath "$INSTDIR\share\icons\breeze-dark\devices\22"
  File ${prefix}/share/icons/breeze-dark/devices/22/input-mouse.svg
  SetOutPath "$INSTDIR\share\icons\breeze-dark\devices\64"
  File ${prefix}/share/icons/breeze-dark/devices/64/input-mouse.svg
  File ${prefix}/share/icons/breeze-dark/devices/64/cpu.svg
  File ${prefix}/share/icons/breeze-dark/devices/64/video-display.svg

  # Mimetypes all from Okular
  SetOutPath "$INSTDIR\share\icons\breeze-dark\mimetypes\16"
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/application-octet-stream.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/application-pdf.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/image-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/text-html.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/text-plain.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/text-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/application-epub+zip.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/16/text-markdown.svg



  SetOutPath "$INSTDIR\share\icons\breeze-dark\mimetypes\22"
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/application-octet-stream.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/application-pdf.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/image-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/text-html.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/text-plain.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/text-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/application-epub+zip.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/22/text-markdown.svg


  SetOutPath "$INSTDIR\share\icons\breeze-dark\mimetypes\32"
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/application-octet-stream.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/application-pdf.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/image-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/text-html.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/text-plain.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/text-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/application-epub+zip.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/32/text-markdown.svg


  SetOutPath "$INSTDIR\share\icons\breeze-dark\mimetypes\64"
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/application-octet-stream.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/application-pdf.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/application-pkcs7-signature.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/application-vnd.oasis.opendocument.text.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/image-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/text-html.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/text-plain.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/text-x-generic.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/application-epub+zip.svg
  File ${prefix}/share/icons/breeze-dark/mimetypes/64/text-markdown.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\places\16"

  File ${prefix}/share/icons/breeze-dark/places/16/start-here-kde.svg
  File ${prefix}/share/icons/breeze-dark/places/16/folder.svg

  # From Okular
  File ${prefix}/share/icons/breeze-dark/places/16/network-server.svg
  File ${prefix}/share/icons/breeze-dark/places/16/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\places\22"

  File ${prefix}/share/icons/breeze-dark/places/22/start-here-kde.svg
  File ${prefix}/share/icons/breeze-dark/places/22/folder.svg
  File ${prefix}/share/icons/breeze-dark/places/22/network-server.svg
  File ${prefix}/share/icons/breeze-dark/places/22/user-identity.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\places\48"
  File ${prefix}/share/icons/breeze-dark/places/48/folder.svg
  File ${prefix}/share/icons/breeze-dark/places/48/network-server.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\places\64"

  File ${prefix}/share/icons/breeze-dark/places/64/start-here-kde.svg
  File ${prefix}/share/icons/breeze-dark/places/64/folder.svg
  File ${prefix}/share/icons/breeze-dark/places/64/network-server.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\status\16"

  File ${prefix}/share/icons/breeze-dark/status/16/dialog-information.svg
  File ${prefix}/share/icons/breeze-dark/status/16/user-away.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\status\22"

  File ${prefix}/share/icons/breeze-dark/status/22/dialog-information.svg
  File ${prefix}/share/icons/breeze-dark/status/22/security-high.svg
  File ${prefix}/share/icons/breeze-dark/status/22/security-low.svg
  File ${prefix}/share/icons/breeze-dark/status/22/security-medium.svg
  File ${prefix}/share/icons/breeze-dark/status/22/auth-sim-locked.svg
  File ${prefix}/share/icons/breeze-dark/status/22/dialog-question.svg
  File ${prefix}/share/icons/breeze-dark/status/22/user-away.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\status\64"

  File ${prefix}/share/icons/breeze-dark/status/64/dialog-error.svg
  File ${prefix}/share/icons/breeze-dark/status/64/dialog-password.svg
  File ${prefix}/share/icons/breeze-dark/status/64/dialog-warning.svg
  File ${prefix}/share/icons/breeze-dark/status/64/dialog-information.svg
  File ${prefix}/share/icons/breeze-dark/status/64/security-high.svg
  File ${prefix}/share/icons/breeze-dark/status/64/security-low.svg
  File ${prefix}/share/icons/breeze-dark/status/64/security-medium.svg
  File ${prefix}/share/icons/breeze-dark/status/64/dialog-question.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\emblems\8"
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-information.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-warning.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-success.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-error.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-question.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/emblem-unavailable.svg
  File ${prefix}/share/icons/breeze-dark/emblems/8/checkmark.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\emblems\16"
  File ${prefix}/share/icons/breeze-dark/emblems/16/checkmark.svg

  SetOutPath "$INSTDIR\share\icons\breeze-dark\actions\symbolic"
  File ${prefix}/share/icons/breeze-dark/actions/symbolic/send-to-symbolic.svg
  File ${prefix}/share/icons/breeze-dark/actions/symbolic/contact-new-symbolic.svg

!endif
SectionEnd
