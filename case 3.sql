SELECT category, AVG(Score), ROUND(100*SUM(Extend = 'Yes')/COUNT(*), 2) as success_percentage
FROM data
GROUP BY category;

SELECT keywords, AVG(Score), ROUND(100*SUM(Extend = 'Yes')/COUNT(*), 2) as success_percentage
FROM data
GROUP BY keywords;

SELECT body, AVG(Score), ROUND(100*SUM(Extend = 'Yes')/COUNT(*), 2) as success_percentage
FROM data
GROUP BY body;

SELECT adtype, AVG(Score), ROUND(100*SUM(Extend = 'Yes')/COUNT(*), 2) as success_percentage
FROM data
GROUP BY adtype;