const Router = require('express');
const router = new Router();
const userController = require('../controller/user.controller')

router.post('/user', userController.createFilm)
router.get('/user/:id', userController.getFilm)
router.put('/user', userController.updateFilm)
router.delete('/user/:id', userController.deleteFilm)



module.exports = router;