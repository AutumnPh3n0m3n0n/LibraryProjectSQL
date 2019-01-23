USE db_zoo;

CREATE TABLE TBL_ANIMALIA (
	animalia_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	animalia_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_animalia
	(animalia_type)
	VALUES
	('vertibrate'),
	('invertebrate')
;

SELECT * FROM tbl_animalia;

CREATE TABLE tbl_class (
	class_id INT PRIMARY KEY NOT NULL IDENTITY(100,1),
	class_type VARCHAR(50) NOT NULL
);

INSERT INTO tbl_class
	(class_type)
	VALUE
	('bird')
	('reptilian')
	('mammal')
	('arthropod')
	('fish')
	('worm')
	('cnidaria')
	('echinoderm')
}
SELECT * FROM tbl_class;

SELECT REPLACE(class_type, 'birds', 'bird') FROM tbl_class;

SELECT COUNT(class_type) FROM tbl_class WHERE class_type = 'bird');

CREATE TABLE tbl_persons (
	persons_id INT PRIMARY KEY NOT NULL IDENTITY (1,1);
	persons_fname VARCHAR(50) NOT NULL,
	persons_lname VARCHAR(50) NOT NULL,
	persons_contact VARCHAR(50) NOT NULL
};

CREATE TABLE tbl_athletes