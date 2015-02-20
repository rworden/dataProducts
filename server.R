library(rworldmap)
library(plyr)      

acledStandard<-read.csv("data/ACLED Version 5 All Africa 1997-2014_dyadic_Updated_csv.csv")

z <- ddply(acledStandard,.(COUNTRY,YEAR,EVENT_TYPE),summarize,fatalities=sum(FATALITIES)) 
#remove these EVENT_TYPES because they don't vary that much and aren't interesting
z <- z[z$EVENT_TYPE != 'Headquarters or base established' & 
           z$EVENT_TYPE != 'Non-violent transfer of territory' &
           z$EVENT_TYPE != 'Non-violent activity by a conflict actor',]        

shinyServer(
    function(input, output) {

        zProd <- reactive({
            z<-z[z$YEAR==input$year,]
            z<-z[z$EVENT_TYPE==input$conflictType,]    
            z <- joinCountryData2Map( z, 
                nameJoinColumn="COUNTRY", 
                joinCode="NAME" )
            })

        map<-reactive({mapCountryData( zProd(), 
                     nameColumnToPlot='fatalities',
                     mapTitle='Fatalities',
                     catMethod='pretty', 
                     borderCol = 'black',
                     missingCountryCol = 'grey',
                     oceanCol = 'deepskyblue3',
                     mapRegion="africa",

                     addLegend = TRUE,
                     #xlim = c(-10,45),
                     #ylim = c(-50,50),
                     lwd=2)})
        
        output$map<-renderPlot( 
            map()
            )
    }
)