#Packages
library(rvest)
library(tidyverse)
library(stringr)

#Crytocurrency page path
url = read_html("https://www.tradingview.com/markets/cryptocurrencies/prices-all/")

#get cryptocurrency table from url
table = html_nodes(url, css = "table")

#Result is a list,so we must explicitly convert the result to a table or dataframe.
crypto_df = html_table(table, fill = T) %>% as.data.frame()

crypto_df = apply(crypto_df[, 2:8], 2, gsub, pattern = "[B M % K]", replacement = "") %>%
  cbind.data.frame(crypto_df$Var.1) %>% select(8, 1:7)

View(crypto_df)
str(crypto_df)

#create vector of names
x <- c("Currency", "Market Capitalization", "Fully_diluted_Mkt_Cap", "Last", "Avail_coins", 
    "Total_coins", "Traded_Vol", "Change%")

#Attach names to crypt_table
names(crypto_df) <- x
View(crypto_df)

#Convert columns except currency column to numeric data type
df2 <- data.frame(apply(crypto_df[2:8], 2, as.numeric)) %>%
  cbind(Currency = crypto_df$Currency) %>% select(8, 1:7)

str(df2)
write.csv(df2, "crypto.csv")