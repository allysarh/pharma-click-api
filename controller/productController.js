const { db, dbQuery } = require("../config");

module.exports = {
  getProducts: async (req, res, next) => {
    try {
      // let category = req.query.category;
      // let pack_price = req.query.pack_price;
      console.log(req.query);

      let getSQL,
        dataSearch = [];
      for (let prop in req.query) {
        if (prop.includes("id")) {
          let a = prop;
          const b = ["id"];
          a = a.replace(new RegExp(b.join("|"), "g"), "p.id");
          dataSearch.push(`${a} = ${db.escape(req.query[prop])}`);
        } else if (prop.includes("name")) {
          let a = prop;
          const b = ["name"];
          a = a.replace(new RegExp(b.join("|"), "g"), "c.name");
          dataSearch.push(`${a} = ${db.escape(req.query[prop])}`);
        } else {
          dataSearch.push(`${prop} = ${db.escape(req.query[prop])}`);
        }
      }

      if (dataSearch.length > 0) {
        getSQL = `select *,t.name as type from product p join category c on p.idcategory=c.id join stock s on s.idproduct=p.id join type t on s.idtype=t.id join product_image pi on pi.idproduct = p.id join product_status ps on s.idstatus = ps.id
        where ${dataSearch.join(" AND ")}`;
      } else {
        getSQL = `select *,t.name as type from product p join category c on p.idcategory=c.id join stock s on s.idproduct=p.id join type t on s.idtype=t.id join product_image pi on pi.idproduct = p.id join product_status ps on s.idstatus = ps.id`;
      }
      dataProducts = await dbQuery(getSQL);
      return res.status(200).send(dataProducts);
    } catch (error) {
      next(error);
    }
  },
  getCity: async (req, res, next) => {
    try {
      origin = await dbQuery(`SELECT * FROM city`);
      res.status(200).send(origin);
    } catch (error) {
      next(error);
    }
  },
};
