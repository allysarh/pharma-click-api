const fs = require('fs')
const { uploader } = require('../config')
const { dbQuery, db } = require('../config/database')


module.exports = {
    getProductPack: async (req, res, next) => {
        try {
            
            let getProduct = `SELECT idproduct, product_name, brand, category, description, effect, p.usage, dosage, indication from product as p
            LEFT join category as c on c.idcategory = p.idcategory
            LEFT join status as s on s.idstatus = p.idstatus;;`
            if (Object.keys(req.query).length > 0) {
                let searchQuery = []
                for (props in req.query) {
                    searchQuery.push(`${props} = ${db.escape(req.query[props])}`)
                }
                getProduct = `SELECT idproduct, product_name, brand, category, description, effect, p.usage, dosage, indication from product as p
                LEFT join category as c on c.idcategory = p.idcategory
                LEFT join status as s on s.idstatus = p.idstatus WHERE ${searchQuery.join(" AND ")};`
            }

            getProduct = await dbQuery(getProduct)
            let getStock
            if(req.params.idtype == 'all') {
                getStock = `SELECT idstock, idproduct, status, netto, qty, total_netto, unit_price, pack_price, unit, type from stock as st
                LEFT join type as t on t.idtype = st.idtype
                LEFT join status as s on s.idstatus = st.idstatus;`
            } else {
                getStock = `SELECT idstock, idproduct, status, netto, qty, total_netto, unit_price, pack_price, unit, type from stock as st
                LEFT join type as t on t.idtype = st.idtype
                LEFT join status as s on s.idstatus = st.idstatus
                WHERE st.idtype = ${req.params.idtype};`
            }
            getStock = await dbQuery(getStock)

            let getImg = `SELECT * from product_image`
            getImg = await dbQuery(getImg)

            getProduct.forEach((item, index) => {
                item.stock = []
                item.images = []

                getStock.forEach((val, idx) => {
                    if (val.idproduct == item.idproduct) {
                        item.stock.push(val)
                    }
                })

                getImg.forEach((e, i) => {
                    if (e.idproduct == item.idproduct) {
                        item.images.push(e.image)
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
    }
}