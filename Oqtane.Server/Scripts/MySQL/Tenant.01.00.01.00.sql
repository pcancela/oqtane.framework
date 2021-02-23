/*  

Version 1.0.1 Tenant migration script

*/

CREATE UNIQUE INDEX IX_Site ON `Site`
	(
	`TenantId`,
	`Name`
	)
;

CREATE UNIQUE INDEX IX_Role ON `Role`
	(
	`SiteId`,
	`Name`
	)
;

CREATE UNIQUE INDEX IX_Profile ON `Profile`
	(
	`SiteId`,
	`Name`
	)
;

CREATE UNIQUE INDEX IX_File ON `File`
	(
	`FolderId`,
	`Name`
	)
;

ALTER TABLE `Notification` 
ADD COLUMN `FromDisplayName` varchar(50) NULL,
ADD COLUMN `FromEmail` varchar(256) NULL,
ADD COLUMN `ToDisplayName` varchar(50) NULL
;
