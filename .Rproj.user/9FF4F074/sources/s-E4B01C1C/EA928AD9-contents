# load library
library(twitteR)
library(tidyverse)
library(lubridate)
library(plotly)
library(tidytext)
library(here)
library(rvest)
library(stringr)
library(xml2)

### Load sentiment dictionary

afinn <- get_sentiments("afinn")

# Access tokens
api_key <- "lisSjjR8uPWeX4HqQjpgc0biF"
api_secret_key <- "hKj8Jwz6CgYdU0JYUZICUXCfRZDm0T091b4ro1kzz89HKkna8E"
access_token <- "1219510401542639617-gjwqhsvxXRTrzr05gfmkrZwvvNsCIq"
access_token_secret <- "ThCPaWb9qMK5JhS08pOc8Od1X7BWSrI9uzROh251S1AHJ"

# Authenticate
setup_twitter_oauth(api_key, api_secret_key, access_token, access_token_secret)

# Set Variables

## date since to scrape.

date_from <- as.character(Sys.Date() - 1)

#### Get hashtag df

get_sentiment_plot_df <- function(hashtag, number_of_tweets){
  
  hashtag <- as.character(hashtag)
  tweets <- searchTwitter(hashtag, lang = "en", n=number_of_tweets, since = date_from, until = as.character(Sys.Date()))
  tweets <- twListToDF(tweets)
  
  tweets <- tweets %>% 
    mutate(created = ymd_hms(created)) %>% 
    arrange(created) %>% 
    mutate(line = row_number())
  
  tweets_unnested <- 
    unnest_tokens(tbl = tweets, input =  text, token = "words", format = "text", output = "word")
  
  sentiment <- tweets_unnested %>% inner_join(afinn, by = "word") %>% group_by(line, created) %>% 
    summarize(value = sum(value))
  
  sentiment_plot_df <- sentiment %>% group_by(created) %>% 
    summarize(value = sum(value)) %>% 
    separate(created, into = c("date", "time"), sep = " ") %>% 
    separate(time, into = c("hour", "minute", "second")) %>% 
    group_by(hour, date) %>% 
    summarize(value = mean(value)) %>% 
    ungroup %>% 
    mutate(coin = hashtag)
  
  return(sentiment_plot_df)
}

btc <- get_sentiment_plot_df('$BTC', 20000 )
eth <- get_sentiment_plot_df('$ETH', 20000 )
ltc <- get_sentiment_plot_df('$LTC', 20000 )

crypto_sentiment <- bind_rows(btc,eth,ltc)

g <- ggplot(data = crypto_sentiment, aes(x=hour, y=value, group=coin)) + geom_line(aes(colour = coin))

ggplotly(g)

# get tweets

tweets <- searchTwitter('$BTC', lang = "en", n=20000, since = date_from, until = as.character(Sys.Date()))
tweets <- twListToDF(tweets)

# tidy

tweets <- tweets %>% 
  mutate(created = ymd_hms(created)) %>% 
  arrange(created) %>% 
  mutate(line = row_number())

tweets_unnested <- 
  unnest_tokens(tbl = tweets, input =  text, token = "words", format = "text", output = "word")

sentiment <- tweets_unnested %>% inner_join(afinn, by = "word") %>% group_by(line, created) %>% 
  summarize(value = sum(value)) #%>% mutate(Time = as.numeric(Time)) 

overall_sentiment <-  sentiment %>% ungroup %>%  select(value) %>% 
  summarize(sum(value)/nrow(sentiment))

print(overall_sentiment)

sentiment_plot <- sentiment %>% group_by(created) %>% 
  summarize(value = sum(value)) %>% 
  separate(created, into = c("date", "time"), sep = " ") %>% 
  separate(time, into = c("hour", "minute", "second")) %>% 
  group_by(hour, date) %>% 
  summarize(value = mean(value)) %>% 
  ungroup

g <- ggplot(data = btc, aes(x=hour, y=value, group=date)) + geom_line()

ggplotly(g)
# 
# trend <- availableTrendLocations()
# 
# #getting Trends
# 
# Zurich <- getTrends(784794)
# head(Zurich)
