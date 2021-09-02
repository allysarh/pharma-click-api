const express = require("express");
const { readToken } = require("../config");
const router = express.Router();
const { transactionController } = require("../controller");
const { authorization, authentication } = require('./auth')

router.post("/shipping-cost", transactionController.shippingCost);
router.post("/checkout", readToken, transactionController.checkoutTransactions);
router.post("/perscription", readToken, transactionController.servePerscription);
router.post(
  "/checkout-perscription",
  readToken,
  transactionController.perscriptionTransaction
);
router.delete("/delete",transactionController.deleteProductCart);
router.get("/bill", transactionController.getTransaction);
router.patch("/accept/:id", readToken,transactionController.acceptTransaction);
router.patch("/reject/:id", readToken,transactionController.rejectTransaction);
router.get('/sales-report', authorization, transactionController.salesReport)
router.get('/revenue', authentication, authorization, transactionController.revenue)
router.get('/product-sales', authentication, authorization, transactionController.productSales)

module.exports = router;
