# ~rnaR/wohlstandShinyDashboard
# Version 6 2023-01-29 ger
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
      menuItem("Impressum", tabName = "impressumTab"),
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
            width=8,
            h2("Warum werden Reiche immer reicher?"),
            "Warum nimmt die Ungleichheit ständig zu? Nicht nur, weil manche Reiche ihre Macht schamlos ausnutzen und sich illegal Vorteile verschaffen. Sondern weil Vermögen automatisch bei Wenigen kumuliert, wie du hier praktisch nachvollziehen kannst.", 
            br(),"Trotzdem unternehmen wir nichts gegen unverdienten Überreichtum. Mangelhaft oder falsch informiert verehren viele Menschen Vermögen als heilig und bewundern überreiche Eliten. Aus vorauseilendem Gehorsam oder durch Bestechung erpressbare Politiker weigern sich, mit vernünftigen Maßnahmen gegenzusteuern.",
            br(),"Diese Webseite möchte aufklären und befähigt dich, mit interaktiven Simulationen eigene praktische Erfahrungen zu machen:",
            tags$ul(
              tags$li("Du erkennst an praktischen Beispielen, dass Ungleichheit automatisch entsteht,"), 
              tags$li("Du probierst aus, was wir dagegen unternehmen könnten,"), 
              tags$li("Du verstehst die zugrundeliegenden Ursachen und warum das schwer zu akzeptieren ist.")
            ),
            "In dieser Simulation wirst du beobachten, wie 1000 Personen ein Jahr erleben. Sie beginnen alle mit gleichem Vermögen. Jede Woche verändert sich ihr Vermögen durch zufällig erfolgreiche Geldgeschäfte: sie erhalten Zinsen für ihr Sparguthaben, investieren in Aktien oder zahlen Kredite zurück. Keiner wendet irgendwelche unredlichen Tricks an. Im Unterschied zur Realität haben hier alle die gleichen Chancen. Einige haben eben mehr Glück, manche weniger. Aber es passiert Überraschendes.",
            br(),"In drei Schritten kannst du Näheres erfahren, allerdings mit steigendem Aufwand:", 
            tags$ol(
              tags$li(tags$b("Einfach:"),em(" Dauer nur 2 Minuten.")," Intuitiv vermutest du, dass sich die Vermögen gerecht verteilen. Überprüfe deine Annahme: Rechts siehst du ein Histogramm. Es dokumentiert, wieviele der 1000 Personen sich nach einem Jahr in welcher Vermögensklasse befinden. Der linkeste Balken und die rote Zahl darüber zeigt an, wieviele Personen sich in der ärmsten Klasse befinden, der rechteste Balken zeigt die Anzahl der Personen, die zur reichsten Klasse gehören. Vergleiche die Zahl der Ärmsten mit den Reichsten. Was fällt dir auf? Hättest du diese Vermögensverteilung erwartet? Vielleicht war das ein Zufall. Drücke links unten auf den grauen Button ", em("Neustart"), " und simuliere ein anderes Jahr. Hat sich die Verteilung wesentlich verändert? Hättest du gerechtere Verteilungen erwartet? Du kannst es beliebig oft versuchen."), 
              tags$li(tags$b("Fortgeschritten:"),em(" Dauer ca. 15 Minuten.")," Wenn du erkannt hast, dass sich Vermögen automatisch ungleich entwickeln, möchtest du vielleicht ausprobieren, wie du diesen Trend mildern kannst. Eine Möglichkeit wäre die Umverteilung durch Besteuerung hoher Vermögen. Lies dir dazu die Menuseite ", em("Anleitung"), " durch und probiere es selber im Menu ", em("Simulation"), " aus. Beurteile die entstehenden Vermögensunterschiede im Menu ", em("Ungleichheit.")), 
              tags$li(tags$b("Professional:"),em(" Dauer etwa 30 Minuten.")," Für viele Menschen ist es schwer zu verstehen, warum Ungleichheit automatisch entsteht. Denn das hier Erlebte spricht gegen unsere Intuition, gegen unser Verständnis von Durchschnittsbildung und gegen traditionelle Wirtschaftstheorien. Wenn dich das irritiert und du etwas mehr erfahren möchtest, dann schau dir die Menuseite ", em("Ergodizität"), " näher an und experimentiere mit exponentiellem und additivem Wachstum mit unterschiedlichen Parametern im Menu ", em("Parameter."))
            ),
            strong("Wie funktioniert das Ganze?"),
            "Wenn du ",strong("links oben das Symbol mit den drei weißen Balken"), " anklickst, öffnet oder schließt sich links das Menu.",
            br(), "Über dieses Menu kannst du rasch zwischen den einzelnen Seiten wechseln:",
            tags$ul(
              tags$li(em("Anleitung"), " erklärt dir, was hier eigentlich los ist."),
              tags$li(em("Simulation"), " zeigt dir, wie sich die Vermögen in einer Gesellschaft innerhalb eines Jahres verändern können.",
                "   Hier wirst du den Ablauf steuern und verschiedene Strategien ausprobieren."),
              tags$li(em("Ungleichheit"), " zeigt dir statistische Messgrößen zur aktuellen Ungleichheit."),
              tags$li(em("Jahresverlauf"), " veranschaulicht, wie sich das Gesamtvermögen und die Extremwerte der einzelnen Vermögen im Jahresverlauf entwickeln."),
              tags$li(em("Funktionsweise"), " erklärt, wie das Simulationsmodell im Detail funktioniert."),
              tags$li(em("Ergodizität"), " beschreibt die Auswirkungen der zugrunde liegenden mathematischen Eigenschaft."),
              tags$li(em("Parameter"), " hier kannst du einige Parameter dieser Simulation selbst verändern."),
              tags$li(em("Impressum"), " hier findest du das Impressum, einen Link zu einem passenden Lied und ein Märchen als analoge Einführung.")
            ),
            "Unter dem Menu findest du 2 Buttons:",
            tags$ul(
              tags$li(em("weiteres Jahr"), ": Wenn du diesen orangen Button anklickst, läuft die Simulation ein weiteres Jahr mit den eingestellten Parametern."),
              tags$li(em("Neustart"), ": Mit diesem grauen Button beginnst du einen neuen Simulationslauf mit den eingestellten Parametern.")
            )
          ),
          box(
            title = "Tipp",
            width = 4,
            "Entscheide, wieviel Zeit du investieren möchtest, und führe dann einen oder mehrere von den drei Schritten ", em("Einfach - Fortgeschritten - Professional"), " links durch. Du kannst dabei gar nichts falsch machen - experimentiere ganz unverbindlich und mache dir dein eigenes Bild!"
          ),
          box(
            title = "Histogramm Verteilung der Vermögen",
            width = 4,
            plotOutput("outHistEnd2")
          ),
          box(
            title = "Kontakt",
            width = 4,
            "Bitte kontaktiere mich gleich mit allen Fragen, Anregungen, Kritikpunkten und Einwänden.",
            br(),"Ich freue mich über alle Reaktionen - nur so kommen wir zu tragfähigen Lösungen.",
            br(),"Rupert Nagler, E-Mail: ",  a(href = "nagler@idi.co.at", "nagler@idi.co.at")
          )
        )),
      tabItem(tabName = "anleitungTab",
              # Boxes need to be put in a row (or column)
              fluidRow(
                box(
                  title = strong("Anleitung Vermögensteuer"),
                  width=6,
                  #                  h2("Wohlstand für alle?" ),
                  strong("Wohlstand für alle? Können wir erreichen, wenn wir große Vermögen vernünftig besteuern."),br(),
                  "Vermögen akkumuliert nämlich ganz automatisch bei einigen Wenigen.", 
                  br(),
                  " Dafür sorgt zuverlässig eine bisher weitgehend unbeachtete mathematische Eigenschaft",
                  " (siehe Menupunkt ", em("Ergodizität"), ").",
                  "Ohne dass irgendwer unfaire Tricks wie Bestechung, Wucher oder Betrug anwendet, geschieht es einfach ganz von selbst. Natürlich führt Reichtum auch zu mehr Macht, die manchmal auch missbraucht wird, um noch mehr Vermögen anzuhäufen.",
                  " Aber auch wenn wir das hier beiseite lassen, erleben wir trotzdem eine schiefe Verteilung von Vermögen.",
                  br(), br(), strong("Probiere bitte selber, ob du gegen diesen automatischen Trend gegensteuern kannst:"), 
                  br(), "Wähle im linken Menu ", em("Simulation"), " aus. Dann siehst du gleich die Simulation eines Jahres mit drei Histogrammen. ",
                  br(), "Histogramme geben einen Überblick über Häufigkeiten und stellen hier grafisch dar, wieviele Personen sich in einzelnen Vermögensklassen befinden. Der linkeste Balken zeigt an, wieviele Personen sich in der ärmsten Klasse befinden, der rechteste die Anzahl in der reichsten Klasse. Auf der horizontalen Skala unter den Histogrammen erkennst du die ungefähre Höhe der Vermögen in den einzelnen Klassen.",
                  br(), "Im linken Histogram siehst du an dem dicken blauen Balken, dass zu Beginn des ersten Jahres alle Vermögen identisch in einer Klasse liegen. Das mittlere Histogramm zeigt die Vermögensverteilung am Ende des Jahres ohne Steuern. Im rechten Histogramm siehst du, wie eine mögliche Besteuerung am Jahresende die Verteilung der Vermögen verändern könnte.",
                  br(), br(), "Links unten im Kasten ", em("Steuerpolitik"), " kannst du mit zwei Schiebereglern die Besteuerung der Vermögen selber festlegen.",
                  "Bitte experimentiere mit anderen Werten:",
                  br(), "Wenn du den ", strong("grünen Schieberegler"), " nach ", em("rechts"), " verschiebst, vergrößerst du die ", strong("Grenze, ab der Vermögensteuer zu zahlen ist"), ". Ganz rechts bei 100% zahlt niemand Vermögensteuer.",
                  "Schiebst du den Regler nach ", em("links,"), "verringerst du die Grenze, bis schließlich alle, auch die Ärmsten, Vermögensteuer zahlen.",
                  br(), "Wenn du den ", strong("roten Schieberegler"), " nach ", em("rechts"), " verschiebst, vergrößerst du den ", strong("Prozentsatz"), " vom aktuellen steuerpflichtigen Vermögen, der als Vermögensteuer am Jahresende abzuführen ist.",
                  "Schiebst du ihn nach ", em("links,"), "verringerst du den Prozentsatz, bis schließlich gar keine Vermögensteuer abzuführen ist.",
                  br(), "Wenn alle Personen 100% Vermögensteuer zahlen, beginnen alle Personen das nächste Jahr mit gleichen Vermögen (vollständige Umverteilung)."
                ),
                box(
                  title = strong("Anleitung zur Umverteilung"),
                  width=6,
                  "Nehmen wir vorerst einmal an, dass du jegliche Umverteilung ablehnst ", em("(nach dem neoliberalen Motto: 'Leistung muss sich wieder lohnen')."), 
                  " Dann möchtest du natürlich jede ", strong("Vermögensteuer verhindern"), ". Mit Begeisterung schiebst du den grünen Regler rasch ganz nach ",
                  em("rechts,"), " so dass sicher keine Umverteilung stattfinden kann.",
                  br(), "Zufrieden wirst du jetzt im linken Menu auf den ", em("orangen Button 'weiteres Jahr'"), " drücken und zusehen, wie sich die Vermögen im nächsten Jahr noch ungleicher verteilen. Du musst nur den grünen Schieberegler immer brav ganz nach rechts schieben.",
                  " und dann weitere Jahre durch Druck auf den orangen Button simulieren. Überlege aber dabei, wie wahrscheinlich es ist, dass gerade du in die Klasse der Reichsten geraten wirst!",                  
                  br(), br(), "Über den Menupunkt ", em("Ungleichheit"), " siehst du statistische ", strong("Messgrößen zur Ungleichheit"), " der Vermögensverteilung, Gini-Koeffizient und Lorenzkurve zu Jahresbeginn, Jahresende und nach einer etwaigen Umverteilung.",
                  br(), br(), "Über den Menupunkt ", em("Jahresverlauf"), " siehst du die wöchentliche ", strong("Entwicklung des Gesamtvermögens"), " und den Verlauf des minimalen und maximalen Einzelvermögens sowie Durchschnitt und Median aller Vermögen. (Median ist das Vermögen, das genau in der Mitte liegt, wenn man die Vermögen der Größe nach sortiert.)",
                  br(), br(), strong("Gefällt dir diese automatische Tendenz zur Ungleichheit?"), " Vielleicht möchtest du jetzt doch einmal ausprobieren, wie wir mehr Wohlstand für alle durch Umverteilung erreichen könnten?",
                  br(), strong("Dann riskiere es,"), "und stelle mit beiden Schiebereglern eine andere Steuerpolitik ein und schau dir an, ob die Vermögensverteilung gerechter wird. Gelingt es dir, die automatisch entstehende Ungleichheit zu bremsen und die eingehobene Vermögensteuer durch staatliche Sozialleistungen gerecht an alle zu verteilen?",
                  br(), br(), strong("Aber: war die entstehende Ungleichheit nicht nur ein Zufall?"), " Probiere es aus, drücke auf den ",
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
                  title = "Steuerpolitik",
                  width = 8,
                  setSliderColor(c("#008000", "#ff0000"), c(1, 2)),
                  #grün erster, rot zweiter
                  sliderTextInput(
                    "sliderFreigrenzeProz",
                    "Steuerfreigrenze: Welcher Prozentanteil der ärmeren Personen mit kleineren Einzelvermögen soll KEINE Steuer zahlen?",
                    choices = c(
                      0,
                      0.5,
                      1,
                      2,
                      10,
                      20,
                      30,
                      40,
                      50,
                      60,
                      70,
                      80,
                      90,
                      95,
                      96,
                      97,
                      98,
                      99,
                      99.5,
                      99.6,
                      99.7,
                      99.8,
                      99.9,
                      100
                    ),
                    selected = 80,
                    grid = T
                  ),
                  "Regler ganz links auf 0 = alle Vermögen sind steuerpflichtig.",
                  " Regler ganz rechts auf 100 = kein Vermögen wird besteuert.",
                  br(), "Tipp: Stelle dir alle Vermögen in einer Reihe der Größe nach aufsteigend sortiert vom kleinsten bis zum größten Vermögen vor. Bis zu welcher Position auf dieser Linie von 0 bis 100 sollen die Vermögen steuerfrei bleiben? Nur Vermögen ab dieser Position werden besteuert. Standardmäßig ist 80 voreingestellt, das bedeutet die 80% kleineren Vermögen werden nicht besteuert, die 20% größten Vermögen schon. Beispiel 10 =  nur die kleinsten 10% der Vermögen werden nicht besteuert, Beispiel 99.5 = die kleinsten 99.5 % der Vermögen werden nicht besteuert, somit zahlen nur die größten 0.5% aller Vermögen Steuern.",
#                  verbatimTextOutput(outputId = "result"),
                  hr(),
                  sliderInput(
                    "sliderSteuerprozent",
                    "Steuerprozentsatz: Wieviel Prozent ihres Vermögens müssen Personen, deren Vermögen über der Steuerfreigrenze liegt, an Vermögensteuer abführen?",
                    0,
                    100,
                    80
                  ),
                  p("Regler ganz links auf 0 = keine Vermögensteuer, Regler ganz rechts auf 100: der gesamte Vermögensanteil über der Steuerfreigrenze wird umverteilt; voreingestellt: 80")
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
                  helpText("über die einzelnen Vermögen am Ende des aktuellen Jahres"),
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
                  helpText("Gini-Koeffizient und Lorenz-Kurve siehe Menuseite 'Funktionsweise'")
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
            "Beim Neustart erhalten zum Jahresbeginn alle 1000 Personen das gleiche Startvermögen und verändern es jede Woche durch finanzielle Transaktionen.",
            br(), "Wie wird jede einzelne Transaktion simuliert? Unser Wirtschaftsleben ist stark durch exponentielles Wachstum bestimmt: für alle kapitalorientierten Transaktionen gilt: ",
            br(), code("neues Vermögen = altes Vermögen * multiplikativer Faktor"), ". In der Realität ist der multiplikative Faktor ein Zinsgewinn, Mietertrag oder Investitionsgewinn, mit dem das alte Vermögen multipliziert wird. Jedenfalls hängt hier die Höhe des neuen Vermögens stark von der Höhe des alten Vermögens ab. Im Modell verwenden wir als multiplikativen Faktor normalverteilte Zufallszahlen mit einem voreingestellten Mittelwert = 1,03 und der Standardabweichung = 0,2.",
            br(), "Zusätzlich gibt es auch ein additives Wachstum, das durch Erwerbsarbeit, Pensionen oder Mietzahlungen der kleinen Leute entsteht. Dieses Wachstum hängt nicht von der aktuellen Vermögenshöhe ab. Hier gilt: ",code("neues Vermögen = altes Vermögen + additiver Faktor"), 
            ". Im Modell verwenden wir als additiven Faktor normalverteilte Zufallszahlen mit einem voreingestellten Mittelwert = 0,03 und der Standardabweichung = 0,2.",
            br(), "Mit diesen Werten stellen wir ein geringfügig positives, aber variierendes  Wachstum ein. Diese Parameter wie auch das Startvermögen kannst du mit den entsprechenden Schiebereglern auf der Menuseite ", em("Parameter"), " verändern. Dort kannst du auch entscheiden, ob du exponentielles oder additives Wachstum oder beide Wachstumsarten nebeneinander simulieren möchtest.",
            br(), "So simulieren wir mit den so parametrisierten Zufallszahlen für jede Woche des aktuellen Jahres die Vermögensveränderung für jede der 1000 Personen. Logischer Weise sind dann die Vermögen zum Jahresende unterschiedlich hoch. Das ist nicht verwunderlich, manche haben eben mehr Glück bei ihren finanziellen Entscheidungen. Daher erwarten wir, dass sich zum Jahresende die Personen in unterschiedlichen Vermögensklassen befinden.",
            "So müssten wir auf der Menuseite ", em("Simulation"), " ausgewogene Histogramme sehen mit etwa gleich besetzten Vermögensklassen. Erstaunlicherweise beobachten wir aber eine schiefe ungleiche Verteilung, wenn - wie in der Realität - exponentielles Wachstum im Spiel ist: ",
            br(), strong("Wenige Personen sind reich geworden und die meisten befinden sich in der Klasse mit den kleinsten Vermögen."),
            br(), br(), "Das verdeutlicht auch die Menuseite ", em("Ungleichheit: "),
            "Hier findest du analog zur Menuseite ", em("Simulation"), " statistische Werte zur Ungleichheit zu Jahresbeginn, zum Jahresende und nach einer eventuellen Umverteilung.",
            br(), "In den Tabellen werden Vermögensanteile für verschiedene Personenklassen angezeigt.",
            br(), "Der ", strong("Gini-Koeffizient")," darunter ist eine Kennzahl für die aktuelle Ungleicheit. Zu Simulationsbeginn ist er 0, das bedeutet: alle haben das gleiche Vermögen. Der Gini-Koeffizient wäre 1 bei maximaler Ungleichheit, also dann, wenn eine Person des gesamte Vermögen besitzt und alle anderen nichts. Näheres zum Gini-Koeffizient: ",
            a(href = "https://de.wikipedia.org/wiki/Gini-Koeffizient", "https://de.wikipedia.org/wiki/Gini-Koeffizient"),
            br(), "Die ", strong("Lorenz-Kurven"), " zeigen grafisch an, welcher Personenanteil welchen Anteil am Gesamtvermögen hat. Näheres zur Lorenz-Kurve findet du unter: ",
            a(href = "https://de.wikipedia.org/wiki/Lorenz-Kurve", "https://de.wikipedia.org/wiki/Lorenz-Kurve"),
            ". Je stärker die rote Lorenzkurve nach rechts unten durchhängt, desto grösser ist hier die Ungleichheit.",
            br(),br(), "Du kannst die Ungleichheit durch höhere Vermögensteuern mildern und zwar durch Erhöhen des Steuerprozentsatzes oder Senken der Steuerfreigrenze. Diese senkst du, indem du den ", em("grünen Schieberegler"), " auf der Menuseite ", em("Simulation"), " weiter nach links bewegst.",
            " Die Steuerfreigrenze, also der Grenzbetrag, ab dem Vermögensteuer zu zahlen ist, stellst du analog zur Lorenz-Kurve ein. Stelle dir dazu alle Vermögen in einer Reihe der Größe nach aufsteigend sortiert vom kleinsten bis zum größten Vermögen vor. Bis zu welcher Position auf dieser Linie von 0 bis 100 sollen die Vermögen steuerfrei bleiben? Nur Vermögen ab dieser Position werden besteuert.",
            " Beispiel 10 =  nur die kleinsten 10% der Vermögen werden nicht besteuert, Beispiel 99.5 = die kleinsten 99.5 % der Vermögen werden nicht besteuert, somit zahlen nur die größten 0.5% aller Vermögen Steuern.",
            " Standardmäßig ist die Vermögensgrenze, ab der Steuer fällig wird, so eingestellt, dass nur die 20% größten Einzelvermögen Steuer zahlen und die 80% kleinsten Einzelvermögen unbesteuert bleiben.",
            br(),"Mit dem ", em("roten Schieberegler"), " stellst du den Prozentsatz ein, mit dem der Vermögensanteil, der über der Steuerfreigrenze liegt, besteuert werden soll. Dieser Steuersatz ist standardmäßig auf 80% gesetzt.",
            br(), "Die zum Jahresende eingehobene Vermögensteuer wird (in der Form von staatlichen Sozialleistungen) gerecht auf alle Personen verteilt, also auch auf die Reichen.",
            br(), "Wenn du auf den ", em("orangen Button 'weiteres Jahr'"), " drückst, werden alle Vermögen vom Jahresende nach Umverteilung auf den Beginn eines weiteren Jahres übertragen und dieses weitere Jahr wie oben mit neuen Zufallszahlen simuliert und angezeigt. ",
            br(), "So kannst du den Ablauf mehrerer Jahre - egal ob mit hohen, geringen oder gar keinen Vermögensteuern - simulieren und Höhe und Verteilung der Vermögen beurteilen. ",
            br(), "Auf der Menuseite ", em("Jahresverlauf"), " siehst du die Entwicklung des Gesamtvermögens aller Personen in diesem Jahr und welche Auswirkungen die Umverteilung haben kann."
          ),
          box(
            title = "Fragen",
            width = 3,
            br(), strong("Warum weisen die Werte zum Jahresende auf größere Ungleichheit hin?"), " Handelt es sich dabei um einen einmaligen zufälligen Effekt? Was kannst du gegen diesen Effekt tun? ",
            br(), br(), strong("Wie gefällt dir der Unterschied mit / ohne Umverteilung?"), " Umverteilen hat ja beängstigende Namen: Vermögensteuer, Erbschaftsteuer. Aber keine Angst, richtig angewendet verliert dabei mittelfristig niemand, auch nicht die Reichen. Kooperative Umverteilung bewirkt Vermögenszuwachs für alle.",
            br(), br(), strong("Hast du ausprobiert, was bei zunehmender Umverteilung mit dem Gesamtvermögen geschieht?"), 
            br(), " Wahrscheinlich profitieren die Ärmeren.",
            br(), strong("Aber wie ergeht es den Reichen?"), "Haben sich ihre Chancen stark verringert?"
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
            "Die in der Realität beobachteten Phasenübergänge liefern dort Gegenbeispiele: beim Erstarren einer Flüssigkeit gilt die ergodische Hypothese ", strong("nicht"), ". Diese Hypothese kann daher dort nicht mehr ohne Einschränkungen angenommen werden.",
            br(), "Das vorliegende Simulationsmodell liefert ein praktisches ", strong("Gegenbeispiel"), " zur ergodischen Hypothese in der Wirtschaft und widerlegt sie damit. Wir zeigen damit, dass die ergodische Hypothese bei ", strong("exponentiellen"), " Wachstumsprozessen NICHT gilt.",
            br(), br(), "Exponentielle Wachstumsprozesse entstehen immer dann, wenn die Höhe des finanziellen Erfolges oder Misserfolges einer Transaktion vom eingesetzten Kapital abhängt (", em("Zinserträge, Dividenden, Mieterlöse, Investitionsgewinne"), ", etc.). ",
            br(), "Im Gegensatz dazu kann bei ", strong("additiven"), " Wachstumsprozessen (Vermögensveränderungen durch ", em("reine Erwerbsarbeit, Pensionseinkünfte, aber auch Ausgaben des täglichen Bedarfs, Mietzahlungen der kleinen Leute"), ", o.ä.) Ergodizität durchaus angenommen werden. Rein additive Wachstumsprozesse führen zu gerechten normalverteilten Vermögen, wie wir es intuitiv annehmen würden.",
            "Exponentielle Wachstumsprozesse aber führen zu schiefen Vermögensverteilungen - entgegen unserer gefühlsmäßigen Einschätzung.",
            br(), br(), "Du kannst das einfach im Modell veranschaulichen, in dem du im Menu ", em("Parameter"), " bei ", em("'Wachstumsart' 'rein additiv'"), " auswählst und auf ", em("'Neustart'"), " drückst und das Histogram zum Jahresende betrachtest. ",
            "Dann wählst du die Wachstumsart ", em("'rein exponentiell'"), " aus, drückst auf wieder auf ", em("'Neustart'"), " und beurteilst die Unterschiede beim Histogramm.",
            br(), br(), strong("Bei exponentiellen Wachstumsprozessen führt die Annahme von Ergodizität unweigerlich zu falschen Schlüssen."),
            br(), "Der Mittelwert des Vermögens aller Personen zu einem bestimmten Zeitpunkt liefert hier ", strong("keine sinnvollen Voraussagen"), " über das mögliche Vermögen einer einzelnen Person.",
            br(), "Daher darf auch in der Ökonomie Ergodizität nicht generell postuliert werden. ",
            br(), "Die traditionelle liberale Wirtschaftslehre setzt aber - absichtlich oder unabsichtlich - die ", strong("additiven"), " Vermögensveränderungen der kleinen Leute gleich mit den ", strong("exponentiellen"), " Vermögensveränderungen eines Kapitalisten.",
            br(), "Damit hat sie uns immer wieder in die Irre geführt und ständige ", strong("Fehlentscheidungen der Politiker"), " verursacht.",
            br(), "Ein steigendes Bruttosozialprodukt eines Staates bedeutet somit keineswegs steigendes Vermögen für alle seine Bürger.",
            br(), "Auch der Satz 'Geht es der Wirtschaft gut, geht es allen gut' ist eine ", strong("grob irreführende Schlussfolgerung.")
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
            br(), br(), "What is ergodicity?, Lars P. Syll, 2016",
            br(), a(href = "https://larspsyll.wordpress.com/2016/11/23/what-is-ergodicity-2/", "https://larspsyll.wordpress.com/2016/11/23/what-is-ergodicity-2/", target="_blank"),
            br(), br(), "Ergodicity Economics, Ole Peters, Alex Adamou, 2018",
            br(), a(href = "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf", "https://ergodicityeconomics.files.wordpress.com/2018/06/ergodicity_economics.pdf"),
            br(), br(), "Democratic domestic product, Ole Peters, 2020",
            br(), a(href = "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/", "https://ergodicityeconomics.com/2020/02/26/democratic-domestic-product/"),
            br(), br(), "Wealth Inequality and the Ergodic Hypothesis, Yonatan Berman, Ole Peters, Alexander Adamou, 2020",
            br(), a(href = "https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2794830", "https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2794830", target="_blank"),
            br(), br(), "Ergodizität, Wikipedia, 2021",
            br(), a(href = "https://de.wikipedia.org/wiki/Ergodizit%C3%A4t", "https://de.wikipedia.org/wiki/Ergodizit%C3%A4t"),
            br(), br(), "Fermi–Pasta–Ulam–Tsingou problem, Wikiwand, 2021",
            br(), a(href = "https://www.wikiwand.com/en/Fermi%E2%80%93Pasta%E2%80%93Ulam%E2%80%93Tsingou_problem", "https://www.wikiwand.com/en/Fermi%E2%80%93Pasta%E2%80%93Ulam%E2%80%93Tsingou_problem"),
            br(), br(), "The Triumph of Injustice, Tax policy simulator, Gabriel Zucman, 2019",
            br(), a(href = "https://taxjusticenow.org/", "https://taxjusticenow.org/")
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
                  helpText("Bitte wähle hier die gewünschte Wachstumsart durch Anklicken aus."),
                  radioButtons("rBwachstum", "Wachstumsart:",
                   c("rein exponentiell" = "mult",
                     "rein additiv" = "add",
                     "gemischt" = "addMult"),
                   selected = "mult")
                ),
                box(
                  title = "Leverage (Hebel)",
                  width = 6,
                  helpText(
                    "Hier kannst du einstellen, welchen Prozentsatz ihres Vermögens Personen bei allen ihren Transaktionen einsetzen. Standardmäßig eingestellt sind 100%. Mehr als 100% würde bedeuten, zusätzlichen Kredit aufzunehmen. Unter 0% wäre ein Short, bedeutet die Rolle der Bank zu übernehmen."
                  ),
                  sliderInput("sliderLeverage", "Leverage:", -100, 200, 100)
                ),
                box(
                  title = "Startvermögen",
                  width = 6,
                  helpText(
                    "Dieser Regler steuert das beim Neustart zugewiesene Startvermögen"
                  ),
                  sliderInput("sliderStartVermoeg", "Startvermögen:", 0.1, 100, 1)
              )
              )),
