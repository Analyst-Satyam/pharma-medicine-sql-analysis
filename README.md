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
- Analyzed Diffrent Companies underperforming products specifically
- Searched and filtered cancer-related medicines using text pattern matching

### Advanced SQL
- Used CTEs to break multi-step problems into stages
- Applied RANK() and ROW_NUMBER() to rank medicines within each manufacturer
- Used PERCENT_RANK() to calculate relative performance standing
- Compared manufacturer-level averages against overall dataset averages

## Key Findings
- Sun Pharmaceutical Industries Ltd has 803 unique medicines — the 
  largest portfolio in the dataset, compared to other
- There are 171 medicines used for 'Cancer' related treatment
- "Sun Pharmaceutical Industries Ltd", "Intas Pharmaceuticals Ltd", "Cipla Ltd" -
  are the top 3 manufacturers by medicine count.


## Tools Used
MySQL, MySQL Workbench

## Author
Satyam Agrawal — Transitioning from Pharma Field Sales to Commercial Data Analytics
LinkedIn : https://www.linkedin.com/in/agrawalsatyam 



