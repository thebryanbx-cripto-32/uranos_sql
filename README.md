# 🍷 Wine Quality Predictor (SQL Project) 

## TEAM URANUS
* Bryan Calderon
* Edson Antonio

## Project Overview

This project analyzes how chemical properties influence wine quality using SQL and Python.
The objective is to identify key factors that determine wine quality and support better production decisions through data.

---

## Business Problem

Wine producers often do not know the final quality of their product until late stages of production.
This uncertainty can lead to financial losses when low-quality wines reach the market.

Additionally, many production decisions are based on experience rather than data-driven insights.

This project aims to use data analysis to identify key chemical factors that influence wine quality, enabling more informed and efficient decision-making.

---

## Dataset

* Source: UCI Machine Learning Repository
* Dataset: Wine Quality Dataset
* Loaded programmatically using Python (`ucimlrepo`)

---

## Hypotheses

1. Higher alcohol → higher quality
2. Higher volatile acidity → lower quality
3. Residual sugar influences quality
4. Higher density → lower quality

---

## Database Design

The dataset was normalized into three tables:

* **wines** → general wine characteristics
* **acidity** → acidity-related variables
* **composition** → chemical composition

Relationships:

* One-to-many relationships using `wine_id` as primary/foreign key
  See ERD diagram in: `0_ERD_wine_project.png`

---

## Conclusions

* Alcohol is the strongest positive indicator of wine quality
* Volatile acidity negatively impacts wine quality
* Density decreases as quality increases
* Residual sugar has limited influence

These findings suggest that improving alcohol balance and controlling acidity are key factors in producing higher-quality wines.

---

## Technologies Used

* Python (Pandas, Matplotlib)
* SQL (MySQL)
* Jupyter Notebook
* GitHub

---

## Project Structure

```
sql-database/
│
├── data/
│   ├── wines.csv
│   ├── acidity.csv
│   ├── composition.csv
│
├── 0_ERD_wine_project.png
├── 1_cleaning.py
│── 2_schema_wine_project.sql
│── 3_data_visualization.ipynb
│
├── sql_result/
│   └── result.csv
```

---

## How to Run the Project

1. Install dependencies:

   ```
   pip install pandas ucimlrepo matplotlib
   ```

2. Run data pipeline:

   ```
   python cleaning.py
   ```

3. Import all CSV files from the /data directory into the MySQL database

4. Execute SQL queries

5. Open Jupyter Notebook to view visualizations

---
