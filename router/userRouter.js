const express = require('express')
const { readToken } = require('../config')
const router = express.Router()
const { userController } = require('../controller')

router.post('/verif', readToken, userController.accVerif)
router.post('/re-verif', userController.reVerif)

module.exports = router