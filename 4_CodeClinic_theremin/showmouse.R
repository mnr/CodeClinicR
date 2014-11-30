# note: having problems finding graphic packages compatible with macintosh mavericks
# requires developer tools from Xcode
# macintosh requires http://xquartz.macosforge.org/landing/
# tutorial at http://www.sciviews.org/_rgui/tcltk/
# http://www.r-project.org/conferences/DSC-2001/Proceedings/Dalgaard.pdf

require(tcltk)

handleMouse <- function(x,y) {
  print(c(x,y))
}

tt<-tktoplevel()
tkbind(tt,"<B1-Motion>", handleMouse )
tkfocus(tt)




