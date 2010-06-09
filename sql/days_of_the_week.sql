-- Days of Week
select DAYOFWEEK(time),count(*),sum(size) from small group by DAYOFWEEK(time);