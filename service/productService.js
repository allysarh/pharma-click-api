const { dbQuery, db } = require("../config");

module.exports = {
  getProduct: (idtype, query) => {
    return `SELECT p.id as idproduct, product_name, brand, c.name as category, description, effect, p.usage, dosage, indication, netto, pack_price, unit, created_at, updated_at from product as p LEFT join category as c on c.id = p.idcategory join stock as s on s.idproduct = p.id where s.idtype = ${db.escape(
      idtype
    )} AND s.idstatus = ${db.escape(1)}`;
  },
  getStock: (idstock) => {},
  getReviews: (idproduct) => {
    let dataReview
    if(idproduct){
      dataReview = `select id as idreview, r.iduser, fullname, idproduct, review, rating, r.created_at, r.updated_at from review r left join user as u on r.iduser = u.iduser where r.idproduct = ${idproduct};`;
    } else {
      dataReview = `select id as idreview, r.iduser, fullname, idproduct, review, rating, r.created_at, r.updated_at from review r left join user as u on r.iduser = u.iduser`
    }
    console.log(dataReview);
    return dbQuery(dataReview);
  },
  addReviews: (iduser, body) =>{
    let values = []
    body.forEach((item, index) =>{
      values.push(`(${iduser}, ${db.escape(item.idproduct)}, ${db.escape(item.rating)}, ${db.escape(item.review)})`)
    })
    let addReview = `INSERT INTO review (iduser, idproduct, rating, review) values ${values.join(',')} `
    return dbQuery(addReview)
  },
  updateReview: (iduser, body) =>{
    let updateTrans = `UPDATE transaction set review = '1' where id = ${body[0].idtransaction};`
    return dbQuery(updateTrans)
  }
};
