CREATE TABLE `HtmlText`(
	`HtmlTextId` int AUTO_INCREMENT NOT NULL,
	`ModuleId` int NOT NULL,
	`Content` varchar(21844) NOT NULL,
	`CreatedBy` varchar(256) NOT NULL,
	`CreatedOn` datetime NOT NULL,
	`ModifiedBy` varchar(256) NOT NULL,
	`ModifiedOn` datetime NOT NULL,
  CONSTRAINT `PK_HtmlText` PRIMARY KEY 
  (
	`HtmlTextId` ASC
  )
)
;

ALTER TABLE `HtmlText` ADD CONSTRAINT FOREIGN KEY (`ModuleId`)
REFERENCES `Module` (`ModuleId`)
ON DELETE CASCADE
;
