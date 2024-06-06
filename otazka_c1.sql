-- vyber hodnot z tabulky pro 5958 - prumerna hruba mzda
SELECT *
FROM czechia_payroll cp 
WHERE value_type_code = 5958;
-- vyber nenulovych hodnot
SELECT *
FROM czechia_payroll cp 
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL;
-- vyber sloupcu
SELECT 
	cp.value,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code;
-- selekt nulovych hodnot
SELECT 
	cp.value,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL;
-- tento vystup pouzit do reportu
SELECT 
	cp.value,
	cp.payroll_year,
	cp.payroll_quarter,
	cp.calculation_code,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL AND 
	calculation_code = 100
ORDER BY 
	cp.payroll_year;
-- prumerne rocni hodnoty
SELECT 
	cp.payroll_year,
	cpib.name,
	cp.calculation_code,
	AVG(cp.value) AS average
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL AND 
	calculation_code = 100
GROUP BY 
	cpib.name,
	cp.payroll_year 
ORDER BY 
	cpib.name,
	cp.payroll_year;
-- proc je mezi lety 2012 a 2013 skok?
SELECT 
	cp.value,
	cp.value_type_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND  
	industry_branch_code = 'K' AND 
	payroll_year = 2012;
-- 2013
SELECT 
	cp.value,
	cp.value_type_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND  
	industry_branch_code = 'K' AND 
	payroll_year = 2013;
-- pro urcity rok a odvetvi
SELECT
	cp.value,
	cp.value_type_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cp.calculation_code,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND 
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL AND 
	industry_branch_code = 'B' AND 
	payroll_year = 2020 AND 
	calculation_code = 100
ORDER BY 
	cp.payroll_year;
-- zjišťuji proč mám dvojí hodnoty - v tabulce je sloupec calculation code, který obsahuje údaje fyzické a přepočtené
-- v reportu vycházím z hodnot fyzických
-- upravuji SQL dotazy pro výstup
SELECT *
FROM czechia_payroll cp 
WHERE cp.value_type_code = 5958
ORDER BY payroll_year DESC;
-- vyber hodnot
SELECT 
	cp.value,
	cp.value_type_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name 
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND  
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL AND 
	industry_branch_code = 'K' AND 
	payroll_year = 2018;
-- ověřuji si správnost výpočtů v reportu
SELECT 
	cp.value,
	cp.value_type_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name,
	avg(value) AS average
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
ON cp.industry_branch_code = cpib.code
WHERE 
	value_type_code = 5958 AND  
	value IS NOT NULL AND 
	industry_branch_code IS NOT NULL AND 
	industry_branch_code = 'K' AND 
	payroll_year = 2018 AND 
	calculation_code = 100
GROUP BY 
	cp.value,
	cp.value_type_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cpib.name;

