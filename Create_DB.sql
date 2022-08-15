-- приемная комиссия университета 

DROP DATABASE IF EXISTS adm_committee;
CREATE DATABASE adm_committee;
USE adm_committee;

DROP TABLE IF EXISTS applicants;
CREATE TABLE applicants (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE
);

DROP TABLE IF EXISTS applicants_points;
CREATE TABLE applicants_points (
	applicants_id BIGINT UNSIGNED NOT NULL UNIQUE,
	rus_point TINYINT UNSIGNED  NOT NULL,
	CHECK (rus_point < 101 AND rus_point > 36),
	math_point TINYINT UNSIGNED  NOT NULL,
	CHECK (math_point < 101 AND rus_point > 27),
	informatics_point TINYINT UNSIGNED NOT NULL,
	CHECK (informatics_point < 101 AND rus_point > 40),
	physics_point TINYINT UNSIGNED NOT NULL,
	CHECK (physics_point < 101 AND rus_point > 36),
	chemistry_point TINYINT UNSIGNED  NOT NULL,
	CHECK (chemistry_point < 101 AND rus_point > 36),
	extra_points TINYINT UNSIGNED  NOT NULL,
	CHECK (extra_points < 11),
	
	FOREIGN KEY (applicants_id) REFERENCES applicants(id)	
);

DROP TABLE IF EXISTS info_applicants;
CREATE TABLE info_applicants (
	applicants_id BIGINT UNSIGNED NOT NULL UNIQUE,
	level_education ENUM('school', 'college'),
	num_document BIGINT UNSIGNED NOT NULL UNIQUE,
	county VARCHAR(50),
	city VARCHAR(50),
	
	FOREIGN KEY (applicants_id) REFERENCES applicants(id)
);

DROP TABLE IF EXISTS directions;
CREATE TABLE directions (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_programm VARCHAR(150),
	budget_place TINYINT UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS agreement;
CREATE TABLE agreement (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	applicants_id BIGINT UNSIGNED NOT NULL,
	directions_id BIGINT UNSIGNED NOT NULL,
	origanal_document ENUM('yes', 'no'),
	FOREIGN KEY (applicants_id) REFERENCES applicants(id),
	FOREIGN KEY (directions_id) REFERENCES directions(id),
	
	INDEX idx(applicants_id, directions_id)
);

DROP TABLE IF EXISTS applied_math_inf;
CREATE TABLE applied_math_inf (
	agreement_id BIGINT UNSIGNED NOT NULL,
	math_point TINYINT UNSIGNED DEFAULT NULL,
	rus_point TINYINT UNSIGNED DEFAULT NULL,
	informatics_point TINYINT UNSIGNED DEFAULT NULL,
	extra_points TINYINT UNSIGNED DEFAULT NULL,
	total INT AS (math_point + rus_point + informatics_point + extra_points),
	
	FOREIGN KEY (agreement_id) REFERENCES agreement(id)
);

DROP TABLE IF EXISTS applied_math;
CREATE TABLE applied_math (
	agreement_id BIGINT UNSIGNED NOT NULL,
	math_point TINYINT UNSIGNED DEFAULT NULL,
	rus_point TINYINT UNSIGNED DEFAULT NULL,
	informatics_point TINYINT UNSIGNED DEFAULT NULL,
	extra_points TINYINT UNSIGNED DEFAULT NULL,
	total INT AS (math_point + rus_point + informatics_point + extra_points),
	
	FOREIGN KEY (agreement_id) REFERENCES agreement(id)
);

DROP TABLE IF EXISTS applied_inf;
CREATE TABLE applied_inf (
	agreement_id BIGINT UNSIGNED NOT NULL,
	math_point TINYINT UNSIGNED DEFAULT NULL,
	rus_point TINYINT UNSIGNED DEFAULT NULL,
	informatics_point TINYINT UNSIGNED DEFAULT NULL,
	extra_points TINYINT UNSIGNED DEFAULT NULL,
	total INT AS (math_point + rus_point + informatics_point + extra_points),
	
	FOREIGN KEY (agreement_id) REFERENCES agreement(id)
);

DROP TABLE IF EXISTS chemistry;
CREATE TABLE chemistry (
	agreement_id BIGINT UNSIGNED NOT NULL,
	math_point TINYINT UNSIGNED DEFAULT NULL,
	rus_point TINYINT UNSIGNED DEFAULT NULL,
	chemistry_point TINYINT UNSIGNED DEFAULT NULL,
	extra_points TINYINT UNSIGNED DEFAULT NULL,
	total INT AS (math_point + rus_point + chemistry_point + extra_points),
	
	FOREIGN KEY (agreement_id) REFERENCES agreement(id)
);

DROP TABLE IF EXISTS physics;
CREATE TABLE physics (
	agreement_id BIGINT UNSIGNED NOT NULL,
	math_point TINYINT UNSIGNED DEFAULT NULL,
	rus_point TINYINT UNSIGNED DEFAULT NULL,
	physics_point TINYINT UNSIGNED DEFAULT NULL,
	extra_points TINYINT UNSIGNED DEFAULT NULL,
	total INT AS (math_point + rus_point + physics_point + extra_points),
	
	FOREIGN KEY (agreement_id) REFERENCES agreement(id)
);


