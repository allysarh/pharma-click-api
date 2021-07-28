const express = require('express')
const { readToken } = require('../config')
const { productController } = require('../controller')
const { authentication, authorization } = require('./auth')

const router = express.Router()

router.get('/:idtype', productController.getProduct)
router.post('', authentication, authorization, productController.addProduct)
router.delete('/:idstock', authentication, authorization, productController.deleteProduct)
router.get("/get-products", productController.getProducts);
router.get("/get-city", productController.getCity);
router.patch('', authentication, authorization, productController.editProduct)

module.exports = router
