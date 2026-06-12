-- EXPLORATORY DATA ANALYSIS

SELECT * 
FROM layoffs_staging2;

 /* =========================================================
	SECTION 1: INITIAL EXPLORATORY ANALYSIS
    ========================================================= */

SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off=12000;

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY total_laid_off DESC;

 /* =========================================================
	SECTION 2: COMPANY, INDUSTRY, AND COUNTRY ANALYSIS
    ========================================================= */

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

/* =========================================================
   SECTION 3: TIME-BASED TREND ANALYSIS
   ========================================================= */

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT DATE_FORMAT(`date`,'%Y-%m') AS month, SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY month
ORDER BY month ;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

/* =========================================================
   SECTION 4: ROLLING TOTAL ANALYSIS
   ========================================================= */
   
SELECT SUBSTRING(`date`,1,7) AS month, SUM(total_laid_off) 
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY month
ORDER BY month ;
 
 WITH ex_1 AS
(SELECT SUBSTRING(`date`,1,7) AS Month, SUM(total_laid_off) AS Total
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY month
ORDER BY month )
SELECT Month,Total,SUM(Total) OVER(ORDER BY month) AS Rolling_total
FROM ex_1;
   
   
   
   
   /* =========================================================
   SECTION 5: COMPANY RANKING ANALYSIS
   ========================================================= */