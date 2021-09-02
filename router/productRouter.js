const express = require("express");
const router = express.Router();
const { readToken } = require("../config");
const { productController } = require("../controller");
const { authentication, authorization } = require("./auth");

router.get("/review", productController.getReviews);
router.get("/:idtype", productController.getProduct);
router.post("", authentication, authorization, productController.addProduct);
router.post("/custom", authentication, authorization, productController.addCustomProduct);
router.delete(
  "/:idstock",
  authentication,
  authorization,
  productController.deleteProduct
);
// router.get("/get-products", productController.getProducts);
router.get("/get-city", productController.getCity);
router.patch("", authentication, authorization, productController.editProduct);
router.patch("/custom", authentication, authorization, productController.editProductCustom);
router.patch("/increment", productController.incrementStock);
router.patch("/decrement", productController.decrementStock);
// router.post("/shipping-cost", productController.shippingCost);
router.post("/add-to-cart", productController.addToCart);

// router.post("/shipping-cost", productController.shippingCost);
router.delete("", productController.deleteProductCart);
router.post('/review', readToken, productController.addReviews)

module.exports = router;
