####--------------------------------------------------------------------####
# Utils for webscraping twitter data #
####--------------------------------------------------------------------####

# Function for downloading twitter data
#--------------------------------------

get_sentiment_plot_df <- function(hashtag, 
                                  number_of_tweets, 
                                  date_from, 
                                  date_to){
  # This function searches twitter with a hashtag and downloads all 
  # tweets into a dataframe
  # Args:
  #   Inputs:
  #     hashtag: hashtag to be searched in twitter (string)
  #     number_of_tweets: maximum number of tweets returned
  #   Returns:
  #     data frame with stored tweets
  
  hashtag <- as.character(hashtag)
  tweets <- searchTwitter(hashtag, 
                          lang = "en", 
                          n=number_of_tweets, 
                          since = date_from, 
                          until = as.character(date_to))
  tweets <- twListToDF(tweets) %>% 
    mutate(coin = hashtag)
  
  return(tweets)
}

####--------------------------------------------------------------------####
# Utils for analysing twitter data
####--------------------------------------------------------------------####


# 
#   #### Busines Logic
#   tweets <- tweets %>% 
#     mutate(created = ymd_hms(created)) %>% 
#     arrange(created) %>% 
#     mutate(line = row_number())
#   
#   tweets_unnested <- 
#     unnest_tokens(tbl = tweets, input =  text, token = "words", format = "text", output = "word")
#   
#   sentiment <- tweets_unnested %>% inner_join(afinn, by = "word") %>% group_by(line, created) %>% 
#     summarize(value = sum(value))
#   
#   sentiment_plot_df <- sentiment %>% group_by(created) %>% 
#     summarize(value = sum(value)) %>% 
#     separate(created, into = c("date", "time"), sep = " ") %>% 
#     separate(time, into = c("hour", "minute", "second")) %>% 
#     group_by(hour, date) %>% 
#     summarize(value = mean(value)) %>% 
#     ungroup %>% 
#     mutate(coin = hashtag)
#   
#   return(sentiment_plot_df)
# }
