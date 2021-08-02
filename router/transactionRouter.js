const express = require("express");
const { readToken } = require("../config");
const router = express.Router();
const { transactionController } = require("../controller");
const { authorization, authentication } = require('./auth')

router.post("/shipping-cost", transactionController.shippingCost);
router.post("/checkout", readToken, transactionController.checkoutTransactions);
router.post(
  "/checkout-perscription",
  readToken,
  transactionController.perscriptionTransaction
);
router.delete("/delete", transactionController.deleteProductCart);
router.get('/sales-report', authentication, authorization, transactionController.salesReport)
router.get('/revenue', authentication, authorization, transactionController.revenue)

module.exports = router;
