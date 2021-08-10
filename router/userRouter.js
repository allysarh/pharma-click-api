const express = require("express");
const { readToken } = require("../config");
const router = express.Router();
const { userController } = require("../controller");
const { authorization } = require('./auth')

router.post("/verif", readToken, userController.accVerif);
router.post("/re-verif", userController.reVerif);
router.post("/register", userController.register);
router.post("/login", userController.login);
router.get("/keep", readToken, userController.keepLogin);
router.get("/get", userController.getUser);
router.post("/forget-pass", userController.forgetPassword);
router.post("/reset-pass", readToken, userController.resetPassword);

router.get("/get-address", userController.getAddress);
router.post("/post-address", readToken,userController.postAddress);
router.delete("/delete-address", readToken,userController.deleteAddress);
router.patch("/patch-address", readToken,userController.patchAddress);
router.get("/sort-transactions", readToken, userController.getHistoryTransaction);
router.get(
  "/detail-transactions/:idtransaction",
  userController.getTransactionDetail
);
router.post("/upload-transaction", readToken, userController.uploadTransaction);
router.patch("/patch-user", readToken, userController.patchUser);
// router.get("/get-image-user", userController.getImageUser);
router.patch("/set-default", readToken,userController.setDefault);
router.get("/get-city", userController.getCity);
router.get("/confirmation-payment/:idtransaction",userController.confirmationPayment);
router.get('/transfer-proof/:idtransaction', authorization, userController.getTransactionProof)
module.exports = router;
