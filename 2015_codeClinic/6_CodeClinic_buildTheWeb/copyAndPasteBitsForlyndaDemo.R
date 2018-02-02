# these bits are used in the lynda demo

# this goes in <head> in index.html ----
<script src="shared/jquery.js" type="text/javascript"></script>
  <script src="shared/shiny.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="shared/shiny.css"/>
  
# this goes in <body> and replaces the static <table> in index.html ----
# everything up to <article/>
  <div id="shinyHere" class="shiny-html-output"></div>
  
# save index.html and close
  
# open server.R and delete everything inside the shinyServer function ----

# start with this ---
output$shinyHere <- renderText({exportHTML})

# setup two variables
assetDirectory <- "www/_assets"
listOfAssets <- list.files(assetDirectory)
exportHTML <- ""

# this is the dynamic part
for (asset in listOfAssets) {
  assetPath <- paste0(assetDirectory,"/",asset)
  theAssetFile <- read.csv(assetPath, stringsAsFactors=FALSE)
  assetNames <- gsub("[.]"," ",names(theAssetFile))
  
  exportHTML <- paste0(exportHTML,'<table cellpadding="0">')
  exportHTML <- paste0(exportHTML, "<caption>",assetNames[1],"  course load for Graphic Design degree</caption>")
  exportHTML <- paste0(exportHTML, '<colgroup><col id="semester"><col id="credits"></colgroup>')
  exportHTML <- paste0(exportHTML, '<tr><th scope="col">',assetNames[1],'</th>')
  exportHTML <- paste0(exportHTML, '<th scope="col">',assetNames[2],'</th>')
  exportHTML <- paste0(exportHTML, '</tr>')
  for(rowIndex in 1:nrow(theAssetFile)) {
    eachRow <- theAssetFile[rowIndex,]
    rowSplitAtSpace <- strsplit(as.character(eachRow[1])," ")[[1]]
    exportHTML <- paste0(exportHTML, '<tr>')
    exportHTML <- paste0(exportHTML, '<td>')
    exportHTML <- paste0(exportHTML, '<strong>',rowSplitAtSpace[1],'</strong>')
    exportHTML <- paste(exportHTML, paste(rowSplitAtSpace[2:length(rowSplitAtSpace)],collapse=" "))
    exportHTML <- paste0(exportHTML, '</td>')
    exportHTML <- paste0(exportHTML, '<td>',as.character(eachRow[2]),'</td>')
    exportHTML <- paste0(exportHTML, '</tr>')
  }
  exportHTML <- paste0(exportHTML, '</table>')
}

