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
}

module.exports = new Transaction