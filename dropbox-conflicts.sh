#!/bin/zsh
#
#	Author:	Timothy J. Luoma
#	Email:	luomat at gmail dot com
#	Date:	2011-03-24
#
#	Purpose: Find conflicted copies in Dropbox

SOUND='Ping'

	# change this if your Dropbox is somewhere else
DIR="$HOME/Dropbox"

SS1="${HOME}/Dropbox/Application Support/dropbox-conflicts.savedSearch"

SS2="${HOME}/Library/Saved Searches/dropbox-conflicts.savedSearch"



####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
#
#		You shouldn’t have to change anything below this.
#



NAME="$0:t:r"


if [ -x '/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier' ]
then

	alias terminal-notifier='/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier'

elif (( $+commands[terminal-notifier] ))
then
		:
		# the 'terminal-notifier' command is somewhere in the PATH
else
		echo "$NAME: Failed to find terminal-notifier in $PATH or in the /Applications/terminal-notifier.app."
		exit 1
fi

if [[ "$SHLVL" = "1" ]]
then
		LAUCHD='yes'

else
		LAUCHD='no'
fi


	# this will look for files with the name "'s conflicted copy YYYY-MM-DD" in it
	# except this in the Trash or the .dropbox.cache folder.
DUPS=$(find "$DIR" -path "*(*'s conflicted copy [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]*" -print |\
		egrep -v "$DIR/.dropbox.cache|$HOME/.Trash/")


if [ -e "$SS1" ]
then
		SS="$SS1"

elif [ -e "$SS2" ]
then
		SS="$SS2"
else
		SS=""
fi


	# this will count the number of lines (wc) and get rid of anything except the
	# number (tr) since 'wc' inexplicably adds blank spaces before its output.

if [[ "$DUPS" == "" ]]
then
	COUNT=0
else
	COUNT=$(echo "$DUPS"| wc -l | tr -dc '[0-9]')
fi


if [ "$COUNT" = "0" ]
then
		if [ "$LAUCHD" = "no" ]
		then
				echo "$NAME: No conflicts found"
		fi

		exit 0
fi

# If we get here, the conflict count is > 0

if [ "$LAUCHD" = "no" ]
then
		if [ "$COUNT" = "1" ]
		then
				echo "	$NAME: Found one conflict"
		else
				echo "	$NAME: Found $COUNT conflicts"
		fi

		if [ -e "SS" ]
		then
				open -a Finder "${SS}"
		fi

		echo "$DUPS"

		exit 0
fi

if [ "$COUNT" = "1" ]
then
		MSG="Found 1 file conflict"
		TITLE='Dropbox Conflict Found'
else
		MSG="Found $COUNT file conflicts"
		TITLE='Dropbox Conflicts Found'
fi




if [ -e "$SS" ]
then

		terminal-notifier \
			-sender com.getdropbox.dropbox \
			-sound "$SOUND" \
			-activate com.apple.Finder \
			-message "$MSG"  \
			-title "$TITLE" \
			-group "$NAME" \
			-subtitle "Click to see conflicts in Finder" \
			-execute "/usr/bin/open -a Finder \"${SS}\""
else
		terminal-notifier \
			-sender com.getdropbox.dropbox \
			-sound "$SOUND" \
			-message "$MSG"  \
			-title "$TITLE" \
			-group "$NAME" \
			-subtitle "$NAME"
fi

exit 0

# EOF
