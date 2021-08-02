const express = require("express");
const { readToken } = require("../config");
const router = express.Router();
const { transactionController } = require("../controller");

router.post("/shipping-cost", transactionController.shippingCost);
router.post("/checkout", readToken, transactionController.checkoutTransactions);
router.post(
  "/checkout-perscription",
  readToken,
  transactionController.perscriptionTransaction
);
router.delete("/delete", transactionController.deleteProductCart);
router.get("/bill", transactionController.getTransaction);
router.patch("/accept/:id", readToken,transactionController.acceptTransaction);
router.patch("/reject/:id", readToken,transactionController.rejectTransaction);

module.exports = router;
