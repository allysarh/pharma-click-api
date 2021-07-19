const { dbQuery, db, transporter, createToken } = require('../config')
const Crypto = require('crypto')

module.exports ={
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
            res.status(200).send({status: 200, messages: "Register Succes", register: true})
        } catch (error) {
            next(error)
        }
    }
}