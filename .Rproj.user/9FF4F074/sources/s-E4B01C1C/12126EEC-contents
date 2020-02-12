####--------------------------------------------------------------------####
# Main script for webscraping Twitter data
####--------------------------------------------------------------------####

source("utils/packages.R")
source("utils/utils.R")
source("utils/authentication.R")

# Authenticate
setup_twitter_oauth(api_key, api_secret_key, access_token, access_token_secret)

# Desired Hashtags

hashtags <- c("$BTC", "$ETH", "$LTC", "$XRP", "$BCH")

# Load afinn data
afinn <- read.csv("utils/afinn_data.csv", header = TRUE)

# Time specifications
date_from <- as.character(Sys.Date() - 1)

# Specify output path
output_path <- "results/data/"


for(hashtag in hashtags){
  df <- get_sentiment_plot_df(hashtag = hashtag,
                              number_of_tweets = 100,
                              date_from = date_from,
                              date_to = Sys.Date())
  filename <- paste0(Sys.Date(), hashtag, ".csv")
  filename <- gsub("\\$", "_", filename)
  filename_full <- paste0(output_path,filename)
  write.csv(file = filename_full, x = df, row.names = FALSE)
}