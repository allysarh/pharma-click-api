const jwt = require('jsonwebtoken')

//
module.exports = {
    authorization: (req, res, next) => {
        jwt.verify(req.token, process.env.JWTSECRET, (err, decoded) => {
            if (err) {
                return res.status(401).send("User not found")
            }
            req.user = decoded

            if(req.user.role == "admin"){
                next()
            } else {
                return res.status(401).send("User not verified")
            }
        })
    }
}
