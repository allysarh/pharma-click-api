const nodemailer = require('nodemailer')

const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: process.env.userNodemailer,
        pass: process.env.pass2FA
    },
    rejectUnauthorized: false
})

module.exports = { transporter }