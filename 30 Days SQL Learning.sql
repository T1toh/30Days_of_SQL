use exercise;
create table exercise_logs(id integer primary key auto_increment, type text,
	minute integer, calories integer, heart_rate integer);
insert into exercise_logs( type, minute, calories, heart_rate)
values
("biking", 30, 100, 110),
("biking", 10, 30, 105),
("dancing", 15, 200, 120),
("tree climbing", 30, 70, 90),
("rowing", 30, 70, 90),
("hiking", 60, 80, 85);

select * from exercise_logs 
where type = "biking" or type = "hiking" or type = "tree climbing" or type = "rowing";

/*IN*/
select * from exercise_logs
where type in ("biking", "hiking", "tree climbing", "rowing");

select * from exercise_logs
where type not in ("biking", "hiking", "tree climbing", "rowing");

drop table drs_favorites;
create table drs_favorites( id integer primary key auto_increment, type text, reason text);
insert into drs_favorites( type, reason)
values
("biking", "improves endurance and flexibility"),
("hiking", "increases cardiovascular health");
select type from drs_favorites;
select * from exercise_logs
where type in ("biking", "hiking");

select * from exercise_logs
where type in (
select type from drs_favorites);

select * from exercise_logs
where type in (
select type from drs_favorites
where reason = "increases cardiovascular health");

/*LIKE*/
select * from exercise_logs
where type in (
select type from drs_favorites
where reason like "%increases cardiovascular health");

create table artists ( id integer primary key auto_increment, 
	name text, country text, genre text);
insert into artists ( name, country, genre)
values
("Taylor Swift", "US", "Pop"),
("Led Zeppelin", "US", "Hard rock"),
("Abba", "Sweden", "Disco"),
("Queen", "UK", "Rock"),
("Celine Dion", "Canada", "Pop"),
("Meatloaf", "US", "Hard rock"),
("Garth Brooks", "US", "Country"),
("Shania Twain", "Canada", "Country"),
("Rihanna", "US", "Pop"),
("Guns N' Roses", "US", "Hard rock"),
("Gloria Estefan", " US", "Pop"),
("Bob Marley", "Jamaica", "Reggea");

create table songs (id integer primary key auto_increment, 
	artists text,
    title text);
insert into songs (artists, title)
values
("Taylor Swift", "Shake it off"),
("Rihanna", "Stay"),
("Celin Dion", "My heart will go on"),
("Celin Dion", "A new day has come"),
("Shania Twain", "Party for two"),
("Gloria Estefan", "Conga"),
("Led Zeppelin", "Stairway to heaven"),
("Abba", "Mamma mia"),
("Queen", "Bicycle Race"),
("Queen", "Bohemian Rhapsody"),
("Guns N' Roses", "Don't cry");

Select * from artists
where name in 
(select artists from songs
where title like "%Shake it off");

/*Restricted Grouoed Results with Having - applying  condition togrouped values*/
select* from exercise_logs;
select type, 
	sum(calories) as total_calories
from exercise_logs
where calories > 150
group by type;

select type, 
	sum(calories) as total_calories
from exercise_logs
group by type
having total_calories > 150;

select type, 
	avg(calories) as avg_calories
from exercise_logs
group by type
having avg_calories > 70;

select type
from exercise_logs 
group by type
having count(*) >= 2;

/*Who issues SQL queries?
1. Software Engineers
2. Data scientits
3. Product management*/

/*Calculating results with CASE*/
select * from exercise_logs;

select count(*) from exercise_logs
where heart_rate > 220 - 30;

/*50-90% of max*/
select count(*) from exercise_logs 
where heart_rate > round(0.50*(220-30))
and heart_rate <= round(0.90 * (220-30));

/*CASE */
select type,
	heart_rate,
	case 
		when heart_rate > 220 - 30 then "above max"
        when heart_rate > round(0.90 *(220-30)) then "above target"
        when heart_rate > round(0.50*(220-30)) then "within target"
        else "below target"
        end as "hr_zone"
from exercise_logs;

select count(*),
	case 
		when heart_rate > 220 - 30 then "above max"
        when heart_rate > round(0.90 *(220-30)) then "above target"
        when heart_rate > round(0.50*(220-30)) then "within target"
        else "below target"
        end as "hr_zone"
