# library(shiny)

shinyUI(

    
    pageWithSidebar(
    headerPanel("Conflict Fatalities in Africa"),
    sidebarPanel(
        h3('Conflict Type'),
        radioButtons("conflictType", "Radio",
                     c("Battle-No change of territory",
                       "Remote violence",
                       "Violence against civilians",
                       "Riots/Protests",
                       "Battle-Government regains territory",
                       "Battle-Non-state actor overtakes territory")
                     ),
        sliderInput('year',label='year',value = 1997, min=1997, max=2014, step=1, sep="",
                    animate=
                        animationOptions(interval=2000, loop=TRUE,pauseButton=TRUE)
                    ),
        h3('Instructions and Sources'),
        h4('Sources'),
        p('All  data in this app comes from http://www.acleddata.com/data/ (Version 5). It\'s an interesting site and you 
          should check it out!' ),
        h4('Instructions'),
        p('This app is fairly straightforward. You can select a Conflict Type and Year or press the play button to play through all Years.'),
        strong('Note: you may experience some lagging in the graph rendering if you click \'Play\'.' ), 
        p('Based on your inputs, the country colors will change to indicate how many deaths were attributable to that Conflict Type in that Year. There\'s more information on 
          Conflict Types for the curious at http://www.acleddata.com/wp-content/uploads/2015/01/ACLED_Codebook_2015.pdf section 2.2. The descriptions are verbose, so I\'m not posting them here.'),
        p('The legend on the map sets the lightest color to be the lowest value for that Conflict Type/Year combination and the highest value to be the reddest color. 
So, be careful when comparing the color of a country at different times or in different conflict types, as "red" just means that a country had the highest 
fatality count for that specific Conflict Type and Year.'),
        p('Gray countries do not have data for the given Conflict Type/Year.')
    ),
    mainPanel(
        plotOutput("map",width=600, height=600)
    )
))