-- Build the small table from the full table
insert into small select * from full where rand < 0.01;