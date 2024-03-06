# UI

ui = fluidPage(
  # theme = shinytheme("cerulean"),
  navbarPage(
    "Virus Linker",
    sidebarLayout(
      sidebarPanel(
        width = 4,
        wellPanel(
          # Upload data
          fileInput(
            inputId = "df",
            label = "User Data",
            accept = c(
              ".txt"
            ),
            placeholder = "No file selected",
            width = "100%"
          ),
          
          # Select distance range
          sliderInput(
            inputId = "threshold",
            label = "Distance Threshold",
            min = 0,
            max = 5,
            value = c(0, 5),
            step = 0.001
          ),
          
          # Select proteins
          pickerInput(
            inputId = "protein",
            label = "Proteins",
            choices = c("B", "C"),
            multiple = T,
            options = list(`live-search` = T,
                           `actions-box` = T)
          ),
        )
      ),
      mainPanel(
        plotOutput("full_name_plot")
      )
    )
  )
)
