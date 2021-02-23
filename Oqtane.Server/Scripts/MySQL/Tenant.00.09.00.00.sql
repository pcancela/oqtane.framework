/*  

Create tables

*/

CREATE TABLE `Site`(
	`SiteId` INT AUTO_INCREMENT NOT NULL,
	`TenantId` INT NOT NULL,
	`Name` VARCHAR(200) NOT NULL,
	`LogoFileId` INT NULL,
	`FaviconFileId` INT NULL,
	`DefaultThemeType` VARCHAR(200) NOT NULL,
	`DefaultLayoutType` VARCHAR(200) NOT NULL,
	`DefaultContainerType` VARCHAR(200) NOT NULL,
	`PwaIsEnabled` TINYINT NOT NULL,
	`PwaAppIconFileId` INT NULL,
	`PwaSplashIconFileId` INT NULL,
	`AllowRegistration` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_Site` PRIMARY KEY 
  (
	`SiteId` ASC
  )
)
;

CREATE TABLE `Page`(
	`PageId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NOT NULL,
	`Path` VARCHAR(50) NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`Title` VARCHAR(200) NULL,
	`ThemeType` VARCHAR(200) NULL,
	`Icon` VARCHAR(50) NOT NULL,
	`ParentId` INT NULL,
	`Order` INT NOT NULL,
	`IsNavigation` TINYINT NOT NULL,
	`Url` VARCHAR(500) NULL,
	`LayoutType` VARCHAR(200) NOT NULL,
	`EditMode` TINYINT NOT NULL,
	`UserId` INT NULL,
	`IsPersonalizable` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_Page` PRIMARY KEY 
  (
	`PageId` ASC
  )
)
;

CREATE TABLE `Module`(
	`ModuleId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NOT NULL,
	`ModuleDefinitionName` VARCHAR(200) NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Module` PRIMARY KEY 
  (
	`ModuleId` ASC
  )
)
;

CREATE TABLE `PageModule`(
	`PageModuleId` INT AUTO_INCREMENT NOT NULL,
	`PageId` INT NOT NULL,
	`ModuleId` INT NOT NULL,
	`Title` VARCHAR(200) NOT NULL,
	`Pane` VARCHAR(50) NOT NULL,
	`Order` INT NOT NULL,
	`ContainerType` VARCHAR(200) NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_PageModule` PRIMARY KEY 
  (
	`PageModuleId` ASC
  )
)
;

CREATE TABLE `User`(
	`UserId` INT AUTO_INCREMENT NOT NULL,
	`Username` VARCHAR(256) NOT NULL,
	`DisplayName` VARCHAR(50) NOT NULL,
	`Email` VARCHAR(256) NOT NULL,
	`PhotoFileId` INT NULL,
	`LastLoginOn` DATETIME NULL,
	`LastIPAddress` VARCHAR(50) NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_User` PRIMARY KEY 
  (
	`UserId` ASC
  )
)
;

CREATE TABLE `Role`(
	`RoleId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NULL,
	`Name` VARCHAR(256) NOT NULL,
	`Description` VARCHAR(50) NOT NULL,
	`IsAutoAssigned` TINYINT NOT NULL,
	`IsSystem` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Role` PRIMARY KEY 
  (
	`RoleId` ASC
  )
)
;

CREATE TABLE `UserRole`(
	`UserRoleId` INT AUTO_INCREMENT NOT NULL,
	`UserId` INT NOT NULL,
	`RoleId` INT NOT NULL,
	`EffectiveDate` DATETIME NULL,
	`ExpiryDate` DATETIME NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_UserRole` PRIMARY KEY 
  (
	`UserRoleId` ASC
  )
)
;

CREATE TABLE `Permission`(
	`PermissionId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NOT NULL,
	`EntityName` VARCHAR(50) NOT NULL,
	`EntityId` INT NOT NULL,
	`PermissionName` VARCHAR(50) NOT NULL,
	`RoleId` INT NULL,
	`UserId` INT NULL,
	`IsAuthorized` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Permission` PRIMARY KEY 
  (
	`PermissionId` ASC
  )
)
;

