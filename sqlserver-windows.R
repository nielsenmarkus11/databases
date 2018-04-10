# install.packages(c('odbc','getPass','dplyr'))
library(odbc)
library(getPass)
library(dbplyr)

db <-DBI::dbConnect(odbc(), "SQL")

# dbWriteTable(db,"iris",iris)

dbGetQuery(db,"SELECT * FROM IRIS")

smry <- tbl(db,"iris") %>% collect

dbDisconnect(db)
