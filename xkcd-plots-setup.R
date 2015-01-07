# Setup instructions follow http://cran.r-project.org/web/packages/xkcd/vignettes/xkcd-intro.pdf
# Torres-Manzanera, Emilio. "xkcd: An R Package for Plotting XKCD Graphs."

# Libraries ####
library(ggplot2)
library(extrafont)
library(xkcd)

# xkcd font install ####

# Checking if xkcd fonts is installed
# From page 3 of xkcd vignette
if( 'xkcd' %in% fonts()) {
    p <- ggplot() + geom_point(aes(x=mpg, y=wt), data=mtcars) +
        theme(text = element_text(size = 16, family = "xkcd"))
    } else {
        warning("xkcd fonts not installed!")
        p <- ggplot() + geom_point(aes(x=mpg, y=wt), data=mtcars)
    }
p

# Font was downloaded from https://github.com/ipython/xkcd-font
# Converted to .ttf format for use with extrafont package
font_import(paths="./Fonts", prompt=FALSE)

# Checking if it worked
fonts()
fonttable()

# Reloading fonts
if(.Platform$OS.type != "unix") {
    ## Register fonts for Windows bitmap output
    loadfonts(device="win")
    } else {
        loadfonts()
}

