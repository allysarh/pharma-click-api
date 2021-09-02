const database = require("./database");
const nodemailer = require("./nodemailer");
const uploader = require("./uploader");
uploaderProfile = require("./uploader");
const token = require("./token");

module.exports = {
  ...database,
  ...nodemailer,
  ...uploader,
  ...token,
  ...uploaderProfile,
};
