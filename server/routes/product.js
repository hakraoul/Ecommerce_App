const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/protected");
const Product = require("../models/product");

productRouter.route("/products").get(async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.route("/products/search/:name").get(async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.route("/rate-product").post(auth,async (req, res, next) => {
  try {
    const {id, rating} = req.body;
    let product = await Product.findById(id);

    for(i=0; i<product.ratings.length ; i++){
      if(product.ratings[i].userId == req.user){
        product.ratings.splice(i, 1); //this will remove old rating
        break;
      }
    }
    const ratingSchema = { 
      userId: req.user,
      rating,
    }
    //save new rating
    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({error: error.message})
  }
});

module.exports = productRouter;
