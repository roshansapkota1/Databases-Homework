drop table if exists attendance;
drop table if exists classe;
drop table if exists mentor;
drop table if exists student;

create table mentor (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  years_in_barcelona  int NOT NULL,
  address   VARCHAR(120),
  city      VARCHAR(30),
  postcode  VARCHAR(12),
  favourite_language VARCHAR(120) not null
);  

create table classe (
  id        SERIAL PRIMARY KEY,
  leading_mentor_id int references mentor(id),
  topic VARCHAR(120) not null,
  class_date date not null,
  class_location VARCHAR(120) not null
);

create table student (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  age       int,
  address   VARCHAR(120),
  city      VARCHAR(30),
  postcode  VARCHAR(12)
);

create table attendance (
  student_id int references student(id),
  classe_id int references classe(id)
);

INSERT INTO mentor (name, years_in_barcelona, address, city, postcode, favourite_language) VALUES ('Ricard', 10, 'C Riereta 22', 'Barcelona', '08001', 'Java' );
INSERT INTO mentor (name, years_in_barcelona, address, city, postcode, favourite_language)  VALUES ('yonah', 10, 'catalunya-9', 'Barcelona','2131', 'JavaScript');
INSERT INTO mentor (name, years_in_barcelona, address, favourite_language, city, postcode) VALUES ('Stefanos',3,'11 Carrer de la Fusina','JS','Barcelona','12345');
INSERT INTO mentor (name, years_in_barcelona, address, city, postcode, favourite_language) VALUES ('Donald', 2, 'ronda guinardo 2,1-2', 'Barcelona', '08024', 'Java');
insert into mentor (name, years_in_barcelona, address, city, postcode, favourite_language) values ('Carlos', 6, 'Passeo de gracia 1', 'Barcelona', '08789', 'Javascript');

insert into classe (leading_mentor_id, topic, class_date, class_location) values (5, 'Presentation', '2020-03-04', 'OCC');
insert into classe (leading_mentor_id, topic, class_date, class_location) values (1, 'DB', '2020-07-18', 'Remote');
insert into classe (leading_mentor_id, topic, class_date, class_location) values (3, 'Javascript', '2020-04-22', 'Remote');

INSERT INTO student (name, address, city, postcode, age) VALUES ('Thiago Pereira','Carrer dAvinyó','Barcelona','08008',28);
insert into student (name, address, city, postcode, age ) values ('Anandamaya', 'Av Sant Ildefons', 'Cornella de Llobregat', '08940', 25);
INSERT INTO student (name, address , city, postcode,age ) VALUES ('Akond', 'C Riereta 32', 'Barcelona', '08001', 31);
insert into student(name,age,address,city,postcode) values('Alejandro Sanchez',24,'Cornella','Cornella','08940');
insert into student  (name, address, city, postcode, age) values ('Rubén', 'Corséga 416', 'Barcelona', '08037', 29);
INSERT INTO student (name,age,address, city, postcode) VALUES ('roshan',25,'glories','Barcelona', '333');
INSERT INTO student (name,age,address, city, postcode) VALUES ('lavinia loredana', 35,'rossello 432','Barcelona', '08237');
insert into student (name, address , city, postcode, age) values ('Umit Oner', 'Carrer Canyelles', 'Tarragona', '43003', 32);
insert into student (name, address, city, postcode, age) values ('Joaquin', 'Joan Blanques', 'Barcelona', '0801AB', 29);
insert into student (name, address , city, postcode, age) values ('Viktoryia ', 'Avenida Denia', 'Santa Coloma de Gramenet', '08921', 31);

insert into attendance values(1, 1);
insert into attendance values(1, 2);
insert into attendance values(2, 2);
insert into attendance values(3, 2);
insert into attendance values(4, 2);
insert into attendance values(4, 2);
insert into attendance values(5, 2);
insert into attendance values(6, 2);
insert into attendance values(7, 2);
insert into attendance values(8, 2);
insert into attendance values(9, 2);
insert into attendance values(10, 2);

insert into attendance values(1, 3);
insert into attendance values(2, 3);
insert into attendance values(3, 3);

select * from mentor where years_in_barcelona > 5;
select * from mentor where favourite_language = 'JavaScript';
select * from classe where class_date < '2020-06-01';
select * from student s join attendance a on s.id = a.student_id join classe c on c.id = a.classe_id where c.topic = 'Javascript'; 

