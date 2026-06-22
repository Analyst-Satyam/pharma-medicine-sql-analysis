select * 
from medicine_details;

alter table medicine_details
change column `Medicine Name` Medicine_Name varchar(300);


alter table medicine_details
change column Composition Composition varchar(500);

alter table medicine_details
change column `Image URL` Image_URL varchar(500);

alter table medicine_details
change column Manufacturer Manufacturer varchar(300);




-- Level-1 :- Exploration — understand the data

select * 
from medicine_details
limit 10;


-- Unique Manufactrure 

select distinct Manufacturer  
from medicine_details;

select count(distinct Manufacturer) as Total_Manufacturure
from medicine_details;


-- Assignment 3		
-- Find all medicines made by Pfizer Ltd. Show only the medicine name, composition, and manufacturer columns. Order results alphabetically by medicine name.

select `Medicine Name`, Composition, Manufacturer
from medicine_details
where Manufacturer = 'Pfizer Ltd'
order by `Medicine Name`;


-- Assignment 4
-- Find all medicines where the excellent review percentage is above 80.
-- Show medicine name, manufacturer, and excellent review percentage.
-- Order by highest excellent review first.


select Medicine_Name, Manufacturer, `Excellent Review %`
from medicine_details
where `Excellent Review %` > 80
order by `Excellent Review %` desc;




-- Assignment 5
-- Find how many medicines each manufacturer has in this dataset.
-- Show manufacturer name and their medicine count.
-- Order by highest count first.
-- Show only the top 10 manufacturers.


select Manufacturer, count(distinct Medicine_Name) as medicine_count
from medicine_details
group by Manufacturer
order by medicine_count desc
limit 10 ;




-- Level-2 :- Data Cleaning — fix the problems

-- Assignment 6
-- Find how many rows have NULL values in the manufacturer column. Just the count.


select *
from medicine_details
where Manufacturer is Null
or Manufacturer = '';






-- Assignment 7
-- The Image_URL column is completely useless for any business analysis.
-- Write a query to permanently remove it from the table.
-- After removing it, verify it is gone by selecting all columns.


alter table medicine_details
drop column Image_URL;

select *
from medicine_details;







-- Assignment 8
-- Find all medicines where the Uses column is either NULL or completely empty.
-- Show medicine name and manufacturer. How many such records exist?


select Medicine_Name, Manufacturer, Uses
from medicine_details
where Uses is null
or Uses = '';








-- Assignment 9
-- In a real dataset the Excellent Review % + Average Review % + Poor Review % should always add up to 100 for every medicine.
-- Find all medicines where this total does NOT equal 100.
-- Show medicine name, all three review percentages, and their sum. How many problematic records exist?


select *
from medicine_details;

select *
from medicine_details
where (`Excellent Review %`+`Average Review %`+`Poor Review %`) != 100 ;

select Medicine_Name, `Excellent Review %` , `Average Review %`, `Poor Review %`,
(`Excellent Review %`+`Average Review %`+`Poor Review %`) as Total_Review
from medicine_details;

select count(*) as Problamatic_Report
from medicine_details
where (`Excellent Review %`+`Average Review %`+`Poor Review %`) != 100;









-- Assignment 10
-- Check for duplicate medicine names — find any medicine name that appears more than once in the dataset.
-- Show the medicine name and how many times it appears.
-- Order by highest duplicates first.
 

select Medicine_Name, count(*) as Repeated_Med 
from medicine_details
group by Medicine_Name
having count(*) > 1
order by Repeated_Med desc;



select *
from medicine_details
where Medicine_Name = 'Lulifin Cream';











-- Assignment 11
-- Some manufacturer names may have extra spaces before or after the name causing them to be counted as different manufacturers.
-- Write a query that compares the original manufacturer name with a trimmed version and shows only the rows where they are different- 
-- meaning rows that have extra spaces. How many such rows exist?

select Manufacturer, trim(Manufacturer)
from medicine_details
where Manufacturer != trim(Manufacturer);



select * 
from medicine_details;

select Medicine_Name, trim(Medicine_Name) 
from medicine_details;

update medicine_details
set Medicine_Name = trim(Medicine_Name);

select Composition, trim(Composition)
from medicine_details;

update medicine_details
set Composition = trim(Composition);

select Uses, trim(Uses)
from medicine_details;

update medicine_details
set Uses = trim(Uses);

select Side_effects, trim(Side_effects)
from medicine_details;

update medicine_details
set Side_effects = trim(Side_effects);

select Manufacturer, trim(Manufacturer)
from medicine_details;

update medicine_details
set Manufacturer = trim(Manufacturer);





-- Level-3 :— Business Analysis Assignments

-- Assignment 12
-- Which composition (active ingredient) appears in the most number of different medicines?
-- Show the composition and how many medicines contain it. Show only the top 10.


select *
from medicine_details;

select Composition, count(*) as Med_use
from medicine_details
group by Composition
having count(*) > 1
order by Med_use desc
limit 10 ;







-- Assignment 13
-- Find the average Excellent Review % for each manufacturer — but only include manufacturers who have at least 20 medicines in the dataset.
-- Show manufacturer, their average excellent review, and their medicine count. Order by highest average review first.


select Manufacturer, avg(`Excellent Review %`) as Avg_Excellent_Review,
		count(*) as Medicine_Count
