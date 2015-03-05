# searching for directories and jpeg files in them

# requires imagemagick
# http://www.imagemagick.org

library(tools) # need tools for file_ext

# Search Directories for Images --------------------------------------------------------
# recursively search directories for image files
directoryToStart <- "/Users/mnr/git/Code_Clinic_for_R"
foundImages <- list.files(path = directoryToStart,
           pattern = "(jpg|jpeg|png|gif|tif)$",
           full.names = TRUE,
           recursive = TRUE,
           ignore.case = TRUE,
           include.dirs = TRUE)

#convert the list to a dataframe
imageList <- as.data.frame(foundImages,stringsAsFactors = FALSE)

imageList$filename <- basename(imageList[,"foundImages"])
imageList$directory <- dirname(imageList[,"foundImages"])
imageList$ext <- file_ext(imageList[,"foundImages"])

# build the directory to sort images into
makeDirectoryHere <- "/Users/mnr/Desktop/CodeClinic"
dir.create(makeDirectoryHere)

# Find Image Data -----------------------------------------
#grab the IPTC data for each image
for (imageIndex in 1:nrow(imageList)) {
  # this uses imagemagick to get the data
  tmp.sysIPTC <- system2("convert",args=paste(imageList$foundImages[imageIndex],"8BIMTEXT:-"),stdout=TRUE) 
  # but there's more here than we need, so subset out just the caption
  tmp.captionLine <- tmp.sysIPTC[grepl("Caption",tmp.sysIPTC,useBytes=TRUE)]
  # then just get the caption string
  tmp.caption <- sub('(.*\\\")(.*)(\\\")',"\\2",tmp.captionLine,perl=TRUE,useBytes=TRUE)
  imageList$caption[imageIndex] <- tmp.caption
  
  
  # Sort into directories -----------------------------
  
  # sort the images into the directory
  firstCharCaption <- substr(imageList$caption[imageIndex],1,1)
  putItHere <- file.path(makeDirectoryHere,firstCharCaption)
  dir.create(putItHere,showWarnings=FALSE)
  file.copy(from = imageList$foundImages[imageIndex],
            to=file.path(putItHere,paste0(imageList$caption[imageIndex],".",imageList$ext[imageIndex])))
}




