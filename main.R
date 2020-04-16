####--------------------------------------------------------------------####
# Main script for webscraping Twitter data
####--------------------------------------------------------------------####

setwd("/home/mkpi/Documents/webscraper_crypto/twitter/twitter_data_scraper/")
library(here)
print(here::here())
source("utils/packages.R")
source("utils/utils.R")
source("utils/authentication.R")

# Authenticate
setup_twitter_oauth(api_key, api_secret_key, access_token, access_token_secret)

# Desired Hashtags

hashtags <- c("$BTC", "$ETH", "$LTC", "$XRP", "$BCH",
		"bitcoin", "ethereum", "litecoin", "cryptocurrency", "btc",
		"eth", "ltc", "xrp","bch", "crypto")

# Load afinn data
afinn <- read.csv("utils/afinn_data.csv", header = TRUE)

# Time specifications
date_from <- as.character(Sys.Date() - 1)

# Specify output path
output_path <- "/mnt/shared/data/crypto/twitter/"


for(hashtag in hashtags){
  df <- get_sentiment_plot_df(hashtag = hashtag,
                              number_of_tweets = 20000,
                              date_from = date_from,
                              date_to = Sys.Date())
  filename <- paste0(date_from,"_", hashtag, ".csv")
  filename <- gsub("\\$", "", filename)
  filename_full <- paste0(output_path,filename)
  write.csv(file = filename_full, x = df, row.names = FALSE)
  Sys.sleep(600)
}
