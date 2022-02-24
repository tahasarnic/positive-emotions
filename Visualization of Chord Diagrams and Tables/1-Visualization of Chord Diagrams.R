# Installing required packages
devtools::install_github("mattflor/chorddiag")
install.packages("Polychrome")
install.packages("webshot")
webshot::install_phantomjs()
install.packages("htmlwidgets")
install.packages("htmltools")

# Importing required packages
library(chorddiag)
library(Polychrome)
library(webshot)
library(htmlwidgets)
library(htmltools)

## Within Clusters

# Importing dataset
within_17_chord <- read.csv("https://raw.githubusercontent.com/tahasarnic/positive-emotions/main/Visualization%20of%20Chord%20Diagrams%20and%20Tables/Data/within_17_chord.csv")

# Manipulation on dataset
within_17_chord = as.matrix(within_17_chord)
dimnames(within_17_chord) <- list(Emotion = c('Admiration', 'Amae', 'Amusement', 'Awe', 'Determination', 'Elation',
                                         'Elevation', 'Excitement', 'Gratitude', 'Hope', 'Inspiration',
                                         'Interested', 'Lust', 'Moved', 'Positive_Surprise', 'Pride', 'Relief',
                                         'Respected', 'Schadenfreude', 'Sensory_Pleasure', 'Tenderness', 'Triumph'),
                             Cluster = 1:17)

# Build-in color palette
P35 = createPalette(35,  c("#ff0000", "#00ff00", "#0000ff"))

# Chord diagram
within_chord <- chorddiag(within_17_chord, type = "bipartite", groupPadding = 3, groupColors = as.vector(P35),
                              categoryNames = c(" ", " "), showTicks = F, groupnameFontsize = 13,
                              groupnamePadding = 5, margin = 110, chordedgeColor = "black", 
                              width = 800,  height = 800)

# Viewing chord
browsable(within_chord)

# Exporting html and png
saveWidget(within_chord, "within_chord.html", selfcontained = TRUE)
webshot("within_chord.html", "within_chord.png", delay = 0.2, vwidth = 900, zoom = 5)


## Across Clusters

# Importing dataset
across_17_chord <- read.csv("https://raw.githubusercontent.com/tahasarnic/positive-emotions/main/Visualization%20of%20Chord%20Diagrams%20and%20Tables/Data/across_17_chord.csv")

# Manipulation on dataset
across_17_chord = as.matrix(across_17_chord)
dimnames(across_17_chord) <- list(Emotion = c('Admiration', 'Amae', 'Amusement', 'Awe', 'Determination', 'Elation',
                                         'Elevation', 'Excitement', 'Gratitude', 'Hope', 'Inspiration',
                                         'Interested', 'Lust', 'Moved', 'Positive_Surprise', 'Pride', 'Relief',
                                         'Respected', 'Schadenfreude', 'Sensory_Pleasure', 'Tenderness', 'Triumph'),
                             Cluster = 1:17)

# Build-in color palette
P35 = createPalette(35,  c("#ff0000", "#00ff00", "#0000ff"))

# Chord diagram
across_chord <- chorddiag(across_17_chord, type = "bipartite", groupPadding = 3, groupColors = as.vector(P35),
          categoryNames = c(" ", " "), showTicks = F, groupnameFontsize = 13,
          groupnamePadding = 5, margin = 110, chordedgeColor = "black", 
          width = 800,  height = 800)

# Viewing chord
browsable(across_chord)

# Exporting html and png
saveWidget(across_chord, "across_chord.html", selfcontained = TRUE)
webshot("across_chord.html", "across_chord.png", delay = 0.2, vwidth = 900, zoom = 5)


## Two Chord Together (Within and Across)

# Combining chords
two_chord <- tagList(
  div(
    style = "display: flex; justify-content: space-between;",
    div(
      style = "display: flex; flex-direction: column-reverse; align-content: flex-start; align-items: center; width: 50%",
      within_chord,
      p(style = 'font-size:200%;', 'Within Clusters')
    ),
    div(
      style = "display: flex; flex-direction: column-reverse; align-content: flex-start; align-items: center; width: 50%",
      across_chord,
      p(style = 'font-size:200%;', 'Across Clusters')
    )
  )
)

# Viewing chord
browsable(two_chord)

# Exporting html and png
save_html(html = two_chord, file = "two_chord.html")
webshot("two_chord.html", "two_chord.png", delay = 0.2, vwidth = 1450, zoom = 5)

