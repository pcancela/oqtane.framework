/*  

Create tables

*/
CREATE TABLE `Tenant`(
	`TenantId` INT AUTO_INCREMENT NOT NULL,
	`Name` VARCHAR(100) NOT NULL,
	`DBConnectionString` VARCHAR(1024) NOT NULL,
	`Version` VARCHAR(50) NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Tenant` PRIMARY KEY 
  (
	`TenantId` ASC
  )
)
;

CREATE TABLE `Alias`(
	`AliasId` INT AUTO_INCREMENT NOT NULL,
	`Name` VARCHAR(200) NOT NULL,
	`TenantId` INT NOT NULL,
	`SiteId` INT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Alias` PRIMARY KEY 
  (
	`AliasId` ASC
  )
)
;


CREATE TABLE `ModuleDefinition`(
	`ModuleDefinitionId` INT AUTO_INCREMENT NOT NULL,
	`ModuleDefinitionName` VARCHAR(200) NOT NULL,
	`Name` VARCHAR(200) NULL,
	`Description` VARCHAR(2000) NULL,
	`Categories` VARCHAR(200) NULL,
	`Version` VARCHAR(50) NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_ModuleDefinition` PRIMARY KEY 
  (
	`ModuleDefinitionId` ASC
  )
)
;

CREATE TABLE `Job` (
	`JobId` INT AUTO_INCREMENT NOT NULL,
	`Name` VARCHAR(200) NOT NULL,
	`JobType` VARCHAR(200) NOT NULL,
	`Frequency` VARCHAR(1) NOT NULL,
	`Interval` INT NOT NULL,
	`StartDate` DATETIME NULL,
	`EndDate` DATETIME NULL,
	`IsEnabled` TINYINT NOT NULL,
	`IsStarted` TINYINT NOT NULL,
	`IsExecuting` TINYINT NOT NULL,
	`NextExecution` DATETIME NULL,
	`RetentionHistory` INT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
    CONSTRAINT `PK_Job` PRIMARY KEY 
    (
	  `JobId` ASC
    )
)
;

CREATE TABLE `JobLog` (
	`JobLogId` INT AUTO_INCREMENT NOT NULL,
	`JobId` INT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`FinishDate` DATETIME NULL,
	`Succeeded` TINYINT NULL,
	`Notes` TEXT NULL,
    CONSTRAINT `PK_JobLog` PRIMARY KEY 
    (
	  `JobLogId` ASC
    ) 
)
;

/*  

Create foreign key relationships

*/
ALTER TABLE `Alias`  ADD CONSTRAINT FOREIGN KEY (`TenantId`)
REFERENCES `Tenant` (`TenantId`)
ON DELETE CASCADE
;



