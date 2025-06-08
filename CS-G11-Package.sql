-- Package Specification
 CREATE OR REPLACE PACKAGE student_pkg AS
       PROCEDURE enroll_student(p_student_id NUMBER, p_course_id NUMBER, p_grade VARCHAR2);
       FUNCTION calculate_gpa(p_student_id NUMBER) RETURN NUMBER;
  END student_pkg;
  /


-- Package Body
CREATE OR REPLACE PACKAGE BODY student_pkg AS

    -- Private procedure
    PROCEDURE validate_course(p_course_id NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM COURSE WHERE course_id = p_course_id;
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Invalid course ID.');
        END IF;
    END;

    -- Public procedure
    PROCEDURE enroll_student(p_student_id NUMBER, p_course_id NUMBER, p_grade VARCHAR2) IS
        v_new_id NUMBER;
    BEGIN
        validate_course(p_course_id);
        SELECT NVL(MAX(enroll_id), 0) + 1 INTO v_new_id FROM ENROLLMENT;
        INSERT INTO ENROLLMENT VALUES (v_new_id, p_student_id, p_course_id, p_grade);
        DBMS_OUTPUT.PUT_LINE('Enrollment successful.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;

    -- Public function
    FUNCTION calculate_gpa(p_student_id NUMBER) RETURN NUMBER IS
        v_total_weighted_score NUMBER := 0;
        v_total_credits NUMBER := 0;
        v_score NUMBER;
        v_credits NUMBER;
        CURSOR c IS
            SELECT e.grade, c.credits
            FROM ENROLLMENT e
            JOIN COURSE c ON e.course_id = c.course_id
            WHERE e.student_id = p_student_id;
    BEGIN
        FOR rec IN c LOOP
            -- Convert grade to score
            CASE rec.grade
                WHEN 'A' THEN v_score := 4;
                WHEN 'B' THEN v_score := 3;
                WHEN 'C' THEN v_score := 2;
                WHEN 'D' THEN v_score := 1;
                ELSE v_score := 0;
            END CASE;
            
            v_credits := rec.credits;

            -- Weighted total
            v_total_weighted_score := v_total_weighted_score + (v_score * v_credits);
            v_total_credits := v_total_credits + v_credits;
        END LOOP;

        IF v_total_credits = 0 THEN
            RETURN 0;
        ELSE
            RETURN ROUND(v_total_weighted_score / v_total_credits, 1);
        END IF;
    END;

END student_pkg;
/