from exercise_logs
group by hr_zone;

use exercise;
create table exercise_logs( id integer primary key auto_increment,
type text, minutes integer, calories integer, heart_rate integer);

insert into exercise_logs( type, minutes, calories, heart_rate) 
values
	("Biking", 30, 100, 110),
    ("Biking", 10, 30, 105),
    ("Dancing", 15, 200, 120);
    
select * from exercise_logs
where calories > 50 
order by calories;

/* AND*/
Select * from exercise_logs
where calories > 50 and minutes < 30;

Select * from exercise_logs
where calories > 50 or  heart_rate > 100;

/*Joining related Tables*/
create database school;
use school;
drop table students;
create table students (id integer primary key auto_increment,
	first_name text,
    last_name text,
    email text,
    phone text,
    birthdate text);
insert into students (first_name, last_name, email, phone, birthdate)
	values
    ("Peter", "Rabbit", "peter@rabbit.com", "555-6666", "2002-06-24"),
    ("Alice", "Wonderland", "alicewonderland.com", "555-4444", "2002-07-04");
    
create table student_grade ( id integer primary key auto_increment,
	student_id integer,
    test text,
    grade integer);
insert into student_grade (student_id, test, grade)
values
(1, "Nutrition", 95),
(2, "Nutrition", 92),
(1, "Chemistry", 85),
(2, "Chemistry", 95);
select * from student_grade;

/*cross join */
select * from student_grade, students;

/*implicit inner join*/
select * from student_grade, students
	where student_grade.student_id = students.id;

/*explicit inner join - join*/
select * from students
	join student_grade
    on students.id = student_grade.student_id;

select first_name, last_name, email, test, grade from students
	join student_grade
    on students.id = student_grade.student_id;
    
select first_name, last_name, email, test, grade from students
	join student_grade
    on students.id = student_grade.student_id
where grade > 90;

select students.first_name, students.last_name, students.email, student_grade.test, student_grade.grade from students
	join student_grade
    on students.id = student_grade.student_id
where grade > 90;

use school;
/*Joining relted tables with left outer joins*/
create table student_projects (id integer primary key auto_increment, student_id integer, title text);
insert into	student_projects (student_id, title)
values 
(1, "Carrotapault");

select students.first_name, students.last_name, student_projects.title
from students
join student_projects
on students.id = student_projects.student_id;
/* outer join */
select students.first_name, students.last_name, student_projects.title
from students
left outer join student_projects
on students.id = student_projects.student_id;

/*Joining tables to themselves with self-joins*/
use school;
select * from students;
insert into students ( first_name, last_name, email, phone, birthdate)
values
	("Aladdin", "Lampland", "aladdin@lampland.com", "555-3333", "2001-05-10"),
    ("Simba", "Kingston", "simba@kingston.com", "555-1111", "2001-12-24");
    
alter table students
add column buddy_id integer;
update students
set buddy_id = case
	when first_name = 'Peter' and last_name = 'Rabbit' then 2
    when first_name = 'Alice' and last_name = 'Wonderland' then 1
    when first_name = 'Aladdin' and last_name = 'Lampland' then 4
    when first_name = 'Simba' and last_name = 'Kingston' then 3
    else buddy_id
end;
select id,
	first_name,
    last_name,
    buddy_id
from students;

select students.first_name,
	students.last_name,
    buddies.email as buddy_email
from students
join students buddies
on students.buddy_id = buddies.id; /*This is called a self join*/

/*Challenge: Sequels in SQL*/
create table movies ( id integer primary key auto_increment,
	title text,
    released integer,
    sequel_id integer);

insert into movies ( title, released, sequel_id)
values 
	("Harry Potter and the Philosopher's Stone", 2001, 2),
    ("Harry Potter and the Chamber of Secrets", 2002,3 ),
    ("Harry Potter and the Prisoner of Azkaban", 2004, 4),
    ("Harry Potter and the Goblet of Fire", 2005, 5),
    ("Harry Potter and the Order of the Phoenix", 2007, 6),
    ("Harry Potter and the Half-Blood Prince", 2009, 7),
    ("Harry Potter and the Deathly Hallows - Part 1", 2010, 8),
    ("Harry Potter and the Deathly Hallows - Part 2", 2011, null);
    
