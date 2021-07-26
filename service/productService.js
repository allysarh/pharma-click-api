module.exports = {
    getProduct: (idtype) => {
        return `SELECT p.id as idproduct, product_name, brand, c.name as category, description, effect, p.usage, dosage, indication, netto, pack_price, unit, created_at, updated_at from product as p
LEFT join category as c on c.id = p.idcategory
join stock as  s on s.idproduct = p.id
where s.idtype = ${idtype} and s.idstatus = 1`
    },
    getStock: (idstock) =>{
        
    }
}
