const { dbQuery, db, transporter, createToken } = require('../config')
const Crypto = require('crypto')

module.exports = {
    accVerif: async (req, res, next) => {
        try {
            let { otp } = req.body
            let accVerif = `UPDATE user set idstatus = 1 where iduser = ${db.escape(req.user.iduser)} and otp = ${db.escape(otp)};`
            await dbQuery(accVerif)

            res.status(200).send({ status: 200, messages: "Verifikasi berhasil silahkan login!", verif: true })
        } catch (error) {
            next(error)
        }
    },
    reVerif: async (req, res, next) => {
        try {
            // GENERATE OTP
            let char = '0123456789abcdefghijklmnoprstuvwxyz'
            let OTP = ''

            for (let i = 0; i < 6; i++) {
                OTP += char.charAt(Math.floor(Math.random() * char.length))
            }

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
    }
}