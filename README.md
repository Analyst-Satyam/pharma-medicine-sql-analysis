# Pharma Medicine Data Analysis — SQL Project

## About
Cleaned and analyzed a real-world dataset of 11,825 Indian pharmaceutical 
medicines using MySQL. As a Medical Representative transitioning into 
Commercial Data Analytics, this project applies pharma domain knowledge 
to real data cleaning and business analysis problems.

## Dataset
- Source: Kaggle — Indian Medicine Dataset
- 11,825 rows
- Columns: Medicine Name, Composition, Uses, Side Effects, Manufacturer, 
  Excellent Review %, Average Review %, Poor Review %

## What I Did

### Data Cleaning
- Renamed columns for consistency
- Identified and removed duplicate medicine names
- Handled NULL and blank values in Manufacturer and Uses columns
- Removed unnecessary Image_URL column
- Trimmed extra whitespace across all text columns
- Validated that review percentages summed correctly to 100

### Business Analysis
- Identified top manufacturers by medicine count
- Found compositions used across the most medicines
- Flagged medicines with poor review % higher than excellent review %
- Searched and filtered cancer-related medicines using text pattern matching

### Advanced SQL
- Used CTEs to break multi-step problems into stages
- Applied RANK() and ROW_NUMBER() to rank medicines within each manufacturer
- Used PERCENT_RANK() to calculate relative performance standing
- Compared manufacturer-level averages against overall dataset averages

## Key Findings
- Sun Pharmaceutical Industries Ltd is the top manufacturer in the dataset with 803 unique medicine count.
- Composition (active ingredient) "Luliconazole (1% w/w)"  appears in the most medicines
- There are 171 diffrent medicines are used for 'Cancer' related treatment
  
## Tools Used
MySQL, MySQL Workbench

## Author
SATYAM AGRAWAL — Transitioning from Pharma Field Sales to Commercial Data Analytics
https://www.linkedin.com/in/agrawalsatyam
