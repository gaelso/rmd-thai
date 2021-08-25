
## For Windows, check if fonts are installed and install if not

if (Sys.info()['sysname'] == "Windows") {
  
  names(windowsFonts())
  
  dir.create("data", showWarnings = F)
  
  if (!("Sarabun" %in% names(windowsFonts()) & dir.exists("data/Sarabun"))) {
    dir.create("data", showWarnings = F)
    download.file(
      url = "https://fonts.google.com/download?family=Sarabun", 
      destfile = "data/Sarabun.zip", 
      mode = "wb"
    )
    unzip(zipfile = "data/Sarabun.zip", exdir = "data/Sarabun")
    extrafont::font_import(paths = "data", recursive = T, pattern = "Sarabun", prompt = F)
    extrafont::loadfonts(device = "win")
  } ## END IF check font
  
  
  if (!("Kanit"  %in% names(windowsFonts()) & dir.exists("data/Kanit"))) {
    dir.create("data", showWarnings = F)
    download.file(
      url = "https://fonts.google.com/download?family=Kanit", 
      destfile = "data/Kanit.zip", 
      mode = "wb"
    )
    unzip(zipfile = "data/Kanit.zip", exdir = "data/Kanit")
    extrafont::font_import(paths = "data", recursive = T, pattern = "Kanit", prompt = F)
    extrafont::loadfonts(device = "win")
  } ## END IF check font
  
} ## END IF check OS
