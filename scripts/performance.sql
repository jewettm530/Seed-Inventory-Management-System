-- Speed up searches for common names
CREATE INDEX idx_seed_name ON Seeds(common_name);

-- Speed up lookups for planting dates in large logs
CREATE INDEX idx_growth_date ON Growth(planting_date);

-- Speed up filtering by supplier
CREATE INDEX idx_supplier_name ON Supplier(supplier_name);
