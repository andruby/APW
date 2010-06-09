-- Enumerate http_methods
select method,count(*),sum(size) from full group by method;