select * from movies;
select id,
	title,
    sequel_id
from movies;

/* Issue a SELECT that will show the title of each movie next to its sequel's title (or NULL if it doesn't have a sequel*/
select hp1.title as movie_title,
	hp2.title as sequel_title
from school.movies hp1
left outer join
	school.movies hp2
    on hp1.sequel_id = hp2.id;
show tables;

/*Combining Multiple Joins- joins and multiple joins - pairing students to review each others projects*/
create table project_pairs (id integer primary key auto_increment,
	project1_id integer,
    project2_id integer);
insert into project_pairs (project1_id, project2_id)
values	
(1, 2),
(3, 4);
select a.title,
b.title
from project_pairs
join student_projects a
on project_pairs.project1_id = a.id
join student_projects b 
on project_pairs.project2_id = b.id;
/*More joins means slower querries*/

/*Challenge: FriendBook. We have created a database for a friend networking site, with a table storing
data on each person, a table on each person's hobbies, and a table of friend connections between the people. 
In this first step, use a JOIN to display a table showing people's names with their hobbies*/
use school;
create table persons (id integer primary key auto_increment,
	fullname text,
    age integer);

insert into persons (fullname, age)
values
("Bobby McBobbyFace", "12"),
("Lucy Bobucie", "25"),
("Banana Fofanna", "14"),
("Shish Kabob", "20"),
("Fluffy Sparkles", "8");

Create table hobbies (id integer primary key auto_increment,
	person_id integer,
    name text);
insert into hobbies (person_id,name)
values
(1, "drawing"),
(1, "coding"),
(2, "dancing"),
(2, "coding"),
(3, "skating"),
(3, "rowing"),
(4, "coding"),
(4, "dilly-dallying"),
(4,  "meowing");

create table friends (id integer primary key auto_increment,
	person1_id integer,
    person2_id integer);
insert into friends (person1_id,person2_id)
values 
	(1, 4),
    (2, 3);
/*Project:Famous People. 
In this project, you're going to make your own table with some small set of "famous people", the make
more table about the things they do and join those to create nice human readable lists.*/
create database Famous_People_DB;
use Famous_People_DB;
create table movie_stars (star_id integer primary key auto_increment,
	name varchar(100) not null,
    birthdate date,
    birthplace varchar(100),
    spouse_id int null,
    foreign key (spouse_id) references movie_stars(star_id) on delete set null
);
create table movies ( movie_id int primary key auto_increment,
	title varchar(100) not null,
    release_year int, 
    genre varchar(50)
);
 create table movie_star_movies (star_id integer primary key auto_increment,
	movie_id integer
);

 insert into movie_stars (name, birthdate, birthplace)
 values
	("Brad Pitt", "1963-12-18", "Shawnee, Oklahoma"),
    ("Angelina Jolie", "1975-06-04", "Los Angeles, California"),
    ("Leonardo DiCaprio", "1974-11-11", "Los Angeles, California"),
    ("Scarlett Johansson", "1984-11-22", "New York City, New York"),
    ("Tom Hanks", "1956-07-09", "Concord, California"),
    ("Meryl Streep", "1949-06-22", "Summit, New Jersy"),
    ("Johnny Depp", "1963-06-09", "Owensboro, Kentucky"),
    ("Natalie Portman", "1981-06-09", "Jerusalem, Israel"),
    ("Robert Downey Jr.", "1965-04-04", "New York City, New York");

insert into movies(title, release_year, genre)
values
	("Fight Club", 1999, "Drama"),
    ("Mr. & Mrs. Smith", 2005, "Action"),
    ("Inception", 2010, "Sci-Fi"),
    ("The Avengers", 2012, "Action"),
    ("Forrest Gump", 1994, "Drama"),
    ("The Iron Lady", 2011, "Biography"),
    ("Pirates of the Carribean: The Curse of the Black Pearl", 2003, "Adventure"),
    ("Black Swan", 2010, "Thriller"),
    ("Iron Man", 2008, "Action");

Insert into movie_star_movies ( movie_id)
values
	(1),
    (2),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (9);
select movie_stars.name as Movie_star,
	movies.title as Movie_Title,
    movies.release_year
