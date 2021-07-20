const express = require('express')
const { readToken } = require('../config')
const router = express.Router()
const { userController } = require('../controller')

router.post('/reset-pass', readToken, userController.resetPassword)

module.exports = router