USE adm_committee;

DELIMITER // 

CREATE PROCEDURE future_st_chemistry () 
BEGIN
	SET @row_number = 0;
	SELECT *
	FROM (
		SELECT (@row_number:=@row_number + 1) AS numb,
			CONCAT (applicants.firstname, applicants.lastname) AS fullname,
			chemistry.total AS total,
			agreement.origanal_document AS confirmation
		FROM chemistry
			JOIN agreement ON chemistry.agreement_id = agreement.id 
			JOIN applicants ON applicants.id = agreement.applicants_id 
			JOIN directions ON directions.id = agreement.directions_id
		WHERE 
			agreement.directions_id = (SELECT id FROM directions WHERE name_programm = 'chemistry')
			AND agreement.origanal_document = 'yes'
		ORDER BY chemistry.total DESC) AS tb1
	WHERE
		numb <= (SELECT budget_place  FROM directions WHERE name_programm = 'chemistry' );
END //
DELIMITER ;

CALL future_st_chemistry ();