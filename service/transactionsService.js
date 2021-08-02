class Transaction {
    ddetail = async () => {
        try {
            let getDetail = `select td.id as idtransaction, iduser, idproduct, product_name, qty_buy, td.created_at, td.updated_at from transaction_detail td 
            join product p on td.idproduct = p.id
            join transaction t on td.idtransaction = t.id;`
            return await dbQuery(getDetail)
        } catch (error) {
            return error
        }
    }
}

module.exports = new Transaction