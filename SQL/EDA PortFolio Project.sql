SELECT *
FROM PortfolioProjects..layoffscopy$

ALTER TABLE PortfolioProjects..layoffscopy$
ALTER COLUMN percentage_laid_off DECIMAL(5, 2);


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM PortfolioProjects..layoffs$
WHERE percentage_laid_off <> 'NULL'


SELECT *
FROM PortfolioProjects..layoffscopy$
WHERE percentage_laid_off =1
ORDER BY funds_raised_millions desc

SELECT company, SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY company
ORDER BY 2 desc

SELECT MIN(date), MAX(date)
FROM PortfolioProjects..layoffscopy$

SELECT industry, SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY industry
ORDER BY 2 desc


SELECT country, SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY country
ORDER BY 2 desc


SELECT YEAR(date), SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY YEAR(date)
ORDER BY 2 desc


SELECT FORMAT(date, 'yyyy-MM') AS [Month], SUM(total_laid_off) AS TotalLaidOff
FROM PortfolioProjects..layoffscopy$
WHERE date IS NOT NULL 
GROUP BY FORMAT(date, 'yyyy-MM')
ORDER BY 1 ASC

WITH Rolling_Total AS
( 
    SELECT 
        FORMAT(date, 'yyyy-MM') AS [Month], 
        SUM(total_laid_off) AS TotalLaidOff
    FROM PortfolioProjects..layoffscopy$
    WHERE date IS NOT NULL 
    GROUP BY FORMAT(date, 'yyyy-MM')
)
SELECT 
    [Month], TotalLaidOff,
    SUM(TotalLaidOff) OVER (ORDER BY [Month] ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Rolling_total
FROM Rolling_Total;


SELECT company,YEAR(date), SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY company, YEAR(date)
ORDER BY 3 desc


WITH company_year (company,years,total_laid_off) AS
(
SELECT company,YEAR(date), SUM(total_laid_off)
FROM PortfolioProjects..layoffscopy$
GROUP BY company, YEAR(date)
) , Company_Year_Rank AS (
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)

SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5