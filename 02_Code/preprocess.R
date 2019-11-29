
library(highcharter)
library(billboarder)
library(lubridate)
library(tidyverse)
library(zoo)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(shinyWidgets)
library(shinythemes)
library(openintro)
library(mapproj)

ufo <- read.csv('ufo_processed.csv',header=TRUE)

# arrange date

ufo$datetime <- mdy_hm(ufo$datetime)
ufo$day <- factor(day(ufo$datetime))
ufo$month <- as.numeric(as.character(factor(month(ufo$datetime))))
ufo$year <- as.numeric(as.character(factor(year(ufo$datetime))))
ufo$dayofweek <- as.character(factor(wday(ufo$datetime, label = TRUE)))
ufo$hour <- factor(hour(ufo$datetime))
ufo$minute <- factor(minute(ufo$datetime))

ufo$state <- str_to_upper(as.character(ufo$state))
ufo$city <- str_to_title(as.character(ufo$city))


ufo <- ufo[ ufo$year>=1950,]

ufo <- ufo[ ufo$country=='us',]



ufo$n_ufos = 1

####################

filePath <- "wordcloud.txt"
text <- readLines(filePath)

docs <- Corpus(VectorSource(text))

#inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, toSpace, "#")
docs <- tm_map(docs, toSpace, "&")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("like")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
#head(d, 10)

freqlist <- seq(0, 50, 5)
wordlist <- seq(10, 350, 10)

sights <- aggregate(n_ufos~ year, ufo, sum)
tmp.df <- ufo[ufo$year>=2000 & ufo$year<=2014,]
tmp.df <- ufo[ufo$shape %in% c("light","triangle","fireball","circle","disk"),]

ufo$state_long <- abbr2state(ufo$state)
unique_states <- unique(ufo$state_long)
unique_states <- sort(unique_states)
unique_states <- c('All States',unique_states)

sights <- aggregate(n_ufos~ year, ufo, sum)

ufo$minute_duration <- ufo$duration/60
ufo$minute_duration <- round(ufo$minute_duration,digits=2)
new_ufo <- ufo[ufo$minute_duration <= 500 & ufo$minute_duration >= 0,]
new_ufo$new_state <- abbr2state(new_ufo$state)

####### MAPA


mapa_state <- aggregate(n_ufos~ state_long + year, ufo, sum)

long <- aggregate(longitude ~ state_long, ufo, mean)


lat <- aggregate(latitude ~ state_long, ufo, mean)

mapa_state <- merge(mapa_state, long, by = c('state_long'))
mapa_state <- merge(mapa_state, lat, by = c('state_long'))

