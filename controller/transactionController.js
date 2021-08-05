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
      let result = await RajaOngkir.getJNECost(params)
      let cost = [];
          result.rajaongkir.results.map((item) => {
            item.costs.map((item) => {
              cost.push({ cost: item });
            });
          });
          res.status(200).send(cost);
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
        expedition,
        service,
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
          expedition:expedition,
          service:service,
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
            total_netto: item.netto*item.qty_product,
          });
        });
        idproduct.map((item) => {
          let updateStock = dbQuery(
            `UPDATE stock SET qty= qty-${db.escape(
              item.qty_product
            )},total_netto=total_netto-${db.escape(
              item.netto*item.qty_product
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
        expedition,
        service,
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

          console.log("req body data", json);
          // console.log(images);
          //console.log("cek file upload :", images);

          if (images !== undefined) {
            let image_profile = images[0].filename;
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
              expedition: json.expedition,
              service: json.service,
              shipping_cost: json.shipping_cost,
              total_price: json.total_price,
              note: json.note,
              idtype: json.idtype,
              img_order_url: `perscription/${image_profile}`,
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
  }
  ,deleteProductCart: async (req, res, next) => {
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
  getTransaction:async(req,res,next)=>{
    try {
      let transactionSQL,transactions,
        dataSearch = [];
      for (let prop in req.params) {
        dataSearch.push(`${prop} = ${db.escape(req.params[prop])}`);
      }

      if (dataSearch.length > 0) {
        transactionSQL = await dbQuery(`SELECT * FROM transaction where ${dataSearch.join(
          " AND "
        )}`)
      }else{
        transactionSQL = await dbQuery(`SELECT * FROM transaction `)
      }
      res.status(200).send(transactionSQL)
    } catch (error) {
      next(error)
    }
  },
  acceptTransaction:async(req,res,next) => {
    try {
      let {id} = req.params
      let {iduser} = req.user
      console.log(req.user)
      console.log(req.params)
    if(req.user.role === "admin"){
      acceptSQL = await dbQuery(`UPDATE transaction SET id_transaction_status = 1 WHERE id=${db.escape(id)}`)
    }
      res.status(200).send({message:"success aceppt transaction"})
    } catch (error) {
      next(error)
    }
  },
  rejectTransaction:async(req,res,next) => {
    try {
      let {id} = req.params
      let {iduser} = req.user
      console.log(req.user)
      console.log(req.params)
    if(req.user.role === "admin"){
      acceptSQL = await dbQuery(`UPDATE transaction SET id_transaction_status = 3 WHERE id=${db.escape(id)}`)
    }
      res.status(200).send({message:"success reject transaction"})
    } catch (error) {
      next(error)
    }
    
  },
  servePerscription:async(req,res,next) =>{
    try {
      console.log(req.user)
      let {idtransaction,products,destination,postalCode,recipient,note,address,expedition,service,shippingCost} = req.body
    //CHECK STOCK BEFORE CONTINUE BUYING
    let id = [];
    let qty = [];
    products.map((item) => {
      // console.log("product", item);
      return id.push({ idproduct: item.idproduct });
    });

    products.map((item) => {
      return qty.push({
        total_netto: item.total_netto,
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
      return qty.map((val) => {
        if (item.idproduct === val.idproduct) {
          if (item.total_netto >= val.total_netto) {
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
    }else {
      let postTransaction = `UPDATE transaction SET ?`; 
      let transaction = await dbQuery(postTransaction, {
        shipping_cost: shippingCost,
        id_transaction_status: 6,
        total_price: products.reduce(
          (a, v) => (a = a + v.unit_price + parseInt(shippingCost)),0),
      });
      let sql = `INSERT INTO transaction_detail SET ?`;
      products.map((item) => {
        let transactions = dbQuery(sql, {
          idproduct: item.idproduct,
          idtransaction: idtransaction,
          qty_buy: Math.ceil(Math.abs(item.total_netto/item.netto)),
          netto: item.netto,
          total_netto: item.total_netto,
        });
      });

      products.map((item) => {
        let updateStock = dbQuery(
          `UPDATE stock SET total_netto=total_netto-${db.escape(
            item.total_netto
          )} WHERE idproduct=${db.escape(item.idproduct)}`
        );
      });
      res.status(200).send({ message: "success serve perscription" });
    }
    } catch (error) {
      next(error)
    }
  }

}