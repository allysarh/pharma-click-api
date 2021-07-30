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
      console.log(req.body);
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

      console.log("TRANS ID", transaction.insertId);

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
  },
};
