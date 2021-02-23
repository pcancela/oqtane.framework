/*  

Version 2.0.1 Tenant migration script

*/

UPDATE `Page` SET Icon = IF(Icon <> '', 'oi oi-' + Icon, '');
;

