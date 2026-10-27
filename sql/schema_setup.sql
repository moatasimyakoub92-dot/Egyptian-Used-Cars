-- ====================================================================
-- Egyptian Used Cars Database Schema
-- Compatible with PostgreSQL, MySQL 8+, SQLite, and DuckDB
-- ====================================================================

-- 1. Used Cars Table
CREATE TABLE IF NOT EXISTS used_cars (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    trim VARCHAR(100),
    year INT NOT NULL,
    price NUMERIC(15, 2) NOT NULL,
    mileage NUMERIC(12, 2) NOT NULL,
    color VARCHAR(50),
    fuel_type VARCHAR(50),
    body_shape VARCHAR(50),
    transmission VARCHAR(50),
    engine VARCHAR(150),
    engine_capacity INT,
    cylinder_count INT,
    turbo_count INT,
    hp INT,
    drivetrain VARCHAR(50),
    car_age INT,
    km_per_year NUMERIC(10, 2),
    brand_tier INT,
    image_paths TEXT,
    condition VARCHAR(50),
    condition_score NUMERIC(4, 2),
    model_average_price NUMERIC(15, 2),
    model_min_price NUMERIC(15, 2),
    model_max_price NUMERIC(15, 2),
    is_zero_km BOOLEAN DEFAULT FALSE,
    mileage_suspect BOOLEAN DEFAULT FALSE,
    fuel_engine_conflict BOOLEAN DEFAULT FALSE
);

-- Indexes for performance optimization
CREATE INDEX idx_cars_brand_model ON used_cars(brand, model);
CREATE INDEX idx_cars_year ON used_cars(year);
CREATE INDEX idx_cars_price ON used_cars(price);
CREATE INDEX idx_cars_brand_tier ON used_cars(brand_tier);

-- 2. Price History Table
CREATE TABLE IF NOT EXISTS price_history (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    snapshot_date DATE NOT NULL,
    average_price NUMERIC(15, 2),
    min_price NUMERIC(15, 2),
    max_price NUMERIC(15, 2),
    is_wide_range BOOLEAN DEFAULT FALSE,
    price_range NUMERIC(15, 2),
    price_range_pct NUMERIC(8, 2)
);

CREATE INDEX idx_history_brand_model_date ON price_history(brand, model, snapshot_date);
