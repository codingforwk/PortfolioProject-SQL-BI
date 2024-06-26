SELECT *
FROM PortfolioProjects..layoffs$


--Remove duplicates

SELECT DISTINCT *
INTO PortfolioProjects..layoffscopy$
FROM PortfolioProjects..layoffs$;




-- Standardizing data

SELECT company, TRIM(company)
FROM PortfolioProjects..layoffscopy$

UPDATE PortfolioProjects..layoffscopy$
SET company = TRIM(company)

SELECT DISTINCT industry
FROM PortfolioProjects..layoffscopy$
ORDER BY industry

SELECT *
FROM PortfolioProjects..layoffscopy$
WHERE industry Like 'Crypto%'

UPDATE PortfolioProjects..layoffscopy$
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM PortfolioProjects..layoffscopy$
ORDER BY 1

UPDATE PortfolioProjects..layoffscopy$
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'


ALTER TABLE PortfolioProjects..layoffscopy$
ALTER COLUMN date DATE;


-- Null and Blank 


SELECT *
FROM PortfolioProjects..layoffscopy$
WHERE industry IS NULL 
or industry = 'NULL'

UPDATE PortfolioProjects..layoffscopy$
SET 
    company = NULL,
    industry = NULL,
    percentage_laid_off = NULL,
    stage = NULL,
    funds_raised_millions = NULL 
WHERE 
    company = 'NULL' 
    OR industry = 'NULL' 
    OR percentage_laid_off = 'NULL' 
    OR stage = 'NULL' 
    OR funds_raised_millions = 'NULL';

SELECT t1.industry , t2.industry 
FROM PortfolioProjects..layoffscopy$ t1
JOIN PortfolioProjects..layoffscopy$ t2
ON t1.company = t2.company 
WHERE (t1.industry  IS NULL OR t1.industry='NULL')
AND t2.industry IS NOT NULL

UPDATE t1
SET t1.industry = t2.industry
FROM PortfolioProjects..layoffscopy$ t1
JOIN PortfolioProjects..layoffscopy$ t2 ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = 'NULL')
AND t2.industry IS NOT NULL;


SELECT *
FROM PortfolioProjects..layoffscopy$
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL

DELETE
FROM PortfolioProjects..layoffscopy$
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL


SELECT *
FROM PortfolioProjects..layoffs$