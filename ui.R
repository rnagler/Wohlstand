# ~rnaR/wohlstand 
# Version 3 2022-01-02
## ui.R ##
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(glue)
#setwd("~/rnaR/wohlstandShinyDashboard")
message(glue("start ui"))

ui <- dashboardPage(
  dashboardHeader(title = "Wohlstand", controlbarIcon = shiny::icon("cog")),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Willkommen", tabName = "willkommenTab"),
      menuItem("Anleitung", tabName = "anleitungTab"),
      menuItem("Simulation", tabName = "simulationTab"),
      menuItem("Ungleichheit", tabName = "ungleichTab"),
      menuItem("Jahresverlauf", tabName = "verlaufTab"),
      menuItem("Funktionsweise", tabName = "funktTab"),
      menuItem("Ergodizität", tabName = "ergoTab"),
      menuItem("Parameter", tabName = "parameterTab"),
      br(),br(),"Klicke auf diesen orangen Button",
      br(),"um ein weiteres Jahr zu simulieren:",
      actionButton("naechstesJahr", "weiteres Jahr",
                   style = "color: #000000; background-color: #ff9900"),
      br(),br(),"Klicke auf diesen grauen Button",
      br(),"um eine neue Simulation zu starten:",
      actionButton("neuStart", "Neustart",
                   style = "color: #000000; background-color: #999999")
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "willkommenTab",
              # Boxes need to be put in a row (or column)
              fluidRow(
                box(
                  title = strong("Willkommen"),
                  width=12,
                  h2("Mehr Wohlstand durch Vermögensteuern?"),
                  "Derzeit nicht umsetzbar, sagen die Politiker. Mangelhaft oder falsch informiert verehren viele Menschen in mittelalterlicher Erstarrung Vermögen als heilig und vergöttern reiche Eliten. Die Problematik unzureichender Bildung mag an die Ängste der Impfgegner in Corona-Zeiten erinnern. Vielleicht kann hier Aufklärung und logisches Denken helfen?",
#                  h2("Willkommen im Simulationsabenteuer!"),
                  p("Wir wollen in diesem Simulationsexperiment herausfinden, ob es möglich ist, durch Besteuerung großer Vermögen den Wohlstand für alle zu verbessern."),
                  strong("Ziel")," ist es, die Ursachen für die wachsende Ungleichheit zu verstehen und auszuprobieren, ob wir mit einer ausgewogenen Umverteilung gegensteuern können.",
                  br(),"Was geschieht, wenn wir Vermögen ab einer bestimmten Grenze besteuern und das so verfügbare Geld über staatliche Sozialleistungen (bessere Schulen, bessere Pflege, etc.) gerecht an alle verteilen?",
                  br(),br(),strong("Wenn dich diese Frage wirklich interessiert, dann bist du hier richtig."),
                  br(),br(),"Wenn du ",strong("links oben das Symbol mit den drei weißen Balken"), " anklickst, öffnet oder schließt sich links das Menu.",
                  br(), "Über dieses Menu kannst du rasch zwischen den einzelnen Seiten wechseln:",
                  br(),br(),em("- 'Anleitung'"), " erklärt dir, was hier eigentlich los ist.",
                  br(),em("- 'Simulation'"), " zeigt dir, wie sich die Vermögen in einer Gesellschaft innerhalb eines Jahres verändern können.",
                   "   Hier wirst du den Ablauf steuern und verschiedene Strategien ausprobieren.",
                  br(),em("- 'Ungleichheit'"), " zeigt dir statistische Messgrößen zur aktuellen Ungleichheit.",
                  br(),em("- 'Jahresverlauf'"), " veranschaulicht, wie sich das Gesamtvermögen und die Extremwerte der einzelnen Vermögen im Jahresverlauf entwickeln.",
                  br(),em("- 'Funktionsweise'"), " erklärt die Funktionsweise des Simulationsmodells.",
                  br(),em("- 'Ergodizität'"), " beschreibt die Auswirkungen der zugrunde liegenden mathematischen Eigenschaft.",
                  br(),em("- 'Parameter'"), ": hier kannst du einige Parameter dieser Simulation verändern.",
                  br(),br(),"Unter dem Menu findest du 2 Buttons:",
                  br(),em("'weiteres Jahr'"), ": Wenn du diesen orangen Button anklickst, läuft die Simulation ein weiteres Jahr mit den eingestellten Parametern.",
                  br(),em("'Neustart'"), ": Mit diesem grauen Button beginnst du einen neuen Simulationslauf mit den eingestellten Parametern.",
                  #                  br(),a(href = "#shiny-tab-parameterTab", "- Parameter"), " hier kannst du die Parameter dieser Simulation verändern.",
                  br(),br(),strong("Tipp:"), "Für einen ersten Überblick wählst du das Menu ",em("'Simulation'"), "und beobachtest die ungleiche Vermögensverteilung im mittleren Histogramm.",
                  br(),"Du erkennst gleich, dass Vermögen ungleich verteilt sind: Die Höhe des linkesten Balken zeigt an, dass sich viele Personen in der ärmsten Klasse befinden, während ganz wenige im rechtesten Balken der reichsten Klasse liegen.",
                  br(),"Auch wenn du eine neue Simulation durch Drücken der Buttons",em("'weiteres Jahr'"), " oder " ,em("'Neustart'"), " startest, findest du immer wieder ähnliche Verhältnisse.",
                  br(),"Möchtest du herausfinden, warum das so ist, dann musst du tiefer einsteigen:",
                  " Lies dir zuerst den Menupunkt ", em("'Anleitung'"), " durch und stürze dich dann ins Abenteuer! Rechne mit etwa einer Stunde Zeitaufwand.",
                  br(),br(),"Bitte kontaktiere mich gleich mit allen Fragen, Anregungen, Kritikpunkten und Einwänden.",
                  br(),"Ich freue mich über alle Reaktionen - nur so kommen wir endlich zu tragfähigen Lösungen.",
                  br(),"Rupert Nagler, E-Mail: ",  a(href = "nagler@idi.co.at", "nagler@idi.co.at")
                )
              )
            ),
      tabItem(tabName = "anleitungTab",
              # Boxes need to be put in a row (or column)
              fluidRow(
                box(
                  title = strong("Anleitung"),
                  width=6,
                  #                  h2("Wohlstand für alle?" ),
                  strong("Wohlstand für alle? Nur erreichbar, wenn wir große Vermögen vernünftig besteuern."),br(),
                  "Vermögen akkumuliert nämlich ganz automatisch bei einigen Wenigen.", 
                  br(),
                  " Dafür sorgt zuverlässig eine bisher weitgehend unbeachtete mathematische Eigenschaft",
                  " (siehe Menupunkt ", em("'Ergodizität'"), ").",
                  "Ohne dass irgendwer unfaire Tricks wie Bestechung, Wucher oder Betrug anwendet, geschieht es einfach ganz von selbst. Natürlich führt Reichtum auch zu mehr Macht, die manchmal auch missbraucht wird, um noch mehr Vermögen anzuhäufen.",
                  " Aber auch wenn wir das hier beiseite lassen, erleben wir trotzdem eine schiefe Verteilung von Vermögen",
                  br(),
                  strong("Argumente dazu liefert diese einfache Simulation:"), br(),
                  "Wir beobachten 100 Personen, die jede Woche finanzielle Transaktionen tätigen (Sparen, Kredite aufnehmen oder tilgen, Investieren, etc.). Wie im richtigen Leben verändert sich ihr individuelles Vermögen dabei zufallsbedingt.	",
                  br(), strong("Probiere es bitte selber:"), 
                  br(), "Wähle im linken Menu ", em("'Simulation'"), " aus. Dann siehst du gleich die Simulation eines Jahres mit drei Histogrammen. ",
                  br(), "Histogramme geben einen Überblick über Häufigkeiten und stellen hier grafisch dar, wieviele Personen sich in einzelnen Vermögensklassen befinden. Der linkeste Balken zeigt an, wieviele Personen sich in der ärmsten Klasse befinden, der rechteste die Anzahl in der reichsten Klasse.",
                  br(), "Im linken Histogram siehst du an dem dicken blauen Balken, dass zu Jahresbeginn alle Vermögen identisch in einer Klasse liegen. Das mittlere Histogramm zeigt die Vermögensverteilung am Ende des Jahres ohne Steuern. Im rechten Histogramm siehst du, wie eine mögliche Besteuerung am Jahresende die Verteilung der Vermögen verändern könnte.",
                  br(), "Mit den beiden Schiebereglern links unten setzt du die Regeln für die Besteuerung von Vermögen.",
                  br(), "Beide Schieberegler sind auf 50% voreingestellt. Bitte experimentiere mit anderen Werten:",
                  br(), "Wenn du den ", em("'türkisen' Schieberegler"), " nach ", em("rechts"), " verschiebst, vergrößerst du die Grenze, ab der Vermögensteuer zu zahlen ist. Ganz rechts bei 100% zahlt niemand Vermögensteuer.",
                  "Schiebst du den Regler nach ", em("links,"), "verringerst du die Grenze, bis schließlich alle, auch die ärmsten Vermögensteuer zahlen.",
                  br(), "Wenn du den ", em("'roten' Schieberegler"), " nach ", em("rechts"), " verschiebst, vergrößerst du den Prozentsatz vom aktuellen Vermögen, der als Vermögensteuer am Jahresende abzuführen ist.",
                  "Schiebst du ihn nach ", em("links,"), "verringerst du den Prozentsatz, bis schließlich gar keine Vermögensteuer abzuführen ist.",
                  br(), "Wenn alle Personen 100% Vermögensteuer zahlten, würden alle Personen das nächste Jahr mit gleichen Vermögen beginnen (vollständige Umverteilung)."
                ),
                box(
                  title = strong("Anleitung zur Umverteilung"),
                  width=6,
                  "Nehmen wir jetzt einmal an, dass du jegliche Umverteilung ablehnst ", em("(nach dem Motto: 'Leistung muss sich lohnen')"), ". Dann möchtest du diese ", strong("Gleichmacherei verhindern"), ": Mit Begeisterung schiebst du den türkisen Regler rasch ganz nach ",
                  em("rechts"), ", so dass sicher keine Umverteilung durch Vermögen- oder Erbschaftsteuer stattfinden kann.",
                  br(), "Zufrieden wirst du jetzt im linken Menu auf den ", em("orangen Button 'weiteres Jahr'"), " drücken und zusehen, wie sich die Vermögen im nächsten Jahr noch ungleicher verteilen. Du musst nur den türkisen Regler immer brav ganz nach rechts schieben.",
                  " und dann weitere Jahre durch Druck auf den orangen Button simulieren. ",                  
                  br(), "Über das linke Menu siehst du unter ", em("'Ungleichheit'"), " statistische ", strong("Messgrößen über die Ungleichheit"), " der Vermögensverteilung zu Jahrsbeginn, Jahresende und nach einer etwaigen Umverteilung.",
                  br(), "Unter ", em("'Jahresverlauf'"), " siehst du die wöchentliche ", strong("Entwicklung des Gesamtvermögens"), " und den Verlauf des minimalen und maximalen Einzelvermögens sowie Durchschnitt und Median aller Vermögen. (Median ist das Vermögen, das genau in der Mitte liegt, wenn man die Vermögen der Größe nach sortiert.)",
                  br(), br(), strong("Gefällt dir diese automatische Tendenz zur Ungleichheit?"), " Vielleicht möchtest du jetzt doch einmal ausprobieren, wie wir mehr Wohlstand für alle durch Umverteilung erreichen könnten?",
                  br(), strong("Dann riskiere es,"), "und stelle mit beiden Schiebereglern eine andere Steuerpolitik ein und schau dir an, wie die Vermögensverteilung gerechter wird. Damit bremst du die automatisch entstehende Ungleichheit und verteilst die eingehobene Vermögensteuer durch staatliche Sozialleistungen gerecht an alle.",
                  br(), strong("Aber: war die entstehende Ungleichheit nicht nur ein Zufall?"), " Probiere es aus, drücke auf den ",
                  em("grauen Button 'Neustart'"), "im linken Menu für einen neuen Versuch und experimentiere nach Lust und Laune. "
                )
              )),
      tabItem(tabName = "simulationTab",
              fluidRow(title = "Simulation",
                box(
                  title = "Simulation",
                  width = 4,
                  plotOutput("outHistAnf")
                ),
                box(
                  title = "",
                  width = 4,
                  plotOutput("outHistEnd")
                ),
                box(
                  title = "",
                  width = 4,
                  plotOutput("outHistUmv")
                )
              ),
              fluidRow(
                box(
                  title = "Steuern",
                  width = 8,
#                  helpText(" in % des größten Vermögens"),
                  # set color of left slider bar
                  setSliderColor(c("#00cccc", "#ff0000"), c(1,2)), #türkis erster, rot zweiter
                  sliderInput(
                    "sliderObergrenze",
                    "Steuergrenze: ab wieviel Prozent des größten Vermögens ist Vermögensteuer zu entrichten?",
                    0,
                    100,
                    50
                  ),
                  p("Regler ganz links auf 0 = alle Personen zahlen Steuer, Regler ganz rechts auf 100: keine Person zahlt Steuer."),
#                  helpText("Steuerprozentsatz"),
                  hr(),
                  sliderInput(
                    "sliderSteuerprozent",
                    "Steuerprozentsatz: Wieviel Prozent ihres Vermögens müssen Personen, deren Vermögen über der Steuergrenze liegt, an Vermögensteuer abführen?",
                    0,
                    100,
                    50
                  ),
                  p("Regler ganz links auf 0 = keine Vermögensteuer, Regler ganz rechts auf 100: das gesamte Vermögen ist abzuführen.")
                ),
                box(
                  title = "Kennzahlen",
                  width = 4,
                  tableOutput("outTabUmvReg")
                )
              )),
      tabItem(tabName = "verlaufTab", 
              fluidRow(
                box(
                  title = "Jahresverlauf des Gesamtvermögens",
                  width = 6,
                  helpText("Die Linie zeigt, wie sich das gesamte Vermögen aller Personen entwickelt."),
                  plotOutput("outPlotVerlaufGes")
                ),
                box(
                  title = "Jahresverlauf von Minimum, Mittelwert, Median, Maximum",
                  width = 6,
                  helpText("Die Linien zeigen, wie sich das jeweilige Maximum, Durchschnitt, Median und Minimum aller Vermögen entwickelt."),
                  plotOutput("outPlotVerlauf")
                ),
                box(
                  title = "Gesamtstatistik",
                  width = 6,
                  helpText("Werte für das aktuelle Jahr"),
                  tableOutput("outTabStat")
                ),
                box(
                  title = "Endstatistik",
                  width = 6,
                  helpText("Werte am Ende des aktuellen Jahres"),
                  tableOutput("outTabEndStat")
                )
              )),
      tabItem(tabName = "ungleichTab",
              fluidRow(
                box(
                  title = "Ungleichheit zu Jahresbeginn",
                  width = 4,
                  helpText("Kennzahlen Ungleichheit und Gini-Koeffizient"),
                  tableOutput("outTabUngAnf"),
                  hr(),
                  plotOutput("outPlotLorenzAnf")
                ),
                box(
                  title = "Ungleichheit zu Jahresende",
                  width = 4,
                  helpText("Kennzahlen Ungleichheit und Gini-Koeffizient"),
                  tableOutput("outTabUngEnd"),
                  hr(),
                  plotOutput("outPlotLorenzEnd"),
                  helpText("Gini-Koeffizient und Lorenz-Kurve siehe Menu 'Funktionsweise'")
                ),
                box(
                  title = "Ungleichheit nach Umverteilung",
                  width = 4,
                  helpText("Kennzahlen Ungleichheit und Gini-Koeffizient"),
                  tableOutput("outTabUngUmv"),
                  hr(),
                  plotOutput("outPlotLorenzUmv")
                )
              )),
