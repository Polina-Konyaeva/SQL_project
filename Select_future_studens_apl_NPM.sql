-- ¬ыборка поступивших на направление прикладна€ математика и информатика
USE adm_committee;

SET @row_number = 0;

SELECT *
FROM (
	SELECT (@row_number:=@row_number + 1) AS numb,
		applicants.firstname AS firstname ,
		applicants.lastname AS lastname ,
		applied_math_inf.total AS total ,
		agreement.origanal_document AS confirmation 
	FROM applied_math_inf
		JOIN agreement ON applied_math_inf.agreement_id = agreement.id 
		JOIN applicants ON applicants.id = agreement.applicants_id 
		JOIN directions ON directions.id = agreement.directions_id
	WHERE 
		agreement.directions_id = (SELECT id FROM directions WHERE name_programm = 'applied_math_inf')
		AND agreement.origanal_document = 'yes'
	ORDER BY applied_math_inf.total DESC) AS tb1
WHERE
	numb <= (SELECT budget_place  FROM directions WHERE name_programm = 'applied_math_inf' );