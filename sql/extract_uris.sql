-- Extracting the uris into a separate table
ALTER TABLE full ADD COLUMN uri_id INTEGER UNSIGNED;
-- CREATE TABLE `uris` (
--   `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
--   `uri` varchar(4100) NOT NULL,
--   `md5` char(32) NOT NULL,
--   PRIMARY KEY (`id`),
--   UNIQUE KEY `md5_unique` (`md5`)
-- ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
-- CREATE function that extracts the uri into a separate table and returns the uri_id
DROP FUNCTION extract_uri_id;
DELIMITER //
CREATE FUNCTION extract_uri_id (in_uri text) RETURNS INTEGER UNSIGNED
deterministic
modifies sql data
begin
INSERT INTO uris (uri,md5) VALUES (in_uri,MD5(in_uri)) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id), uri=in_uri;
RETURN (SELECT LAST_INSERT_ID());
end//
DELIMITER ;
-- UPDATE the original table
UPDATE full SET uri_id = extract_uri_id(uri), uri = NULL WHERE uri IS NOT NULL;
-- REMOVE the unneeded uri column
ALTER TABLE full DROP COLUMN uri;
--CREATE INDEX uri_id_index ON full (uri_id);
OPTIMIZE TABLE full;
-- REMOVE the unneeded md5 column from uris
DROP INDEX md5_unique ON uris;
ALTER TABLE uris DROP COLUMN md5;
OPTIMIZE TABLE uris;