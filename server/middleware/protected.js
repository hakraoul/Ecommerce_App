const jwt = require("jsonwebtoken");

const protected = async (req, res, next) => {
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

module.exports = protected;
