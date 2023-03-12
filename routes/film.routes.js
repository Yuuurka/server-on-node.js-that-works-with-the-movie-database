const Router = require('express');
const router = new Router();
const FilmController = require('../controller/film.controller')

router.post('/film', FilmController.createFilm)
router.get('/film/:id', FilmController.getFilm)
router.put('/film', FilmController.updateFilm)
router.delete('/film/:id', FilmController.deleteFilm)



module.exports = router;