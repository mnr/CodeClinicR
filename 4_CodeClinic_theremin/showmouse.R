# note: having problems finding graphic packages compatible with macintosh mavericks
# requires developer tools from Xcode
# macintosh requires http://xquartz.macosforge.org/landing/
# tutorial at http://www.sciviews.org/_rgui/tcltk/

require(tcltk)      # Load the tcltk package

tt <- tktoplevel()  # Create a new toplevel window

# Create a button whose function (command) is to destroy the window
OK.but <- tkbutton(tt, text = "OK", command = function() tkdestroy(tt))

# Place the button on the window, using the grid manager
tkgrid(OK.but)

# Now, bring the window to the focus, using tkfocus.  (This will not work
# if the code is run from Rgui, because the focus will automatically
# return to Rgui, but it will work if the code is copied and pasted into
# a script file and run using
# Rterm < scriptfile.R > scriptfile.Rout
tkfocus(tt)
