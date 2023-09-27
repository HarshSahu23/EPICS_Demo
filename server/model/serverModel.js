const mongoose = require("mongoose");

const serverSchema = new mongoose.Schema({
  name: {
    type: String,
    require: [true, "item must have a name"],
  },
});

const Server = mongoose.model("Server", serverSchema);

module.exports = Server;
