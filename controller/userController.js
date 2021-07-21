const { dbQuery, db, transporter, createToken } = require('../config')
const Crypto = require('crypto')

module.exports = {
    accVerif: async (req, res, next) => {
        try {
            let accVerif = `UPDATE user set idstatus = 1 where iduser = ${db.escape(req.user.iduser)};`
            await dbQuery(accVerif)

            res.status(200).send({ status: 200, messages: "Verifikasi berhasil silahkan login!", verif: true })
        } catch (error) {
            next(error)
        }
    },
    reVerif: async (req, res, next) => {
        try {
            let { email } = req.body
            let getUser = `SELECT * from user where email = ${db.escape(email)};`
            getUser = await dbQuery(getUser)

            if (getUser.length > 0) {
                let { iduser, fullname, gender, age, username, idrole, idstatus, profile_image, otp } = getUser[0]
                let reVerif = `UPDATE user set otp = ${db.escape(OTP)} where iduser = ${db.escape(iduser)};`

                await dbQuery(reVerif)
                let token = createToken({ iduser, fullname, gender, age, username, idrole, idstatus, profile_image, otp })
                let mail = {
                    from: 'PHARMACLICK-ADMIN <allysa.rahagustiani@gmail.com>',
                    to: email,
                    subject: '[PHARMACLICK RESET PASSWORD]',
                    html: `<div style="text-align: center;">
                        <h1> This is email for verify your account</h1>
                        <p> Click <a href="http://localhost:3000/verif/${token}">this link</a> and input this otp</p>
                        <h1>OTP: ${OTP}</h1>
                        </div>`
                }

                await transporter.sendMail(mail)
                res.status(200).send({ status: 200, messages: 'Verfication email sent!', reVerif: true })
            } else {
                res.status(404).send({ status: 404, messages: 'Email not registered. Please register!', reVerif: false })
            }

        } catch (error) {
            next(error)
        }
    },
    resgister: async (req, res, next) => {
        try {
            let { nama, username, email, password } = req.body
            // GENERATE OTP
            let char = '0123456789abcdefghijklmnoprstuvwxyz'
            let OTP = ''

            for (let i = 0; i < 6; i++) {
                OTP += char.charAt(Math.floor(Math.random() * char.length))
            }
            // HASHING PASSOWRD
            let hashPassword = Crypto.createHmac("sha256", "PHR$$$").update(password).digest("hex")
            console.log(hashPassword)
            let register = `INSERT INTO user (fullname, username, email, idrole, idstatus, password, otp) values (${db.escape(nama)}, ${db.escape(username)}, ${db.escape(email)},  2, 2, ${db.escape(hashPassword)}, ${db.escape(OTP)});`

            register = await dbQuery(register)

            let iduser = register.insertId

            // CREATE TOKEN
            let token = createToken({ iduser, username, email })

            //  Email configuration
            let mail = {
                from: 'PHARMACLICK-ADMIN <allysa.rahagustiani@gmail.com>',
                to: email,
                subject: '[PHARMACLICK VERFICATION EMAIL]',
                html: ` <table cellpadding="0" cellspacing="0" class="es-content" align="center">
                <tbody>
                    <tr>
                        <td class="esd-stripe" align="center">
                            <table bgcolor="#ffffff" class="es-content-body" align="center" cellpadding="0" cellspacing="0" width="700">
                                <tbody>
                                    <tr>
                                        <td class="esd-structure es-p40t es-p20b es-p20r es-p20l" align="left" esd-custom-block-id="334499">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tbody>
                                                    <tr>
                                                        <td width="660" class="esd-container-frame" align="center" valign="top">
                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                <tbody>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-image" style="font-size: 0px;"><a target="_blank"><img src="https://tlr.stripocdn.email/content/guids/CABINET_2663efe83689b9bda1312f85374f56d2/images/10381620386430630.png" alt style="display: block;" width="100"></a></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-text">
                                                                            <h2>Verify your email to finish signing up</h2>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-spacer es-p10t es-p10b es-m-txt-c" style="font-size:0">
                                                                            <table border="0" width="40%" height="100%" cellpadding="0" cellspacing="0" style="width: 40% !important; display: inline-table;">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="border-bottom: 1px solid #cccccc; background:none; height:1px; width:100%; margin:0px 0px 0px 0px;"></td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-text es-p5t es-p5b es-p40r es-m-p0r" esd-links-underline="none">
                                                                            <p>Thank you for choosing PHARMACLICK.</p>
                                                                            <p><br></p>
                                                                            <p>Please confirm that <strong><a target="_blank" href="mailto:${email}" style="text-decoration: none;">${email}</a></strong>&nbsp;is your email address by input OTP on the button below to <a target="_blank" href="http://localhost:3000/verif/${token}" style="text-decoration: none; word-break: break-all;">this link</a> within <strong>48 hours</strong>.</p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-spacer es-p10t es-p10b es-m-txt-c" style="font-size:0">
                                                                            <table border="0" width="40%" height="100%" cellpadding="0" cellspacing="0" style="width: 40% !important; display: inline-table;">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="border-bottom: 1px solid #cccccc; background:none; height:1px; width:100%; margin:0px 0px 0px 0px;"></td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-button es-p10t es-p10b es-m-txt-l">
                                                                        <h3>Your OTP:</h3>
                                                                        <h1 style="border: 1px solid black; background: #ffffff;">${OTP}</h1>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>`
            }
            await transporter.sendMail(mail)
            res.status(200).send({ status: 200, messages: "Register Succes", register: true })
        } catch (error) {
            next(error)
        }
    },
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
                        res.status(200).send({ response: 400, status: "unverified", messages: "Account not verified! Please verify", })
                    }
                } else {
                    res.status(200).send({ response: 400, messages: "Wrong password!" })
                }
            } else {
                res.status(200).send({ response: 400, messages: "Account not found! Please register" })
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
    },
    forgetPassword: async (req, res, next) => {
        try {
            let { email } = req.body
            
            let verifyEmail = `SELECT * from user where email = ${db.escape(email)};`
            verifyEmail = await dbQuery(verifyEmail)
            console.log(verifyEmail)
            
            if (verifyEmail.length > 0) {
                let { iduser, fullname, gender, age, username, idrole, idstatus, profile_image,otp } = verifyEmail[0]
                let token = createToken({ iduser, fullname, gender, age, username, idrole, idstatus, profile_image, otp })

                let mail = {
                    from: 'PHARMACLICK-ADMIN <allysa.rahagustiani@gmail.com>',
                    to: email,
                    subject: '[PHARMACLICK RESET PASSWORD]',
                    html: ` <table cellpadding="0" cellspacing="0" class="es-content" align="center">
                <tbody>
                    <tr>
                        <td class="esd-stripe" align="center">
                            <table bgcolor="#ffffff" class="es-content-body" align="center" cellpadding="0" cellspacing="0" width="700">
                                <tbody>
                                    <tr>
                                        <td class="esd-structure es-p40t es-p20b es-p20r es-p20l" align="left" esd-custom-block-id="334499">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tbody>
                                                    <tr>
                                                        <td width="660" class="esd-container-frame" align="center" valign="top">
                                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                                <tbody>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-image" style="font-size: 0px;"><a target="_blank"><img src="https://tlr.stripocdn.email/content/guids/CABINET_2663efe83689b9bda1312f85374f56d2/images/10381620386430630.png" alt style="display: block;" width="100"></a></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-text">
                                                                            <h2>Verify your email to finish signing up</h2>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-spacer es-p10t es-p10b es-m-txt-c" style="font-size:0">
                                                                            <table border="0" width="40%" height="100%" cellpadding="0" cellspacing="0" style="width: 40% !important; display: inline-table;">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="border-bottom: 1px solid #cccccc; background:none; height:1px; width:100%; margin:0px 0px 0px 0px;"></td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-text es-p5t es-p5b es-p40r es-m-p0r" esd-links-underline="none">
                                                                            <p>Thank you for choosing PHARMACLICK.</p>
                                                                            <p><br></p>
                                                                            <p>To reset pasword, please click<strong><a target="_blank" href="mailto:${email}" style="text-decoration: none;">${email}</a></strong>&nbsp;is your email address by input OTP on the button below to <a target="_blank" href="http://localhost:3000/reset/${token}" style="text-decoration: none; word-break: break-all;">this link</a> within <strong>12 hours</strong> or click button below.</p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" class="esd-block-spacer es-p10t es-p10b es-m-txt-c" style="font-size:0">
                                                                            <table border="0" width="40%" height="100%" cellpadding="0" cellspacing="0" style="width: 40% !important; display: inline-table;">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="border-bottom: 1px solid #cccccc; background:none; height:1px; width:100%; margin:0px 0px 0px 0px;"></td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                    <td align="center">
                                                                        <a href="http://localhost:3000/reset/${token}">
                                                                            <button>
                                                                                <h4>Reset password</h4>
                                                                            </button>
                                                                        </a>
                                                                    </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>`
                }
                await transporter.sendMail(mail)
                res.status(200).send({ status: 200, messages: "Password reset link sent to your e-mail!", verifyEmail: true })
            } else {
                res.status(404).send({ status: 404, messages: "Email not found. Make sure your email is registered!", verifyEmail: false })
            }

        } catch (error) {
            next(error)
        }
    }
}