const express = require('express')
const { productController } = require('../controller')
const authentication = require('./auth/authentication')
const authorization = require('./auth/authorization')
const router = express.Router()

router.get('/get/:idtype', productController.getProduct)
router.post('/add', productController.addProduct)
router.delete('/delete/:idstock', productController.deleteProduct)
router.get("/get-products", productController.getProducts);
router.get("/get-city", productController.getCity);
router.patch('/edit', productController.editProduct)

module.exports = router
