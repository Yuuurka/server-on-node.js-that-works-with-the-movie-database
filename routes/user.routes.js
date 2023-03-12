const Router = require('express');
const router = new Router();
const userController = require('../controller/user.controller')

router.post('/film', userController.createFilm)
router.get('/film/:id', userController.getFilm)
router.put('/film', userController.updateFilm)
router.delete('/film/:id', userController.deleteFilm)



module.exports = router;