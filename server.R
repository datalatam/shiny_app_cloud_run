# server

server <- function(input, output, session) {
  
  # Llamados a modulos simple
  callModule(module = deslizador, id =  "deslizador_segundo")
  
  # Llamar módulo en objeto para traer selecciones
  carriers <- callModule(module = seleccionador, id = "carrier_seleccionador")
  
  observeEvent(
    carriers$carrier_input(), {
      callModule(module = grafico,
                 id = "grafico_aviones",
                 aerolinea = carriers$carrier_input())
    }
  )
  
  # Modulo en un objeto
  deslizadores <- callModule(module = deslizador, id = "deslizador_nuevo")
  
  # Deslizadores lo tenemos como una lista con dos funciones
  
  observeEvent(
    (deslizadores$frec_input() | deslizadores$max_input()), {
      
      callModule(module = nube,
                 id = "nube_palabras",
                 frecuencia = deslizadores$frec_input(),
                 maximo = deslizadores$max_input())  
    }

  )
  
  
}