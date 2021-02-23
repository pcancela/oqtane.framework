/*  

Version 1.0.2.0 Tenant migration script

*/

ALTER TABLE `Tenant` ADD
	`DBEngineVersion` VARCHAR(50) NULL
;

ALTER TABLE `Tenant` ADD
	`DBSqlType` VARCHAR(50) NOT NULL
;
