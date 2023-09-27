const express = require("express");
const modelController = require("./../controller/modelController");

const router = express.Router();

router.route("/").get(modelController.getInfo).post(modelController.createInfo);

module.exports = router;
