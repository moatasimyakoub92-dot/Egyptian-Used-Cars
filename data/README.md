# 📊 Dataset Documentation

This directory houses both raw scraped datasets and the refined, feature-engineered datasets for the **Egyptian Used Cars Analysis Project**.

---

## 📁 Directory Structure

```plaintext
data/
├── raw/
│   ├── used_cars.csv                      # Raw scraped vehicle listings
│   └── price_history.csv                  # Raw historical price trends
└── cleaned/
    ├── used_cars_cleaned.csv              # Cleaned dataset with engineered features
    └── price history_super cleaned.csv    # Super-cleaned time-series monthly price data
```

---

## 🚘 1. `used_cars_cleaned.csv` Data Dictionary

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| **Brand** | `string` | Manufacturer name (e.g., Mercedes, BMW, Hyundai, Toyota). |
| **Model** | `string` | Vehicle model (e.g., Giulia, Tucson, Corolla, C-Class). |
| **Trim** | `string` | Trim / package level (e.g., Base, Super, Highline). |
| **Year** | `integer` | Model release / manufacturing year. |
| **Price** | `numeric` | Listing price in Egyptian Pounds (EGP). |
| **Mileage** | `numeric` | Odometer reading in kilometers (km). |
| **Color** | `string` | Exterior paint color. |
| **Fuel Type** | `string` | Fuel category (Gas, Diesel, Hybrid, Electric). |
| **Body Shape** | `string` | Body style (Sedan, SUV, Hatchback, Coupe, etc.). |
| **Transmission** | `string` | Gearbox type (Automatic, Manual). |
| **Engine** | `string` | Detailed engine specification string. |
| **Engine Capacity** | `numeric` | Displacement in cubic centimeters (cc). |
| **Cylinder Count** | `integer` | Number of engine cylinders. |
| **Turbo Count** | `integer` | Number of turbochargers (0, 1, 2). |
| **HP** | `numeric` | Horsepower rating. |
| **Drivetrain** | `string` | Drive system (FWD, RWD, AWD / 4WD). |
| **car_age** | `integer` | Calculated age of the vehicle in years. |
| **km_per_year** | `numeric` | Average annual usage rate ($\text{Mileage} / \text{Age}$). |
| **Brand_Tier** | `integer/cat` | Market positioning category (1: Economy, 2: Mid-range, 3: Luxury). |
| **Image Paths** | `string` | Semicolon-separated paths to vehicle photos. |
| **Condition** | `string` | Overall descriptive condition rating (e.g., Very Good, Good, Fair). |
| **Condition_Score** | `numeric` | Weighted condition score (0.0 to 10.0 scale). |
| **model_average_price**| `numeric` | Benchmark mean market price for this brand/model/year. |
| **model_min_price** | `numeric` | Lowest recorded market price for this model. |
| **model_max_price** | `numeric` | Highest recorded market price for this model. |
| **is_zero_km** | `boolean` | Flag indicating brand-new / unregistered inventory ($0\text{ km}$). |
| **mileage_suspect** | `boolean` | Anomaly flag for odometer rollback or unrealistic annual mileage. |
| **fuel_engine_conflict**| `boolean` | Data integrity flag for contradictory fuel & engine specifications. |

---

## 📈 2. `price history_super cleaned.csv` Data Dictionary

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| **Brand** | `string` | Vehicle manufacturer. |
| **Model** | `string` | Vehicle model. |
| **Year** | `integer` | Model year under observation. |
| **Month/Year** | `date` | Timestamp for monthly snapshot (MM/DD/YYYY). |
| **Average Price** | `currency` | Mean observed market price during that month. |
| **Min Price** | `currency` | Minimum observed market price. |
| **Max Price** | `currency` | Maximum observed market price. |
| **IsWideRange** | `boolean` | Flag denoting high price dispersion / market volatility. |
| **Price Range** | `currency` | Spread between Max and Min Price ($\text{Max} - \text{Min}$). |
| **Price Range %** | `numeric` | Spread expressed as a percentage of the average price. |
