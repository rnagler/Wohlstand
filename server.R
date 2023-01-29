# ~rnaR/wohlstandShinyDashboard
# Version 6 2023-01-29 ger
## server.R ##
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(glue)
library(tidyverse)
library(scales)
library(ineq)
#setwd("~/rnaR/wohlstandShinyDashboard")
message(glue("server start for all sessions, Time: {Sys.time()}"))

# global constants
anzSpieler <- 1000
anzWeek <- 53
randNormMean <- 1.03
randNormSd <- 0.2
randAddNormMean <- 0.03
randAddNormSd <- 0.2
startKap <- 1.0
leverage <- 1.0
obergrenzeProzent <- 80.0
steuerProzent <- 80.0
## end statements server run once
message(glue("entering server function"))

server <- function(input, output, session) {
  # those statements run once per session
  #### define functions for server session
  
  yearSim <- function(mw, sd, addMw, addSd) {
    # ein jahr auf m durchsimulieren
    message(glue("server yearSim begin"))
    
    # Vermögensentwicklung rechnen
    for (i in 2:ncol(m)) {
      # for-loop over columns
      x <- rnorm(anzSpieler, mean = mw, sd = sd) # multiplikative Zufallszahlen
      xAdd <- rnorm(anzSpieler, mean = addMw, sd = addSd) # additive Zufallszahlen
      m[, i] <<- (m[,i-1] * leverage * x) + xAdd + (m[,i-1] * (1.0 - leverage))
      # newWealth = (oldWealth * leverage * mulFac) + addFac + unused part of oldWealth (= oldWealth *(1.0 - leverage) )
      # old:     m[, i] <<- m[, i - 1] * x # nur mult
      # old2: m[, i] <<- m[,i-1] * x + xAdd
    }
    
    for (i in 1:ncol(m)) {
      # for-loop over columns
      weekMedian[i] <<- median(m[, i])
      weekMin[i] <<- min(m[, i])
      weekMax[i] <<- max(m[, i])
      weekMean[i] <<- mean(m[, i])
      weekSum[i] <<- sum(m[, i])
    }

    # endewerte
    firstWeekVermoeg <<- m[, 1]
    lastWeekVermoeg <<- m[, anzWeek]
    lastProzAnteil <<- lastWeekVermoeg * 100 / weekSum[anzWeek]

    # umverteilung
    sortLastWeekVermoeg <<- sort(lastWeekVermoeg) # neu rna 20.3.2022
    obergrenze <<- sortLastWeekVermoeg[trunc(obergrenzeProzent*anzSpieler/100)] # rna lorenzumv 2022-03-25
#    obergrenze <<- round(weekMedian[anzWeek] * obergrenzeProzent / 100.0) #default 100% des aktuellen Medians aller Vermögen
#    obergrenze <<- round(weekMax[anzWeek] * obergrenzeProzent / 100.0) #default 50% des reichsten Vermögens
    message(glue("yearSim, obergrenze: {obergrenze}"))
    gesamtVermoegenAnf <<- sum(firstWeekVermoeg)
    gesamtVermoegenEnd <<- sum(lastWeekVermoeg)

    # inequality nach: https://www.rpubs.com/nowo/546793
    # install.packages("ineq")
    # compute gini
    giniAnf <<- Gini(m[, 1], corr = FALSE, na.rm = TRUE)
    giniEnd <<- Gini(lastWeekVermoeg, corr = FALSE, na.rm = TRUE)
    # compute lorenz
    lorenzAnf <<- Lc(firstWeekVermoeg)
    lorenzEnd <<- Lc(lastWeekVermoeg)
    # p*100 percent have L(p)*100 percent of x.

    # anschauliche scalare
    anteilReichsterAnf <<- 1 - lorenzAnf$L[anzSpieler]
    anteilReichste10Anf <<- 1 - lorenzAnf$L[anzSpieler*0.9 +1]
    anteilAermste50Anf <<- lorenzAnf$L[anzSpieler*0.5 +1]
    anteilAermste10Anf <<- lorenzAnf$L[anzSpieler*0.1 +1]
    anteilAermsterAnf <<- lorenzAnf$L[2]
    
    anteilReichsterEnd <<- 1 - lorenzEnd$L[anzSpieler]
    anteilReichste10End <<- 1 - lorenzEnd$L[anzSpieler*0.9 +1]
    anteilAermste50End <<- lorenzEnd$L[anzSpieler*0.5 +1]
    anteilAermste10End <<- lorenzEnd$L[anzSpieler*0.1 +1]
    anteilAermsterEnd <<- lorenzEnd$L[2]

    rechneUmv()    # hier wird umverteilt und alle umv Werte errechnet
    # combine stat vectors into dataframe for line plotting
    s <<- data.frame(weekMin, weekMean, weekMedian, weekMax, weekSum)
    # hier neusetzen rv$
    message(glue(
      "server yearSim end, Time: {Sys.time()}"
    ))
  } # end def yearSim()
  
  setRv <- function() {
    rv$weekMedian <- weekMedian
    rv$weekMin <- weekMin
    rv$weekMax <- weekMax
    rv$weekMean <- weekMean
    rv$weekSum <- weekSum
    rv$s <- s
    rv$firstWeekVermoeg <- firstWeekVermoeg
    rv$lastWeekVermoeg <- lastWeekVermoeg
    rv$sortLastWeekVermoeg <- sortLastWeekVermoeg
    rv$lastProzAnteil <- lastProzAnteil
    rv$lfdJahr <- lfdJahr
    rv$gesamtVermoegenAnf <- gesamtVermoegenAnf
    rv$gesamtVermoegenEnd <- gesamtVermoegenEnd
    rv$gesamtVermoegenUmv <- gesamtVermoegenUmv
    rv$obergrenzeProzent <- obergrenzeProzent
    rv$steuerProzent <- steuerProzent
    rv$obergrenze <- obergrenze
    rv$abschoepf <- abschoepf
    rv$anteil <- anteil
    rv$umverteilung <- umverteilung
    rv$nachSteuern <- nachSteuern
    rv$giniAnf <- giniAnf
    rv$giniEnd <- giniEnd
    rv$giniUmv <- giniUmv
    rv$lorenzAnf <- lorenzAnf
    rv$lorenzEnd <- lorenzEnd
    rv$lorenzUmv <- lorenzUmv
    rv$anteilReichsterAnf <- anteilReichsterAnf
    rv$anteilReichste10Anf <- anteilReichste10Anf
    rv$anteilAermste50Anf <- anteilAermste50Anf
    rv$anteilAermste10Anf <- anteilAermste10Anf
    rv$anteilAermsterAnf <- anteilAermsterAnf
    rv$anteilReichsterEnd <- anteilReichsterEnd
    rv$anteilReichste10End <- anteilReichste10End
    rv$anteilAermste50End <- anteilAermste50End
    rv$anteilAermste10End <- anteilAermste10End
    rv$anteilAermsterEnd <- anteilAermsterEnd
    rv$anteilReichsterUmv <- anteilReichsterUmv
    rv$anteilReichste10Umv <- anteilReichste10Umv
    rv$anteilAermste50Umv <- anteilAermste50Umv
    rv$anteilAermste10Umv <- anteilAermste10Umv
    rv$anteilAermsterUmv <- anteilAermsterUmv
#    message(glue("setRv end"))
  } # end def setRv
  
  setRvUmv <-
    function() {
      #setze reactive Values nach veränderung steuern
      rv$lastProzAnteil <- lastProzAnteil
      rv$obergrenzeProzent <- obergrenzeProzent
      rv$steuerProzent <- steuerProzent
      rv$obergrenze <- obergrenze
      rv$gesamtVermoegenUmv <- gesamtVermoegenUmv
      rv$abschoepf <- abschoepf
      rv$anteil <- anteil
      rv$umverteilung <- umverteilung
      rv$nachSteuern <- nachSteuern
      rv$giniUmv <- giniUmv
      rv$lorenzUmv <- lorenzUmv
      rv$anteilReichsterUmv <- anteilReichsterUmv
      rv$anteilReichste10Umv <- anteilReichste10Umv
      rv$anteilAermste50Umv <- anteilAermste50Umv
      rv$anteilAermste10Umv <- anteilAermste10Umv
      rv$anteilAermsterUmv <- anteilAermsterUmv
#      message(glue("setRvUmv end, rv$giniUmv: {rv$giniUmv}"))
    } # end def setRvUmv
  
  rechneUmv <- function() {
#    obergrenze = weekMedian[anzWeek] * obergrenzeProzent / 100.0 # alter median
#    obergrenze = weekMax[anzWeek] * obergrenzeProzent / 100.0
#    obergrenze = weekMax[anzWeek] * obergrenzeProzent / 100.0
    sortLastWeekVermoeg <<- sort(lastWeekVermoeg) # neu rna 20.3.2022
    obergrenze <<- sortLastWeekVermoeg[trunc(obergrenzeProzent*anzSpieler/100)] # umvLorenz rna 2022-03-25
    message(glue("rechneUmv anf, index: {trunc(obergrenzeProzent*anzSpieler/100)}, obergrenze: {obergrenze}"))
    abschoepf <<-
      ifelse(lastWeekVermoeg > obergrenze,
#             lastWeekVermoeg  * steuerProzent / 100.0, # gesamtes Vermögen wird besteuert
            (lastWeekVermoeg - obergrenze)  * steuerProzent / 100.0, # nur vom Betrag ober obergrenze 2022-03-20
             0.0)
    anteil <<- sum(abschoepf) / anzSpieler
    umverteilung <<- rep(anteil, anzSpieler)
    nachSteuern <<- lastWeekVermoeg - abschoepf + umverteilung
    gesamtVermoegenUmv <<- sum(nachSteuern)
    giniUmv <<- Gini(nachSteuern, corr = FALSE, na.rm = TRUE)
    # compute lorenz
    lorenzUmv <<- Lc(nachSteuern)
    anteilReichsterUmv <<- 1 - lorenzUmv$L[anzSpieler]
    anteilReichste10Umv <<- 1 - lorenzUmv$L[anzSpieler*0.9 +1]
    anteilAermste50Umv <<- lorenzUmv$L[anzSpieler*0.5 +1]
    anteilAermste10Umv <<- lorenzUmv$L[anzSpieler*0.1 +1]
    anteilAermsterUmv <<- lorenzUmv$L[2]
    message(glue("rechneUmv end, anteil: {anteil}, giniUmv: {giniUmv}"))
  }# end rechneUmv
  
  newStart <- function(startKap, mw, sd, addMw, addSd) {
    message(glue("server newStart begin"))
    # set week 1 to startKap
    m[, 1]  <<- rep(startKap, anzSpieler)
    lfdJahr <<- 1
    yearSim(mw, sd, addMw, addSd)
    #  setRv()
    message(glue("server newStart end"))
  }
  
  nextYear <- function(mw, sd, addMw, addSd) {
    message(glue("server nextYear begin"))
    # set week 1 to nachSteuern
    m[, 1]  <<- nachSteuern
    lfdJahr <<- lfdJahr + 1
    yearSim(mw, sd, addMw, addSd)
    #  setRv()
    message(glue("server nextYear end"))
  }
  
  # 3 format functions
  fmtZahl <- function(zahl) {
    return (format(
      as.numeric(zahl),
      digits = 2,
      nsmall = 2,
      big.mark = ".",
      decimal.mark = ","
    ))
  }
  
  fmtBetrag <- function(betrag) {
    return(paste(fmtZahl(betrag), "$"))
  }
  
  fmtProz <- function(betrag) {
    return(paste(fmtZahl(betrag * 100), "%"))
  }
  
  # tabular output functions
  fTabAnf <- function(gini) {
    tAnf <- c(
      "Reichste Person besitzt: " = fmtProz(rv$anteilReichsterAnf),
      "Reichste 10% besitzen: " = fmtProz(rv$anteilReichste10Anf),
      "Ärmste 50% besitzen: " = fmtProz(rv$anteilAermste50Anf),
      "Ärmste 10% besitzen: " = fmtProz(rv$anteilAermste10Anf),
      "Ärmste Person besitzt: " = fmtProz(rv$anteilAermsterAnf),
      "Gini-Koeffizient: " = fmtZahl(rv$giniAnf)
    )
    return (tAnf)
  }
  
  fTabEnd <- function(gini) {
    tEnd <- c(
      "Reichste Person besitzt: " = fmtProz(rv$anteilReichsterEnd),
      "Reichste 10% besitzen: " = fmtProz(rv$anteilReichste10End),
      "Ärmste 50% besitzen: " = fmtProz(rv$anteilAermste50End),
      "Ärmste 10% besitzen: " = fmtProz(rv$anteilAermste10End),
      "Ärmste Person besitzt: " = fmtProz(rv$anteilAermsterEnd),
      "Gini-Koeffizient: " = fmtZahl(rv$giniEnd)
    )
    return (tEnd)
  }
  
  fTabUmv <- function(gini) {
    tUmv <- c(
      "Reichste Person besitzt: " = fmtProz(rv$anteilReichsterUmv),
      "Reichste 10% besitzen: " = fmtProz(rv$anteilReichste10Umv),
      "Ärmste 50% besitzen: " = fmtProz(rv$anteilAermste50Umv),
      "Ärmste 10% besitzen: " = fmtProz(rv$anteilAermste10Umv),
      "Ärmste Person besitzt: " = fmtProz(rv$anteilAermsterUmv),
      "Gini-Koeffizient: " = fmtZahl(rv$giniUmv)
    )
    return (tUmv)
  }
  
  fTabStat <- function(jahr) {
    tStat <- c(
      "Laufendes Jahr Nr.:" = rv$lfdJahr,
      "Gesamtvermögen zum Jahresanfang:" = fmtBetrag(rv$gesamtVermoegenAnf),
      "Gesamtvermögen zum Jahresende:" = fmtBetrag(rv$gesamtVermoegenEnd),
      "Gesamtvermögen nach Umverteilung:" = fmtBetrag(rv$gesamtVermoegenUmv),
      "Größtes Vermögen zum Jahresende:" = fmtBetrag(max(rv$lastWeekVermoeg)),
      "Größtes Vermögen nach Umverteilung:" = fmtBetrag(max(rv$nachSteuern)),
      "Kleinstes Vermögen zum Jahresende:" = fmtBetrag(min(rv$lastWeekVermoeg)),
      "Kleinstes Vermögen nach Umverteilung:" = fmtBetrag(min(rv$nachSteuern))
    )
    return (tStat)
  }

  fTabEndStat <- function(jahr) {
    tEndStat <- c(
      "Maximum:" = fmtBetrag(rv$weekMax[anzWeek]),
      "Mittelwert:" = fmtBetrag(rv$weekMean[anzWeek]),
      "Median:" = fmtBetrag(rv$weekMedian[anzWeek]),
      "Minimum:" = fmtBetrag(rv$weekMin[anzWeek])
    )
    return (tEndStat)
  }
  
  #### end of function defs
  message(glue("start server init scalars"))
  
  # scalars per session
  #  startKap <- 1.0
  lfdJahr <- 0
  gesamtVermoegenAnf <- 0.0
  gesamtVermoegenEnd <- 0.0
  gesamtVermoegenUmv <- 0.0
  obergrenze <- 0.0
  anteil <- 0.0
  giniAnf <- 0.0
  giniEnd <- 0.0
  giniUmv <- 0.0
  anteilReichsterAnf <- 0.0
  anteilReichste10Anf <- 0.0
  anteilAermste50Anf <- 0.0
  anteilAermste10Anf <- 0.0
  anteilAermsterAnf <- 0.0
  anteilReichsterEnd <- 0.0
  anteilReichste10End <- 0.0
  anteilAermste50End <- 0.0
  anteilAermste10End <- 0.0
  anteilAermsterEnd <- 0.0
  anteilReichsterUmv <- 0.0
  anteilReichste10Umv <- 0.0
  anteilAermste50Umv <- 0.0
  anteilAermste10Umv <- 0.0
  anteilAermsterUmv <- 0.0
  
  # capital matrix
  m <- matrix(startKap, nrow = anzSpieler, ncol = anzWeek)
  
  # statistical vectors for each week
  weekMedian <- vector(mode = "double", length = anzWeek)
  weekMin <- weekMedian
  weekMax <- weekMedian
  weekMean <- weekMedian
  weekSum <- weekMedian
  
  # dataframe for line plots
  s <- data.frame()
  
  # state vectors last week
  firstWeekVermoeg <- vector(mode = "double", length = anzSpieler)
  lastWeekVermoeg <- firstWeekVermoeg
  sortLastWeekVermoeg <- firstWeekVermoeg
  lastProzAnteil <- firstWeekVermoeg
  abschoepf <- firstWeekVermoeg
  umverteilung <- firstWeekVermoeg
  nachSteuern <- firstWeekVermoeg
  
  # lorenz
  lorenzAnf <- vector(mode = "double", length = anzSpieler + 1)
  lorenzEnd <- lorenzAnf
  lorenzUmv <- lorenzAnf
  
  rv <- reactiveValues(
    #define all reactive values for session
    weekMedian = weekMedian,
    weekMin = weekMin,
    weekMax = weekMax,
    weekMean = weekMean,
    weekSum = weekSum,
    s = s,
    lfdJahr = lfdJahr,
    firstWeekVermoeg = firstWeekVermoeg,
    lastWeekVermoeg = lastWeekVermoeg,
    sortLastWeekVermoeg = sortLastWeekVermoeg,
    lastProzAnteil = lastProzAnteil,
    obergrenze = obergrenze,
    gesamtVermoegenAnf = gesamtVermoegenAnf,
    gesamtVermoegenEnd = gesamtVermoegenEnd,
    gesamtVermoegenUmv = gesamtVermoegenUmv,
    abschoepf = abschoepf,
    anteil = anteil,
    umverteilung = umverteilung,
    nachSteuern = nachSteuern,
    giniAnf = giniAnf,
    giniEnd = giniEnd,
    giniUmv = giniUmv,
    lorenzAnf = lorenzAnf,
    lorenzEnd = lorenzEnd,
    lorenzUmv = lorenzUmv,
    anteilReichsterAnf = anteilReichsterAnf,
    anteilReichste10Anf = anteilReichste10Anf,
    anteilAermste50Anf = anteilAermste50Anf,
    anteilAermste10Anf = anteilAermste10Anf,
    anteilAermsterAnf = anteilAermsterAnf,
    anteilReichsterEnd = anteilReichsterEnd,
    anteilReichste10End = anteilReichste10End,
    anteilAermste50End = anteilAermste50End,
    anteilAermste10End = anteilAermste10End,
    anteilAermsterEnd = anteilAermsterEnd,
    anteilReichsterUmv = anteilReichsterUmv,
    anteilReichste10Umv = anteilReichste10Umv,
    anteilAermste50Umv = anteilAermste50Umv,
    anteilAermste10Umv = anteilAermste10Umv,
    anteilAermsterUmv = anteilAermsterUmv
  )
  
  message(glue("start running inside server"))
  newStart(startKap, randNormMean, randNormSd, 0.0, 0.0) # erster Start nur mult wachstum
  setRv()
### end of statements initializing server session
  
### from here only reactives, 
### reactive input  
  observeEvent(input$neuStart, {
    # Button NeuStart
    newStart(
      input$sliderStartVermoeg,
      input$sliderMittelwert,
      input$sliderStandardabweichung,
      input$sliderAddMittelwert,
      input$sliderAddStandardabweichung
    )
    setRv()
    message(glue("observeEvent Button Neustart: {input$neuStart}"))
  })
  
  observeEvent(input$naechstesJahr, {
    # Button ein weiteres Jahr
    nextYear(input$sliderMittelwert, 
             input$sliderStandardabweichung,
             input$sliderAddMittelwert, 
             input$sliderAddStandardabweichung)
  setRv()
    message(glue("observeEvent Button Nächstes Jahr: {input$naechstesJahr}"))
  })

  observeEvent(input$rBwachstum, {
    # radioButton Wachstumsart mult, add, addMult
    message(glue("observeEvent input$rBwachstum anf: {input$rBwachstum}"))
    if (input$rBwachstum == "mult"){
      updateSliderInput(session,"sliderMittelwert",value = 1.02)
      updateSliderInput(session,"sliderStandardabweichung",value = 0.2)
      updateSliderInput(session,"sliderAddMittelwert",value = 0.0)
      updateSliderInput(session,"sliderAddStandardabweichung",value = 0.0)
    }
    else if (input$rBwachstum == "add"){
      updateSliderInput(session,"sliderMittelwert",value = 1.0)
      updateSliderInput(session,"sliderStandardabweichung",value = 0.0)
      updateSliderInput(session,"sliderAddMittelwert",value = 0.03)
      updateSliderInput(session,"sliderAddStandardabweichung",value = 0.2)
    }
    else { # addMult
      updateSliderInput(session,"sliderMittelwert",value = 1.02)
      updateSliderInput(session,"sliderStandardabweichung",value = 0.2)
      updateSliderInput(session,"sliderAddMittelwert",value = 0.03)
      updateSliderInput(session,"sliderAddStandardabweichung",value = 0.2)
    }
    message(glue("observeEvent input$rBwachstum end: {input$rBwachstum}"))
  })
  
observeEvent(input$sliderFreigrenzeProz, {
    # Slider Obergrenze der Verteilung
    obergrenzeProzent <<- max(0.1, input$sliderFreigrenzeProz) # darf nicht 0 sein
    steuerProzent <<- input$sliderSteuerprozent
    message(glue(
      "observeEvent sliderFreigrenzeProz anf, sliderVal: {input$sliderFreigrenzeProz}, obergrenzeProzent: {obergrenzeProzent}, rv$giniUmv: {rv$giniUmv}"
    ))
    rechneUmv()
    setRvUmv()
    message(glue(
      "observeEvent sliderFreigrenzeProz: {input$sliderFreigrenzeProz} end, rv$giniUmv: {rv$giniUmv}"
    ))
  })

observeEvent(input$sliderSteuerprozent, {
  # Slider Obergrenze der Verteilung
  steuerProzent <<- input$sliderSteuerprozent
  obergrenzeProzent <<- max(0.1, input$sliderFreigrenzeProz) # darf nicht 0 sein
  message(glue(
    "observeEvent sliderSteuerprozent: {input$sliderSteuerprozent} anf, rv$giniUmv: {rv$giniUmv}"
  ))
  rechneUmv()
  setRvUmv()
  message(glue(
    "observeEvent sliderSteuerprozent: {input$sliderSteuerprozent} end, rv$giniUmv: {rv$giniUmv}"
  ))
})

observeEvent(input$sliderLeverage, {
  # Slider Leverage
  leverage <<- input$sliderLeverage / 100.0
  message(glue(
    "observeEvent sliderLeverage: {input$sliderLeverage} end"
  ))
})

observeEvent(input$sliderStartVermoeg, {
  # Slider Startvermoegen
  startKap <<- input$sliderStartVermoeg
  message(glue(
    "observeEvent sliderStartVermoeg: {input$sliderStartVermoeg} end"
  ))
})

## reactive output
  output$outHistAnf <- renderPlot({
    ggplot(mapping=aes(x=rv$firstWeekVermoeg))+
      geom_histogram(bins=10, colour="red", fill="blue", lwd=0.2)+
      scale_x_continuous(labels = scales::dollar) +
      labs(y = "Anzahl (rot) der Personen in VermögensKlasse", x = "Vermögenshöhe pro Klasse", 
           title = "Histogramm der Vermögen zum Jahresbeginn")+ 
      lims(y = c(0,anzSpieler))+
      stat_bin(bins=10, geom="text", colour="red", lwd=6.0,
               aes(label=after_stat(count)), vjust=-0.2 )
  })
  
  output$outHistEnd <- renderPlot({
    ggplot(mapping=aes(x=rv$lastWeekVermoeg))+
      geom_histogram(bins=10, colour="red", fill="blue", lwd=0.2)+
      scale_x_continuous(labels = scales::dollar) +
      labs(y = "Anzahl (rot) der Personen in VermögensKlasse", x = "Vermögenshöhe pro Klasse", 
           title = "Histogramm der Vermögen zum Jahresende ohne Umverteilung")+ 
      lims(y = c(0,anzSpieler))+
      stat_bin(bins=10, geom="text", colour="red", lwd=6.0,
        aes(label=after_stat(count)), vjust=-0.2 )
  })
  
  output$outHistEnd2 <- renderPlot({
    ggplot(mapping=aes(x=rv$lastWeekVermoeg))+
      geom_histogram(bins=10, colour="red", fill="blue", lwd=0.2)+
      scale_x_continuous(labels = scales::dollar) +
      labs(y = "Anzahl (rot) der Personen in VermögensKlasse", x = "Vermögenshöhe pro Klasse", 
           title = "Vermögen zum Jahresende")+ 
      lims(y = c(0,anzSpieler))+
      stat_bin(bins=10, geom="text", colour="red", lwd=6.0,
               aes(label=after_stat(count)), vjust=-0.2 )
  })
  
  output$outHistUmv <- renderPlot({
    ggplot(mapping=aes(x=rv$nachSteuern))+
      geom_histogram(bins=10, colour="red", fill="blue", lwd=0.2)+
      scale_x_continuous(labels = scales::dollar) +
      labs(y = "Anzahl (rot) der Personen in VermögensKlasse", x = "Vermögenshöhe pro Klasse", 
           title = "Histogramm der Vermögen nach Umverteilung")+ 
      lims(y = c(0,anzSpieler))+
      stat_bin(bins=10, geom="text", colour="red", lwd=6.0,
               aes(label=after_stat(count)), vjust=-0.2 )
  })
  
  output$outPlotVerlauf <- renderPlot({
    ggplot(data = rv$s, aes(x = 1:anzWeek)) +
      geom_line(aes(y = weekMax, color = "1")) +
      geom_line(aes(y = weekMedian, color = "2")) +
      geom_line(aes(y = weekMean, color = "3")) +
      geom_line(aes(y = weekMin, color = "4")) +
      #  coord_trans(y = "log10")+
      scale_y_log10(labels = scales::dollar) +
      labs(y = "Vermögen (log10)", x = "Wochen", title = "Wochenverlauf Minimum, Median, Mittelwert, Maximum der Vermögen", ) +
      scale_color_manual(
        values = c("firebrick", "darkgreen", "red", "green"),
        name = "Legende:",
        labels = c("Maximum", "Median", "Mittelwert", "Minimum")
      ) +
      theme(legend.position = "bottom")
  })
  
  output$outPlotVerlaufGes <- renderPlot({
    ggplot(data = rv$s, aes(x = 1:anzWeek)) +
      geom_line(aes(y = weekSum, color = "1")) +
      scale_y_log10(labels = scales::dollar) +
      labs(y = "Vermögen (log10)", x = "Wochen", title = "Wochenverlauf GesamtVermögen aller Personen") +
      scale_color_manual(
        values = c("firebrick", "darkgreen", "red", "green"),
        name = "Legende:",
        labels = c("Summe", "Median", "Mean", "Min")
      ) +
      theme(legend.position = "bottom")
  })
  output$outPlotLorenzAnf <- renderPlot({
    plot(rv$lorenzAnf,
         main = "Lorenz-Kurve zu Jahresbeginn",
         xlab = "Anteil der Personen an allen Personen (Percentile)",
         ylab = "Anteil am GesamtVermögen", col = "red")
  })
  output$outPlotLorenzEnd <- renderPlot({
    plot(rv$lorenzEnd,
         main = "Lorenz-Kurve zu Jahresende",
         xlab = "Anteil der Personen an allen Personen (Percentile)",
         ylab = "Anteil am GesamtVermögen", col = "red")
  })
  output$outPlotLorenzUmv <- renderPlot({
    plot(rv$lorenzUmv,
         main = "Lorenz-Kurve nach Umverteilung",
         xlab = "Anteil der Personen an allen Personen (Percentile)",
         ylab = "Anteil am GesamtVermögen", col = "red")
  })
  
  output$outTabUngAnf <- renderTable({
    fTabAnf(rv$giniAnf)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)
  
  output$outTabUngEnd <- renderTable({
    fTabEnd(rv$giniEnd)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)
  
  output$outTabUngUmv <- renderTable({
    fTabUmv(rv$giniUmv)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)
  
  output$outTabStat <- renderTable({
    fTabStat(rv$lfdJahr)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)
  
  output$outTabEndStat <- renderTable({
    fTabEndStat(rv$lfdJahr)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)

    # outTabUmvReg unter 4 tasten
  output$outTabUmvReg <- renderTable({
    fTabStat(rv$lfdJahr)
  },
  align = 'r', rownames = TRUE, colnames = FALSE)
  
  message(glue("end inside server"))

  session$onSessionEnded(function() {
    stopApp()
  })
}
# message(glue("end total server"))
