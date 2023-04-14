FROM rocker/shiny
RUN R -e "install.packages(c('DT', 'shiny', 'shinydashboard'), repos='https://cloud.r-project.org/')"
COPY . /usr/local/src/app
WORKDIR /usr/local/src/app
EXPOSE 3201
CMD ["R", "-e", "shiny::runApp('R/surrealViewApp.R', port = 3201, host='0.0.0.0')"]

