const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const authRouter = require("./routes/auth");

dotenv.config({ path: "./config.env" });

const DB = process.env.DATABASE.replace(
  "<PASSWORD>",
  process.env.DATABASE_PASSWORD
);

const app = express();

const PORT = process.env.PORT;

//Middleware
app.use(express.json()); //middleware that allow content of response to be process in the req
app.use("/api", authRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("Database connected successfully");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected to port: ${PORT}`);
});
