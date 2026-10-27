# 🗄️ SQL Analytics & Relational Modeling

This folder contains DDL schema definitions, analytical queries, and relational data modeling used to analyze market dynamics, pricing trends, and vehicle metrics.

---

## 📁 Directory Structure

```plaintext
sql/
├── schema_setup.sql        # Table DDL and indexing strategies
├── analysis_queries.sql    # Analytical queries covering business & market questions
└── README.md               # Documentation & analytical methodology
```

---

## 🎯 Analytical Objectives & Query Categories

1. **Market Composition & Brand Dominance**:
   - Market share by Brand, Model, and Brand Tier.
   - Volume distributions by transmission type and body shape.

2. **Price Depreciation & Value Retention**:
   - Average price drop per model year calculated using window functions (`LAG()`).
   - Comparison of depreciation velocity across European, Asian, and American brands.

3. **Time-Series Volatility (Price History)**:
   - Month-over-month (MoM) average price change and volatility index.
   - Identifying models with highest price dispersion (`Price Range %`).

4. **Data Integrity & Outlier Audit**:
   - Querying listings with `mileage_suspect = TRUE` or `fuel_engine_conflict = TRUE`.
   - Identifying underpriced and overpriced listings compared against `model_average_price`.
