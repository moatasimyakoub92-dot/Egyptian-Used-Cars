# 🐍 Python Analytics & Statistical Modeling

This module encapsulates all Python-based workflows for data wrangling, exploratory data analysis (EDA), and rigorous statistical testing on the Egyptian Used Cars market.

---

## 📌 Module Structure & Workflow

```plaintext
python/
├── notebooks/                # Jupyter Notebooks for interactive analysis
│   ├── 01_data_cleaning.ipynb     # [Incoming] Data cleaning & feature engineering pipeline
│   ├── 02_eda.ipynb               # Exploratory Data Analysis & visual profiling
│   └── 03_statistical_analysis.ipynb # Statistical hypothesis testing & regression modeling
├── scripts/                  # Modular Python helper scripts
│   ├── data_loader.py        # Dataset loading & type casting utilities
│   └── stats_helpers.py      # Statistical testing functions & plotting helpers
└── requirements.txt          # Python dependencies
```

---

## 🧹 1. Data Cleaning Stage (`01_data_cleaning.ipynb`)
> **Note:** The data cleaning stage was conducted in Python and the production pipeline notebook/scripts will be added here.

### Key Cleaning & Engineering Highlights:
- **Outlier Detection & Imputation**: IQR trimming on vehicle prices and odometer readings to filter anomalies.
- **Mileage Anomaly Flagging**: Engineered `mileage_suspect` flag comparing vehicle age against unrealistic annual mileage (< 500 km/yr or > 60,000 km/yr).
- **Condition Scoring Engine**: Multi-variable weighted scoring index based on age, mileage, trim, and body health to construct `Condition_Score` (0–10 scale).
- **Brand Tier Classification**: Discretized manufacturers into `Brand_Tier` (Economy, Mid-Market, Luxury/Prestige).
- **Market Benchmarks**: Computed `model_average_price`, `model_min_price`, and `model_max_price` grouped by model & manufacturing year.

---

## 🔬 2. Statistical Analysis Plan (`03_statistical_analysis.ipynb`)

1. **Descriptive & Distributional Analysis**:
   - Skewness and Kurtosis testing on Price, Mileage, and Engine Displacement.
   - Logarithmic price transformation testing to normalize right-skewed pricing distributions.
   - Normality checks using **Shapiro-Wilk** and **Kolmogorov-Smirnov** tests.

2. **Inferential Hypothesis Testing**:
   - **One-Way ANOVA & Kruskal-Wallis Test**: Test whether mean/median vehicle valuation differs significantly across `Brand_Tier` and `Body Shape`.
   - **Independent Two-Sample T-Test / Mann-Whitney U**: Validate price variance between `Automatic` vs. `Manual` transmissions and `Gas` vs. `Hybrid/Electric`.
   - **Chi-Square Test of Independence**: Evaluate association between `Condition` categories and `Brand_Tier`.

3. **Econometric & Depreciation Regression Modeling**:
   - **Multiple Linear Regression (OLS)**:
     $$\log(\text{Price}) = \beta_0 + \beta_1(\text{Car Age}) + \beta_2(\text{Mileage}) + \beta_3(\text{HP}) + \beta_4(\text{Condition Score}) + \sum \gamma_i(\text{Brand Tier}_i) + \epsilon$$
   - Calculate annual depreciation rates ($\%$ value loss per year) by brand tier.
   - OLS diagnostics: Check for Multicollinearity using Variance Inflation Factor (VIF), Heteroscedasticity using Breusch-Pagan test, and Q-Q residual plots.

---

## 🚀 Setup & Execution

Install the recommended environment:

```bash
pip install -r python/requirements.txt
```
