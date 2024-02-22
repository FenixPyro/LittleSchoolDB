# Design Document

By Leonardo Carabajal

Video overview: https://youtu.be/Yv7lTnA-YzY

## Scope

This database includes information that a little school or school support center can take to facilitate the organization of the classes
and updates for new students.
The scope includes:
* Students information and tracking
* Teachers that takes part of the school
* The classes that are taught in the school, with it's subject, teacher and year
* All the subjects that the school has
* A register for all the enrollments per year, incluiding the students and the classes that they choose

Out of the scope:
* Some additional administrative aspects of a school like licenses or absences of students and teachers. On the other hand, some
micro management data of the classes like notes, exams or problems.

## Functional Requirements

With the database, the user can:
* Track the info of the teachers that take part of the school
* Add new students to see in which class they take part
* Manage the information of the classes and it's subjects

Beyond the scope, it doesn't support classes taught by more that one teacher or aspects like teacher's assistants.

## Representation
Entities are captured in SQLite tables with the following schema.

### Entities

This database includes:

Teachers table:
* "id" An integer that identifies the teacher with an unique number. It's the primary key of the table.
* "first_name" A text to register the first name of the teacher.
* "last_name" A text to register the last name of the teacher. It's separated to support teachers with the same names.
* "subject_id" An integer used to track the subject that the teacher works. It's a foreign key related to the "subjects" table.

Subjects table:
* "id" An integer that identifies the subject. It's the unique primary key of the table.
* "name" The name of the subject in text. It has the unique constraint.

Classes table:
* "id" An integer that identifies the class with an unique number, and it's the primary key.
* "teacher_id" A number to reference the teacher of a class. It's a foreign key of the "id" column in "teachers".
* "subject_id" It references the subject of a class. It's a foreign key of the "id" column in "subjects".
* "year" A number to register the year of the class.

Students table:
* "id" The primary key to identify the students with an integer.
* "first_name" The first name of the student, in text.
* "last_name" The last name of the student. Separated for students with the same name.

Enrollments table:
* "id" The primary key of the table to identify the enrollment.
* "student_id" An integer to identify the student that took the enrollment. It's a foreign key to the "students" table and the "id" column.
* "class_id" Same case with student_id, to identify which class or classes the student choose.
* "year" The year of the enrollment, with an integer.

All columns doesn't have NULL constraint for administrative issues, so that it can be updated later on if some name it's missing.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.
![ER Diagram](diagram.png)

Details:
* One class can be taught by one teacher, but a teacher can work on many classes.
* The classes can have only one subject and the school can have many classes of a same subject.
* A teacher only works on one subject and many teachers can work on the same subject.
* The enrollments can take many classes depending of the student's decision. Obviously, a class can have many enrollments
depending of it's students. Each enrollment it's registered for a specific case, and a student can choose many classes so
it can take part of one or many enrollments.


## Optimizations

The optimizations are made with indexes for the popular queries that the user could make. For that, the teacher's column for names are
indexed. Same case for the subject's name. In the enrollments, the index is made for the id's of the student and the class.

## Limitations

The database is limited for classes with only one teacher. It needs to be updated to take more teachers or to note assistants
that take part of the class.
