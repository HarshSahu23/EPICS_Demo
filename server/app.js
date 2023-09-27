const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const ModelRoute = require("./routes/model");

const app = express();

app.use(express.json());
app.use(morgan("dev"));
app.use(cors());

app.use("/api/model", ModelRoute);

module.exports = app;
