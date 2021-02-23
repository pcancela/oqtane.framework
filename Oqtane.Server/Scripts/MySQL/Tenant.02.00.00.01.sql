/*  

Version 2.0.0 Tenant migration script

*/

ALTER TABLE  `Page` 
MODIFY COLUMN `Path` varchar(256) NOT NULL
;

ALTER TABLE `Profile` ADD
	`Options` varchar(2000) NULL
;

UPDATE `Profile` SET Options = ''
;