const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const authRouter = express.Router();

const signToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

const createSendToken = (user, statusCode, res) => {
  const token = signToken(user._id);
  res.status(statusCode).json({
    status: "success",
    token : token,
    ...user._doc,
  });
}

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
      error: error.message,
    });
  }
});

authRouter.route("/signin").post(async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: email }).select("+password");
    if (!user || !(await user.correctPassword(password, user.password))) {
      return res.status(400).json({
        message: "Invalid Email or Password.",
      });
    }
    createSendToken(user, 200, res);
  } catch (error) {
    res.status(400).json({
      status: "failed",
      error: error.message,
    });
  }
});

module.exports = authRouter;
