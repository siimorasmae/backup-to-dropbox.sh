# backup-to-dropbox.sh

Copyright 2014 Siim Orasmäe.

A Bash script to create incremental backups and upload them to [Dropbox](http://www.dropbox.com/) via [Dropbox_Uploader](https://github.com/andreafabrizi/Dropbox-Uploader). Primarily meant to be used on systems where the official Dropbox app has a hissy fit and says "architecture not supported".

### Requirements

A working install of [Dropbox_Uploader](https://github.com/andreafabrizi/Dropbox-Uploader).

### Usage

```
	./backup-to-dropbox.sh [DIRECTORY] [-f]
```

* `-f`	force full backup

### Contact

Visit [serenity.ee](http://www.serenity.ee)

---

### Licence

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