tabItem(tabName = "funktTab",
        fluidRow(
          box(
            title = strong("Funktionsweise"),
            width=9,
            #                  h2("Wie funktioniert dieses Modell?" ),
            "Beim Neustart erhalten zum Jahresbeginn alle 100 Personen das gleiche Startvermögen und verändern es jede Woche durch finanzielle Transaktionen.",
            br(), "Wie wird jede einzelne Transaktion simuliert? Unser Wirtschaftsleben ist stark durch exponentielles Wachstum bestimmt: für kapitalorientierte Transaktionen gilt: ",
            br(), code("neues Vermögen = altes Vermögen * multiplikativer Faktor"), ". In der Realität ist der multiplikative Faktor ein Zinsgewinn, Mietertrag oder Investitionsgewinn, mit dem das alte Vermögen multipliziert wird. Jedenfalls hängt hier die Höhe des neuen Vermögens stark von der Höhe des alten Vermögens ab. Im Modell verwenden wir als multiplikativen Faktor normalverteilte Zufallszahlen mit einem voreingestellten Mittelwert = 1,03 und der Standardabweichung = 0,2.",
            br(), "Zusätzlich gibt es auch ein additives Wachstum, das durch Erwerbsarbeit, Pensionen oder Mietzahlungen der kleinen Leute entsteht. Dieses Wachstum hängt nicht von der aktuellen Vermögenshöhe ab. Hier gilt: ",code("neues Vermögen = altes Vermögen + additiver Faktor"), 
            ". Im Modell verwenden wir als additiven Faktor normalverteilte Zufallszahlen mit einem voreingestellten Mittelwert = 0,03 und der Standardabweichung = 0,2.",
            br(), "Mit diesen Werten stellen wir ein geringfügig positives, aber variierendes  Wachstum ein. Diese Parameter wie auch das Startvermögen kannst du mit den entsprechenden Schiebereglern auf der Menuseite ", em("'Parameter'"), " verändern. Dort kannst du auch entscheiden, ob du exponentielles oder additives Wachstum oder beide Wachstumsarten nebeneinander simulieren möchtest.",
            br(), "So simulieren wir mit den so parametrisierten Zufallszahlen für jede Woche des aktuellen Jahres die Vermögensveränderung für jede der 100 Personen. Logischer Weise sind dann die Vermögen zum Jahresende unterschiedlich hoch. Das ist nicht verwunderlich, manche haben eben mehr Glück bei ihren finanziellen Entscheidungen. Daher erwarten wir, dass sich zum Jahresende die Personen in unterschiedlichen Vermögensklassen befinden.",
            "So müssten wir auf der Menuseite ", em("'Simulation'"), " ausgewogene Histogramme sehen mit etwa gleich besetzten Vermögensklassen. Erstaunlicherweise beobachten wir aber eine schiefe ungleiche Verteilung, wenn - wie in der Realität - exponentielles Wachstum im Spiel ist: ",
            strong("Wenige Personen sind reich geworden, aber die meisten befinden sich in der Klasse mit den kleinsten Vermögen."),
            br(), "Das verdeutlicht auch die Menuseite ", em("'Ungleichheit': "),
            "Hier findest du analog zur Menuseite ", em("'Simulation'"), " statistische Werte zur Ungleichheit zu Jahresbeginn, zum Jahresende und nach einer eventuellen Umverteilung.",
            br(), "In den Tabellen werden Vermögensanteile für verschiedene Personenklassen angezeigt.",
            br(), "Der ", strong("Gini-Koeffizient")," darunter ist eine Kennzahl für die aktuelle Ungleicheit. Zu Simulationsbeginn ist er 0, das bedeutet: alle haben das gleiche Vermögen. Der Gini-Koeffizient wäre 1 bei maximaler Ungleichheit, also dann, wenn eine Person des gesamte Vermögen besitzt und alle anderen nichts. Näheres zum Gini-Koeffizient: ",
            a(href = "https://de.wikipedia.org/wiki/Gini-Koeffizient", "https://de.wikipedia.org/wiki/Gini-Koeffizient"),
            br(), "Die ", strong("Lorenz-Kurven"), " zeigen grafisch an, welcher Personenanteil welchen Anteil am Gesamtvermögen hat. Näheres zur Lorenz-Kurve findet du unter: ",
            a(href = "https://de.wikipedia.org/wiki/Lorenz-Kurve", "https://de.wikipedia.org/wiki/Lorenz-Kurve"),
            ". Je stärker die rote Lorenzkurve nach rechts unten durchhängt, desto grösser ist hier die Ungleichheit.",
            br(),br(), "Du kannst die Ungleichheit durch höhere Vermögensteuern mildern, wenn du den ", em("'türkisen' Schieberegler"), " auf der Menuseite ", em("'Simulation'"), " weiter nach links bewegst und damit die Vermögensgrenze senken, ab der Steuer fällig wird.",
            " Oder du schiebst den ", em("'roten' Schieberegler"), " weiter nach rechts, um damit den Prozentsatz der Steuer zu erhöhen.",
            br(), "Standardmäßig wird der Vermögenshöhe, ab der Steuer fällig wird, auf 50% des größten Einzelvermögens gesetzt und der Steuersatz auf 50%.",
            br(), "Die zum Jahresende eingehobene Vermögensteuer wird (in der Form von staatlichen Sozialleistungen) gerecht auf alle Personen verteilt, also auch auf die Reichen.",
            br(), "Wenn du auf den orangen Button ", em("'weiteres Jahr'"), " drückst, werden alle Vermögen vom Jahresende nach Umverteilung auf den Beginn eines weiteren Jahres übertragen und dieses weitere Jahr wie oben mit neuen Zufallszahlen simuliert und angezeigt. ",
            br(), "So kannst du den Ablauf mehrerer Jahre - egal ob mit hohen, geringen oder gar keinen Vermögensteuern - simulieren und Höhe und Verteilung der Vermögen beurteilen. ",
            br(), "Auf der Menuseite ", em("'Jahresverlauf'"), " siehst du die Entwicklung des Gesamtvermögens aller Personen in diesem Jahr und welche Auswirkungen die Umverteilung haben kann."
          ),
          box(
            title = "Fragen",
            width = 3,
            br(), strong("Warum weisen die Werte zum Jahresende auf größere Ungleichheit hin?"),
            br(), br(), strong("Wie gefällt dir der Unterschied mit / ohne Umverteilung?"), " Umverteilen hat ja beängstigende Namen: Vermögensteuer, Erbschaftsteuer. Aber keine Angst, richtig angewendet verliert dabei mittelfristig niemand, auch nicht die Reichen. Kooperative Umverteilung bewirkt nämlich stärkeren Vermögenszuwachs für alle.",
            br(), br(), strong("Hast du ausprobiert, was bei zunehmender Umverteilung mit dem Gesamtvermögen geschieht?"), 
            br(), " Wahrscheinlich profitieren die Ärmeren.",
            br(), strong("Aber wie ergeht es den Reichen?"), "Haben sich ihre Chancen verringert?"
          )
        )),