from movie_stars 
join movie_star_movies 
on movie_stars.star_id = movie_star_movies.star_id
join movies 
on movies.movie_id = movie_star_movies.movie_id;

/*More efficient SQL with query planning and optimization 
The life cycle of a query is: Parse - Optimize - Execute
1. The query parser ensures that the query is  syntactically correct( e.g. commas out of place and semantically correct (i.e. the tables
exist, and returns errors if not. If it's correct, then it turns into an algebraic expression and passes it to the next step
2. The query planner and optimizer does the hard thinking work. It first performs straightforward optimizations (improvements that always result in better
performance, like simplifying 5*10 into 50). It then considers different "query plans" which may have different optiomizations,estimates the cost (CPU and time)
of each query plan based on the number of rows in the relevant tables, then it picks the optimal plan and passes it on to the net step
3. The query executor take the plan and turns it into operations for the database, returning the results back to us if there are any
Creating Indees in SQL can often make repeated queries more efficient. More details on query optimization can be accessed through the provided links.alter
e.g. SQL Query Optimizer, Oracle SQL Tuning, MSSQL Eecution Plan Basics, Query planner overview, SQLite query planning,Explain query plan, 
Explain query plan reference, how do I get an execution plan in*/

/* Using SQL to update a database:
An example of a "read-only operation" is a data analysis on a data dump from some app or research study. 
For example, if I was a data scientist working for a daily diary, I might query what percentage of users
eat ice cream on the same day that they run, to understand if exercise makes people want to reward themselves:

SELECT * FROM diary_logs WHERE
       food LIKE "%ice cream%" AND activity LIKE "%running%";
       
If I'm doing a data analysis like that, then pretty much everything I'm doing is a 
SELECT - it's all read only. We're not creating any new data, we are just querying existing data.
 We need to get very good at SELECT queries, but we don't need to know how to create tables, update rows, and all of that.
An example of "read/write operations" is a software engineer creating the backend for a webapp. 
For example, if I was the software engineer working on the health tracker, I might write code that knows
how to insert a new daily log in the database every time a user submits a form:
INSERT INTO diary_logs (id, food, activity)
            VALUES (123, "ice cream", "running");
I would probably be issuing that SQL command from inside a server-side language, likely using a library to 
make it easier to construct the commands. This is what that insertion would look like 
if I was using Python with the SQLAlchemy library:*/

use school;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT);

drop table diary_logs;    
CREATE TABLE diary_logs (
    id INTEGER PRIMARY KEY auto_increment,
    user_id INTEGER,
    date TEXT,
    content TEXT
    );
    
/* After user submitted their new diary log */
INSERT INTO diary_logs (user_id, date, content) 
VALUES (1, "2015-04-01",
    "I had a horrible fight with OhNoesGuy and I buried my woes in 3 pounds of dark chocolate."),
    (1, "2015-04-02",
    "We made up and now we're best friends forever and we celebrated with a tub of ice cream.");

SELECT * FROM diary_logs;
UPDATE diary_logs 
SET content = "I had a horrible fight with OhNoesGuy" 
WHERE user_id=1 AND date = "2015-04-01";

SELECT * FROM diary_logs;

DELETE FROM diary_logs WHERE id = 1;

SELECT * FROM diary_logs;

/* Challenge: Dynamic Documents
Step 1
We've created a database for a documents app, with rows for each document with it's title, content, and author. 
In this first step, use UPDATE to change the author to 'Jackie Draper' for all rows where it's currently 'Jackie Paper'. 
Then re-select all the rows to make sure the table changed like you expected.
Hint
UPDATE …;
SELECT …;*/

CREATE table documents (
    id INTEGER PRIMARY KEY auto_increment,
    title TEXT,
    content TEXT,
    author TEXT);
    
INSERT INTO documents (author, title, content)
    VALUES ("Puff T.M. Dragon", "Fancy Stuff", "Ceiling wax, dragon wings, etc.");
INSERT INTO documents (author, title, content)
    VALUES ("Puff T.M. Dragon", "Living Things", "They're located in the left ear, you know.");
INSERT INTO documents (author, title, content)
    VALUES ("Jackie Paper", "Pirate Recipes", "Cherry pie, apple pie, blueberry pie.");
