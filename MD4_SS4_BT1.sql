create database md4_baitap_ls4;
use md4_baitap_ls4;
CREATE TABLE Class (
	classId int primary key auto_increment,
    className varchar(255) unique not null,
    startDate datetime default now(),
    statusClass tinyint 
);
insert into Class(className,startDate,statusClass)  values 
("A1", '2008/12/20', 1),
("A2", '2008/12/22', 1),
("A3",'2008/12/12', 0)
;
create table studentmanage(
	studentId int primary key auto_increment, 
    studenName varchar(255)  not null,
	address text,
	phoneNumber varchar(255),
	statusStd tinyint,
    classId int ,
    foreign key (classId) references Class (classId)
);
insert into studentmanage values 
(null, "Hung", "Ha Noi", "0389373739287",  1,1),
(null, "Hoa ", "Hai phong", null,  1,1),
(null, "Manh", "HCM", null, 0,2 );

create table `subject`(
	subjectId int primary key  auto_increment ,
    subjectName varchar(255) not null,
    credit int ,
    status1 tinyint 
);

-- nhap du lieu vao cho bang  subject
insert into `subject` (subjectname, credit,status1) values
("CF", 5, 1),
("C", 6,1 ),
("HDJ", 5,1),
("RDBMS", 10,1);
-- nhap du lieu vao cho bang  student
create table Mark (
	markId int primary key auto_increment,
    subId int ,
    foreign key (subId) references `subject`(subjectId),
    studentId int ,
    foreign key (subId) references studentmanage(studentId),
    mark tinyint ,
	examTimes time 
);
insert into Mark (subId,studentId,mark,examTimes) values 
	(1,1,8,1), (1,2,10,2),(2,1,12,1);
-- •	Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
SELECT *
FROM `subject`
WHERE credit = (
  SELECT MAX(credit)
  FROM subject
);
-- •	Hiển thị các thông tin môn học có điểm thi lớn nhất.
 select 
 s.subjectId , m.markId from `subject` s join Mark m on s.subjectId = m.markId
 where(select max(mark) from Mark);
 -- •	Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
 SELECT S.studentId,S.studenName, AVG(Mark)
FROM studentmanage S join Mark M on S.studentId = M.studentId
GROUP BY S.studentId, S.studenName
order by  AVG(Mark) desc