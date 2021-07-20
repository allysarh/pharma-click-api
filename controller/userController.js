const { db, dbQuery, createToken } = require('../config')
const Crypto = require('crypto')

module.exports = {
    resetPassword: async (req, res, next) => {
        try {
            console.log(req.user)
            let { password } = req.body
            let { iduser } = req.user
            let hashPassword = Crypto.createHmac("sha256", "PHR$$$").update(password).digest("hex")

            let resetPass = `UPDATE user set password = ${db.escape(hashPassword)} WHERE iduser = ${db.escape(iduser)};`
            await dbQuery(resetPass)

            res.status(200).send({ status: 200, messages: "Reset password success" })
        } catch (error) {
            next(error)
        }
    }
}