CREATE TABLE `Setting`(
	`SettingId` INT AUTO_INCREMENT NOT NULL,
	`EntityName` VARCHAR(50) NOT NULL,
	`EntityId` INT NOT NULL,
	`SettingName` VARCHAR(50) NOT NULL,
	`SettingValue` TEXT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Setting` PRIMARY KEY 
  (
	`SettingId` ASC
  )
)
;

CREATE TABLE `Profile`(
	`ProfileId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`Title` VARCHAR(50) NOT NULL,
	`Description` VARCHAR(256) NULL,
	`Category` VARCHAR(50) NOT NULL,
	`ViewOrder` INT NOT NULL,
	`MaxLength` INT NOT NULL,
	`DefaultValue` VARCHAR(2000) NULL,
	`IsRequired` TINYINT NOT NULL,
	`IsPrivate` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_Profile` PRIMARY KEY 
  (
	`ProfileId` ASC
  )
)
;

CREATE TABLE `Log` (
   `LogId` INT AUTO_INCREMENT NOT NULL,
   `SiteId` INT NULL,
   `LogDate` DATETIME NOT NULL,
   `PageId` INT NULL,
   `ModuleId` INT NULL,
   `UserId` INT NULL,
   `Url` VARCHAR(2048) NOT NULL,
   `Server` VARCHAR(200) NOT NULL,
   `Category` VARCHAR(200) NOT NULL,
   `Feature` VARCHAR(200) NOT NULL,
   `Function` VARCHAR(20) NOT NULL,
   `Level` VARCHAR(20) NOT NULL,
   `Message` TEXT NOT NULL,
   `MessageTemplate` TEXT NOT NULL,
   `Exception` TEXT NULL,
   `Properties` TEXT NULL,
   CONSTRAINT `PK_Log` PRIMARY KEY 
   (
     `LogId` ASC
   ) 
)
;

CREATE TABLE `Notification`(
	`NotificationId` INT AUTO_INCREMENT NOT NULL,
    `SiteId` INT NOT NULL,
	`FromUserId` INT NULL,
	`ToUserId` INT NULL,
	`ToEmail` VARCHAR(256) NOT NULL,
	`Subject` VARCHAR(256) NOT NULL,
	`Body` TEXT NOT NULL,
	`ParentId` INT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`IsDelivered` TINYINT NOT NULL,
	`DeliveredOn` DATETIME NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_Notification` PRIMARY KEY 
  (
	`NotificationId` ASC
  )
)
;

