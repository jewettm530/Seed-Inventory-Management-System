# Table: Seeds
## Description: The master registry for all plant varieties in the collection.
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | seed_id | NUMBER | PK, Identity | Unique internal identifier for the seed variety |
 | common_name | VARCHAR2(50) | NOT NULL | The primary name used by gardeners (e.g., 'Tomato') | 
 | scientific_name | VARCHAR2(50) | - | The Latin botanical name (e.g., 'Solanum lycopersicum') | 
 | type | VARCHAR2(25) | - | Category: vegetable, flower, fruit, herb, etc. | 
 | life_cycle | VARCHAR2(15) | CHECK | Restricted to 'annual', 'perennial', or 'biennial' | 
 | characteristics | VARCHAR2(100) | - | Physical traits (e.g., 'Heirloom', 'Drought-tolerant') | 

# Table: Supplier
## Description: Information regarding the source of the seeds
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | supplier_id | NUMBER | PK | Unique identifier for the seed source
 | supplier_name | VARCHAR2(100) | NOT NULL | Name of the company or wild-harvest location | 
 | supplier_type | VARCHAR2(50) | - | Categorization: 'Commercial' or 'Wild' | 
 | website | VARCHAR2(50) | - | Digital contact info for re-ordering | 

# Table: Care
## Description: Specific cultivation requirements for a seed variety
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | care_id | NUMBER | PK | Unique identifier for the care profile | 
 | seed_id | NUMBER | FK | Reference to the Seeds table | 
 | indoor_planting | DATE | - | Ideal date to start seeds indoors | 
 | outdoor_planting | DATE | - | Ideal date to sow directly into the garden | 
 | min_temp | NUMBER | - | Minimum soil temperature required for germination | 
 | max_temp | NUMBER | - | Maximum heat tolerance for the plant | 
 | water_range | VARCHAR2(20) | - | Qualitative moisture needs (Low, Medium, High) | 
 | sunlight_range | VARCHAR2(25) | - | Lighting needs (Full Sun, Partial Shade, etc.) | 
 
# Table: Seed_Order
## Description: Transactional records of seed acquisitions
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | order_id | NUMBER | PK | Unique identifier for the purchase | 
 | seed_id | NUMBER | FK | Reference to the Seeds table | 
 | supplier_id | NUMBER | FK | Reference to the Supplier table | 
 | original_amount | NUMBER | > 0 | Total number of seeds in the packet at purchase | 
 | order_date | DATE | - | Date the seeds were acquired | 
 | price | NUMBER(10,2) | - | Total cost of the seed packet | 

# Table: Storage
## Description: Tracks physical location and viability of seed packets
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | location_id | NUMBER | PK | Unique identifier for the storage spot | 
 | seed_id | NUMBER | FK | Reference to the Seeds table | 
 | location_name | VARCHAR2(30) | - | Physical spot (e.g., 'Basement Fridge', 'Tool Shed') | 
 | estimated_expiration | DATE | - | Calculated or stated date when viability drops | 
 | seed_acquisition_date | DATE | - | Date the seeds entered storage | 

# Table: Growth
## Description: The primary log for planting activities and success rates
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | planting_id | NUMBER | PK | Unique identifier for a specific planting session | 
 | seed_id | NUMBER | FK | Reference to the Seeds table | 
 | quantity_planted | NUMBER | > 0 | How many seeds were used in this session | 
 | date_sprouted | DATE | - | Observation date of the first germination | 
 
# Table: Harvest_Data
## Description: Records of successful plant production
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | harvest_id | NUMBER | PK | Unique identifier for the harvest record | 
 | planting_id | NUMBER | FK | Reference to the Growth table | 
 | harvest_size | NUMBER | - | Total count or weight of produce harvested | 
 | harvest_date | DATE | - | When the crop was picked | 
 | germination_percent | NUMBER | 0-100 | Measured germination rate of this planting | 
 
# Table: Problem_Data
## Description: Log for pests, diseases, and environmental stressors
 | Column Name | Data Type | Constraints | Description |
 | --- | --- | --- | --- |
 | problem_id | NUMBER | PK | Unique identifier for the issue | 
 | planting_id | NUMBER | FK | Reference to the Growth table | 
 | disease_or_pest | VARCHAR2(50) | - | Description of the problem (e.g., 'Aphids') | 
 | treatment | VARCHAR2(50) | - | Action taken (e.g., 'Neem Oil') | 
 | outcome | VARCHAR2(30) | - | Final result (e.g., 'Recovered', 'Plant Died') | 

-----------------------------------------------------------------------

### Key Abbreviations & Definitions
* PK: Primary Key (Unique Identifier).
* FK: Foreign Key (Link to another table).
* CHECK: Logic constraint to ensure data quality.
* Identity: Field that automatically increments with each new entry.
