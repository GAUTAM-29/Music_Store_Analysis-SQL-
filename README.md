# Music Store Database Analysis

## Project Overview

This project is a SQL-based data analysis for a fictional music store database. The goal is to extract meaningful insights from the dataset using SQL queries. The project demonstrates proficiency in SQL by answering complex business questions and performing data analysis on music sales, customer spending, and artist popularity.

Dataset Details

The dataset consists of 11 CSV files, representing different tables in a relational database. The schema includes:
1. Artist.csv - Contains artist information with Artist ID and Name.
2. Album.csv - Stores album details, including Album ID, Title, and Artist ID.
3. Track.csv - Holds track details such as Track ID, Name, Album ID, Genre ID, Media Type ID, Composer, Duration (Milliseconds), and Unit Price.
4. Genre.csv - Provides Genre ID and Name.
5. MediaType.csv - Stores Media Type ID and Name.
6. Playlist.csv - Contains Playlist ID and Name.
7. PlaylistTrack.csv - Links Playlists to Tracks via Playlist ID and Track ID.
8. Employee.csv - Stores Employee details like Employee ID, Name, Title, and ReportsTo.
9. Customer.csv - Contains Customer ID, Name, Contact Details, and Support Rep ID.
10. Invoice.csv - Tracks invoices with Invoice ID, Customer ID, Invoice Date, Billing Address, Billing Country, and Total Amount.
11. InvoiceLine.csv - Stores invoice details, including Invoice Line ID, Invoice ID, Track ID, Quantity, and Unit Price.

# SQL Analysis & Queries

The project includes SQL queries solving real-world business problems such as:

- Identifying the best customers based on total spending.
- Finding the most popular music genre in each country.
- Determining the top-selling artists based on track sales.
- Identifying cities with the highest revenue generation for promotional events.
- Finding the customer who spent the most on music per country using Common Table Expressions (CTEs).
- Listing songs longer than the average track duration in the database.
- Finding the top rock bands by counting their total tracks.
- Identifying customers who listen to rock music.

#### ✯ This project showcases SQL data analysis skills by performing advanced queries, using JOINs, GROUP BY,   ORDER BY, subqueries, and CTEs, and deriving actionable insights from a music store database. This project is an excellent addition to a Data Science portfolio, demonstrating SQL expertise in business intelligence and database management.

## Tools Used

- MySQL Workbench: Used for writing and executing SQL queries.
- SQL: Used for querying and analyzing data.
- Excel/CSV Handling: Data was pre-processed in CSV format.

## How to Use

1. Import the dataset into MySQL Workbench.
2. Use the provided SQL queries to extract insights from the database.
3. Modify and extend the queries to explore additional insights.

## Files Included
________________________________________________________________________________
|File_Name               |Description                                          |
|------------------------|-----------------------------------------------------|
|MusicDatabaseSchema.png | Entity-Relationship Diagram of the database schema. |
|SQL_Script_Questions.pdf| List of business problems solved using SQL.         | 
|SQL_Solved_Script.pdf   | Solutions to the SQL questions.                     |
|SQL_Solved_Script.sql   | SQL script containing all queries.                  |
|Dataset (11 CSV files)  | The raw data for the music store.                   |

### Author: Gautam Acharya
### Contact: gautamacharya8665@gmaill.com
