const express = require('express')
const { productController } = require('../controller')
const router = express.Router()

router.get('/get/:idtype', productController.getProduct)
router.post('/add', productController.addProduct)
router.delete('/delete/:idstock', productController.deleteProduct)
router.get("/get-products", productController.getProducts);
router.get("/get-city", productController.getCity);

module.exports = router
