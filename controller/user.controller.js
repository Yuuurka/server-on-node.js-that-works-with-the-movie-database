const db = require('../db');

class UserController {
    async createFilm(req, res) {
        const {name, year, genres} = req.body;
        const newFilm = await db.query(`INSERT INTO Film (name, year) values ($1, $2) RETURNING *`, [name, year]);
        for (let value of genres){
            const getGenre = await db.query(`SELECT genre_id FROM Genre WHERE genre_name = $1`, [value]);
            const genre_id = getGenre.rows[0].genre_id
            await db.query(`INSERT INTO genre_film (film_id, genre_id) VALUES ($1, $2) RETURNING *`, [newFilm.rows[0].film_id, genre_id]);
        }
        res.json(newFilm);
    }

    async getFilm(req, res) {

    }

    async updateFilm(req, res) {

    }

    async deleteFilm(req, res) {

    }
}

module.exports = new UserController();