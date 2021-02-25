# ui

library(shiny)

# Encabezado --------------------------------------------------------------

header <- dashboardHeader(
  title = "Módulos"
)

# Sidebar -----------------------------------------------------------------

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Nube de palabras", tabName = "nube", icon = icon("dashboard")),
    menuItem("Gráfico vuelos", tabName = "texto", icon = icon("align-left"))
  )
)

# Cuerpo ------------------------------------------------------------------
body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "nube",
      fluidRow(
          nubeUI("nube_palabras")
      ),
      
      fluidRow(
        box(
          deslizadorUI("deslizador_nuevo")
          # deslizadorUI("deslizador_segudno")
        )
      )
    ),
    
    tabItem(
      tabName = "texto",
      fluidRow(
        column(
          width = 4,
          seleccionadorUI("carrier_seleccionador")
        ),
        column(
          width = 8,
          graficoUI("grafico_aviones")
        )
      )
    )
  )
)

## App completo ----------------------------------------------------------------
dashboardPage(
  skin = "black",
  header,
  sidebar,
  body
)