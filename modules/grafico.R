# Modulo gráfico de vuelos -------------------------------------------------

## Segmento del UI
graficoUI <- function(id) {
  ns <- NS(id)
  
  plotOutput(ns("vuelo"))
  
}

## Segmento del server

grafico <- function(input, output, session, aerolinea) {
  
  by_dest <- group_by(flights, dest) %>% 
    filter(carrier == aerolinea)
  
  delay <- summarize(
    by_dest,
    conteo = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  )
  
  delay <- filter(delay, conteo > 20, dest != "HNL")
  
  output$vuelo <- renderPlot({
    ggplot(data = delay, mapping = aes(x = dist, y = delay)) + 
      geom_point(aes(size = conteo, alpha = 0.3)) +
      geom_smooth(se = FALSE)
    
  })
  
}
