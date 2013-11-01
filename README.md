dropboxconflicts
================

Check for Dropbox Conflicts using Terminal and/or launchd and [terminal-notifier][].

I made a version of this using Growl awhile ago ([find it here](https://github.com/tjluoma/launchd-check-for-dropbox-conflicts)) but I’ve since grown to prefer Notification Center, because clicking the notification can open the “Saved Search” in Finder if you use [terminal-notifier][tn].

## Installation and Configuration ##

1.	Install [terminal-notifier]. Easiest way is via [Homebrew](http://mxcl.github.com/homebrew/).

2.	Download the [saved search][] file, make sure it’s named “dropbox-conflicts.savedSearch” and then save it to either one of these locations (note: you may have to create the folders):

	* ${HOME}/Dropbox/Application Support/

	* ${HOME}/Library/Saved Searches/

3. Download the [launchd plist] and make sure it’s named “com.tjluoma.dropbox-conflicts.plist” and save it to “$HOME/Library/LaunchAgents/“. 

4. Download the [shell script] and make sure it’s named `dropbox-conflicts.sh` and save it to somewhere in your $PATH such as `/usr/local/bin/dropbox-conflicts.sh` and make it executable: 

## Post Installation ##

After the files are in place, you need to do two more things:

First, make the shell script executable:

		chmod 755 /usr/local/bin/dropbox-conflicts.sh

Second, I suggest a reboot, but if you want to try doing this without that, try entering this line in Terminal: 

		launchctl load ~/Library/LaunchAgents/com.tjluoma.dropbox-conflicts.plist




## Also works well with... ##

My other script and Keyboard Maestro setup for comparing Dropbox duplicates: [km-diff-dropbox-duplicates].


<!-- Footnotes and References -->

[terminal-notifier]: https://github.com/alloy/terminal-notifier

[launchd plist]: https://github.com/tjluoma/dropboxconflicts/blob/master/com.tjluoma.dropbox-conflicts.plist

[saved search]: https://github.com/tjluoma/dropboxconflicts/blob/master/dropbox-conflicts.savedSearch

[shell script]: https://github.com/tjluoma/dropboxconflicts/blob/master/dropbox-conflicts.sh

[km-diff-dropbox-duplicates]: https://github.com/tjluoma/km-diff-dropbox-duplicates
