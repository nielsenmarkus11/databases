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
# https://docs.microsoft.com/en-us/sql/connect/sql-connection-libraries?view=sql-server-2017

# install.packages('RJDBC')

library(RJDBC)
library(getPass)

# Specify driver and path to driver in RJDBC 
# For Integrated Authentication add to java library path
options(java.parameters="-Djava.library.path=C:/Program Files/sqljdbc_6.4/enu/auth/x64") 
db <- DBI::dbConnect(RJDBC::JDBC("com.microsoft.sqlserver.jdbc.SQLServerDriver","C:/Program Files/sqljdbc_6.4/enu/mssql-jdbc-6.4.0.jre8.jar"),
                     url = "jdbc:sqlserver://localhost;databaseName=ML;integratedSecurity=true")

# Execute SQL query
DBI::dbGetQuery(db,"SELECT * FROM IRIS")

#Disconnect from database
DBI::dbDisconnect(db)





### pivot package ###
# install.packages('pivot')

library(dplyr)
library(dbplyr)
library(pivot)
library(odbc)

# Connect using the DSN
db <- DBI::dbConnect(odbc::odbc(), "SQL")

result <- tbl(db,"iris") %>% pivot(Species, mean(Petal.Length, na.rm = TRUE),
                                 setosa, versicolor, virginica)
sql_render(result)
