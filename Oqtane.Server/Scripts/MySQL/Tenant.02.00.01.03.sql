/*  

Version 2.0.1 Tenant migration script

*/

DELETE FROM `Page`
WHERE Path = 'admin/tenants';
;

ALTER TABLE `Site` ADD
	`AdminContainerType` VARCHAR(200) NULL
;

UPDATE `Site` SET AdminContainerType = ''
;

