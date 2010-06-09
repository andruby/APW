-- Getting the top unique uri's
SELECT uri, uri_id, count FROM
	(select s.uri_id,count(*) as 'count' from small s WHERE s.method = 'GET' group by s.uri_id order by count DESC LIMIT 100) c, uris u
	WHERE u.id = c.uri_id