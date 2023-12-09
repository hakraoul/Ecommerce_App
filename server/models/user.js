const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");

const userSchema = mongoose.Schema({
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const regex =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(regex);
      },
      message: "Please enter valid email or password.",
    },
  },
  name: {
    required: true,
    type: String,
    trim: true,
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length >6;
      },
      message: "Password must be 6 characters."
    },
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
});

//Middleware
//This will execute before the document is saved
userSchema.pre('save', async function (next) {
  //Only execute when the password field is modified.
  if (!this.isModified('password')) return next();

  //Hash the password with the cost of 12
  this.password = await bcrypt.hash(this.password, 12);

  //Delete the confirmPassword field as it is only for input validation
  // this.passwordConfirm = undefined;

  next();
});

const User = mongoose.model("User", userSchema);

module.exports = User;
