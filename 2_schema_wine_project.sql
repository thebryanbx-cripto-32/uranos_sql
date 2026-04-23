-- SQL MINI PROJET - WINE PROJECT
-- Dataset: Wine Quality database
-- Authors: Bryan Calderon and Edson Antonio

CREATE DATABASE wine_project;
USE wine_project;

CREATE TABLE wines (
    wine_id INT PRIMARY KEY,
    alcohol FLOAT,
    density FLOAT,
    pH FLOAT,
    quality INT
);

CREATE TABLE acidity (
    acidity_id INT PRIMARY KEY,
    wine_id INT,
    fixed_acidity FLOAT,
    volatile_acidity FLOAT,
    citric_acid FLOAT,
    FOREIGN KEY (wine_id) REFERENCES wines(wine_id)
);

CREATE TABLE composition (
    comp_id INT PRIMARY KEY,
    wine_id INT,
    residual_sugar FLOAT,
    chlorides FLOAT,
    sulphates FLOAT,
    FOREIGN KEY (wine_id) REFERENCES wines(wine_id)
);

########################
-- ANALYSIS #
########################

## Exploring tables
SELECT * FROM wines;
SELECT * FROM acidity;
SELECT * FROM composition;

## How many wines are for each quality type?
SELECT quality, COUNT(*) AS total_wines
FROM wines
GROUP BY quality
ORDER BY quality;

SELECT quality,
    COUNT(*) AS total_wines,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM wines
GROUP BY quality
ORDER BY quality;

## Hypothesis 1: alcohol and quality. Average alcohol increases as quality increases.
SELECT quality,
    ROUND(AVG(alcohol), 2) AS avg_alcohol,
    MIN(alcohol) AS min_alcohol,
    MAX(alcohol) AS max_alcohol
FROM wines
GROUP BY quality
ORDER BY quality;

## Hypothesis 2: "Higer acidity reduces quality"
SELECT w.quality,
    ROUND(AVG(a.volatile_acidity), 2) AS avg_volatile_acidity,
    MIN(a.volatile_acidity) AS min_volatile_acidity,
    MAX(a.volatile_acidity) AS max_volatile_acidity
FROM wines w
JOIN acidity a 
    ON w.wine_id = a.wine_id
GROUP BY w.quality
ORDER BY w.quality;

## Hypothesis 3: residual sugar and quality. The pattern is weak or irregular,
SELECT * FROM composition;
SELECT w.quality,
    ROUND(AVG(c.residual_sugar), 2) AS avg_residual_sugar,
    MIN(c.residual_sugar) AS min_residual_sugar,
    MAX(c.residual_sugar) AS max_residual_sugar
FROM wines w
JOIN composition c ON w.wine_id = c.wine_id
GROUP BY w.quality
ORDER BY w.quality;

## Hipótesis 4 density and quality. If density falls as quality increases, then H4 is supported.
SELECT quality,
    ROUND(AVG(density), 4) AS avg_density,
    ROUND(MIN(density), 4) AS min_density,
    ROUND(MAX(density), 4) AS max_density
FROM wines
GROUP BY quality
ORDER BY quality;

## Getting into 3 cathegories HIGH, MEDIUM and LOW -------------
SELECT CASE
        WHEN quality >= 7 THEN 'High'
        WHEN quality >= 5 THEN 'Medium'
        ELSE 'Low'
    END AS quality_group,
    COUNT(*) AS total_wines,
    ROUND(AVG(alcohol), 2) AS avg_alcohol,
    ROUND(AVG(density), 4) AS avg_density
FROM wines
GROUP BY quality_group
ORDER BY avg_alcohol DESC;

### Adding the results in one Table for graphs ---------------
SELECT w.quality,
    ROUND(AVG(w.alcohol), 2) AS avg_alcohol,
    ROUND(AVG(w.density), 4) AS avg_density,
    ROUND(AVG(a.volatile_acidity), 3) AS avg_volatile_acidity,
    ROUND(AVG(c.residual_sugar), 2) AS avg_residual_sugar
FROM wines w
JOIN acidity a
    ON w.wine_id = a.wine_id
JOIN composition c
    ON w.wine_id = c.wine_id
GROUP BY w.quality
ORDER BY w.quality;

## THAT is THE END ##


