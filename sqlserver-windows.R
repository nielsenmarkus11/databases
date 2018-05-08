### odbc setup ###

# install.packages('odbc')

library(odbc)
library(getPass)
library(dbplyr)

# Connect using the DSN
db <- DBI::dbConnect(odbc::odbc(), "SQL")

# Connect without a DSN
# Configure DSN with ODBC Data Source Administrator (64-bit)
db <- DBI::dbConnect(odbc::odbc(),
                     Driver = 'ODBC Driver 13 for SQL Server',
                     Server = 'DB-DEV',
                     Database = "ML",
                     trusted_connection = 'yes',
                     Port = 1433
                     )

# dbWriteTable(db,"iris",iris)

dbGetQuery(db,"SELECT * FROM IRIS")

smry <- tbl(db,"iris") %>% collect

dbDisconnect(db)


### RJDBC setup ###

# # Install Java Client
#
# # Download MS SQL Server JDBC driver

# install.packages('RJDBC')

library(RJDBC)
library(getPass)

# Specify driver and path to driver in RJDBC 
db <- DBI::dbConnect(RJDBC::JDBC("org.postgresql.Driver","postgresql-42.2.2.jar"),
                     url = "jdbc:postgresql://localhost:5432/postgres",
                     user = "postgres",
                     password = getPass("Enter Password:"))

# Execute SQL query
DBI::dbGetQuery(db,"SELECT * FROM MTCARS")

#Disconnect from database
DBI::dbDisconnect(db)