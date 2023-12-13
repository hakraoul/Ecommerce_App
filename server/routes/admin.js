const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const Product = require("../models/product");

adminRouter.route("/add-product").post(admin, async (req, res, next) => {
  try {
    const { name, description, category, quantity, price, images } = req.body;
    let product = new Product({
      name,
      description,
      category,
      quantity,
      price,
      images,
    });
    product = await product.save();
    res.json(product);
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.route("/get-products").get(admin, async (req, res, next) => {
  try {
    const products = await Product.find({});
    res.json(products);
    next();
  } catch (error) {}
});

adminRouter.route("/delete-product").post(admin, async (req, res, next) => {
  try {
    const {id} = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = adminRouter;
