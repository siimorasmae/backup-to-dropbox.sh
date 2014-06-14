#!/bin/bash

### backup-to-dropbox.sh v1.0
#
# Copyright 2014 Siim Orasmäe
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
###
#
# Usage: backup-to-dropbox.sh [DIRECTORY] [-f]
#
#	-f	Force full backup
#
# This script makes incremental backups in the form of
# backup-HOSTNAME-DATETIME.tar.gz files and uploads them to Dropbox.
#
# NOTICE: *Must have Dropbox-Uploader installed and set up to work!*
#
###

REMOTE_DIR="/"
DROPBOX_UPLOADER="dropbox_uploader.sh"

TMP_DIR="/tmp"
BACKUP_TIMESTAMP="$HOME/.backup_timestamp"

#######################################################################

if [ ! $1 ]
then
		echo "USAGE: $0 [DIRECTORY]"
		echo "What directory should I back up?"
		exit 2
fi

# Generate a filename for the backup archive
BACKUP_FILENAME="backup-"$(hostname -s)"-"$(date "+%F-%H-%M-%S")".tar.gz"

# Full backup if no timestamp or forced, otherwise exit if no changes or
# do an incremental backup of files changed since last backup
if [ ! -e $BACKUP_TIMESTAMP -o "$2" == "-f" ]
then
		echo "FULL backup: No timestamp detected or forced"
		echo -n " > Creating archive of \"$1\"... "
		find $1 -xdev -print0 | tar czf $TMP_DIR/$BACKUP_FILENAME --null -T - &> /dev/null
		echo "DONE"
else
		if [ ! $(find $1 -xdev -newer $BACKUP_TIMESTAMP) ]
		then
		  echo "NO backup: No changes since last backup"
			exit 0
		else
			LAST_BACKUP=$(date -r $BACKUP_TIMESTAMP "+%F %T")
			echo "INCREMENTAL backup: Last backup was at $LAST_BACKUP"
			echo -n " > Creating archive of changed files... "
			find $1 -xdev -newer $BACKUP_TIMESTAMP -print0 | tar czf $TMP_DIR/$BACKUP_FILENAME --null -T - &> /dev/null
			echo "DONE"
		fi
fi

# Upload the archive file to Dropbox
$DROPBOX_UPLOADER upload $TMP_DIR/$BACKUP_FILENAME $REMOTE_DIR

# Delete the tmp file
echo -n " > Performing cleanup... "
rm $TMP_DIR/$BACKUP_FILENAME
echo "DONE"

# Let it be known that the backup has taken place!
touch $BACKUP_TIMESTAMP

exit 0
