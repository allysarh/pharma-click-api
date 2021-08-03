const { uploader } = require("../config");
const { dbQuery, db } = require("../config/database");
const fs = require("fs");
const fs1 = require("fs").promises;
const Transactions = require("../service/transactionsService");
const { parse } = require("dotenv");
const { detail } = require("../service/transactionsService");
const { nextTick } = require("process");

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
      let getDetail = await Transactions.detail(req.query)

      getDetail.forEach((item, index) => {
        let date = item.created_at.toLocaleDateString().split('/')
        item.created_at = item.created_at.toLocaleDateString()
        item.updated_at = item.updated_at
        item.month = parseInt(date[0])
        item.day = parseInt(date[1])
        item.year = parseInt(date[2])
        let week = Math.floor(date[1] / 7)
        item.week = week > 0 ? week : week += 1
        delete item.updated_at
      })

      let response = [{ total_product: 0, total_qty: 0, detail: [] }]
      response[0].detail = getDetail
      total_qty = getDetail.reduce((a, b) => a + b.qty_buy, 0)

      let total_product = getDetail.map(item => item.product_name).filter((item, index, self) => self.indexOf(item) == index).length
      response[0].total_qty = total_qty
      response[0].total_product = total_product


      res.status(200).send(response)
    } catch (error) {
      next(error)
    }
  },
  revenue: async (req, res, next) => {
    try {
      
      let transactions = await Transactions.revenue(req.query.start, req.query.end)
      transactions.forEach((item) => {
        let date = item.created_at.toLocaleDateString().split('/')
        item.created_at = item.created_at.toLocaleDateString()
        item.updated_at = item.updated_at
        item.month = parseInt(date[0])
        item.day = parseInt(date[1])
        item.year = parseInt(date[2])
        let week = Math.floor(date[1] / 7)
        item.week = week > 0 ? week : week += 1
        delete item.updated_at

      })
      let revenue = [{ total_revenue: 0, total_user: 0, total_transactions: 0, transactions }]
    
      revenue[0].total_transactions = transactions.length
      revenue[0].total_revenue = transactions.map(item => item.total_price - item.shipping_cost).reduce((a, b) => a + b, 0)
      revenue[0].total_user = transactions.map(item => item.iduser).filter((item, index, self) => self.indexOf(item) == index).length
      res.status(200).send(revenue)
      // res.status(200).send("OK")
    } catch (error) {
      next(error)
    }
  },
  productSales: async (req, res, next) =>{
    try {
      let productSales = await Transactions.productSales()
      res.status(200).send(productSales)
    } catch (error) {
      nextTick(error)
    }
  }
};
