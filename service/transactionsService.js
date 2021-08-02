const { dbQuery, db } = require("../config/database")

class Transaction {
    detail = async (query) => {
        try {
            let getDetail = `select td.id as idtransaction, iduser, idproduct, product_name, qty_buy, td.created_at, td.updated_at from transaction_detail td 
            join product p on td.idproduct = p.id
            join transaction t on td.idtransaction = t.id`

            if (query.start && query.end) getDetail += ` where DATE(td.created_at) between ${db.escape(query.start)} and ${db.escape(query.end)}`
            else getDetail

            getDetail = await dbQuery(getDetail)
            return getDetail
        } catch (error) {
            return error
        }
    }
    revenue = async (query) =>{
        try {
            let getTransaction = `select * from transaction`
            if(query.start && query.end) getTransaction += ``
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

            let orders = `select t.id as idtransaction, t.invoice, t.iduser, fullname, td.idproduct as idproduct, t.created_at, td.netto, ts.name as transaction_status, td.qty_buy as qty from transaction t 
            left join transaction_detail td on t.id = td.id
            left join user u on u.iduser = t.iduser
            left join transaction_status ts on ts.id = t.id_transaction_status;`

            orders = await dbQuery(orders)

            product.forEach((item, index) =>{
                item.orders = []
                orders.forEach((val) =>{
                    if(item.id == val.idproduct){
                        val.created_at = val.created_at.toLocaleDateString()
                        val.total_netto = val.qty * val.netto
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