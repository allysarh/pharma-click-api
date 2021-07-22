const fs = require('fs')
const { uploader } = require('../config')
const { dbQuery, db } = require('../config/database')


module.exports = {
    getProduct: async (req, res, next) => {
        try {

            let getProduct = `SELECT p.id as idproduct, product_name, brand, c.name as category, description, effect, p.usage, dosage, indication, netto, pack_price, unit, created_at, updated_at from product as p
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
            const upload = uploader('/products', 'IMG').fields([{ name: 'products' }])
            upload(req, res, async (error) => {
                try {
                    const { products } = req.files
                    let { product_name, brand, idcategory, description, effect, usage, dosage, indication, netto, pack_price, unit, stock } = JSON.parse(req.body.data)
                    let addProduct = `INSERT into product values (null, ${db.escape(product_name)}, ${db.escape(brand)}, ${db.escape(idcategory)}, ${db.escape(description)}, ${db.escape(effect)}, ${db.escape(usage)}, ${db.escape(dosage)}, ${db.escape(indication)}, ${db.escape(netto)}, ${db.escape(pack_price)}, ${db.escape(unit)}, now(), now())`
                    addProduct = await dbQuery(addProduct)

                    let addImg = `INSERT into product_image values (null, ${addProduct.insertId}, ${db.escape(`products/${products[0].filename}`)})`
                    await dbQuery(addImg)

                    let addStock = `INSERT into stock values (null, ${addProduct.insertId}, 1, ${db.escape(stock[0].qty)}, ${db.escape(stock[0].total_netto)}, null, 1);`
                    await dbQuery(addStock)

                    res.status(200).send({status: 200, messages: 'Add product berhasil!'})
                } catch (error) {
                    // hapus gambar yang sudah di upload
                    fs.unlinkSync(`./public/products/${req.files.products[0].filename}`)
                    // error db query
                    console.log("error catch", error)
                    res.status(200).send("ERROR")
                }

            })

        } catch (error) {
            next(error)
        }
    },

}