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


CREATE TABLE Film
(
	film_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	year INT NOT NULL CHECK (year BETWEEN 1888 AND 9999)
);


CREATE TABLE genre_film
(
	film_id INT NOT NULL, FOREIGN KEY (film_id) REFERENCES film(film_id),
	genre_id INT NOT NULL, FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
	
	CONSTRAINT genre_film_pkey PRIMARY KEY(film_id, genre_id)
);