const dotenv = require('dotenv')

dotenv.config()

const express = require('express')
const app = express()
const PORT = process.env.PORT
const cors = require('cors')
const bearerToken = require('express-bearer-token')
const { db } = require('./config/database')
const bodyParser = require('body-parser');
const { userRouter } = require('./router')

app.use(express.json())
app.use(cors())
app.use(bearerToken())
app.use(express.static('public'))

// MAIN ROUTING
app.get('/', (req, res) =>{
    console.log("tes")
    res.status(200).send("TEST pharmaclick api")
})
app.use('/user', userRouter)

db.getConnection((err, connection) =>{
    if(err){
        return console.log("error mysql", err.message)
    }
    console.log(`Connected to mysql server`, connection.threadId)
})

// error handling
app.use((error, req, res, next, detail) =>{
    res.status(500).send({status: 500, message: error, source: detail})
})

app.listen(PORT, () => console.log("Server running at", PORT))