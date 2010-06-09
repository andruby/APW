-- Days of Week
select DAYOFWEEK(time),count(*),sum(size) from full group by DAYOFWEEK(time);