-- Will delete the database if it is already exists 
drop database if exists UNIVERSITY;

create database UNIVERSITY;
-- use the database
use  UNIVERSITY; 

-- create the first table
create table Student (
StudentName varchar(50),
StudentID int,
Age int);

-- create the second table
create table Course(
CourseName varchar(50),
CourseID int,
CourseDepartment varchar(50));

-- create the thrid table
create table Instructer(
InstructerName varchar(50),
InstructerID int,
CourseIDTeaching int);

-- create enrollment table to make a relationship betwen course and student
CREATE TABLE Enrollment (
    StudentID INT,                
    CourseID INT,
    Marks INT
);

-- add primary keys
alter table Student
add primary key (StudentID);

alter table Course
add primary key (CourseID);

alter table Instructer 
add primary key (InstructerID);

ALTER TABLE Enrollment
ADD PRIMARY KEY (StudentID,CourseID);

-- add foreign keys
alter table Instructer
add foreign key (CourseIDTeaching) references Course(CourseID);

ALTER TABLE Enrollment
ADD FOREIGN KEY (StudentID) REFERENCES Student(StudentID);  

ALTER TABLE Enrollment
ADD FOREIGN KEY (CourseID) REFERENCES Course(CourseID);

-- Add conditions and constraints to the tables
alter table Student 
modify column StudentName varchar(50) NOT NULL;

alter table Course
add unique (CourseName);

alter table Course
alter CourseName set default 'unknown';

alter table Instructer
add check (instructerID > 0);

-- insert values
insert into Student values
('Abdullah',100,19),
('Muhammad',101,22),
('Ahmed',102,20),
('Ali',103,22),
('Eyad',104,19),
('Jamal',105,18),
('Mark',106,24),
('Abdulrahman',107,22),
('Jack',108,21),
('Wasem',109,20),
('Oby',110,20);

insert into Course values
('Database',1,'Computer'),
('Calculus',2,'Engineering'),
('Data Structures',3,'Computer'),
('Art basics',4,'Art'),
('Electircal Circuits',5,'Engineering');

insert into Instructer values
('Muhammad',1,2),
('Khalid',2,3),
('Jay',3,4),
('Saud',4,1),
('Hasan',5,5);

insert into Enrollment values
(100,2,98),
(101,4,87),
(102,1,89),
(103,2,67),
(104,3,100),
(105,5,79),
(106,3,73),
(107,4,100),
(108,4,82),
(109,3,92),
(110,1,96);

-- Selects statements
select StudentID
from Enrollment
where marks > 95;

select StudentID
from Student
where Age=20;

-- Aggregate operations
SELECT CourseID, AVG(Marks) AS Average_Mark
FROM Enrollment
GROUP BY CourseID;

select count(*) as Students
from Student;

-- Join statement
select Instructer.InstructerName , Instructer.CourseIDTeaching 
from Instructer
join Course on Instructer.CourseIDTeaching = CourseID;

-- Make the subquery
select StudentID
from Enrollment
where CourseID = (
select CourseID
from Course
where Coursename = 'Database' );

-- Make the view
create view Instructers_And_Courses as
select Instructer.InstructerID, Instructer.Instructername , Instructer.CourseIDTeaching 
from Instructer
join Course on Instructer.CourseIDTeaching = CourseID;

-- select the view
select * from Instructers_And_Courses;