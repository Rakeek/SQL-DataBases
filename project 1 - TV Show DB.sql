create database tvshow;
use tvshow;

CREATE TABLE tv_show (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    show_name VARCHAR(55) NOT NULL,
    genre VARCHAR(100),
    release_year YEAR,
    seasons INT
);

CREATE TABLE episode (
    episode_id INT AUTO_INCREMENT PRIMARY KEY,
    show_id INT,
    episode_name VARCHAR(255) NOT NULL,
    season INT NOT NULL,
    episode_number INT NOT NULL,
    air_date DATE,
    FOREIGN KEY (show_id) REFERENCES tv_show(show_id) ON DELETE CASCADE
);

CREATE TABLE actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    show_id INT,
    actor_name VARCHAR(255) NOT NULL,
    role_name VARCHAR(255),
    FOREIGN KEY (show_id) REFERENCES tv_show(show_id) ON DELETE CASCADE
);

INSERT INTO tv_show (show_name, genre, release_year, seasons)
VALUES
('Breaking Bad', 'Crime, Drama', 2008, 5),
('Friends', 'Comedy, Romance', 1994, 10),
('Game of Thrones', 'Fantasy, Drama', 2011, 8),
('Stranger Things', 'Sci-Fi, Horror', 2016, 4),
('The Office', 'Comedy', 2005, 9);

INSERT INTO episode (show_id, episode_name, season, episode_number, air_date)
VALUES
(1, 'Pilot', 1, 1, '2008-01-20'),
(1, 'Ozymandias', 5, 14, '2013-09-15'),
(2, 'The One Where Monica Gets a Roommate', 1, 1, '1994-09-22'),
(3, 'Winter Is Coming', 1, 1, '2011-04-17'),
(4, 'Chapter One: The Vanishing of Will Byers', 1, 1, '2016-07-15');

INSERT INTO actor (show_id, actor_name, role_name) 
VALUES 
(1, 'Bryan Cranston', 'Walter White'),
(1, 'Aaron Paul', 'Jesse Pinkman'),
(2, 'David Schwimmer', 'Ross Geller'),
(2, 'Jennifer Aniston', 'Rachel Green'),
(3, 'Kit Harington', 'Jon Snow');
SELECT * FROM tv_show;
SELECT show_name FROM tv_show;
# dsply the gnre where shw name is the office
SELECT genre FROM tv_show WHERE show_name = 'The Office';
# display the count of seasons in breakingbad
SELECT seasons FROM tv_show WHERE show_name = 'Breaking Bad';
SELECT episode_name FROM episode WHERE show_id = (SELECT show_id FROM tv_show WHERE show_name = 'Friends') AND season = 1;
SELECT actor_name FROM actor WHERE show_id = (SELECT show_id FROM tv_show WHERE show_name = 'Game of Thrones');

DELETE FROM actor
WHERE actor_name = 'Bryan Cranston';

UPDATE actor SET role_name = 'Jesse Pinkman Jr.' WHERE actor_name = 'Aaron Paul';

SELECT * FROM tv_show WHERE show_name LIKE '%Game%';

SELECT air_date FROM episode
WHERE show_id = (SELECT show_id FROM tv_show WHERE show_name = 'Stranger Things')
AND season = 1 AND episode_number = 1;

SELECT genre, AVG(seasons) AS avg_seasons
FROM tv_show
GROUP BY genre;

SELECT episode.episode_name, tv_show.show_name
FROM episode
JOIN tv_show ON episode.show_id = tv_show.show_id;

SELECT episode.episode_name, episode.air_date
FROM episode
JOIN tv_show ON episode.show_id = tv_show.show_id
WHERE tv_show.show_name = 'Breaking Bad';

SELECT e.episode_name, e.season, e.episode_number, e.air_date
FROM episode e
JOIN tv_show s ON e.show_id = s.show_id
WHERE s.show_name = 'Friends';
