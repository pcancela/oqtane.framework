/* 
    migrate to new naming convention for scripts
*/
 
 
UPDATE `schemaversions` SET scriptName = 'Oqtane.Scripts.Master.00.09.00.00.sql' WHERE scriptName = 'Oqtane.Scripts.Master.0.9.0.sql'
;
UPDATE `schemacersions` SET scriptName = 'Oqtane.Scripts.Master.01.00.01.00.sql' WHERE scriptName = 'Oqtane.Scripts.Master.1.0.1.sql'
;