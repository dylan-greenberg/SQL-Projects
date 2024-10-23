-- Exploratory Data Analysis

SELECT *
FROM World_Layoffs.layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM World_Layoffs.layoffs_staging2;

SELECT *
FROM World_Layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM World_Layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM World_Layoffs.layoffs_staging2;

SELECT date
FROM World_Layoffs.layoffs_staging2
WHERE date LIKE 'NULL';

UPDATE World_Layoffs.layoffs_staging2
SET date = NULL
WHERE date = 0;

SELECT date
FROM World_Layoffs.layoffs_staging2
WHERE date LIKE NULL;

SELECT MIN(`date`), MAX(`date`)
FROM World_Layoffs.layoffs_staging2;


SELECT industry, SUM(total_laid_off)
FROM World_Layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT *
FROM World_Layoffs.layoffs_staging2;

ALTER TABLE World_Layoffs.layoffs_staging2
modify date varchar(50);

select date
from World_Layoffs.layoffs_staging2;

ALTER TABLE World_Layoffs.layoffs_staging2
MODIFY date date_format(date, '%Y/%m/%d');

SELECT `date`, SUM(total_laid_off)
FROM World_Layoffs.layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

SELECT DATE_FORMAT(`date`, '%Y-%m-%d')
from World_Layoffs.layoffs_staging2;



