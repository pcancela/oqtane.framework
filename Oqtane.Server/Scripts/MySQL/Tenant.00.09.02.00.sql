/*  

Version 0.9.2 migration script

*/

ALTER TABLE `Role`
MODIFY COLUMN `Description` VARCHAR (256) NOT NULL
;

ALTER TABLE `Page` ADD
	`DefaultContainerType` VARCHAR(200) NULL
;

UPDATE `Page`
SET `DefaultContainerType` = ''
;
