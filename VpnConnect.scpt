-- 1. Place in ~/Library/Scripts and enable the Applescript menu via the Applescript Editor
-- 2. Substitute sofTokenKey with your "SofToken II" PIN
-- 3. Open Security & Privacy System Preferences, go to Privacy, Accessibility
-- 4. Enable Applescript Editor and System UI Server
-- 5. Trigger script from the menu
-- 6. Enjoy being connected

set sofTokenKey to "11111111"
on quitApp(theAppName)
	tell application "System Events"
		set processExists to exists process theAppName
	end tell
	if processExists is true then
		try
			tell application theAppName
				quit
			end tell
		end try
		delay 3
	end if
end quitApp
try
	do shell script "ping -o www.apple.com"
on error
	set theAlertText to "No internet connection"
	set theAlertMessage to "Please check the internet connectivity. Re-run the script after correcting the internet connection"
	display alert theAlertText message theAlertMessage as critical buttons {"Ok"} default button "Ok" cancel button "Ok"
end try
quitApp("SofToken II")
quitApp("Cisco AnyConnect Secure Mobility Client")
tell application "SofToken II"
	activate
end tell
repeat until application "SofToken II" is running
	delay 1
end repeat
tell application "System Events"
	repeat until (window 1 of process "SofToken II" exists)
		delay 1
	end repeat
	tell process "SofToken II"
		tell window 1
			tell text field 1
				set value to sofTokenKey
			end tell
			click button "Go"
		end tell
	end tell
end tell
delay 1
quit application "SofToken II"
delay 1
tell application "Cisco AnyConnect Secure Mobility Client"
	activate
end tell
repeat until application "Cisco AnyConnect Secure Mobility Client" is running
	delay 1
end repeat
tell application "System Events"
	repeat until (window 1 of process "Cisco AnyConnect Secure Mobility Client" exists)
		delay 1
	end repeat
	repeat until (window "Cisco Anyconnect | Bangalore - SSL" of process "Cisco AnyConnect Secure Mobility Client" exists)
		delay 1
	end repeat
	tell window "Cisco Anyconnect | Bangalore - SSL" of process "Cisco AnyConnect Secure Mobility Client"
		keystroke "v" using {command down}
	end tell
	keystroke return
	repeat until (window "Cisco Anyconnect - Banner" of process "Cisco AnyConnect Secure Mobility Client" exists)
		delay 1
	end repeat
	click button "Accept" of window "Cisco Anyconnect - Banner" of process "Cisco AnyConnect Secure Mobility Client"
end tell

