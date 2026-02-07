# Assessment 1 - Database Project

This project contains a MySQL database for a hospital system, including tables for hospitals, doctors, patients, and prescriptions.  
The repository demonstrates database design, data import, and SQL queries to extract and analyse the data.

## Repository Contents

- **hospitals.sql**
  FULL MySQL database dump including table structures and imported data.

- **diagrams**  
  - **Flowchart database hospitals.png** – Flowchart illustrating the database design and data loading process
  - **ERD Database hospitals.png** – Entity Relationship Diagram showing tables and relationships
 
- **queries.sql**  
  A collection of SQL queries that answer the assessment tasks.  
  Each query is commented to explain what it does and why it is used.
  Where appropriate, alternative approaches are shown (e.g. using 'WHERE' only and 'INNER JOIN').

## Data Handling

When importing the data from the CSV files, the tables were initially created **without AUTO_INCREMENT on the *primary key***.
This was done to preserve the original ID values from the source data. In particular, the *patients.csv* file uses patient IDs starting from 100, while the other CSV files use IDs staring from 1. These IDs were imported exactly as provided.

After all data had been successfully loaded, the *primary keys* for each table were updated using:

```sql
ALTER TABLE table
      MODIFY entity_id INT unsigned NOT NULL AUTO_INCREMENT;
```

This allows new records (e.g. new patients) to be inserted without manually specifying an ID and helps prevent key conflicts or errors during future inserts.
  
## Diagrams

### Entity Relationship Diagram (ERD)
<img src="diagrams/ERD_Database_hospitals.png" width="700">




