### RPostgreSQL setup ###

# sudo apt-get install libpq-dev
# install.packages("RPostgreSQL")

library(RPostgreSQL)
library(getPass)

pgdrv <- dbDriver(drvName = "PostgreSQL")

db <-DBI::dbConnect(pgdrv,
                    dbname="postgres",
                    host="localhost", 
                    port=5432,
                    user = 'postgres',
                    password = getPass("Enter Password:"))

# Write to database
DBI::dbWriteTable(db, "mtcars", mtcars)

# Execute SQL query
DBI::dbGetQuery(db,"SELECT * FROM MTCARS")

#Disconnect from database
DBI::dbDisconnect(db)


### odbc setup ###

# # Install the unixODBC library
# apt-get install unixodbc unixodbc-dev
# 
# # PostgreSQL ODBC Drivers
# apt-get install odbc-postgresql

library(odbc)
library(getPass)

# Set up connection without DSN
db <- DBI::dbConnect(odbc::odbc(),
                     Driver = "PostgreSQL Unicode",
                     Database = "postgres",
                     Servername = "localhost",
                     Port = 5432,
                     UserName = "postgres",
                     Password = getPass("Enter Password:"))

# Set up connection with DSN
# - Modify /etc/odbc.ini 
db <- dbConnect(odbc::odbc(), "PostgreSQL")

# Execute SQL query
DBI::dbGetQuery(db,"SELECT * FROM MTCARS")

#Disconnect from database
DBI::dbDisconnect(db)


### RJDBC setup ###

# # Install Java Client
# apt-get install default-jdk
#
# # Download PostgreSQL JDBC driver

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
