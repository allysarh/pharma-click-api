const jwt = require('jsonwebtoken')

module.exports = {
    authentication: (req, res, next) => {
        jwt.verify(req.token, process.env.JWTSECRET, (err, decoded) => {
            if (err) {
                return res.status(401).send("User not found")
            }
            req.user = decoded
            next()
        })
    }
}
