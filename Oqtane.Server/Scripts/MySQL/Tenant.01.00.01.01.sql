/*  

Version 1.0.1 Notification migration script

*/

ALTER TABLE `Notification` ADD
	`SendOn` datetime NULL
;

UPDATE `Notification` SET SendOn = CreatedOn WHERE SendOn IS NULL
;