tabItem(tabName = "impressumTab",
        fluidRow(
          box(
            title = "Impressum:",
            width = 4,
            "This website is provided by:",
            br(), "Information Design Institute, 120 Hoetzendorfstrasse,",
            "A-2231 Strasshof, Austria / Europe,",
            br(), "Tel.: +43 650 2287 001, nagler@idi.co.at,",
            a(href = "https://www.idi.co.at/", "https://www.idi.co.at/", target="_blank"),
            br(), br(), "Managing director and responsible for content: Dipl.-Ing. Dr. Rupert Nagler, Dr. Nagler KG,",
            br(), "Line of Business: Consulting, Register number: 174660 d, UID: ATU45617202",
            br(), br(), "This website may contain links to other sites. We are not responsible for linked content.",
            br(), br(), "Developed in Rstudio V4.0+ with library 'shinydashboard'.",
            br(), "Open Sourcecode public available at:",
            a(href = "https://github.com/rnagler/prosperity/", "https://github.com/rnagler/prosperity/", target="_blank"),
            hr(),
            br(), h4("Netter Song, zur Einstimmung ins Thema:"),
            "Everybody Knows, Leonard Cohen, 1988 (to play while viewing this website)",
            br(), a(href = "https://www.youtube.com/watch?v=xu8u9ZbCJgQ", "https://www.youtube.com/watch?v=xu8u9ZbCJgQ", target="_blank"),
            br(), br(), "Everybody knows that the dice are loaded",
            br(), "    Everybody rolls with their fingers crossed",
            br(), "    Everybody knows the war is over",
            br(), "    Everybody knows the good guys lost",
            br(), "    Everybody knows the fight was fixed",
            br(), "    The poor stay poor, the rich get rich",
            br(), "    That's how it goes",
            br(), "    Everybody knows..."
          ),
          box(
            title = "Märchen: Die Insel der Seeligen, eine einfache analoge Einstimmung zur Umverteilung",
            width = 8,
            "Es war einmal ein Reisender, der segelte durch unbekannte gefährliche Meere. In einem schrecklichen Unwetter kentert sein Boot. Er hat Glück und wird total erschöpft an den Strand der Insel der Seeligen gespült.",
            br(), "Dort leben 1000 Insulaner in perfektem Frieden. Alle sind auffallend glücklich und zufrieden. Überaus hilfsbereit nehmen sie den Gestrandeten bei sich auf. Als er wieder zu Kräften gekommen ist erzählen ihm ihre Geschichte:",
            br(), "Sie beginnen alle mit dem gleichen Vermögen und lassen ihr Geld arbeiten. Sie investieren es in die wunderschöne Landschaft, bauen auf fruchtbaren Böden herrliche Früchte an und züchten kräftige Tiere, die sie an ihre Mitbewohner verkaufen. Manche legen ihr Geld auf Sparbücher mit prächtigen Zinsen. ",
            "Auf dieser Insel der Seeligen möchte keiner den anderen übervorteilen oder gar betrügen.",
            br(), "Aber so gerecht und ehrlich sie auch zueinander sind, immer wieder passiert es, dass ganz wenige von ihnen viel reicher werden und alle anderen fast nichts mehr haben. Gegen diesen unerklärlichen Verlauf haben sie aber eine einfache Lösung gefunden:",
            br(), "Am Ende eines Jahres werfen sie einen grossen Teil aller Vermögen auf einen Haufen und verteilen diesen wieder gerecht an alle. Das nennen sie 'Umverteilung'. Der Gestrandete wundert sich über diesen ungewöhnlichen Brauch und fragt, wie sie auf diese seltsame Idee gekommen sind.",
            br(), "Sie erklären, dass in grauer Vorzeit ein Prophet bei ihnen gelandet war und ihnen dieses Vorgehen als für ihren inneren Frieden enorm wichtig empfohlen hat. Da erinnert sich der Gestrandete dunkel, dass er in der Schule ähnliches gelernt hatte: in vielen alten Kulturen war es üblich gewesen, entstandene Ungleichheit regelmässig auszugleichen, Namen wie 'Symposion' oder 'Jubileum' tauchen in seinem Gedächtnis auf.",
            br(), "Und wirklich erlebt unser Gestrandeter den Frieden, die Ruhe und Ausgeglichenheit der Inselbewohner als Beweis für die mächtige Wirksamkeit dieser seltsamen Umverteilung. Er denkt: 'Das ist ja wirklich wie auf einer Insel der Seeligen hier, ganz anders als in meinem Heimatland, wo Gier, Hektik und Mißgunst herschen.'",
            "Falls er durch glückliche Fügung jemals wieder in sein Heimatland zurückkehren könnte, dann würde er seinen Volksvertretern unbedingt eine ähnliche Vorgangsweise empfehlen.",
            br(), "Nach einigen glücklichen Jahren, die er noch auf der Insel der Seeligen verbringen darf, erscheint eines Tages ein silbernes Boot am Horizont, das ihn schließlich an Bord nimmt und nach langer Fahrt in sein Heimatland zurück bringt.",
            br(), "Einerseits ist er jetzt froh, wieder zu Hause zu sein, andererseits ist er entsetzt, wie sich die Lage in seinem Land verschlechtert hat: Viele Leute sind völlig verarmt, auch seine Brüder, Schwestern und Freunde. Er wundert sich auch über hohe Mauern mit vielen Wächtern an Orten, mit denen sich wenige Reiche aus Angst vor den Armen schützen wollen und die vielen schwer bewaffneten Polizisten, die ängstlich die jammernden Armen von Verzweiflungstaten abhalten müssen.",
            br(), "So sucht er um Audienz bei seinen Volksvertretern an. Als er endlich vorgelassen wird, berichtet er ihnen über seine Erlebnisse auf der Insel der Seeligen und schlägt ihnen diese regelmäßige Umverteilung zur Wiedererlangung des inneren Friedens vor. Doch da brechen die Volksvertreter in ein verzweifeltes Lachen aus.",
            "Sie sagen, dass so etwas bei ihnen gänzlich unmöglich sei. Das von ihnen vertretene Volk bewundere die Reichen und verehre sie besonders intensiv. Viele Arme glaubten in ihrer Verblendung, Vermögen sei sakrosankt. Daher dürfe man niemandem etwas wegnehmen. So sehr wünschen auch die Armen, den Reichen ähnlich zu sein, dass sie jegliche Umverteilung als undenkbar und sogar sündhaft ablehnen.",
            br(), "Dabei geraten immer mehr Menschen in bittere Armut. Manche von diesen Unglücklichen versuchen mit Gewalt, anderen ihr Eigentum zu entreissen. Leider sind das meist ähnlich Arme wie sie selbst, da die Reichen in ihren sicheren Schlössern hinter den hohen Mauern für sie unerreichbar sind. Aber die Reichen werden immer gieriger. Sie versuchen durch unredliche Machenschaften, noch mehr Vermögen anzuhäufen.",
            "Sie verlangen von den Armen immer höhere Mieten und Zinsen, zahlen immer geringere Löhne, bedrohen manche Beamte, um noch mehr Vorteile zu erlangen. Mächtige Reiche bestechen sogar Volksvertreter diese Gesetze zu beschließen, die es ihnen erlauben, die Armen noch mehr auszubeuten.",
            br(), "Den Reichen gelingt es immer mehr, Vermögen als heilig und die Ungleichheit als naturgegeben und von Gott gewollt hinzustellen. Daher traut sich kein  Volksvertreter, mutig geeignete Naßnahmen gegen die immer stärker wachsende Ungleichheit zu ergreifen.",
            br(), "Und so kommt es schließlich zu einem fürchterlichen Bürgerkrieg, bei dem alle Reiche und viele Arme ihr Leben verlieren. Und wenn die wenigen Überlebenden nicht auch schon gestorben sind, dann leben sie heute noch - aber nur mit regelmäßiger Umverteilung wie auf der Insel der Seeligen."
          )
        ))
    )
  ),
message(glue("end ui")),
footer = dashboardFooter(left = "Rupert Nagler",
                         right = "(c) Information Design Institute, 2023")
)
#message(glue("end ui out")) wenn das activ, dann wird ui nicht gefunden
