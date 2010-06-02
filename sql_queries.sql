-- Enumerate http_methods
select method,count(*),sum(size) from full group by method;

-- Days of Week
select DAYOFWEEK(time),count(*),sum(size) from small group by DAYOFWEEK(time);

-- Build the small table from the full table
insert into small select * from full where rand < 0.01;