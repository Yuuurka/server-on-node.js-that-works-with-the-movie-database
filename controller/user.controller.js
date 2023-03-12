const db = require('../db');


class UserController {
    async createFilm(req, res) {
        const {name, year, genres} = req.body;
        const newFilm = await db.query(`INSERT INTO Film (name, year) VALUES ($1, $2) RETURNING *`, [name, year]);

        for (let value of genres){
            const getGenre = await db.query(`SELECT genre_id FROM Genre WHERE genre_name = $1`, [value]);
            const genre_id = getGenre.rows[0].genre_id
            await db.query(`INSERT INTO genre_film (film_id, genre_id) VALUES ($1, $2) RETURNING *`, [newFilm.rows[0].film_id, genre_id]);
        }
        const response = await db.query(`SELECT Film.film_id, Film.name, Film.year, Genre.genre_name FROM Film
                                         LEFT JOIN genre_film ON Film.film_id = genre_film.film_id
                                         LEFT JOIN Genre ON genre_film.genre_id = Genre.genre_id 
                                         WHERE Film.film_id = $1`, [newFilm.rows[0].film_id]);
        res.json(response.rows);
    }

    async getFilm(req, res) {
        const film_id = req.params.id;

        const response = await db.query(`SELECT Film.film_id, Film.name, Film.year, Genre.genre_name FROM Film
                                         LEFT JOIN genre_film ON Film.film_id = genre_film.film_id
                                         LEFT JOIN Genre ON genre_film.genre_id = Genre.genre_id 
                                         WHERE Film.film_id = $1`, [film_id]);
        res.json(response.rows)
    }

    async updateFilm(req, res) {
        const {film_id, name, year, genres} = req.body;

        await db.query(`UPDATE Film SET name = $1, year = $2 WHERE film_id = $3 RETURNING *`, [name, year, film_id]);
        await db.query(`DELETE FROM genre_film WHERE film_id = $1`, [film_id]);

        for (let value of genres){
            const getGenre = await db.query(`SELECT genre_id FROM Genre WHERE genre_name = $1`, [value]);
            const genre_id = getGenre.rows[0].genre_id
            await db.query(`INSERT INTO genre_film (film_id, genre_id) VALUES ($1, $2) RETURNING *`, [film_id, genre_id]);
        }

        const response = await db.query(`SELECT Film.film_id, Film.name, Film.year, Genre.genre_name FROM Film
                                         LEFT JOIN genre_film ON Film.film_id = genre_film.film_id
                                         LEFT JOIN Genre ON genre_film.genre_id = Genre.genre_id 
                                         WHERE Film.film_id = $1`, [film_id])
        res.json(response.rows)
    }

    async deleteFilm(req, res) {
        const film_id = req.params.id;
        const film = await db.query(`DELETE FROM Film WHERE film_id = $1`, [film_id]);

        await db.query(`DELETE FROM genre_film WHERE film_id = $1`, [film_id]);

        res.json(film.rows[0])
    }
}

module.exports = new UserController();