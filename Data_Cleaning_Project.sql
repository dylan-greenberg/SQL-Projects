-- Data Cleaning

-- 1. remove duplicates
-- 2. standardize the data
-- 3. Null values or blank values
-- 4. remove any columns

USE World_Layoffs;

SELECT *
FROM World_Layoffs_2.0.layoffs;


DROP TABLE IF EXISTS layoffs_staging;
CREATE TABLE layoffs_staging
LIKE World_Layoffs_2.0.layoffs;

INSERT layoffs_staging
SELECT *
FROM World_Layoffs_2.0.layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY industry, total_laid_off, percentage_laid_off, `date`) as row_num
FROM `World_Layoffs_2.0`.layoffs;

WITH duplicate_cte AS
         (SELECT *,
                 ROW_NUMBER() OVER (
                     PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
          FROM `World_Layoffs_2.0`.layoffs)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM `World_Layoffs_2.0`.layoffs
WHERE company = 'Casper';

DROP TABLE IF EXISTS layoffs_staging2;
create table layoffs_staging2
(
    company               text   null,
    location              text   null,
    industry              text   null,
    total_laid_off        int    null,
    percentage_laid_off   double null,
    `date`                text   null,
    stage                 text   null,
    country               text   null,
    funds_raised_millions int    null,
    row_num               INT
);

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;


SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- standardizing data

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT distinct (company)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoffs_staging2
WHERE industry LIKE 'Crypto%';

SELECT distinct country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT DISTINCT layoffs_staging2.industry
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = 'NULL';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = 'NULL';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = 'NULL';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    on t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = 'NULL')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;
