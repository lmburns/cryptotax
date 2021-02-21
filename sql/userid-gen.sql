-- use to generate document / user id's
create table seed ( i int not null auto_increment primary key );
insert into seed values (NULL),(NULL),(NULL),(NULL),(NULL),
                        (NULL),(NULL),(NULL),(NULL),(NULL);

insert into seed select NULL from seed s1, seed s2, seed s3, seed s4, seed s5, seed s6;
delete from seed where i < 100000;

create table idmap ( n int not null auto_increment primary key, id int not null );
insert into idmap select NULL, i from seed order by rand();

drop table seed;

select * from idmap limit 10;
