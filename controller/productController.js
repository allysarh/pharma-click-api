const fs = require('fs')
const { uploader } = require('../config')
const { dbQuery, db } = require('../config/database')


module.exports = {
    getProduct: async (req, res, next) => {
        try {

            let getProduct = `SELECT p.id as product_id, product_name, brand, c.name, description, effect, p.usage, dosage, indication, netto, pack_price, unit from product as p
            LEFT join category as c on c.id = p.idcategory`

            if (Object.keys(req.query).length > 0) {
                let searchQuery = []
                for (props in req.query) {
                    searchQuery.push(`${props} = ${db.escape(req.query[props].replace('%20', ' '))}`)
                }
                getProduct = getProduct + ` WHERE ${searchQuery.join(" AND ")};`

            }

            getProduct = await dbQuery(getProduct)
            let getStock = `SELECT s.id, idproduct, t.name as type, qty, total_netto, unit_price, ps.name as status from stock as s 
            LEFT JOIN type as t on t.id = s.idtype
            LEFT JOIN product_status as ps on ps.id = s.idstatus`

            if (['1', '2'].indexOf(req.params.idtype) > -1) {
                getStock = getStock + ` WHERE s.idtype = ${req.params.idtype};`
            }
            console.log(getStock)
            getStock = await dbQuery(getStock)

            let getImg = `SELECT * from product_image`
            getImg = await dbQuery(getImg)

            getProduct.forEach((item, index) => {
                item.stock = []
                item.images = []

                getStock.forEach((val, idx) => {
                    if (val.idproduct == item.product_id) {
                        item.stock.push(val)
                    }
                })

                getImg.forEach((e, i) => {
                    if (e.idproduct == item.product_id) {
                        item.images.push(e.image_url)
                    }
                })
            })

            res.status(200).send(getProduct)
        } catch (error) {
            next(error)
        }
    },
    addProduct: async (req, res, next) => {
        try {
            // console.log("hayoloh")
            // let { product_name, brand, idstatus, idcategori, stock, description, effect, dosage, usage, indication } = JSON.parse(req.body.data)
            // console.log(product_name)
            // const { images } = req.files
            // console.log(req.files)
            // let addProduct = `INSERT into product (product_name, brand, idstatus, category, description, effect, usage, dosage, indication) values (${db.escape(product_name)}, ${db.escape(brand)}, '3', ${db.escape(category)}, ${db.escape(description)}, ${db.escape(effect)}, ${db.escape(usage)}, ${db.escape(dosage)}, ${db.escape(indication)})`
            // const upload = uploader('/products', 'IMG').fields([{ name: 'products' }])
            // res.status(200).send("OK")

        } catch (error) {

        }
    },

}