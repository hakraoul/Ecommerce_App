const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({
        message: "No authentication token, access Denied.",
      });

    const verified = jwt.verify(token, process.env.JWT_SECRET);
    if (!verified)
      return res.status(401).json({
        message: "Token authorization failed. Authorization denited.",
      });
    const user = User.findById(verified.id);
    if (user.type == "user" || user.type == "seller") {
      return res.status(401).json({ message: "Unauthorize Access" });
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({
      status: "failed",
      error: error.message,
    });
  }
};

module.exports = admin;
