---------------------------------------------------------
-- Insert sample data for viewing the database
---------------------------------------------------------

-- 1. Populate Suppliers
INSERT INTO Supplier (supplier_name, supplier_type, website) 
VALUES ('Baker Creek Heirloom', 'Commercial', 'rareseeds.com');

INSERT INTO Supplier (supplier_name, supplier_type, website) 
VALUES ('Wildwood Foragers', 'Wild', NULL);

-- 2. Populate Seeds
INSERT INTO Seeds (common_name, scientific_name, type, life_cycle, characteristics)
VALUES ('Cherokee Purple Tomato', 'Solanum lycopersicum', 'vegetable', 'annual', 'Deep purple, beefsteak style, heirloom');

INSERT INTO Seeds (common_name, scientific_name, type, life_cycle, characteristics)
VALUES ('Common Lavender', 'Lavandula angustifolia', 'flower', 'perennial', 'Fragrant purple spikes, attracts bees');

-- 3. Populate Care (Linking to Seed IDs 1 and 2)
INSERT INTO Care (indoor_planting_time, outdoor_planting_time, transplant_time, min_temp, max_temp, water_range, sunlight_range, seed_id)
VALUES (TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-05-15', 'YYYY-MM-DD'), TO_DATE('2026-06-01', 'YYYY-MM-DD'), 60, 85, 'medium', 'full sun', 1);

-- 4. Populate Seed Orders
INSERT INTO Seed_Order (original_seed_amount, order_date, price, seed_id, supplier_id)
VALUES (50, TO_DATE('2026-01-10', 'YYYY-MM-DD'), 4.50, 1, 1);

INSERT INTO Seed_Order (original_seed_amount, order_date, price, seed_id, supplier_id)
VALUES (100, TO_DATE('2026-02-15', 'YYYY-MM-DD'), 0.00, 2, 2);

-- 5. Populate Storage
INSERT INTO Storage (location_name, estimated_expiration, seed_aquisition_date, seed_id)
VALUES ('Main Seed Box', TO_DATE('2028-12-31', 'YYYY-MM-DD'), TO_DATE('2026-01-15', 'YYYY-MM-DD'), 1);

INSERT INTO Storage (location_name, estimated_expiration, seed_aquisition_date, seed_id)
VALUES ('Basement Freezer', TO_DATE('2030-01-01', 'YYYY-MM-DD'), TO_DATE('2026-02-20', 'YYYY-MM-DD'), 2);

-- 6. Populate Growth (Planting the Tomato)
INSERT INTO Growth (quantity_planted, date_sprouted, seed_id)
VALUES (10, TO_DATE('2026-03-10', 'YYYY-MM-DD'), 1);

-- 7. Populate Problem Data (Aphids on the Tomato)
INSERT INTO Problem_Data (disease_or_pest, treatment_or_action, outcome, observation_date, planting_id)
VALUES ('Aphids', 'Neem Oil Spray', 'Recovered', TO_DATE('2026-04-05', 'YYYY-MM-DD'), 1);

-- 8. Populate Harvest Data
INSERT INTO Harvest_Data (harvest_size, harvest_date, planting_location, notes, germination_percent, planting_id)
VALUES (15, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'South Garden Plot A', 'Excellent flavor, very juicy', 90, 1);

COMMIT;
