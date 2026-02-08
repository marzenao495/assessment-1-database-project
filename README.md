# Hospital Database Project

[GitHub Repository](https://github.com/marzenao495/assessment-1-database-project.git)

## About The Project

### **Project Overview**

​​This repository contains a MySQL-based hospital database developed as part of an academic assessment. The CSV files used in this project were provided as part of the course. The project includes database planning, implementation, data import from CSV files, and SQL querying using relational database principles.



## Database Description
The database stores information about hospitals, doctors, patients, and prescriptions.
Relationships between tables are implemented using primary and foreign keys to ensure data integrity.
Each patient is assigned to exactly one doctor, and prescriptions are linked to both patients and doctors.


## Repository Structure

### SQL Files

- **hospitals.sql**

  MySQL database dump containing the complete database schema and imported data. Importing this file recreates the hospital database used in this project.
 
- **queries.sql**  

  A collection of SQL queries that address the assessment tasks. Each query is commented to explain its purpose. Where appropriate, alternative query approaches are included (e.g. using `WHERE` clauses versus `INNER JOIN`).
  

### Diagrams

- **Flowchart database hospitals.png**

  Flowchart illustrating the database design process and data loading workflow.
  
- **ERD Database hospitals.png**

  Entity Relationship Diagram showing all tables and their relationships.



## Database Planning and Design

### Database Development Process
First, a flowchart was created to outline the overall planning process.
The provided CSV files were inspected, and the existing ID fields were adopted as primary keys; corresponding reference fields were used to define the foreign key relationships between tables.
Finally, the tables were implemented in MySQL, the data was imported, and the required SQL queries were executed.


### Flowchart
The flowchart illustrates the overall planning process of the database, including database design, table creation, data loading from CSV files, and handling of new data entries.


### Entity Relationship Diagram (ERD)

The ERD reflects the structure derived from the provided CSV data.
Each entity is defined with a primary key corresponding to the existing ID fields in the data.
Foreign key relationships represent the references between entities (e.g. doctors assigned to hospitals and prescriptions linked to patients), ensuring referential integrity in the relational schema.

The ERD illustrates all tables in the hospital database and their relationships:
- `Hospital` – `Doctor` (One-to-Many)
- `Doctor` – `Patient` (One-to-Many)
- `Doctor` – `Prescription` (One-to-Many)
- `Patient` – `Prescription` (One-to-Many)


This diagram was used to plan the database structure and ensure correct implementation of relationships using foreign keys. 


<img src="diagrams/2_ERD_Database_hospitals.png" width="700">



## Data Import and Primary Key Handling

The database was populated using CSV files provided as part of the assessment. The files (`hospitals.csv`, `doctors.csv`, `patients.csv`, `prescriptions.csv`) were imported into tables created without `AUTO_INCREMENT` on the primary keys. 
This ensured that the original ID values contained in the CSV files were preserved. In particular, `patients.csv` uses patient IDs starting from 101, while the other CSV files use IDs starting from 1. All IDs were therefore imported exactly as provided.

After the data import, the primary key columns were modified to use `AUTO_INCREMENT` to support future inserts without manually specifying primary key values. The following SQL statement illustrates how the primary key columns were updated after data import.

```sql
ALTER TABLE table
MODIFY entity_id INT unsigned NOT NULL AUTO_INCREMENT;
```

This approach allows new records (e.g. new patients) to be added safely and helps prevent primary key conflicts in future inserts.



## Usage

To load and explore the database:
1. Import the `hospitals.sql` file into a MySQL database (e.g. via terminal: `mysql -u root < hospitals.sql`).
2. Open the file `queries.sql`, which contains the SQL queries required for the assessment.
3. Execute the queries individually. Each query is commented to explain its purpose.




