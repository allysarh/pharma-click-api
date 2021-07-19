const mysql = require('mysql')
const util = require('util')

const db = mysql.createPool({
    host: process.env.HOSTNAME,
    user: process.env.USER,
    password: process.env.PASSSQL,
    database: process.env.DB,
    port: process.env.PORTSQL,
    multipleStatements: true
})

const dbQuery = util.promisify(db.query).bind(db)
module.exports = { db, dbQuery }