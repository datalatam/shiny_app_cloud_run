FROM rocker/shiny:4.0.3

RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libv8-dev \
  curl  

# Download and install library
RUN R -e "install.packages(c('shiny'))"

# copy the app to the image COPY shinyapps /srv/shiny-server/
COPY . /srv/shiny-server/
COPY shiny-server.conf /etc/shiny-server/shiny-server.conf

# Fix permissions in case this was deployed from Windows
RUN chmod -R 755 /srv/shiny-server/

EXPOSE 8080

