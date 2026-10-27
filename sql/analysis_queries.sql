-- ====================================================================
-- Egyptian Used Cars Market Analysis Queries
-- Demonstrating CTEs, Window Functions, Aggregations & Business Logic
-- ====================================================================

-- 1. Top 10 Most Common Brands and Their Market Share & Average Price
WITH BrandCounts AS (
    SELECT 
        brand,
        COUNT(*) AS total_listings,
        ROUND(AVG(price), 2) AS avg_price,
        ROUND(AVG(mileage), 2) AS avg_mileage,
        ROUND(AVG(car_age), 1) AS avg_car_age
    FROM used_cars
    GROUP BY brand
),
TotalMarket AS (
    SELECT COUNT(*) AS total_market_listings FROM used_cars
)
SELECT 
    b.brand,
    b.total_listings,
    ROUND((b.total_listings::NUMERIC / t.total_market_listings) * 100, 2) AS market_share_pct,
    b.avg_price,
    b.avg_mileage,
    b.avg_car_age
FROM BrandCounts b
CROSS JOIN TotalMarket t
ORDER BY b.total_listings DESC
LIMIT 10;

-- 2. Depreciation Analysis by Model Year (Window Function: LAG)
SELECT 
    brand,
    model,
    year,
    ROUND(AVG(price), 2) AS current_year_avg_price,
    LAG(ROUND(AVG(price), 2)) OVER (PARTITION BY brand, model ORDER BY year ASC) AS previous_year_avg_price,
    ROUND(
        (AVG(price) - LAG(AVG(price)) OVER (PARTITION BY brand, model ORDER BY year ASC)) / 
        NULLIF(LAG(AVG(price)) OVER (PARTITION BY brand, model ORDER BY year ASC), 0) * 100, 
        2
    ) AS yoy_price_growth_pct
FROM used_cars
GROUP BY brand, model, year
HAVING COUNT(*) >= 5
ORDER BY brand, model, year DESC;

-- 3. High Value Retention Vehicles (Condition Score vs. Price Retention)
SELECT 
    brand,
    model,
    COUNT(*) AS listings_count,
    ROUND(AVG(condition_score), 2) AS avg_condition_score,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(price / NULLIF(car_age, 0)), 2) AS price_per_year_of_age
FROM used_cars
WHERE car_age > 0
GROUP BY brand, model
HAVING COUNT(*) >= 10
ORDER BY avg_condition_score DESC, avg_price DESC
LIMIT 15;

-- 4. Odometer Anomaly & Deal Hunter Query (Underpriced vs. Benchmark)
SELECT 
    brand,
    model,
    year,
    trim,
    price,
    model_average_price,
    ROUND(((model_average_price - price) / NULLIF(model_average_price, 0)) * 100, 2) AS discount_from_avg_pct,
    mileage,
    condition,
    condition_score
FROM used_cars
WHERE price < (model_average_price * 0.80) -- 20%+ below benchmark average
  AND mileage_suspect = FALSE
  AND condition_score >= 6.5
ORDER BY discount_from_avg_pct DESC
LIMIT 20;

-- 5. Time-Series Volatility & Month-over-Month Price Shift (Price History)
SELECT 
    brand,
    model,
    snapshot_date,
    average_price,
    LAG(average_price) OVER (PARTITION BY brand, model ORDER BY snapshot_date) AS prev_month_price,
    ROUND(
        ((average_price - LAG(average_price) OVER (PARTITION BY brand, model ORDER BY snapshot_date)) / 
        NULLIF(LAG(average_price) OVER (PARTITION BY brand, model ORDER BY snapshot_date), 0)) * 100, 
        2
    ) AS mom_inflation_pct,
    price_range_pct
FROM price_history
ORDER BY brand, model, snapshot_date DESC;
