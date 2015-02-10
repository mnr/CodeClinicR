# published at https://niemannross.shinyapps.io/codeClinic_buildTheWeb/
shinyServer(function(input, output) {

  assetDirectory <- "www/assets"
  listOfAssets <- list.files(assetDirectory)
  
  for (asset in listOfAssets) {
    assetPath <- paste0(assetDirectory,"/",asset)
    theAssetFile <- read.csv(assetPath, stringsAsFactors=FALSE)
    assetNames <- gsub("[.]"," ",names(theAssetFile))
    
    exportHTML <- '<table cellpadding="0">'
    exportHTML <- paste0(exportHTML, "<caption>",assetNames[1],"  course load for Graphic Design degree</caption>")
    exportHTML <- paste0(exportHTML, '<colgroup><col id="semester"><col id="credits"></colgroup>')
    exportHTML <- paste0(exportHTML, '<tr><th scope="col">',assetNames[1],'</th>')
    exportHTML <- paste0(exportHTML, '<th scope="col">',assetNames[2],'</th>')
    exportHTML <- paste0(exportHTML, '</tr>')
    for(eachRow in asset) {
      rowSplitAtSpace <- strsplit(eachRow[1]," ")
      exportHTML <- paste0(exportHTML, '<tr>')
      exportHTML <- paste0(exportHTML, '<td>')
      exportHTML <- paste0(exportHTML, '<strong>',rowSplitAtSpace[1],'</strong>')
      exportHTML <- paste(exportHTML, rowSplitAtSpace[2:length(rowSplitAtSpace)])
      exportHTML <- paste0(exportHTML, '</td>')
      exportHTML <- paste0(exportHTML, '<td>',eachRow[2],'</td>')
      exportHTML <- paste0(exportHTML, '</tr>')
    }
    exportHTML <- paste0(exportHTML, '</table>')
    
    output$shinyHere <- renderHTML({exportHTML})
  }
  
})
