# I'm using 

# sudo apt-get install libpq-dev
install.packages("RPostgreSQL")

library(RPostgreSQL)
library(DBI)
library(getPass)

pgdrv <- DBI::dbDriver(drvName = "PostgreSQL")

db <-DBI::dbConnect(pgdrv, dbname="postgres",
                      host="localhost", port=5432,
                      user = 'postgres',
                      password = getPass("Enter Password:"))

library(dplyr)
# Write to database
copy_to(db,mtcars,"mtcars", overwrite=TRUE)

DBI::dbGetQuery(db,"SELECT * FROM MTCARS")
