# Server

server = function(input, output, session){
  mydf = reactiveVal()
  min_gap = 0.01

  observeEvent(input$df, {
    get_df(input$df$datapath, "clean_data_full")
    mydf(read.csv("clean_data_full.csv", header = T))
    
    updatePickerInput(session, "protein",
                      choices = unique(c(mydf()$atom1, mydf()$atom2)),
                      selected = unique(c(mydf()$atom1, mydf()$atom2)))
    
    updateSliderInput(session, "threshold",
                      min = round(min(mydf()$distance), 3) - 0.01,
                      max = round(max(mydf()$distance), 3) + 0.01)
  })
  
  observe({
    minval = round(min(mydf()$distance), 3)
    maxval = round(max(mydf()$distance), 3)
    
    if (input$threshold[2] - input$threshold[1] < min_gap) {
      new_range = input$threshold

      if (new_range[2] <= minval) {
        new_range[2] = minval + 0.01
      } else if (new_range[1] >= maxval){
        new_range[1] = maxval - 0.01
      } else{
        new_range[2] = new_range[1] + min_gap
      }
      
      updateSliderInput(session, "threshold", value = new_range)
    }
  })
  
  output$full_name_plot = renderPlot({
    plot_linker(mydf(), input$threshold[1], input$threshold[2],
                input$protein)
  })
}

