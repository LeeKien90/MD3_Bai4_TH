CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

insert into Class
values (1, 'A1', '2008-12-20', 1),
(2, 'A2', '2008-12-22', 1),
(3, 'B3', current_date, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1),
('Hoa', 'Hai phong',093256476, 1, 1),
('Manh', 'HCM', '0123123123', 0, 2); 

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
 (2, 'C', 6, 1),
 (3, 'HDJ', 5, 1),
 (4, 'RDBMS', 10, 1);
 
 insert INTO Mark (SubId, StudentId, Mark, ExamTimes) 
 VALUES (1, 1, 8, 1),
 (1, 2, 10, 2),
 (2, 1, 12, 1);
 
 -- Hiển thị số lượng sinh viên ở từng nơi
 select s.address, count(s.studentid) as 'số lượng sinh viên'
 from student s
 group by s.address;
 -- Tính điểm trung bình các môn học của mỗi học viên
 select s.studentname, avg(m.mark) as 'điểm trung bình'
 from student s join mark m on s.studentid = m.studentid
 group by s.studentid;
 -- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
 select s.studentname, avg(m.mark) as 'điểm trung bình'
 from student s join mark m on s.studentid = m.studentid
 group by s.studentid
 having avg(m.mark) > 15;
 -- Hiển thị thông tin các học viên có điểm trung bình lớn nhất. 
select s.studentname, avg(m.mark) as 'điểm trung bình'
 from student s join mark m on s.studentid = m.studentid
 group by s.studentid
 having avg(m.mark) >= all(
 select avg(m.mark)
 from mark m
 group by m.studentid
 );