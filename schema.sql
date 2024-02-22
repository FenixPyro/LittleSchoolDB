-- Represent subjects of the classes
CREATE TABLE "subjects" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    PRIMARY KEY ("id")
);

-- Represent the teachers in the school
CREATE TABLE "teachers" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "subject_id" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("subject_id") REFERENCES "subjects"("id")
);

-- Represent the students in the school
CREATE TABLE "students" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    PRIMARY KEY ("id")
);

-- Represent the classes and the year it started
CREATE TABLE "classes" (
    "id" INTEGER,
    "teacher_id" INTEGER,
    "subject_id" INTEGER,
    "year" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("teacher_id") REFERENCES "teachers"("id"),
    FOREIGN KEY ("subject_id") REFERENCES "subjects"("id")
);

-- Represent the enrollments and year
CREATE TABLE "enrollments" (
    "id" INTEGER,
    "student_id" INTEGER,
    "class_id" INTEGER,
    "year" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("student_id") REFERENCES "students"("id"),
    FOREIGN KEY ("class_id") REFERENCES "classes"("id")
);

-- View to see all the students enrolled in a specific year
CREATE VIEW "enrollment_per_year" AS
SELECT "year", "students"."first_name", "students"."last_name"
FROM "enrollments"
JOIN "students"
ON "enrollments"."student_id" = "students"."id";

CREATE VIEW "teachers_per_year" AS
SELECT "teachers"."first_name", "teachers"."last_name", "subjects"."name" as "subject", "classes"."year" as "year" FROM "teachers"
JOIN "classes"
ON "teachers"."id" = "classes"."teacher_id"
JOIN "subjects"
ON "teachers"."subject_id" = "subjects"."id";

CREATE INDEX "classes_data" ON "classes"("teacher_id","subject_id");
CREATE INDEX "enrollments_data" ON "enrollments"("student_id","class_id");
CREATE INDEX "teachers_name" ON "teachers"("first_name","last_name");
CREATE INDEX "subjects_name" ON "subjects"("name");
