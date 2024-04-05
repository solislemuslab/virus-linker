library(shiny)
library(dplyr)
library(stringr)
library(ggraph)
library(igraph)
library(ggiraph)
library(shinyWidgets)

source("./get_data.R")
source("./linker.R")

set_girafe_defaults(
  # opts_hover = opts_hover(css = css_default_hover),
  opts_zoom = opts_zoom(min = 1, max = 4),
  # opts_tooltip = opts_tooltip(css = "padding:3px;background-color:#333333;color:white;"),
  opts_sizing = opts_sizing(rescale = TRUE),
  opts_toolbar = opts_toolbar(saveaspng = FALSE, position = "bottom")
)