tabItem(tabName = "ergoTab",
        fluidRow(
          box(
            title = strong("Ergodizität"),
            width=6,
#            h3("" ),
            "Die traditionelle Ökonomielehre unterscheidet nicht zwischen ", strong("additivem"), " und ", strong("exponentiellem"), " Wachstum. Sie suggeriert uns fälschlicherweise Chancengleichheit für alle, in dem sie ", strong("Ergodizität"), " postuliert:",
            br(), "der Mittelwert des Vermögens einer Einzelperson über die Zeitachse sei gleich mit dem Mittelwert des Vermögens aller Personen zu einem bestimmten Zeitpunkt. Das nennt man die ",
            a(href = "https://de.wikipedia.org/wiki/Ergodenhypothese.", "ergodische Hypothese."),
            br(), "Diese Hypothese besagt vereinfacht in der Thermodynamik, dass ein System alle energetisch möglichen Zustände auch wirklich erreichen kann.",
            "Die in der Realität beobachteten Phasenübergänge lieferten dort Gegenbeispiele: beim Erstarren einer Flüssigkeit gilt die ergodische Hypothese ", strong("nicht"), ". Diese Hypothese kann daher dort nicht ohne Einschränkungen angenommen werden.",
            br(), "Das vorliegende Simulationsmodell liefert ein ", strong("Gegenbeispiel"), " gegen die Annahme von Ergodizität in der Wirtschaft. Wir zeigen damit, dass die ergodische Hypothese bei ", strong("exponentiellen"), " Wachstumsprozessen NICHT gilt.",
            br(), "Exponentielle Wachstumsprozesse entstehen immer dann, wenn die Höhe des finanziellen Erfolges oder Misserfolges einer Transaktion vom eingesetzten Kapital abhängt (", em("Zinserträge, Dividenden, Mieterlöse, Investitionsgewinne"), ", etc.). ",
            br(), "Im Gegensatz dazu kann bei ", strong("additiven"), " Wachstumsprozessen (Vermögensveränderungen durch ", em("reine Erwerbsarbeit, Pensionseinkünfte, aber auch Ausgaben des täglichen Bedarfs, Mietzahlungen der kleinen Leute"), ", o.ä.) Ergodizität durchaus angenommen werden. Rein additive Wachstumsprozesse führen zu gerechten normalverteilten Vermögen, wie wir es intuitiv annehmen würden.",
            "Exponentielle Wachstumsprozesse aber führen zu schiefen Vermögensverteilungen - entgegen unserer gefühlsmäßigen Einschätzung.",
            br(), "Du kannst das einfach im Modell veranschaulichen, in dem du im Menu ", em("'Parameter'"), " bei ", em("'Wachstumsart' 'rein additiv'"), " auswählst und auf ", em("'Neustart'"), " drückst und das Histogram zum Jahresende betrachtest. ",
            "Dann wählst du die Wachstumsart ", em("'rein exponentiell'"), " aus, drückst auf wieder auf ", em("'Neustart'"), " und beurteilst die Unterschiede beim Histogramm.",
            br(), strong("Bei exponentiellen Wachstumsprozessen führt die Annahme von Ergodizität unweigerlich zu falschen Schlüssen."),
            br(), "Der Mittelwert des Vermögens aller Personen zu einem bestimmten Zeitpunkt liefert hier ", strong("keine sinnvollen Voraussagen"), " über das mögliche Vermögen einer einzelnen Person.",
            br(), "Daher darf auch in der Ökonomie Ergodizität nicht generell postuliert werden. ",
            br(), "Die traditionelle liberale Wirtschaftslehre setzt aber - absichtlich oder unabsichtlich - die ", strong("additiven"), " Vermögensveränderungen der kleinen Leute gleich mit den ", strong("exponentiellen"), " Vermögensveränderungen eines Kapitalisten.",
            br(), "Damit hat sie uns immer wieder in die Irre geführt und ständige ", strong("Fehlentscheidungen der Politiker"), " verursacht.",
            br(), "Ein steigendes Bruttosozialprodukt eines Staates bedeutet somit keineswegs steigendes Vermögen für alle seine Bürger.",
            br(), "Auch der Satz 'Geht es der Wirtschaft gut, geht es allen gut' ist eine ", strong("grob irreführende Schlussfolgerung")
          ),
          box(
            title = "Quellen",
            width = 6,
            br(), strong("Quellen:"),
            br(), "Vermögenssteuer: Warum es nicht gelingt, höhere Steuern für Reiche durchzusetzen, Momentum, Dez.2021",
            br(), a(href = "https://www.moment.at/story/vermoegenssteuer-reiche-scheitern", "https://www.moment.at/story/vermoegenssteuer-reiche-scheitern"),
            br(), br(), "Vorteile von Vermögensteuern spielerisch erklärt, Rupert Nagler, 2020",
            br(), a(href = "https://drive.google.com/file/d/1f1J-EhkkB49vkey1L_F3ICk0EwYErmzn/view?usp=sharing", "https://drive.google.com/file/d/1f1J-EhkkB49vkey1L_F3ICk0EwYErmzn/view?usp=sharing"),
            br(), br(), "Kapital und Ideologie, Vortrag Thomas Piketty, AK Wien, 2021",
            br(), a(href = "https://wien.arbeiterkammer.at/service/veranstaltungen/rueckblicke/AK_Piketty_WEB.pdf", "https://wien.arbeiterkammer.at/service/veranstaltungen/rueckblicke/AK_Piketty_WEB.pdf"),
            br(), br(), "Ergodicity Economics, Ole Peters, Alex Adamou, 2018",
            br(), a(href = "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf", "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf"),
            br(), br(), "Democratic domestic product, Ole Peters, 2020",
            br(), a(href = "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/", "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/"),
            br(), br(), "Ergodizität, Wikipedia, 2021",
            br(), a(href = "https://de.wikipedia.org/wiki/Ergodizit%C3%A4t", "https://de.wikipedia.org/wiki/Ergodizit%C3%A4t"),
            br(), br(), "Fermi–Pasta–Ulam–Tsingou problem, Wikiwand, 2021",
            br(), a(href = "https://www.wikiwand.com/en/Fermi%E2%80%93Pasta%E2%80%93Ulam%E2%80%93Tsingou_problem", "https://www.wikiwand.com/en/Fermi%E2%80%93Pasta%E2%80%93Ulam%E2%80%93Tsingou_problem"),
            hr(),br(),h4("Impressum"),
            "This website is provided by:",
            br(), "Information Design Institute, 120 Hoetzendorfstrasse,",
            br(), "A-2231 Strasshof, Austria / Europe,",
            br(), "Tel.: +43 650 2287 001, nagler@idi.co.at,",
            a(href = "https://www.idi.co.at/", "https://www.idi.co.at/"),
            br(), "Managing director and responsible for content: Dipl.-Ing. Dr. Rupert Nagler, Dr. Nagler KG,",
            br(), "Line of Business: Consulting, Register number: 174660 d, UID: ATU45617202",
            br(), "This website may contain links to other sites. We are not responsible for linked content.",
            br(), "Developed in Rstudio V4.0+ with library 'shinydashboard'.",
            br(), "Open Sourcecode public available at:",
            a(href = "https://github.com/rnagler/Wohlstand/", "https://github.com/rnagler/Wohlstand/")
          )
        )),
