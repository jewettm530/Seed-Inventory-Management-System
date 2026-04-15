-- Connects 5 tables to track a seed from purchase to harvest
SELECT 
    s.common_name,
    sup.supplier_name,
    so.order_date,
    g.quantity_planted,
    h.harvest_date,
    h.harvest_size || ' units' AS yield
FROM Seeds s
JOIN Supplier sup ON s.seed_id = s.seed_id -- Logic: Which supplier?
JOIN Seed_Order so ON s.seed_id = so.seed_id
JOIN Growth g      ON s.seed_id = g.seed_id
JOIN Harvest_Data h ON g.planting_id = h.planting_id
ORDER BY h.harvest_date DESC;

-- Problems and Harvest union to create a master timeline of events in the garden
SELECT observation_date AS event_date, 'ISSUE: ' || disease_or_pest AS description, outcome
FROM Problem_Data
UNION ALL
SELECT harvest_date, 'HARVEST: ' || notes, 'Success'
FROM Harvest_Data
ORDER BY event_date ASC;

-- Find seeds in the Seed that are missing care instructions in the Care table
SELECT s.common_name, s.type
FROM Seeds s
LEFT JOIN Care c ON s.seed_id = c.seed_id
WHERE c.seed_id IS NULL;

-- Find seeds performing better than the garden average based on high germination rate
SELECT s.common_name, h.germination_percent
FROM Seeds s
JOIN Growth g ON s.seed_id = g.seed_id
JOIN Harvest_Data h ON g.planting_id = h.planting_id
WHERE h.germination_percent > (SELECT AVG(germination_percent) FROM Harvest_Data);

-- Calculate the $ value of remaining inventory (good for businesses, not really individuals)
SELECT 
    s.common_name,
    v.current_seed_remaining,
    ROUND((so.price / so.original_seed_amount) * v.current_seed_remaining, 2) AS estimated_value
FROM Seeds s
JOIN Seed_Order so ON s.seed_id = so.seed_id
JOIN v_inventory_status v ON s.seed_id = v.seed_id
WHERE v.current_seed_remaining > 0;
