-- Select the name of a teacher from a specific subject

SELECT "first_name", "last_name"
FROM "teachers"
WHERE "subject_id" = (
    SELECT "id"
    FROM "subjects"
    WHERE "name" = 'Calculus'
);

-- Select the names of the students enrolled in a specific class
SELECT "first_name", "last_name"
FROM "enrollments"
WHERE "class_id" = (
    SELECT "id"
    FROM "classes"
    WHERE "subject_id" = (
        SELECT "id"
        FROM "subjects"
        WHERE "name" = 'Computer Science'
    )
    AND YEAR = 2021
);

-- Select the classes of a specific teacher
SELECT "id"
FROM "classes"
WHERE "teacher_id" = (
    SELECT "id"
    FROM "teachers"
    WHERE "first_name" = 'Carl'
    AND "last_name" = 'Johnson'
);

-- Select how many enrollments were in a specific year
SELECT COUNT("id"), "class_id"
FROM "enrollments"
WHERE "year" = 2023;

-- Add a new teacher to the school
INSERT INTO "teachers" ("first_name","last_name","subject_id")
VALUES
('Mike','Tyson',"5");

-- Add new enrollments
INSERT INTO "enrollments"("student_id","class_id","year")
VALUES
('25','2','2022'),
('27','2','2022');

-- Update the teacher from a class
UPDATE "classes"
SET "teacher_id" = 7
WHERE "subject_id" = 5
AND "year" = 2022;

-- Delete some enrollments
DELETE FROM "enrollments"
WHERE "student_id" = 29
AND "class_id" = 5;

