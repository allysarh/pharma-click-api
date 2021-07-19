const express = require('express')
const { readToken } = require('../config')
const { userController } = require('../controller')
const router = express.Router()

router.post('/register', userController.resgister)

module.exports = router