INSERT INTO documents (author, title, content)
    VALUES ("Jackie Paper", "Boat Supplies", "Rudder - guitar. Main mast - bed post.");
INSERT INTO documents (author, title, content)
    VALUES ("Jackie Paper", "Things I'm Afraid Of", "Talking to my parents, the sea, giant pirates, heights.");

SELECT * FROM documents;
delete from documents
where id = 5;

/*Altering tables after creation*/
ALTER TABLE diary_logs ADD emotion TEXT;

INSERT INTO diary_logs (user_id, date, content, emotion) 
VALUES (1, "2015-04-03",
    "We went to Disneyland!", "happy");
    
SELECT * FROM diary_logs;

/*Drop tables*/

/*Challenge: Clothing alterations:
Step 1
We've created a database of clothes, and decided we need a price column. Use ALTER to add a 'price' column to the table. 
Then select all the columns in each row to see what your table looks like now.*/
CREATE TABLE clothes (
    id INTEGER PRIMARY KEY auto_increment,
    type TEXT,
    design TEXT);
    
INSERT INTO clothes (type, design)
    VALUES
		("dress", "pink polka dots"),
		("pants", "rainbow tie-dye"),
		("blazer", "black sequin");
        
alter table clothes
add column price integer;
select * from clothes;
update clothes
set price = case
	when type = 'dress' and design = 'pink polka dots' then price = 250
    when type = 'pants' and design = 'rainbow tie-dye' then price = 450
    when type = 'blazer' and design = 'black sequin' then price = 1000
    else null
end;

/*Project: App impersonator:
Think about your favorite apps, and pick one that stores your data- like a game that stores scores, an app that lets you post updates, etc.
 Now in this project, you're going to imagine that the app stores your data in a SQL database (which is pretty likely!), 
 and write SQL statements that might look like their own SQL.

CREATE a table to store the data.
INSERT a few example rows in the table.
Use an UPDATE to emulate what happens when you edit data in the app.
Use a DELETE to emulate what happens when you delete data in the app.*/
/*Here we re-imagine the SnapBook app*/
create table posts ( post_id integer primary key auto_increment,
	user_id integer,
    content text,
    timestamp datetime default current_timestamp,
    likes integer default 0);

INSERT INTO posts (user_id, content, likes) 
VALUES
(1, 'Just had an amazing lunch!', 10),
(2, 'Loving the new SnapBook features!', 25),
(3, 'Excited for the weekend!', 5);

select * from posts;
UPDATE posts
SET content = 'Just had an amazing lunch! Feeling great!'
WHERE post_id = 1;

DELETE FROM posts
WHERE post_id = 3;

CREATE TABLE user_scores (
    score_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    username VARCHAR(50),
    score INT,
    achieved_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Assuming you have a method to generate random data
INSERT INTO user_scores (user_id, username, score) 
SELECT 
    FLOOR(1 + (RAND() * 1000)),  -- Random user_id between 1 and 1000
    CONCAT('User', FLOOR(1 + (RAND() * 1000))),  -- Random username like 'User123'
    FLOOR(50 + (RAND() * 950))  -- Random score between 50 and 1000
FROM 
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) a,
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) b,
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) c,
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) d;
	
drop table posts;
CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    username VARCHAR(50),
    content TEXT,
    post_type VARCHAR(20),  -- Example: 'photo', 'text', 'status'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert 100,000 rows of random data
INSERT INTO posts (user_id, username, content, post_type)
SELECT 
    FLOOR(1 + (RAND() * 1000)),  -- Random user_id between 1 and 1000
    CONCAT('User', FLOOR(1 + (RAND() * 1000))),  -- Random username like 'User123'
    CONCAT('This is post number ', FLOOR(1 + (RAND() * 100000))),  -- Random content
    CASE 
        WHEN RAND() < 0.33 THEN 'photo'
        WHEN RAND() < 0.66 THEN 'text'
        ELSE 'status'
    END  -- Random post_type: 'photo', 'text', or 'status'
FROM 
    (SELECT 1 FROM dual UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) a,
    (SELECT 1 FROM dual UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) b,
    (SELECT 1 FROM dual UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) c,
    (SELECT 1 FROM dual UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) d;
