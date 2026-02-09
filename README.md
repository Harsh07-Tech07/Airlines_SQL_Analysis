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

**3.routes**
<br>
<br>Contains flight route information.
- route_id (PK)
- flight_num
- origin_airport
- destination_airport
- aircraft_id
- distance_miles

**4.ticket_details**
<br>
<br>Stores ticket purchase & pricing details.
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

## Key Insights
**1.Customer Base Insights**
- Majority of customers travel occasionally, not frequently.
- A small % of customers generate a large % of revenue.
- High-value customers mostly prefer Business / Premium classes.

**2.Route Performance Insights**
- Few routes contribute disproportionately high revenue.
- Some routes have high passenger volume but low revenue (pricing problem).
- Long-distance routes generate higher ticket value, even with fewer passengers.

**3.Pricing & Class Insights**
- Economy class drives volume, not profit.
- Business / Premium classes drive profit, not volume.
- Price per ticket varies significantly by route and aircraft type.

**4.Operational Insights**
- Certain aircraft types are underutilized.
- Route–aircraft mismatch observed on low-performing routes
- Seasonal travel patterns visible via travel_date (peaks & troughs).

## Overall business recommendations
**1.Customer Strategy**
- Create loyalty programs for top 10–15% revenue customers.
- Offer upgrade incentives from Economy to Business class.
- Personalize offers based on customer class preference.

**2.Route Optimization**
- Reprice high-demand / low-revenue routes.
- Reduce frequency or aircraft size on underperforming routes.
- Increase premium capacity on profitable long-haul routes.

**3.Pricing Strategy**
- Introduce dynamic pricing based on route demand
- Bundle services (meals, baggage, priority boarding) on long-haul routes.
-  Review Economy pricing floor on over-crowded routes.

**4.Fleet & Operations**
- Match aircraft type to route distance and demand.
- Retire or redeploy underperforming aircraft.
- Optimize seat configuration (more premium seats on key routes).


  
