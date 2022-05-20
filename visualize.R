#Packages
#install.packages("flexdashboard", type = "source")
library(flexdashboard)
library(ggplot2)
library(dplyr)
library(rvest)
library(tidyverse)
library(stringr)

#import the csv file
df = read.csv("crypto.csv")
#View(df)
#summary(df)
#str(df)

#Top 10 traded vol
df %>% select(Currency, Traded_Vol) %>% filter(Traded_Vol > 500) %>% 
  top_n(10) %>%
  ggplot(., aes(reorder(Currency, Traded_Vol), Traded_Vol)) + 
  geom_bar(stat = "identity", aes(fill = Traded_Vol)) + coord_flip() +
  ggtitle("Top 10 Traded Volume") +  xlab("Currency") + ylab("Traded Volume") + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 10))


# Bar plot of Market Capitalization > 700
df %>% select(Currency, Market.Capitalization) %>% filter(Market.Capitalization > 700) %>%
  top_n(10) %>%
  ggplot(., aes(reorder(Currency, Market.Capitalization), Market.Capitalization)) + 
  geom_bar(stat = "identity", aes(fill = Market.Capitalization)) + coord_flip() +
  labs(x = "Currency", y = "Mrkt Cap", title = "Market Cap greater than 700B")