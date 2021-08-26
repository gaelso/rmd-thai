# rmd-thai: Rmarkdown setting for Thai language

## Guide for Window users. 

The demo html file is available at: https://gaelso.github.io/rmd-thai/report.html

1. System locale set to Thai
1. Install Thai compatible font system wide (R package `extrafonts`)
1. use font family in ggplot (R package `showtext`)
1. Add settings in `preamble.tex` to use fonts and and other text formatting in pdf.

### System locale

Recommend to edit at project level to avoid potential side effects on other projects.

- In your project: open/create .Rprofile with `file.edit(".Rprofile")`  
- In your file type: `Sys.setlocale("LC_CTYPE", "thai")` 
- Go to Session > Restart R

### Install fonts 

The following script install 2 Google fonts (Windows only). More available at: https://fonts.google.com/?subset=thai
One font will be used for text (roman and sf) and one for code chunks (mono).

Note: This make local copy of the fonts for TeX paths. Might duplicate the fonts but is a more portable solution.

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
 
 
Note that if `extrafont::font_import()` gives an error message `...No FontName. Skipping.` it is most probably due to a bug in the latest version of the `Rttf2pt1` package and you need to install an older version with:

    remotes::install_version("Rttf2pt1", version = "1.3.8") ## Run 1 time



### Font family for plots

Plots are generated fro R and then passed on to markdown/pandooc/LaTeX. The `showtext` package is useful to have a font inside R plots that can display thai characters.Setup looks like this:

    library(showtext)
    sysfonts::font_add_google("Sarabun", "Sarabun")
    showtext::showtext_auto()

Then add to your gggplots:

    theme(text = element_text(family = "Sarabun"))



### Settings for pdf

Recommended YAML header:

    ---
    includes:
          in_header: preamble.tex
        latex_engine: xelatex
        dev: cairo_pdf
    ---

Content of the `preamble.tex` file:

    \usepackage{xunicode}
    \usepackage{xltxtra}
    \defaultfontfeatures{Scale=MatchLowercase}
    \XeTeXlinebreaklocale "th"
    \XeTeXlinebreakskip = 0pt plus 1pt
    
    \usepackage[Latin,Thai]{ucharclasses}
    
    \usepackage{polyglossia}
    \setdefaultlanguage{english}
    \setotherlanguage{thai}
    
    
    \setsansfont{Sarabun}[
        Path=./data/Sarabun/,
        Scale=1.0,
        Extension = .ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
        ItalicFont=*-Italic,
        BoldItalicFont=*-BoldItalic
        ]
    
    \setromanfont{Sarabun}[
        Path=./data/Sarabun/,
        Extension = .ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
        ItalicFont=*-Italic,
        BoldItalicFont=*-BoldItalic
        ]
    
    
    \setmonofont{Kanit}[
        Path=./data/Kanit/,
        Scale=0.85,
        Extension = .ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
        ItalicFont=*-Italic,
        BoldItalicFont=*-BoldItalic
        ]

