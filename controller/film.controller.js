const db = require('../db');


class FilmController {
    async createFilm(req, res) {
        const {name, year, genres} = req.body;

        if (await checkValidate(genres, year)){
            const newFilm = await db.query(`INSERT INTO Film (name, year) VALUES ($1, $2) RETURNING *`, [name, year]);
            await insertGenres(genres, newFilm.rows[0].film_id);
            await getResponse(newFilm.rows[0].film_id, res);
        }else{
            res.json({"error": "Фильм не был создан, проверьте корректность введенных данных"})
        }
    }


    async getFilm(req, res) {
        const film_id = req.params.id;
        await getResponse(film_id, res)
    }


    async updateFilm(req, res) {
        const {film_id, name, year, genres} = req.body;

        if (await checkValidate(genres, year)){
            await db.query(`UPDATE Film SET name = $1, year = $2 WHERE film_id = $3 RETURNING *`, [name, year, film_id]);
            await db.query(`DELETE FROM genre_film WHERE film_id = $1`, [film_id]);

            await insertGenres(genres, film_id)
            await getResponse(film_id, res)
        }else{
            res.json({"error": "Фильм не был обновлен, проверьте корректность введенных данных"})
        }

    }


    async deleteFilm(req, res) {
        const film_id = req.params.id;

        await db.query(`DELETE FROM genre_film WHERE film_id = $1`, [film_id]);
        await db.query(`DELETE FROM Film WHERE film_id = $1`, [film_id]);

        res.json({"delete": true})
    }
}


async function getResponse(id, res){
    const response = await db.query(`SELECT Film.film_id, Film.name, Film.year, Genre.genre_name FROM Film
                                         LEFT JOIN genre_film ON Film.film_id = genre_film.film_id
                                         LEFT JOIN Genre ON genre_film.genre_id = Genre.genre_id 
                                         WHERE Film.film_id = $1`, [id]);

    res.json(response.rows)
}


async function insertGenres(arrayOfGenres, film_id){
    for (let value of arrayOfGenres){
        const getGenre = await db.query(`SELECT genre_id FROM Genre WHERE genre_name = $1`, [value]);
        const genre_ID = getGenre.rows[0].genre_id
        await db.query(`INSERT INTO genre_film (film_id, genre_id) VALUES ($1, $2) RETURNING *`, [film_id, genre_ID]);
    }
}

async function checkValidate(arrayOfGenres, year){
    if (1888 >= year || year > 9999){
        return false
    }
    for (let value of arrayOfGenres){
        const validate = await db.query(`SELECT 1 FROM Genre WHERE genre_name = $1 LIMIT 1`, [value]);
        if (validate.rowCount < 1){
            return false
        }
    }
    return true
}
module.exports = new FilmController();