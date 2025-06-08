-- Test enroll_student procedure
BEGIN
    student_pkg.enroll_student(1, 102, 'B');
END;
/

-- Test calculate_gpa function
DECLARE
    v_gpa NUMBER;
BEGIN
    v_gpa := student_pkg.calculate_gpa(1);
    DBMS_OUTPUT.PUT_LINE('GPA for Student 1: ' || v_gpa);
END;
/

