CREATE TABLE Person
(
	person_id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);
INSERT INTO person VALUES(1, 'Фрэнк Дарабонт');
INSERT INTO person VALUES(2, 'Дэвид Тэттерсолл');
INSERT INTO person VALUES(3, 'Томас Ньюман');
INSERT INTO person VALUES(4, 'Теренс Марш');
INSERT INTO person VALUES(5, 'Ричард Фрэнсис-Брюс');
INSERT INTO person VALUES(6, 'Стивен Кинг');
-------------------------------------------------------------------------
CREATE TABLE Genre
(
	genre_id INT PRIMARY KEY,
	genre_name VARCHAR(32) NOT NULL UNIQUE
);

INSERT INTO Genre VALUES
(1, 'Комедия'),
(2, 'Мультфильм'),
(3, 'Ужасы'),
(4, 'Фантастика'),
(5, 'Триллер'),
(6, 'Боевик'),
(7, 'Мелодрама'),
(8, 'Детектив'),
(9, 'Приключения'),
(10, 'Фэнтези'),
(11, 'Военный'),
(12, 'Семейный'),
(13, 'Аниме'),
(14, 'Исторический'),
(15, 'Драма'),
(16, 'Документальный'),
(17, 'Детский'),
(18, 'Криминал'),
(19, 'Биография'),
(21, 'Вестерн'),
(22, 'Нуар'),
(23, 'Спортивный'),
(24, 'Реальное ТВ'),
(25, 'Короткометражка'),
(26, 'Музыкальный'),
(27, 'Мюзикл'),
(28, 'Ток-шоу'),
(29, 'Игры');
-------------------------------------------------------------------------
CREATE TABLE character (
	character_id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	role VARCHAR(32) NOT NULL
);
INSERT INTO character VALUES(1, 'Том Хэнкс', 'В главных ролях');
INSERT INTO character VALUES(2, 'Дэвид Морс', 'В главных ролях');
INSERT INTO character VALUES(3, 'Бонни Хант', 'В главных ролях');
INSERT INTO character VALUES(4, 'Майкл Кларк Дункан', 'В главных ролях');
INSERT INTO character VALUES(5, 'Джеймс Кромуэлл', 'В главных ролях');
INSERT INTO character VALUES(6, 'Всеволод Кузнецов', 'Роли дублировали');
INSERT INTO character VALUES(7, 'Владимир Антоник', 'Роли дублировали');
INSERT INTO character VALUES(8, 'Любовь Германова', 'Роли дублировали');
INSERT INTO character VALUES(9, 'Валентин Голубенко', 'Роли дублировали');
INSERT INTO character VALUES(10, 'Александр Белявский', 'Роли дублировали');
-------------------------------------------------------------------------
CREATE TABLE Film
(
	film_id INT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	director INT NOT NULL, FOREIGN KEY (director) REFERENCES person(person_id),
	producer INT NOT NULL, FOREIGN KEY (producer) REFERENCES person(person_id),
	operator INT NOT NULL, FOREIGN KEY (operator) REFERENCES person(person_id),
	composer INT NOT NULL, FOREIGN KEY (composer) REFERENCES person(person_id),
	artist INT NOT NULL, FOREIGN KEY (artist) REFERENCES person(person_id),
	editing INT NOT NULL, FOREIGN KEY (editing) REFERENCES person(person_id),
	story INT NOT NULL, FOREIGN KEY (story) REFERENCES person(person_id)
);

INSERT INTO Film VALUES (1, 'Зеленая миля', 1, 1, 2, 3, 4, 5, 6);
-------------------------------------------------------------------------
CREATE TABLE character_film
(
	film_id INT NOT NULL, FOREIGN KEY (film_id) REFERENCES film(film_id),
	character_id INT NOT NULL, FOREIGN KEY (character_id) REFERENCES character(character_id),
	
	CONSTRAINT character_film_pkey PRIMARY KEY(film_id, character_id)
);

INSERT INTO character_film VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10);
-------------------------------------------------------------------------
CREATE TABLE genre_film
(
	film_id INT NOT NULL, FOREIGN KEY (film_id) REFERENCES film(film_id),
	genre_id INT NOT NULL, FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
	
	CONSTRAINT genre_film_pkey PRIMARY KEY(film_id, genre_id)
);

INSERT INTO genre_film VALUES
(1, 10),
(1, 15),
(1, 18);
-------------------------------------------------------------------------
CREATE TABLE Country
(
	country_id INT PRIMARY KEY,
	country VARCHAR(128) NOT NULL UNIQUE
);
INSERT INTO Country VALUES 
(1, 'Россия'),
(2, 'США'),
(3, 'Канада'),
(4, 'Мексика'),
(5, 'Австралия'),
(6, 'Германия'),
(7, 'Перу'),
(8, 'Греция'),
(9, 'Норвегия'),
(10, 'Финляндия'),
(11, 'Швеция'),
(12, 'Швейцария'),
(13, 'Израиль'),
(14, 'Испания'),
(15, 'Италия'),
(16, 'Португалия'),
(17, 'Хорватия'),
(18, 'Франция');
-------------------------------------------------------------------------
CREATE TABLE country_film
(
	film_id INT NOT NULL, FOREIGN KEY (film_id) REFERENCES film(film_id),
	country_id INT NOT NULL, FOREIGN KEY (country_id) REFERENCES country(country_id),
	count_viewers_mln NUMERIC(9,1) NOT NULL,
	
	CONSTRAINT country_film_pkey PRIMARY KEY(film_id, country_id, count_viewers_mln)
);

INSERT INTO country_film VALUES
(1, 2, 26),
(1, 6, 2.1),
(1, 15, 1.7);