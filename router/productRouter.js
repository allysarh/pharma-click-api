const express = require('express')
const { productConctroller, productController } = require('../controller')
const router = express.Router()

router.get('/get/:idtype', productController.getProductPack)
router.post('/add', productController.addProduct)

module.exports = router