const mysql = require("mysql");
const util = require("util");

const db = mysql.createPool({
  connectionLimit: 1000,
  connectTimeout: 60 * 60 * 1000,
  acquireTimeout: 60 * 60 * 1000,
  timeout: 60 * 60 * 1000,
  host: process.env.HOSTNAME,
  user: process.env.USER,
  password: process.env.PASSSQL,
  database: process.env.DB,
  port: process.env.PORTSQL,
  multipleStatements: true,
});

const dbQuery = util.promisify(db.query).bind(db);
module.exports = { db, dbQuery };