tabItem(tabName = "parameterTab",
              fluidRow(
                box(
                  h4("Zufallszahlengenerator für exponentielles Wachstum"),
                  title = "Parameter",
                  width = 6,
                  helpText("Multiplikative Transaktionen führen zu einer exponentiellen Vergrösserung oder Verminderung des einzelnen Vermögens. Das wird durch normalverteilte Zufallszahlen simuliert."),
                  helpText("Diese Regler steuern das Generieren der multiplikativen Zufallszahlen."),
                  hr(),
                  helpText("Ein Mittelwert > 1 erzeugt eine positive Tendenz."),
                  sliderInput("sliderMittelwert", "Mittelwert der multiplikativen Zufallszahlen:", 0.9, 1.2, 1.02),
                  hr(),
                  helpText("Eine grössere Standardabweichung bewirkt mehr Streuung, 0 verhindert jede Streuung"),
                  sliderInput("sliderStandardabweichung", "Standardabweichung der multiplikativen Zufallszahlen:", 0, 0.6, 0.2)
                ),
                box(
                  h4("Zufallszahlengenerator für additives Wachstum"),
                  title = "Parameter",
                  width = 6,
                  helpText("Additive Transaktionen führen zu einer additiven Vergrösserung oder Verminderung des einzelnen Vermögens. Das wird durch normalverteilte Zufallszahlen simuliert."),
                  helpText("Diese Regler steuern das Generieren der additiven Zufallszahlen."),
                  hr(),
                  helpText("Ein Mittelwert > 0 erzeugt eine positive Tendenz."),
                  sliderInput("sliderAddMittelwert", "Mittelwert der additiven Zufallszahlen:", -0.9, 0.9, 0.03),
                  hr(),
                  helpText("Eine grössere Standardabweichung bewirkt mehr Streuung, 0 verhindert jede Streuung"),
                  sliderInput("sliderAddStandardabweichung", "Standardabweichung der additiven Zufallszahlen:", 0, 0.6, 0.2)
                ),
                box(
                  title = "Wachstumsart",
                  width = 6,
                  helpText("Bitte die gewünschte Wachstumsart durch Anklicken auswählen"),
                  radioButtons("rBwachstum", "Wachstumsart:",
                   c("rein exponentiell" = "mult",
                     "rein additiv" = "add",
                     "gemischt" = "addMult"),
                   selected = "mult")
                ),
                box(
                  title = "Startvermögen",
                  width = 6,
                  helpText(
                    "Dieser Regler steuert das beim Neustart zugewiesene Startvermögen"
                  ),
                  sliderInput("sliderStartVermoeg", "Startvermögen:", 0.1, 100, 1)
              )
              ))
    )
  ),
footer = dashboardFooter(left = "Rupert Nagler",
                         right = "(c) Information Design Institute, 2022")
)
# message(glue("end ui")) wenn das activ, dann wird ui nicht gefunden
