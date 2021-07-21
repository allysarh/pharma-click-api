const express = require('express')
const { productConctroller, productController } = require('../controller')
const router = express.Router()

router.get('/get', productController.getProduct)
router.post('/add', productController.addProduct)

module.exports = router