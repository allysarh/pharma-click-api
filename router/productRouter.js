const express = require('express')
const { readToken } = require('../config')
const { productController } = require('../controller')
const { authentication, authorization } = require('./auth')

const router = express.Router()

router.get('/review', productController.getReviews)
router.get('/:idtype', productController.getProduct)
router.post('', authentication, authorization, productController.addProduct)
router.delete('/:idstock', authentication, authorization, productController.deleteProduct)
router.get("/get-products", productController.getProducts);
router.get("/get-city", productController.getCity);
router.patch('', authentication, authorization, productController.editProduct)
router.patch("/increment", productController.incrementStock);
router.patch("/decrement", productController.decrementStock);
// router.post("/shipping-cost", productController.shippingCost);
router.post("/add-to-cart", productController.addToCart);

// router.post("/shipping-cost", productController.shippingCost);
router.delete("", productController.deleteProductCart);

module.exports = router;
