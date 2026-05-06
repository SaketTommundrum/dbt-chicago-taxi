# 🚕 Chicago Taxi dbt Pipeline

A production-style ELT pipeline built with **dbt Core** and **BigQuery**, transforming raw Chicago taxi trip data into clean, tested, and documented analytical models.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| dbt Core 1.11 | Data transformation and testing |
| Google BigQuery | Cloud data warehouse |
| Python 3.x | Virtual environment management |
| Git + GitHub | Version control |

---

## 📁 Project Structure
models/
├── staging/
│ ├── stg_chicago_taxi.sql # Cleans and standardizes raw taxi data
│ └── sources.yml # Source definition for BigQuery raw table
└── marts/
├── fct_taxi_trips.sql # Incremental fact table aggregated by date + payment type
├── dim_payment_types.sql # Dimension table mapping payment codes to labels
└── schema.yml # Column descriptions and data tests
tests/
├── assert_positive_total_fare.sql
├── assert_positive_total_revenue.sql
└── assert_positive_total_trips.sql


---

## 📊 Data Models

### `stg_chicago_taxi` (View)
Staging model that reads directly from the raw BigQuery source table. Standardizes column names and filters out invalid records.

### `fct_taxi_trips` (Incremental Table)
Fact table aggregating taxi trips by `trip_date` and `payment_type`. Loads incrementally — only new dates are appended on each run.

| Column | Type | Description |
|--------|------|-------------|
| trip_date | DATE | Date the trip started |
| payment_type | STRING | Payment method used |
| total_trips | INTEGER | Total number of trips |
| total_fare | FLOAT | Sum of base fares |
| total_tips | FLOAT | Sum of tips |
| total_revenue | FLOAT | Sum of total trip revenue |

### `dim_payment_types` (Table)
Dimension table mapping raw payment type codes to human-readable labels and categories.

| Column | Type | Description |
|--------|------|-------------|
| payment_type | STRING | Raw payment code (joins to fct_taxi_trips) |
| payment_label | STRING | Human-readable payment description |
| payment_category | STRING | Online / Offline / Other |

---

## ✅ Data Quality Tests

16 tests across all models — 0 failures.

| Test Type | Count | Examples |
|-----------|-------|---------|
| `not_null` | 10 | All key columns validated |
| `accepted_values` | 2 | Payment types and categories validated |
| `unique` | 1 | dim_payment_types primary key |
| Singular (custom SQL) | 3 | No negative fares, revenue, or trip counts |

---

## 🚀 How to Run

### Prerequisites
- Python 3.x
- Google Cloud account with BigQuery access
- dbt profiles.yml configured at `~/.dbt/profiles.yml`

### Setup
```bash
# Clone the repo
git clone https://github.com/SaketTommundrum/dbt-chicago-taxi.git
cd dbt-chicago-taxi

# Create and activate virtual environment
python -m venv dbt-env
dbt-env\Scripts\activate  # Windows
source dbt-env/bin/activate  # Mac/Linux

# Install dependencies
pip install dbt-bigquery
```

### Run the Pipeline
```bash
# First time / full refresh
dbt run --full-refresh

# Incremental run (new data only)
dbt run

# Run tests
dbt test

# Generate and serve docs
dbt docs generate
dbt docs serve
```

---

## 📈 Pipeline Architecture
BigQuery Raw Source (chicago_taxi.taxi_trips)
↓
stg_chicago_taxi (view)
↓
fct_taxi_trips (incremental)
dim_payment_types (table)

---

## 📊 Live Dashboard
[View Looker Studio Dashboard →](https://datastudio.google.com/reporting/a383d026-a944-4180-8e25-918487d8223a)
<img width="918" height="608" alt="image" src="https://github.com/user-attachments/assets/13f3e384-d392-41f4-9be7-bd49b85660b7" />


## 👤 Author

**Saket Tommundrum**  
MS Data Science & Business Analytics  
[LinkedIn](https://www.linkedin.com/in/saket-tommundrum-9634641b0)

