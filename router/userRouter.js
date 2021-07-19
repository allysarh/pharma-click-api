const express = require('express')
const userController = require('../controller/userController')
const router = express.Router()

router.post('/forget-pass', userController.forgetPassword)

module.exports = router