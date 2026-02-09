# Airlines_SQL_Analysis
## Poject Overview
This project focuses on analyzing an **Air Cargo airline database**to extract meaningful business insights related to **customers, routes, ticket sales, pricing, and operational efficiency**.
<br>
<br>
The project demonstrates strong skills in:
- SQL data cleaning & transformation
- Database schema design
- Relationship building using foreign keys
- Business-driven analytical thinking

## Dataset Description
The database consists of 4 core tables:
<br>
**1.customer**
<br>
<br>Stores customer demographic information.
- customer_id (PK)
- first_name
- last_name
- date_of_birth
- gender

**2.passengers_on_flights**
<br>
<br>Captures passenger travel details.
- pof_id (PK)
- customer_id (FK)
- route_id (FK)
- aircraft_id
- travel_date
- seat_num
- class_id
- flight_num
 <br>
**3.routes**
Contains flight route information.
- route_id (PK)
- flight_num
- origin_airport
- destination_airport
- aircraft_id
- distance_miles
<br>
**4.ticket_details**
  Stores ticket purchase & pricing details.
  - tkt_id (PK)
  - customer_id (FK)
  - class_id
  - no_of_tickets
  - price_per_ticket
  - brand
  - purchase_date

## Tools & Technologies
- **Database:** MySQL
- **Language:** SQL
- **IDE:** MySQL Workbench
- **Data Source:** CSV files

## Data Preparation Steps
- Loaded CSV files using _Load data import wizard_
- Alter tables (modify\add)
- Converted incorrect datatypes (TEXT to DATE / INT)
- Added primary keys & auto-increment fields
- Built foreign key relationships
- Enforced data quality using NOT NULL & CHECK constraints

















  
