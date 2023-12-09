const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.route("/signup").post(async (req, res) => {
  try {
    const { email, name, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        status: "Failed",
        message: "User with the same email already exist.",
      });
    }
    let user = new User({
      email,
      name,
      password,
    });
    user = await user.save();
    res.status(200).json({
      status: "Success",
      user,
    });
  } catch (err) {
    res.status(400).json({
      status: "failed",
      err,
    });
  }
});

authRouter.route("/users").get(async (req, res) => {
  const users = await User.find();
  res.status(200).json({
    status: "success",
    users,
  });
});

module.exports = authRouter;
