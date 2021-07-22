const express = require("express");
const { readToken } = require("../config");
const router = express.Router();
const { userController } = require("../controller");

router.post("/verif", readToken, userController.accVerif);
router.post("/re-verif", userController.reVerif);
router.post("/register", userController.resgister);
router.post("/login", userController.login);
router.get("/keep", readToken, userController.keepLogin);
router.get("/get", userController.getUser);
router.get("/get-address", userController.getAddress);
router.post("/forget-pass", userController.forgetPassword);
router.post("/post-address", userController.postAddress);
router.delete("/delete-address", userController.deleteAddress);
router.patch("/patch-address", userController.patchAddress);
router.patch("/patch-user", userController.patchUser);
router.get("/get-image-user", userController.getImageUser);
module.exports = router;
