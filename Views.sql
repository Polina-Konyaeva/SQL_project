-- Подсчет поданных оригиналов на каждое направление
USE adm_committee;

-- представление 1
DROP VIEW IF EXISTS quantity_origanal;
CREATE VIEW quantity_origanal AS 
SELECT 
	directions.name_programm AS 'direction', 
	count(agreement.applicants_id) AS 'quantity origanal',
	directions.budget_place AS 'quantity budget'
FROM 
	agreement
	JOIN directions ON agreement.directions_id = directions.id 
WHERE agreement.origanal_document = 'yes'
GROUP BY agreement.directions_id;

-- Абитуриенты, которые пришли после школы
-- представление 2
DROP VIEW IF EXISTS finish_school;
CREATE VIEW finish_school AS 
SELECT 
	CONCAT (applicants.firstname, ' ', applicants.lastname) AS 'full name',
	info_applicants.level_education AS 'level education'
FROM info_applicants
	JOIN applicants ON applicants.id = info_applicants.applicants_id
WHERE level_education = 'school';


