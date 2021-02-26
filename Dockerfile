FROM rocker/shiny:4.0.3

RUN apt-get update && apt-get install \
  libcurl4-openssl-dev \
  libv8-dev \
  curl -y \
  libpq-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libxml2-dev

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Instalar paquete remotes para controlar las versiones de otros paquetes
RUN R -e 'install.packages("remotes", repos="http://cran.rstudio.com")'

# Descargar e instalar paquetes de R necesarios para el app
RUN R -e 'remotes::install_version(package = "shiny", version = "1.6.0", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "tm", version = "0.7")'
RUN R -e 'remotes::install_version(package = "SnowballC", version = "0.7.0", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "wordcloud", version = "2.6", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "RColorBrewer", version = "1.1-2", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "shinydashboard", version = "0.7.1", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "ggplot2", version = "3.3.3", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "nycflights13", version = "1.0.1", dependencies = TRUE)'
RUN R -e 'remotes::install_version(package = "dplyr", version = "1.0.4", dependencies = TRUE)'

# Copiar el app a la imagen de shinyapps /srv/shiny-server/
COPY . /srv/shiny-server/
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

RUN chown shiny:shiny /srv/shiny-server/

# Configurar permisos en caso de que sea desarrollado desde windows
RUN chmod -R 755 /srv/shiny-server/

EXPOSE 8080
