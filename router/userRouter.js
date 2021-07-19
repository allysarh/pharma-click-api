const express = require('express')
const { readToken } = require('../config')
const { userController } = require('../controller')
const router = express.Router()

router.post('/login', userController.login)
router.get('/keep', readToken, userController.keepLogin)
router.get('/get', userController.getUser
)
module.exports = router