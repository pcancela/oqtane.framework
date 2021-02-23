/*  

Version 0.9.1 migration script

*/

ALTER TABLE `Module` ADD
	`AllPages` tinyint NULL
;

UPDATE `Module`
SET `AllPages` = 0
;

