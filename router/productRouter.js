const express = require('express')
const { productConctroller, productController } = require('../controller')
const router = express.Router()

router.get('/get/:idtype', productController.getProduct)
router.post('/add', productController.addProduct)
router.delete('/delete/:idstock', productController.deleteProduct)
module.exports = router