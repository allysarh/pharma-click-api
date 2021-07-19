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
                        let response = 200
                        res.status(200).send({ iduser, fullname, gender, age, username, role, status, profile_image, cart, address, token, response })
                    } else {
                        res.status(200).send({ response: 400, status: "unverified", messages: "Account not verified! Please verify",  })
                    }
                } else {
                    res.status(200).send({ response: 400, messages: "Wrong password!" })
                }
            } else {
                res.status(200).send({ response: 400 , messages: "Account not found! Please register" })
            }
        } catch (error) {
            next(error)
        }
    },
    keepLogin: async (req, res, next) => {
        try {

            let keepLogin = `SELECT iduser, fullname, gender, age, username, email, role, status, profile_image, otp 
            from user as u
            LEFT join role as r
            on r.idrole = u.idrole
            left join status as s
            on s.idstatus = u.idstatus
            where iduser = ${db.escape(req.user.iduser)};`
            keepLogin = await dbQuery(keepLogin)

            keepLogin[0].cart = []
            keepLogin[0].address = []

            let { iduser, fullname, gender, age, username, role, status, profile_image, cart, address } = keepLogin[0]
            let token = createToken({ iduser, fullname, gender, age, username, role, status, profile_image })

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
        } catch (error) {
            next(error)
        }
    },
    getUser: async (req, res, next) => {
        try {

            let getUser = ''
            let userSearch = []

            for (let prop in req.query) {
                userSearch.push(`${prop} = ${db.escape(req.query[prop])}`)
            }

            if (Object.keys(req.query).length > 0) {
                getUser = `SELECT iduser, fullname, gender, age, username, email, role, status, profile_image, otp 
                from user as u
                LEFT join role as r
                on r.idrole = u.idrole
                left join status as s
                on s.idstatus = u.idstatus WHERE ${userSearch.join(' AND ')};`
                console.log(getUser)
            } else {
                getUser = `SELECT iduser, fullname, gender, age, username, email, role, status, profile_image, otp 
                from user as u
                LEFT join role as r
                on r.idrole = u.idrole
                left join status as s
                on s.idstatus = u.idstatus;`
            }
            getUser = await dbQuery(getUser)
            let getAddress = `SELECT * from address;`
            getAddress = await dbQuery(getAddress)

            let getCart = `SELECT * from cart;`
            getCart = await dbQuery(getCart)
            console.log(getCart)

            getUser.forEach((item, index) => {
                item.address = []
                item.cart = []
                getAddress.forEach((e, idx) => {
                    if (item.iduser === e.iduser) {
                        item.address.push({ idadress: e.idaddress, name: e.name, alamat: e.alamat, kode_pos: e.kode_pos })
                    }
                })

                getCart.forEach((val, id) => {
                    console.log("c", val)
                    if (item.iduser == val.iduser) {
                        item.cart.push(val)
                    }
                })
            })

            console.log("get user:", getUser)
            res.status(200).send(getUser)
        } catch (error) {
            next(error)
        }
    }
}