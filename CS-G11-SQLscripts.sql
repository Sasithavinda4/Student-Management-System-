-- Create STUDENT table
CREATE TABLE STUDENT (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    dob DATE
);

-- Create COURSE table
CREATE TABLE COURSE (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100),
    credits NUMBER
);

-- Create ENROLLMENT table
CREATE TABLE ENROLLMENT (
    enroll_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    grade VARCHAR2(2),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

-- Insert 5 records each
INSERT INTO STUDENT VALUES (1, 'Kamal Perera', 'kamal@gmail.com', TO_DATE('2000-05-10','YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (2, 'Nimal Silva', 'nimal@gmail.com', TO_DATE('2001-07-12','YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (3, 'Sunil Wickrama', 'sunil@gmail.com', TO_DATE('1999-11-23','YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (4, 'Dulani Kariyawasam', 'dulani@gmail.com', TO_DATE('2002-01-15','YYYY-MM-DD'));
INSERT INTO STUDENT VALUES (5, 'Ruwan Jayasekara', 'ruwan@gmail.com', TO_DATE('2000-09-18','YYYY-MM-DD'));

INSERT INTO COURSE VALUES (101, 'Database Systems', 3);
INSERT INTO COURSE VALUES (102, 'Java Programming', 4);
INSERT INTO COURSE VALUES (103, 'Data Structures', 3);
INSERT INTO COURSE VALUES (104, 'Networks', 2);
INSERT INTO COURSE VALUES (105, 'AI Basics', 3);

INSERT INTO ENROLLMENT VALUES (1, 1, 101, 'A');
INSERT INTO ENROLLMENT VALUES (2, 2, 102, 'B');
INSERT INTO ENROLLMENT VALUES (3, 3, 103, 'C');
INSERT INTO ENROLLMENT VALUES (4, 4, 104, 'A');
INSERT INTO ENROLLMENT VALUES (5, 5, 105, 'B');

COMMIT;
