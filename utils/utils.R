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

