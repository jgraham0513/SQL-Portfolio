/*In this project, you’re going to make your own table with some small set of “famous people”, then make more tables about things they do and join those to create nice human readable lists.

For example, here are types of famous people and the questions your data could answer:

Movie stars: What movies are they in? Are they married to each other?
Singers: What songs did they write? Where are they from?
Authors: What books did they write?
Fictional characters: How are they related to other characters? What books do they show up in?*/

/* Create table about the people and what they do here */

CREATE TABLE famous_people (id INTEGER PRIMARY KEY,
    name TEXT,
    famous_for TEXT);

INSERT INTO famous_people (name, famous_for)
    VALUES("Jerry Seinfeld", "Seinfeld");
INSERT INTO famous_people (name, famous_for)
    VALUES("Derek Jeter", "baseball");
INSERT INTO famous_people (name, famous_for)
    VALUES("Drake", "rapping");
INSERT INTO famous_people (name, famous_for)
    VALUES("Bill Burr", "stand up");
INSERT INTO famous_people (name, famous_for)
    VALUES("Julia Louis Dreyfus", "Seinfeld");
INSERT INTO famous_people (name, famous_for)
    VALUES("F Scott Fitzgerald", "The Great Gatsby");
INSERT INTO famous_people (name, famous_for)
    VALUES("Matthew McConnaughey", "Interstellar");
INSERT INTO famous_people (name, famous_for)
    VALUES("Tony Soprano", "The Sopranos");
INSERT INTO famous_people (name, famous_for)
    VALUES("Tom Brady", "football");
INSERT INTO famous_people (name, famous_for)
    VALUES("Rocky Balboa", "boxing");
INSERT INTO famous_people (name, famous_for)
    VALUES("Alex Rodriguez", "baseball");
INSERT INTO famous_people (name, famous_for)
    VALUES("Jason Alexander", "Seinfeld");
INSERT INTO famous_people (name, famous_for)
    VALUES("Dave Chappelle", "stand up");
INSERT INTO famous_people (name, famous_for)
    VALUES("Mark Wahlberg", "Shooter");
INSERT INTO famous_people (name, famous_for)
    VALUES("Apollo Creed", "boxing");
    
    
CREATE TABLE information (id INTEGER PRIMARY KEY,
    activity TEXT,
    city TEXT,
    real TEXT);
    
INSERT INTO information (activity, city, real)
    VALUES("actor", "New York", "yes");
INSERT INTO information (activity, city, real)
    VALUES("athlete", "New York", "yes");
INSERT INTO information (activity, city, real)
    VALUES("rapper", "Toronto", "yes");
INSERT INTO information (activity, city, real)
    VALUES("comedian", "Boston", "yes");
INSERT INTO information (activity, city, real)
    VALUES("actress", "New York", "yes");
INSERT INTO information (activity, city, real)
    VALUES("author", "Los Angeles", "yes");
INSERT INTO information (activity, city, real)
    VALUES("actor", "Austin", "yes");
INSERT INTO information (activity, city, real)
    VALUES("mob boss", "Newark", "no");
INSERT INTO information (activity, city, real)
    VALUES("athlete", "Boston", "yes");
INSERT INTO information (activity, city, real)
    VALUES("athlete", "Philadelphia", "no");
INSERT INTO information (activity, city, real)
    VALUES("athlete", "New York", "yes");
INSERT INTO information (activity, city, real)
    VALUES("actor", "New York", "yes");
INSERT INTO information (activity, city, real)
    VALUES("comedian", "Los Angeles", "yes");
INSERT INTO information (activity, city, real)
    VALUES("actor", "Boston", "yes");
INSERT INTO information (activity, city, real)
    VALUES("athlete", "Philadelphia", "no");

/*Selected famous people, what they are famous for, and if they are real or just tv/movie characters*/

SELECT famous_people.name, famous_people.famous_for, information.activity, information.real
    FROM information
    JOIN famous_people
    ON information.id = famous_people.id;

/* Selected famous people that are both based in New York and famous for the show Seinfeld */

SELECT famous_people.name, famous_people.famous_for, information.city
    FROM information
    JOIN famous_people
    ON information.id = famous_people.id
    WHERE city = "New York" AND famous_for = "Seinfeld";
    
