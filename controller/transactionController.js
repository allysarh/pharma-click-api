const { uploader } = require("../config");
const { dbQuery, db } = require("../config/database");
var RajaOngkir = require("rajaongkir-nodejs").Starter(
  "8b59fc64454aba0cbdc1fcc8a03daf39"
);

// api 8b59fc64454aba0cbdc1fcc8a03daf39
// api 63b5cc834bb0e38090a2b629da2ca394

module.exports = {
  shippingCost: async (req, res, next) => {
    try {
      const params = {
        origin: req.body.origin,
        destination: req.body.destination,
        weight: req.body.weight,
      };

      // console.log(params.origin, params.destination, params.weight, "shipping");
      await RajaOngkir.getJNECost(params)
        .then(function (result) {
          let cost = [];
          result.rajaongkir.results.map((item) => {
            item.costs.map((item) => {
              cost.push({ cost: item });
            });
          });
          res.status(200).send(cost);
        })
        .catch(function (error) {
          console.log(error);
        });
    } catch (error) {
      next(error);
    }
  },
  checkoutTransactions: async (req, res, next) => {
    try {
      let { iduser } = req.user;
      console.log(req.body);
      let {
        idstatus,
        idproduct,
        invoice,
        id_city_origin,
        id_city_destination,
        address,
        shipping_cost,
        total_price,
        note,
        idtype,
      } = req.body;

      // let udpateStock = `UPDATE stock SET ? WHERE ?`;
      // idproduct.map((item) => {
      //   let updateTransaction = dbQuery(sql, [
      //     {
      //       qty: item.qty_buy,
      //     },
      //     { idproduct: item.idproduct },
      //   ]);
      // });

      let deleteStock = `DELETE  FROM cart WHERE ? AND ?`;
      idproduct.map((item) => {
        let updateTransaction = dbQuery(deleteStock, [
          {
            idproduct: item.idproduct,
          },
          { iduser: iduser },
        ]);
      });

      // let sql = `INSERT INTO transaction SET ?`;

      // idproduct.map((item) => {
      //   let transactions = dbQuery(sql, {
      //     iduser: iduser,
      //     idstatus: idstatus,
      //     idproduct: item.idproduct,
      //     invoice: invoice,
      //     id_city_origin: id_city_origin,
      //     id_city_destination: id_city_destination,
      //     address: address,
      //     shipping_cost: shipping_cost,
      //     total_price: total_price,
      //     note: note,
      //     idtype: idtype,
      //     qty_buy: item.qty_buy,
      //   });
      // });

      //   let postTransactions = `INSERT INTO transaction (iduser,idstatus,invoice,id_city_origin,id_city_destination,shipping_cost,total_price,note,idtype)
      // VALUES(${db.escape(iduser)},${db.escape(idstatus)},${db.escape(
      //     invoice
      //   )},${db.escape(id_city_origin)},${db.escape(
      //     id_city_destination
      //   )},${db.escape(shipping_cost)},${db.escape(total_price)},${db.escape(
      //     note
      //   )},${db.escape(idtype)})`;

      res.status(200).send({ message: "transaction success" });
    } catch (error) {
      console.log(error);
    }
  },

  // getProvince: (req, res) => {
  //   RajaOngkir.getProvinces()
  //     .then(function (result) {
  //       let kota = [];
  //       result.rajaongkir.results.map((item) => {
  //         kota.push({ item: item });
  //       });
  //       console.log(kota);
  //       res.status(200).send(kota);
  //     })
  //     .catch(function (error) {
  //       next(error);
  //     });
  // },
};
