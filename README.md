# Noties
This is my test application
Everything is done in Code
For storage I used CoreData and UserDefaults
MapKit and PHAssets implemented for using maps and photo gallery
Used MVVM Architecture (sort of)
ViewController asks ViewModel for information, ViewModel goes for Data, and gives back information in completion closure, then tells VC that it can update Views. Views use delegates, to tell VC than some action was initiated.


Here's most of features

Login & Registration screen:
-Check if user exists
-Check if user already registered
-Check if pass meet conditions
-Check if 2 passwords match
-Check if pass is correct 
-Buttons don’t work until all conditions are met
-Can remember user
-Highlight all errors

Main screen:
-Remembers user
-Can show multiple users only their notes
-Shows only user’s notes
-No notes warning sign
-New notes showed on the top
-Plus to add the note
-Tap the note to edit 
-If note doesn’t have added location - navigation doesn’t show
-If note has added location - tap navigates on it

Add/edit screen:
-Can add photo from library
-Can always edit all fields
-You can add no location to note
-You can add default (your) location to note
-Can change location if wanted
-Can delete note

Map screen:
-Shows all notes that have location
-Show note name and Date added
-Can edit and delete notes directly 
