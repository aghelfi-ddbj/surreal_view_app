FROM rocker/shiny
RUN R -e "install.packages(c('DT', 'shiny', 'shinydashboard'), repos='https://cloud.r-project.org/')"
#copy the current folder into the path of the app
COPY . /usr/local/src/app
#set working directory to the app
WORKDIR /usr/local/src/app
EXPOSE 3201
#set the unix commands to run the app
CMD ["R", "-e", "shiny::runApp('R/surrealViewApp.R', port = 3201, host='0.0.0.0')"]

