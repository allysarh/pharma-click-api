const { dbQuery, db } = require("../config/database")

class Transaction {
    detail = async (query) => {
        try {
            let getDetail = ` select td.id as idtransaction, iduser, idproduct, product_name, qty_buy, td.created_at, td.updated_at, ts.name as status from transaction_detail td 
            join product p on td.idproduct = p.id
            join transaction t on td.idtransaction = t.id
            join transaction_status ts on t.id_transaction_status = ts.id`

            if (query.start && query.end) getDetail += ` where DATE(td.created_at) between ${db.escape(query.start)} and ${db.escape(query.end)}`
            else getDetail

            getDetail = await dbQuery(getDetail)
            return getDetail
        } catch (error) {
            return error
        }
    }
    revenue = async (start, end) =>{
        try {
            let getTransaction = `select t.id, iduser, ts.name as status, invoice, id_city_origin, id_city_destination, address, recipient, postal_code, expedition, postal_code, service, shipping_cost, total_price, note, img_order_url, created_at, update_at  from transaction t join transaction_status ts on t.id_transaction_status = ts.id`
            if(start && end) getTransaction += ` where DATE(created_at) between ${db.escape(start)} and ${db.escape(end)}`
            getTransaction = await dbQuery(getTransaction)
            return getTransaction
        } catch (error) {
            return error
        }
    }

    productSales = async() =>{
        try {
            let product = `SELECT s.id, s.idproduct, product_name, image_url, t.name as type, qty, total_netto, unit_price, pack_price, unit, ps.name as status from stock as s 
            LEFT JOIN type as t on t.id = s.idtype
            LEFT JOIN product_status as ps on ps.id = s.idstatus
            LEFT join product as p on p.id = s.idproduct
            LEFT join product_image as pi on pi.id = s.idproduct
            where s.idstatus = 1;`
            product = await dbQuery(product)

            let orders = `select t.id as idtransaction, t.invoice, ty.name as type, t.iduser, fullname, td.idproduct as idproduct, t.created_at, total_netto, ts.name as transaction_status, td.qty_buy as qty from transaction t 
            left join transaction_detail td on t.id = td.id
            left join user u on u.iduser = t.iduser
            left join transaction_status ts on ts.id = t.id_transaction_status
            left join type ty on ty.id = idtype;`

            orders = await dbQuery(orders)
            let cos = []
            product.forEach((item, index) =>{
                item.orders = []
                orders.forEach((val) =>{
                    if(item.id == val.idproduct && item.type == val.type){
                        val.created_at = val.created_at.toLocaleDateString()
                        item.orders.push(val)
                    }
                })
            })
            return product
        } catch (error) {
            return error
        }
    }
}

module.exports = new Transaction