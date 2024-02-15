# UI

ui <- fluidPage(
  # theme = shinytheme("cerulean"),
  navbarPage(
    "Virus Linker",
    sidebarLayout(
      sidebarPanel(
        width = 4,
        wellPanel(
          fileInput(
            inputId = "df",
            label = "User Data",
            accept = c(
              ".txt"
            ),
            placeholder = "No file selected",
            width = "100%"
          ),
          
          sliderInput(
            inputId = "threshold",
            label = "Threshold",
            min = 0,
            max = 1,
            value = c(0, 1),
            step = 0.0001
          ),
          
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
        fluidRow(
          h3("Full Name"),
          plotOutput("full_name_plot")
        ),
        fluidRow(
          h3("Position"),
          plotOutput("number_name_plot")
        )
      )
    )
  )
)