CREATE TABLE `Folder`(
	`FolderId` INT AUTO_INCREMENT NOT NULL,
	`SiteId` INT NOT NULL,
	`Path` VARCHAR(50) NOT NULL,
	`Name` VARCHAR(50) NOT NULL,
	`ParentId` INT NULL,
	`Order` INT NOT NULL,
	`IsSystem` TINYINT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_Folder` PRIMARY KEY 
  (
	`FolderId` ASC
  )
)
;

CREATE TABLE `File`(
	`FileId` INT AUTO_INCREMENT NOT NULL,
	`FolderId` INT NOT NULL,
	`Name` VARCHAR(250) NOT NULL,
	`Extension` VARCHAR(50) NOT NULL,
	`Size` INT NOT NULL,
	`ImageHeight` INT NOT NULL,
	`ImageWidth` INT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
	`DeletedBy` VARCHAR(256) NULL,
	`DeletedOn` DATETIME NULL,
	`IsDeleted`TINYINT NOT NULL,
  CONSTRAINT `PK_File` PRIMARY KEY 
  (
	`FileId` ASC
  )
)
;

CREATE TABLE `HtmlText`(
	`HtmlTextId` INT AUTO_INCREMENT NOT NULL,
	`ModuleId` INT NOT NULL,
	`Content` TEXT NOT NULL,
	`CreatedBy` VARCHAR(256) NOT NULL,
	`CreatedOn` DATETIME NOT NULL,
	`ModifiedBy` VARCHAR(256) NOT NULL,
	`ModifiedOn` DATETIME NOT NULL,
  CONSTRAINT `PK_HtmlText` PRIMARY KEY 
  (
	`HtmlTextId` ASC
  )
)
;

/*  

Create foreign key relationships

*/
ALTER TABLE `Module` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;

ALTER TABLE `Page` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;

ALTER TABLE `PageModule` ADD CONSTRAINT FOREIGN KEY (`ModuleId`)
REFERENCES `Module` (`ModuleId`)
;

ALTER TABLE `PageModule` ADD CONSTRAINT FOREIGN KEY (`PageId`)
REFERENCES `Page` (`PageId`)
ON DELETE CASCADE
;

ALTER TABLE `Role`  ADD CONSTRAINT FOREIGN KEY (`SiteId`) 
REFERENCES `Site` (`SiteId`) 
ON DELETE CASCADE 
;

ALTER TABLE `UserRole` ADD CONSTRAINT FOREIGN KEY (`UserId`) 
REFERENCES `User` (`UserId`) 
ON DELETE CASCADE 
;

ALTER TABLE `UserRole` ADD CONSTRAINT FOREIGN KEY (`RoleId`) 
REFERENCES `Role` (`RoleId`) 
;

ALTER TABLE `Permission` ADD CONSTRAINT FOREIGN KEY (`SiteId`) 
REFERENCES `Site` (`SiteId`) 
ON DELETE CASCADE 
;

ALTER TABLE `Permission` ADD CONSTRAINT FOREIGN KEY (`UserId`) 
REFERENCES `User` (`UserId`) 	
;

ALTER TABLE `Permission` ADD CONSTRAINT FOREIGN KEY (`RoleId`) 
REFERENCES `Role` (`RoleId`) 
;



ALTER TABLE `Log` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;

ALTER TABLE `Notification` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;

ALTER TABLE `Folder` ADD CONSTRAINT FOREIGN KEY (`SiteId`)
REFERENCES `Site` (`SiteId`)
ON DELETE CASCADE
;

ALTER TABLE `File` ADD CONSTRAINT FOREIGN KEY (`FolderId`)
REFERENCES `Folder` (`FolderId`)
ON DELETE CASCADE
;

ALTER TABLE `HtmlText` ADD CONSTRAINT FOREIGN KEY (`ModuleId`)
REFERENCES `Module` (`ModuleId`)
ON DELETE CASCADE
;


/*  

Create indexes

*/

CREATE UNIQUE INDEX IX_Setting ON Setting
	(
	EntityName,
	EntityId,
	SettingName
	)
;

CREATE UNIQUE INDEX IX_User ON `User`
	(
	Username
	)
;

CREATE UNIQUE INDEX IX_Permission ON Permission
	(
	SiteId,
	EntityName,
	EntityId,
	PermissionName,
	RoleId,
	UserId
	)
;

CREATE UNIQUE INDEX IX_Page ON Page
	(
	SiteId,
	`Path`,
	UserId
	)
;

CREATE UNIQUE INDEX IX_UserRole ON UserRole
	(
	RoleId,
	UserId
	)
;

CREATE UNIQUE INDEX IX_Folder ON Folder
	(
	SiteId,
	`Path`
	)
;

/*  

ASP.NET Identity Minimal Schema

*/

CREATE TABLE `AspNetUsers`(
	`Id` VARCHAR(450) NOT NULL,
	`UserName` VARCHAR(256) NULL,
	`NormalizedUserName` VARCHAR(256) NULL,
	`Email` VARCHAR(256) NULL,
	`NormalizedEmail` VARCHAR(256) NULL,
	`EmailConfirmed` TINYINT NOT NULL,
	`PasswordHash` TEXT NULL,
	`SecurityStamp` TEXT NULL,
	`ConcurrencyStamp` TEXT NULL,
	`PhoneNumber` TEXT NULL,
	`PhoneNumberConfirmed` TINYINT NOT NULL,
	`TwoFactorEnabled` TINYINT NOT NULL,
	`LockoutEnd` DATETIME NULL,
	`LockoutEnabled` TINYINT NOT NULL,
	`AccessFailedCount` INT NOT NULL,
 CONSTRAINT `PK_AspNetUsers` PRIMARY KEY 
(
	`Id` ASC
)
)
;

CREATE TABLE `AspNetUserClaims`(
	`Id` INT AUTO_INCREMENT NOT NULL,
	`UserId` VARCHAR(450) NOT NULL,
	`ClaimType` TEXT NULL,
	`ClaimValue` TEXT NULL,
 CONSTRAINT `PK_AspNetUserClaims` PRIMARY KEY 
(
	`Id` ASC
)
)
;

CREATE INDEX `IX_AspNetUserClaims_UserId` ON `AspNetUserClaims`
(
	`UserId` ASC
)
;

CREATE INDEX `EmailIndex` ON `AspNetUsers`
(
	`NormalizedEmail` ASC
)
;

CREATE UNIQUE INDEX `UserNameIndex` ON `AspNetUsers`
(
	`NormalizedUserName` ASC
)
;

ALTER TABLE `AspNetUserClaims` ADD  CONSTRAINT FOREIGN KEY (`UserId`)
REFERENCES `AspNetUsers` (`Id`)
ON DELETE CASCADE
;

