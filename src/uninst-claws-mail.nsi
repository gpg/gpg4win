# uninst-claws-mail.nsi - Installer snippet.        -*- coding: latin-1; -*-
# Copyright (C) 2005, 2007 g10 Code GmbH
#               2015, Intevation GmbH
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


# Special installer section that uninstalls claws and its libaries
Section /o "-uninst_claws_mail" SecUninstClawsMail
!include "uninst-claws-mail-cmds.nsi"
SectionEnd

# And the normal uninstall part in case claws was not removed during
# installation
Section "-un.claws_mail"
!include "uninst-claws-mail-cmds.nsi"
SectionEnd
