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


### Q: “I have it installed, but how does it work?” ##

A: I’m glad you asked. Every five minutes, `launchd` will check for files in your Dropbox have the words “conflicted copy” in the filename, which is what Dropbox uses when conflicts are created. If it finds any, it will show a notification in Mountain Lion or Mavericks’ Notification Center. It will look like this:

![](Notification-Center.png)

If you click on the notification, it will open a “Saved Search” in Finder which will also show any files with the words “conflicted copy” in the filename.

Combine this with [km-diff-dropbox-duplicates] -- my other script and Keyboard Maestro setup for comparing Dropbox duplicates -- and you can compare the conflicted copy with its original. 

### Q: “Ok, but what about Terminal?” ##

A: If you run `dropbox-conflicts.sh` from the command line, it will show you the duplicate files, and then open the saved search in Finder.

### Q: “I have a file that has the words ‘conflicted copy’ in the filename, but it’s not a Dropbox conflicted copy…”

A: Yeah, you’re going to have to rename that, or else it will continually confuse this script. Sorry.


<!-- Footnotes and References -->

[terminal-notifier]: https://github.com/alloy/terminal-notifier

[launchd plist]: https://github.com/tjluoma/dropboxconflicts/blob/master/com.tjluoma.dropbox-conflicts.plist

[saved search]: https://github.com/tjluoma/dropboxconflicts/blob/master/dropbox-conflicts.savedSearch

[shell script]: https://github.com/tjluoma/dropboxconflicts/blob/master/dropbox-conflicts.sh

[km-diff-dropbox-duplicates]: https://github.com/tjluoma/km-diff-dropbox-duplicates
