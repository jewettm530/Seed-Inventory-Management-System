-- This view calculates current inventory by subtracting the sum of seeds planted 
-- from the original order amount.
CREATE OR REPLACE VIEW v_inventory_status AS
SELECT 
    s.seed_id,
    s.common_name,
    s.variety,
    so.original_seed_amount,
    NVL(SUM(g.quantity_planted), 0) AS total_planted,
    (so.original_seed_amount - NVL(SUM(g.quantity_planted), 0)) AS current_seed_remaining
FROM Seeds s
JOIN Seed_Order so ON s.seed_id = so.seed_id
LEFT JOIN Growth g ON s.seed_id = g.seed_id
GROUP BY 
    s.seed_id, 
    s.common_name, 
    s.variety, 
    so.original_seed_amount;

-- This view helps the user know which seeds need attention based on the current month
-- It combines the Seeds info with the Care requirements
CREATE OR REPLACE VIEW v_planting_schedule AS
SELECT 
    s.common_name,
    s.variety,
    c.indoor_planting_time,
    c.outdoor_planting_time,
    c.sunlight_range,
    CASE 
        WHEN TO_CHAR(c.outdoor_planting_time, 'MM') = TO_CHAR(SYSDATE, 'MM') THEN 'PLANT NOW'
        ELSE 'Wait'
    END AS status
FROM Seeds s
JOIN Care c ON s.seed_id = c.seed_id;

-- highlights which seed varieties are struggling. 
-- If a specific variety of tomato always shows up in the Problem_Data table,
-- this view will expose that pattern
CREATE OR REPLACE VIEW v_seed_risk_assessment AS
SELECT 
    s.common_name,
    p.disease_or_pest,
    p.treatment_or_action,
    p.outcome,
    g.quantity_planted
FROM Seeds s
JOIN Growth g ON s.seed_id = g.seed_id
JOIN Problem_Data p ON g.planting_id = p.planting_id
WHERE p.outcome = 'Failure' OR p.outcome = 'Struggling';

-- calculates the average germination rate for every supplier 
-- This tells the gardener which supplier provides the "best" seeds
CREATE OR REPLACE VIEW v_supplier_performance AS
SELECT 
    sup.supplier_name,
    COUNT(so.order_id) as total_orders,
    ROUND(AVG(h.germination_percent), 2) as avg_germination_rate
FROM Supplier sup
JOIN Seed_Order so ON sup.supplier_id = so.supplier_id
JOIN Seeds s ON so.seed_id = s.seed_id
JOIN Growth g ON s.seed_id = g.seed_id
JOIN Harvest_Data h ON g.planting_id = h.planting_id
GROUP BY sup.supplier_name;

-- acts as a "Warning System" for seeds that are about to go bad
CREATE OR REPLACE VIEW v_expiring_inventory AS
SELECT 
    s.common_name,
    st.location_name,
    st.estimated_expiration,
    ROUND(st.estimated_expiration - SYSDATE) AS days_until_expired
FROM Seeds s
JOIN Storage st ON s.seed_id = st.seed_id
WHERE st.estimated_expiration <= SYSDATE + 90 -- Expiring in next 3 months
ORDER BY st.estimated_expiration ASC;