from medicine_details
group by Manufacturer
having count(*) >= 20
order by Avg_Excellent_Review desc;








-- Assignment 14
-- A "side effect" worth flagging is when a medicine's Poor Review % is higher than its Excellent Review % 
-- meaning patients are more unhappy than happy with it. 
-- Find all such medicines. Show medicine name, manufacturer, excellent review %, and poor review %.


select Medicine_Name, Manufacturer, `Excellent Review %`, `Poor Review %`
from medicine_details
where `Poor Review %` > `Excellent Review %`;







-- Assignment 15
-- You are now thinking like a Torrent Pharma analyst. 
-- Find all medicines made by Torrent Pharmaceuticals Ltd where the Excellent Review % is below 50 
-- meaning underperforming products from your own company. Show medicine name, composition, and excellent review %.


select Manufacturer, Medicine_Name, Composition, `Excellent Review %`
from medicine_details
where Manufacturer = 'Torrent Pharmaceuticals Ltd' 
and `Excellent Review %` < 50 ;








-- Assignment 16
-- Find which manufacturer has the highest average Poor Review % across all their medicines 
-- but only consider manufacturers with at least 10 medicines, to avoid one bad product skewing a small manufacturer's average. 
-- Show manufacturer, average poor review, and medicine count.


select Manufacturer, avg(`Poor Review %`) as Avg_Poor_Review , count(*) as Med_Count
from medicine_details
group by Manufacturer
having count(*) >= 10
order by Avg_Poor_Review desc ;






-- Assignment 17
-- Using the Uses column, find how many medicines are used for 'Cancer' related treatment 
-- search for the word "Cancer" anywhere in that column, not just exact matches. Show medicine name, manufacturer, and uses.


select Medicine_Name, Manufacturer, Uses
from medicine_details
where Uses like '%cancer%'
;

select count(*) as Medicine_Related_to_Cancer
from medicine_details
where Uses like '%cancer%'
;









-- Level-4 :— Advanced SQL (CTEs and Window Functions)


-- Assignment 18
-- Using a CTE, find the top 3 manufacturers by medicine count, 
-- then show all individual medicines belonging to those 3 manufacturers. 
-- (Hint: first CTE gets top 3 manufacturers, then join or filter the main table against that CTE.)


select Manufacturer, count(*) as Med_Count
from medicine_details
group by Manufacturer 
order by Med_Count desc
limit 3 ;


with Top_3_Manufacturer as
(
	select Manufacturer, count(*) as Med_Count
	from medicine_details
	group by Manufacturer 
	order by Med_Count desc
	limit 3
)
select m.Medicine_Name, t.Manufacturer 
from  medicine_details m
join Top_3_Manufacturer t
	on t.Manufacturer = m.Manufacturer 
order by t.Med_Count desc, m.Medicine_Name
;







-- Assignment 19
-- Using RANK() or DENSE_RANK(), rank every medicine within its own manufacturer by Excellent Review % 
-- highest review gets rank 1. Show manufacturer, medicine name, excellent review %, and the rank.
-- Only show Torrent Pharmaceuticals Ltd results.


select Manufacturer, Medicine_Name,  `Excellent Review %`,
	rank() over (partition by Manufacturer 
				order by `Excellent Review %` desc) as Review_Rank
from medicine_details
where Manufacturer = 'Torrent Pharmaceuticals Ltd';





-- Assignment 20
-- Using ROW_NUMBER(), find the single best-reviewed medicine (highest Excellent Review %) for every manufacturer 
-- just one medicine per manufacturer. Show manufacturer and their top medicine.


select Manufacturer, Medicine_Name, `Excellent Review %`,
		row_number() OVER (partition by Manufacturer order by `Excellent Review %` desc)
from medicine_details;


with Best_Medicine as
(
select Manufacturer, Medicine_Name, `Excellent Review %`,
		row_number() OVER (partition by Manufacturer order by `Excellent Review %` desc) as Rating
from medicine_details
)
select *
from Best_Medicine
where Rating = 1;







-- Assignment 21
-- Write a CTE that calculates each manufacturer's average Excellent Review %,
-- then in the main query, show only manufacturers whose average is above the overall dataset average. 
-- (This requires a second calculation comparing against the full dataset's average 
--  -think about how to get that single overall number into your comparison.)


with Average_Review as
(
select Manufacturer, avg(`Excellent Review %`) as avg_review
from medicine_details
group by Manufacturer
),
Overall_Avg as
(
select avg(`Excellent Review %`) as overall_avg
from medicine_details
)
select a.Manufacturer, a.avg_review
from Average_Review a, Overall_Avg o
where o.overall_Avg < a.avg_review
order by a.avg_review desc;








-- Assignment 22
-- Using a window function, for every medicine, show what percentage of all medicines from the same manufacturer have a lower Excellent Review % than itself. 
-- (It's testing whether you understand PERCENT_RANK() or similar window functions.)


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       RANK() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) AS review_rank
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) AS review_percent_rank
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       ROUND(percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) * 100, 2) AS pct_lower_than_self
FROM medicine_details
WHERE Manufacturer = 'Torrent Pharmaceuticals Ltd';


SELECT Manufacturer, Medicine_Name, `Excellent Review %`,
       ROUND(percent_rank() OVER (PARTITION BY Manufacturer ORDER BY `Excellent Review %` ASC) * 100, 2) AS pct_lower_than_self
FROM medicine_details
;

















































