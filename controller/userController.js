const { dbQuery, db, transporter, createToken } = require('../config')
const Crypto = require('crypto')

module.exports = {
    login: async (req, res, next) => {
        try {
            let { email, password } = req.body
            let hashPassword = Crypto.createHmac("sha256", "PHR$$$").update(password).digest("hex")
            // email check
            let emailCheck = `SELECT * from user where email = ${db.escape(email)};`
            emailCheck = await dbQuery(emailCheck)

            if (emailCheck.length > 0) {

                let login = `SELECT iduser, fullname, gender, age, username, email, role, status, profile_image, otp 
                from user as u
                LEFT join role as r
                on r.idrole = u.idrole
                left join status as s
                on s.idstatus = u.idstatus
                where email = ${db.escape(email)} and password = ${db.escape(hashPassword)};`
                login = await dbQuery(login)

                if (login.length > 0) {
                    login[0].cart = []
                    login[0].address = []
                    let { iduser, fullname, gender, age, username, role, status, profile_image, cart, address, otp } = login[0]
                    if (status == "verified") {
                        let token = createToken({ iduser, fullname, gender, age, username, role, status, profile_image, otp })

                        let getCart = `SELECT * from cart where iduser = ${iduser};`
                        getCart = await dbQuery(getCart)

                        getCart.forEach((item, index) => {
                            cart.push(item)
                        })

                        let getAddress = `SELECT * from address where iduser = ${iduser};`
                        getAddress = await dbQuery(getAddress)

                        getAddress.forEach((val, i) => {
                            address.push(val)
                        })
                        res.status(200).send({ iduser, fullname, gender, age, username, role, status, profile_image, cart, address, token })
                    } else {
                        res.status(404).send({ status: 400, messages: "Account not verified! Please verify" })
                    }
                } else {
                    res.status(400).send({ status: 400, messages: "Wrong password!" })
                }
            } else {
                res.status(404).send({ status: 404, messages: "Account not found! Please register" })
            }
        } catch (error) {
            next(error)
        }
    }
}