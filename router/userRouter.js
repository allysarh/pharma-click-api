const express = require('express')
const { readToken } = require('../config')
const router = express.Router()
const { userController } = require('../controller')

router.get('/verif', readToken, userController.accVerif)
router.post('/re-verif', userController.reVerif)
router.post('/register', userController.resgister)

module.exports = router