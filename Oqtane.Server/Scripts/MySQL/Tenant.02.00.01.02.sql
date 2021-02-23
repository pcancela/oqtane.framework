/*  

Version 2.0.1 Tenant migration script

*/

CREATE TABLE `Language`(
	`LanguageId` int AUTO_INCREMENT NOT NULL,
	`Name` varchar(100) NOT NULL,
    `Code` varchar(10) NOT NULL,
    `IsDefault` tinyint NOT NULL,
    `SiteId` int NOT NULL,
	`CreatedBy` varchar(256) NOT NULL,
	`CreatedOn` datetime NOT NULL,
	`ModifiedBy` varchar(256) NOT NULL,
	`ModifiedOn` datetime NOT NULL,
  CONSTRAINT `PK_Language` PRIMARY KEY 
  (
	`LanguageId` ASC
  )
)
;

ALTER TABLE `Language` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;