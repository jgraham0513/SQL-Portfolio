/*Think about your favorite apps, and pick one that stores your data- like a game that stores scores, an app that lets you post updates, etc. Now in this project, you're going to imagine that the app stores your data in a SQL database (which is pretty likely!), and write SQL statements that might look like their own SQL.

CREATE a table to store the data.
INSERT a few example rows in the table.
Use an UPDATE to emulate what happens when you edit data in the app.
Use a DELETE to emulate what happens when you delete data in the app.*/

/* What does the app's SQL look like? */

CREATE TABLE Instagram
    (id INTEGER PRIMARY KEY,
    username TEXT,
    posts INTEGER,
    date TEXT,
    caption TEXT);
    
INSERT INTO Instagram (username, posts, date, caption)
    VALUES ("jgraham0513", 1, "6-1-2022", "Beaching");
INSERT INTO Instagram (username, posts, date, caption)
    VALUES ("rfryer34", 20, "9-30-2022", "Happy Birthday");
INSERT INTO Instagram (username, posts, date, caption)
    VALUES ("derekjeter", 15, "9-11-2022", "Never Forget");
INSERT INTO Instagram (username, posts, date, caption)
    VALUES ("bertkreischer", 50, "10-4-2022", "Sober October");
INSERT INTO Instagram (username, posts, date, caption)
    VALUES ("dwaynejohnson", 700, "10-15-2022", "Teremana");
    
SELECT * FROM Instagram;

/*Update username*/

UPDATE Instagram SET username = "THEonlyBERTkreischer" WHERE id=4;  

SELECT * FROM Instagram;

/*Delete user from Instagram*/

DELETE FROM Instagram WHERE id=2;

/*Update username, number of posts, and most recent date*/

UPDATE Instagram SET username = "The Rock",  posts = 701, date = "12-25-2022" WHERE id=5;

SELECT * FROM Instagram;
