# 📊 Tableau Dashboards & Visual Analytics

This module outlines the Tableau visual storytelling and interactive dashboard architecture designed for the **Egyptian Used Cars Analysis**.

---

## 🎨 Planned Dashboard Views

### 1. 🏎️ Executive Market Overview Dashboard
- **Top KPIs**: Total Active Inventory, Market Average Price (EGP), Median Mileage (km), Average Vehicle Age.
- **Brand Market Share**: Treemap / Sunburst showing volume distribution across Brand Tiers and Manufacturers.
- **Body Shape & Transmission Split**: Interactive donuts filtering listings by Sedan, SUV, Hatchback, etc.
- **Top 10 Most Listed Models**: Bar chart ranked by volume with tooltip breakdowns.

### 2. 📉 Price Elasticity & Depreciation Matrix
- **Scatter Plot (Price vs. Mileage)**:
  - X-Axis: Mileage (km)
  - Y-Axis: Price (EGP)
  - Color: `Condition_Score` (diverging palette)
  - Size: `car_age`
  - Trend Lines: Polynomial / Logarithmic depreciation curves per `Brand_Tier`.
- **Condition vs. Price Retention Box Plots**: Distribution of prices across Very Good, Good, Fair, etc.

### 3. 📈 Time-Series Market Volatility Story
- **Monthly Average Price Trend**: Dual-axis line chart tracking `Average Price` and `Price Range %` over time from `price history_super cleaned.csv`.
- **Market Highs & Lows Band**: Ribbon chart displaying `Min Price` and `Max Price` envelopes.

---

## 🧮 Recommended Tableau Calculated Fields

```tableau
// 1. Price Depreciation Rate (EGP / Year)
[Price Depreciation Per Year] = 
[Price] / MAX([car_age], 1)

// 2. Value Flag (Below Benchmark Model Average)
[Deal Opportunity] = 
IF [Price] < ([model_average_price] * 0.85) AND [mileage_suspect] = FALSE THEN "Great Deal"
ELSEIF [Price] > ([model_average_price] * 1.15) THEN "Overpriced"
ELSE "Fair Market"
END

// 3. Mileage Category
[Mileage Tier] = 
IF [is_zero_km] = TRUE THEN "0 km (Brand New)"
ELSEIF [Mileage] < 50000 THEN "< 50k km"
ELSEIF [Mileage] <= 120000 THEN "50k - 120k km"
ELSE "> 120k km"
END
```

---

## 🔗 How to Connect & Publish
1. Open **Tableau Desktop** or **Tableau Public**.
2. Connect to **Text file** -> Select `data/cleaned/used_cars_cleaned.csv`.
3. (Optional) Relate to `data/cleaned/price history_super cleaned.csv` on `Brand` and `Model`.
4. Publish final workbook to Tableau Public and embed the URL here.
