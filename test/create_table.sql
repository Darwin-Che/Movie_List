CREATE TABLE Movies (
    titleid     VARCHAR(11)  NOT NULL PRIMARY KEY,
    title       VARCHAR(400) NOT NULL,
    releaseyear    SMALLINT UNSIGNED,
    runtimemin  MEDIUMINT UNSIGNED,
    summary     TEXT
);

CREATE TABLE Users (
    userid     VARCHAR(32)  NOT NULL PRIMARY KEY,
    username   VARCHAR(20)  NOT NULL UNIQUE,
    password   BINARY(64)   NOT NULL /* 32 bytes SHA256, 32 bytes salt*/
);

CREATE TABLE Casts (
    castid      VARCHAR(11)  NOT NULL PRIMARY KEY,
    castname    VARCHAR(200) NOT NULL
);

CREATE TABLE Cast_Movie (
    castid      VARCHAR(11)  NOT NULL,
    titleid     VARCHAR(11)  NOT NULL,
    role        VARCHAR(20)  NOT NULL,
    PRIMARY KEY (castid, titleid, role),
    FOREIGN KEY (castid) REFERENCES Casts(castid) ON DELETE CASCADE,
    FOREIGN KEY (titleid) REFERENCES Movies(titleid) ON DELETE CASCADE
);

CREATE TABLE Lists (
    listid      VARCHAR(32) NOT NULL PRIMARY KEY,
    userid      VARCHAR(32) NOT NULL,
    listname    VARCHAR(20) NOT NULL,
    FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE,
    UNIQUE (userid, listname)
);

CREATE TABLE Comments (
    commentid   VARCHAR(32) NOT NULL PRIMARY KEY,
    titleid     VARCHAR(11) NOT NULL,
    userid      VARCHAR(32) NOT NULL,
    comment     LONGTEXT    NOT NULL,
    publishtime DATETIME    NOT NULL,
    FOREIGN KEY (userid) REFERENCES Users(userid) ON DELETE CASCADE,
    FOREIGN KEY (titleid) REFERENCES Movies(titleid) ON DELETE CASCADE
);

CREATE TABLE List_Movie (
    listid      VARCHAR(32) NOT NULL,
    titleid     VARCHAR(11) NOT NULL,
    PRIMARY KEY (listid, titleid),
    FOREIGN KEY (titleid) REFERENCES Movies(titleid) ON DELETE CASCADE,
    FOREIGN KEY (listid) REFERENCES Lists(listid) ON DELETE CASCADE
);

CREATE TABLE Genre_Movie (
    titleid      VARCHAR(11) NOT NULL,
    genre        VARCHAR(20) NOT NULL,
    PRIMARY KEY (titleid, genre),
    FOREIGN KEY (titleid) REFERENCES Movies(titleid) ON DELETE CASCADE
);

CREATE TABLE Subscription (
    subscriber  VARCHAR(32) NOT NULL, -- this is userid
    subscribeto VARCHAR(32) NOT NULL, -- this is listid
    PRIMARY KEY (subscriber, subscribeto),
    FOREIGN KEY (subscriber) REFERENCES Users(userid) ON DELETE CASCADE,
    FOREIGN KEY (subscribeto) REFERENCES Lists(listid) ON DELETE CASCADE
);


