const { uploader } = require("../config");
const { dbQuery, db } = require("../config/database");
const fs = require("fs");
const fs1 = require("fs").promises;
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
      // console.log(req.body);
      let {
        id_transaction_status,
        idproduct,
        invoice,
        id_city_origin,
        id_city_destination,
        address,
        recipient,
        postal_code,
        shipping_cost,
        total_price,
        note,
        idtype,
      } = req.body;

      //CHECK STOCK BEFORE CONTINUE BUYING
      let id = [];
      let qty = [];
      idproduct.map((item) => {
        // console.log("product", item);
        return id.push({ idproduct: item.idproduct });
      });

      idproduct.map((item) => {
        return qty.push({
          qty: item.qty_product,
          idproduct: item.idproduct,
        });
      });

      let qtyStock,
        dataSearch = [];

      id.map((item) => {
        for (let prop in item) {
          dataSearch.push(`${prop} = ${db.escape(item[prop])}`);
        }
      });

      if (dataSearch.length > 0) {
        qtyStock = `SELECT * FROM stock WHERE ${dataSearch.join(" OR ")}`;
      }
      let stockQty = await dbQuery(qtyStock);

      let checked = [];

      stockQty.map((item, idx) => {
        // console.log("stockqty", item.qty);
        return qty.map((val) => {
          if (item.idproduct === val.idproduct) {
            console.log("qty", item.qty, val.qty);
            if (item.qty >= val.qty) {
              checked.push({ id: val.idproduct });
            }
          }
        });
      });
      // console.log(checked);
      // console.log(stockQty.length);

      if (checked.length !== stockQty.length) {
        let sqlProduct,
          dataSearch = [];

        checked.map((item) => {
          for (let prop in item) {
            dataSearch.push(`${prop} = ${db.escape(item[prop])}`);
          }
        });

        if (dataSearch.length > 0) {
          sqlProduct = `SELECT product_name from product WHERE ${dataSearch.join(
            " AND "
          )}`;
        }
        let unavailableProducts = await dbQuery(sqlProduct);
        res.status(200).send({
          message: `${unavailableProducts[0].product_name} not enough stock`,
        });
      } else {
        let postTransaction = `INSERT INTO transaction SET ?`;
        let transaction = await dbQuery(postTransaction, {
          iduser: iduser,
          id_transaction_status: id_transaction_status,
          invoice: invoice,
          id_city_origin: id_city_origin,
          id_city_destination: id_city_destination,
          address: address,
          recipient: recipient,
          postal_code: postal_code,
          shipping_cost: shipping_cost,
          total_price: total_price,
          note: note,
          idtype: idtype,
        });
        let sql = `INSERT INTO transaction_detail SET ?`;
        idproduct.map((item) => {
          let transactions = dbQuery(sql, {
            idproduct: item.idproduct,
            idtransaction: transaction.insertId,
            qty_buy: item.qty_product,
            netto: item.netto,
          });
        });
        idproduct.map((item) => {
          let updateStock = dbQuery(
            `UPDATE stock SET qty= qty-${db.escape(
              item.qty_product
            )},total_netto=total_netto-${db.escape(
              item.total_netto
            )} WHERE idproduct=${db.escape(item.idproduct)}`
          );
        });
        let deleteStock = `DELETE  FROM cart WHERE ? AND ?`;
        idproduct.map((item) => {
          let updateTransaction = dbQuery(deleteStock, [
            {
              idproduct: item.idproduct,
            },
            { iduser: iduser },
          ]);
        });
        res.status(200).send({ message: "transaction success" });
      }
    } catch (error) {
      console.log(error);
    }
  },
  perscriptionTransaction: async (req, res, next) => {
    try {
      let { iduser } = req.user;
      let {
        id_transaction_status,
        invoice,
        id_city_origin,
        id_city_destination,
        address,
        recipient,
        postal_code,
        shipping_cost,
        total_price,
        note,
        idtype,
      } = req.body;
      const upload = uploader("/perscription", "IMG").fields([
        { name: "images" },
      ]);

      upload(req, res, async (error) => {
        if (error) {
          //hapus gambar jika proses upload error
          fs.unlinkSync(
            `./public/transactions/${req.files.images[0].filename}`
          );
          next(error);
        }
        try {
          var json = JSON.parse(req.body.data);
          const { images } = req.files;
          // console.log(images);
          console.log("req body data", req.body);
          //console.log("cek file upload :", images);

          if (images !== undefined) {
            let image_profile = images[0].path;
            let postTransaction = `INSERT INTO transaction SET ?`;
            let transactionPerscription = await dbQuery(postTransaction, {
              iduser: iduser,
              id_transaction_status: json.id_transaction_status,
              invoice: json.invoice,
              id_city_origin: json.id_city_origin,
              id_city_destination: json.id_city_destination,
              address: json.address,
              recipient: json.recipient,
              postal_code: json.postal_code,
              shipping_cost: json.shipping_cost,
              total_price: json.total_price,
              note: json.note,
              idtype: json.idtype,
              img_order_url: image_profile,
            });
          }
        } catch (error) {
          if (req.files.images) {
            await fs.unlinkSync(
              `./public/perscription/${req.files.images[0].filename}`
            );
          }
          next(error);
        }
      });
      res
        .status(200)
        .send({ message: "Success Order By Transaction Perscription" });
      // BATAS
    } catch (error) {
      console.log(error);
    }
  }, deleteProductCart: async (req, res, next) => {
    try {
      let { idproduct, iduser } = req.query;
      console.log(req.query);

      console.log(idproduct);
      console.log(iduser);
      let deleteCart = await dbQuery(
        `DELETE FROM cart WHERE idproduct =${db.escape(
          idproduct
        )} AND iduser =${db.escape(iduser)}`
      );
      res.status(200).send({ message: `Delete product from cart success` });
    } catch (error) {
      next(error);
    }
  },
  salesReport: async (req, res, next) => {
    try {
      let detail = await Transactions.detail()
      // console.log(detail[0].created_at.toLocaleDateString())

      detail.forEach((item, index) => {
        let date = item.created_at.toLocaleDateString().split('/')
        item.created_at = item.created_at.toLocaleDateString()
        item.updated_at = item.updated_at
        item.month = parseInt(date[0])
        item.day = parseInt(date[1])
        item.year = parseInt(date[2])
        item.week = Math.floor(date[1] / 7)
        delete item.updated_at
        // delete item.created_at
      })

      let start
      let end
      let hasil = detail

      console.log(start)
      console.log(end)

      if (req.query.start) start = new Date(`${req.query.start} GMT`)
      if (req.query.end) end = new Date(`${req.query.end} GMT`)

      if (req.query.start && req.query.end) {
        hasil = detail.filter(item => {
          let date = new Date(item.created_at)
          return (date >= start && date <= end)
        })
      }
      // console.log("hasil", hasil)
      // function groupBy(objectArray, property) {
      //   return objectArray.reduce(function (acc, obj) {
      //     let key = obj[property]
      //     if (!acc[key]) {
      //       acc[key] = [{ total_qty: 0, total_product: 0, detail: [] }]
      //     }

      //     if (req.query.day) {
      //       if (obj.day == req.query.day) {
      //         acc[key][0].detail.push(obj)
      //         acc[key][0].total_qty += obj.qty_buy
      //         acc[key][0].total_product += 1

      //       }
      //     } else if (req.query.week) {
      //       if (obj.week == req.query.week) {
      //         acc[key][0].detail.push(obj)
      //         acc[key][0].total_qty += obj.qty_buy
      //         acc[key][0].total_product += 1

      //       }
      //     } else if (req.query.month) {
      //       if (obj.month == req.query.month) {
      //         acc[key][0].detail.push(obj)
      //         acc[key][0].total_qty += obj.qty_buy
      //         acc[key][0].total_product += 1

      //       }
      //     } else {
      //       acc[key][0].detail.push(obj)
      //       acc[key][0].total_qty += obj.qty_buy
      //       acc[key][0].total_product += 1
      //     }

      //     return acc
      //   }, {})
      // }

      // let response = groupBy(detail, req.params.time)
      // if (Object.keys(req.query).length > 0) {
      //   response = groupBy(detail, req.params.time)[req.query.name]
      // }
      // let response = groupBy(detail, 'day')

      // res.status(200).send(response)
      res.status(200).send(hasil)
    } catch (error) {
      next(error)
    }
  }
};
