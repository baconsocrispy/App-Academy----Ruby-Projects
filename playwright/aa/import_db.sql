-- DROP TABLE IF EXISTS question_likes;
-- DROP TABLE IF EXISTS question_follows;
-- DROP TABLE IF EXISTS replies;
-- DROP TABLE IF EXISTS questions;
-- DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(250) NOT NULL,
    lname VARCHAR(250) NOT NULL
);

INSERT INTO 
    users (fname, lname)
VALUES 
    ('Carter', 'Bacon');

INSERT INTO users (fname, lname)
VALUES ('Rebecca', 'Eddy');

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER,

    FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO questions (title, body, user_id)
VALUES ('Is it ok for boyfriends to call their girlfriend" "s friends?', 'Why is it ok for Chris to call me about Lauren?', 2);

INSERT INTO questions (title, body, user_id)
VALUES ('What time is it?', 'Why is it not the time I think it is?', 1);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (question_id) REFERENCES questions (id)
);

INSERT INTO question_follows (user_id, question_id)
VALUES (1, 1);

INSERT INTO question_follows (user_id, question_id)
VALUES (2, 2);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    parent_reply_id INTEGER,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    
    FOREIGN KEY (parent_reply_id) REFERENCES replies (id),
    FOREIGN KEY (question_id) REFERENCES questions (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO replies (question_id, user_id, body)
VALUES (1, 1, 'Damn straight!');

INSERT INTO replies (parent_reply_id, question_id, user_id, body)
VALUES (1, 1, 2, 'Thanks for your support!');

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (question_id) REFERENCES questions (id)
);

INSERT INTO question_likes (user_id, question_id)
VALUES (1, 1);

INSERT INTO question_likes (user_id, question_id)
VALUES (2, 2);