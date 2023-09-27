const Server = require("./../model/serverModel");

exports.getInfo = async (req, res) => {
  try {
    const info = await Server.find();
    res.status(200).json({
      status: "success",
      length: info.length,
      data: {
        info,
      },
    });
  } catch (err) {
    res.status(404).json({
      status: "fail",
      message: err.message,
    });
  }
};

exports.createInfo = async (req, res) => {
  try {
    const info = await Server.create(req.body);
    res.status(200).json({
      status: "success",
      data: {
        info,
      },
    });
  } catch (err) {
    res.status(404).json({
      status: "fail",
      message: err.message,
    });
  }
};
