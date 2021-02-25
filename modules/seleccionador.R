# Modulo deslizador -------------------------------------------------

## Segmento del UI
seleccionadorUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    selectInput(ns("carrier_input"),
                label = "Carrier:",
                choices = unique(flights$carrier))
  )
}

## Segmento del server
seleccionador <- function(input, output, session) {
  return(
    list(
      carrier_input = reactive({input$carrier_input })
      )
  )
}


