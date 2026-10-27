# 🟡 Power BI Business Intelligence & Modeling

This module houses the enterprise Power BI data modeling, Star Schema architecture, and DAX metric suite for the Egyptian Used Cars market.

---

## 🏗️ Data Model Architecture (Star Schema)

```mermaid
erDiagram
    DIM_BRAND ||--o{ FACT_CARS : "has"
    DIM_DATE ||--o{ FACT_CARS : "listed on"
    DIM_SPECS ||--o{ FACT_CARS : "equipped with"
    DIM_DATE ||--o{ FACT_PRICE_HISTORY : "tracks"
    DIM_BRAND ||--o{ FACT_PRICE_HISTORY : "relates"

    FACT_CARS {
        int Car_ID PK
        string Brand FK
        int Year FK
        decimal Price
        decimal Mileage
        decimal Condition_Score
        decimal Model_Average_Price
    }

    DIM_BRAND {
        string Brand PK
        string Origin_Country
        int Brand_Tier
    }

    DIM_SPECS {
        int Spec_ID PK
        string Body_Shape
        string Transmission
        string Fuel_Type
        int Engine_Capacity
        int HP
    }

    FACT_PRICE_HISTORY {
        int History_ID PK
        string Brand FK
        date Snapshot_Date FK
        decimal Average_Price
        decimal Price_Range
    }
```

---

## 📐 Key DAX Measures

### 1. Market Inventory Metrics
```dax
Total Listings = COUNTROWS(used_cars_cleaned)

Zero KM Listings = 
CALCULATE(
    [Total Listings], 
    used_cars_cleaned[is_zero_km] = TRUE()
)

Pct Zero KM = 
DIVIDE([Zero KM Listings], [Total Listings], 0)
```

### 2. Pricing & Valuation Measures
```dax
Average Market Price = AVERAGE(used_cars_cleaned[Price])

Median Market Price = MEDIAN(used_cars_cleaned[Price])

Price Spread (IQR Proxy) = 
PERCENTILE.INC(used_cars_cleaned[Price], 0.75) - PERCENTILE.INC(used_cars_cleaned[Price], 0.25)
```

### 3. Depreciation & Value Intelligence
```dax
Average Price per Year of Age = 
DIVIDE(
    [Average Market Price], 
    AVERAGE(used_cars_cleaned[car_age]), 
    0
)

Discount vs Model Benchmark % = 
AVERAGEX(
    used_cars_cleaned,
    DIVIDE(
        used_cars_cleaned[model_average_price] - used_cars_cleaned[Price],
        used_cars_cleaned[model_average_price],
        0
    )
)
```

---

## 📊 Report Pages Plan
1. **Executive Overview**: Market size, volume by brand tier, average pricing indicators.
2. **Depreciation & Mileage Analytics**: Decomposition tree and scatter analysis for price erosion vs age & odometer.
3. **Historical Pricing & Inflation Monitor**: Time-series matrix tracking historical price shifts and inflation effects in EGP.
4. **Deal Finder Tool**: Parameterized filter tool to identify undervalued vehicle listings based on condition score and benchmark discount.
