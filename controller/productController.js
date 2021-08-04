const fs = require('fs')
const { productController } = require('.')
const { uploader } = require('../config')
const { dbQuery, db } = require('../config/database')
const productService = require('../service/productService')
const Product = require('../service/productService')
var RajaOngkir = require("rajaongkir-nodejs").Starter(
  "63b5cc834bb0e38090a2b629da2ca394"
);

module.exports = {
  getProduct: async (req, res, next) => {
    try {

      let getProduct = productService.getProduct(req.params.idtype)

      if (Object.keys(req.query).length > 0) {
        let searchQuery = []
        let sortQuery = []
        let filterQuery = []

        for (props in req.query) {
          if (props.toLowerCase() == "sort") {
            sortQuery.push(`${req.query[props].split(':').join(' ')}`)
          }
          else if (req.query[props].includes('%')) {
            searchQuery.push(`${props} LIKE ${db.escape(req.query[props].replace('+', ' '))}`)
            getProduct += ` AND ${searchQuery.join(" AND ")}`
          }

          else if (req.query[props].includes('[and]')) {
            let range = req.query[props].split('[and]')
            filterQuery.push(` and ${props} >= ${range[0]} and ${props} <= ${range[1]}`)
            getProduct += filterQuery
          } else {
            searchQuery.push(`${props} = ${db.escape(req.query[props].replace('+', ' '))}`)
            getProduct += ` AND ${searchQuery.join(" AND ")}`
          }

        }
        if (sortQuery.length > 0) {
          getProduct += ` ORDER BY ${sortQuery}`
        }

      }

      getProduct = await dbQuery(getProduct);
      let getStock = `SELECT s.id, idproduct, t.name as type, qty, total_netto, unit_price, ps.name as status from stock as s 
            LEFT JOIN type as t on t.id = s.idtype
            LEFT JOIN product_status as ps on ps.id = s.idstatus`;

      if (["1", "2"].indexOf(req.params.idtype) > -1) {
        getStock =
          getStock +
          ` WHERE s.idtype = ${req.params.idtype} and s.idstatus = 1;`;
      }

      getStock = await dbQuery(getStock);

      let getImg = `SELECT * from product_image`;
      getImg = await dbQuery(getImg);

      getProduct.forEach((item, index) => {
        item.stock = [];
        item.images = [];

        getStock.forEach((val, idx) => {
          if (val.idproduct == item.idproduct) {
            item.stock.push(val);
          }
        });

        getImg.forEach((e, i) => {
          if (e.idproduct == item.idproduct) {
            item.images.push(e.image_url);
          }
        });
      });

      res.status(200).send(getProduct);
    } catch (error) {
      next(error);
    }
  },
  addProduct: async (req, res, next) => {
    try {
      const upload = uploader("/products", "IMG").fields([
        { name: "products" },
      ]);
      upload(req, res, async (error) => {
        try {
          const { products } = req.files;
          let {
            product_name,
            brand,
            idcategory,
            description,
            effect,
            usage,
            dosage,
            indication,
            netto,
            pack_price,
            unit,
            stock,
          } = JSON.parse(req.body.data);
          let addProduct = `INSERT into product values (null, ${db.escape(
            product_name
          )}, ${db.escape(brand)}, ${db.escape(idcategory)}, ${db.escape(
            description
          )}, ${db.escape(effect)}, ${db.escape(usage)}, ${db.escape(
            dosage
          )}, ${db.escape(indication)}, ${db.escape(netto)}, ${db.escape(
            pack_price
          )}, ${db.escape(unit)}, now(), now());`;
          addProduct = await dbQuery(addProduct);

          let addImg = `INSERT into product_image values (null, ${addProduct.insertId
            }, ${db.escape(`products/${products[0].filename}`)})`;
          await dbQuery(addImg);

          let addStock = `INSERT into stock values (null, ${addProduct.insertId
            }, 1, ${db.escape(stock[0].qty)}, ${db.escape(
              stock[0].total_netto
            )}, null, 1);`;
          await dbQuery(addStock);

          res
            .status(200)
            .send({ status: 200, messages: "Add product berhasil!" });
        } catch (error) {
          next(error);
        }
      })
    } catch (error) {
      next(error);
    }
  },
  addCustomProduct: async (req, res, next) => {
    try {
      const upload = uploader("/products", "IMG").fields([
        { name: "products" },
      ]);
      upload(req, res, async (error) => {
        try {
          const { products } = req.files;
          let {
            product_name,
            brand,
            idcategory,
            description,
            effect,
            usage,
            dosage,
            indication,
            netto,
            pack_price,
            unit,
            stock,
          } = JSON.parse(req.body.data);
          let addProduct = `INSERT into product values (null, ${db.escape(
            product_name
          )}, ${db.escape(brand)}, ${db.escape(idcategory)}, ${db.escape(
            description
          )}, ${db.escape(effect)}, ${db.escape(usage)}, ${db.escape(
            dosage
          )}, ${db.escape(indication)}, ${db.escape(netto)}, ${db.escape(
            pack_price
          )}, ${db.escape(unit)}, now(), now());`;
          addProduct = await dbQuery(addProduct);

          let addImg = `INSERT into product_image values (null, ${addProduct.insertId
            }, ${db.escape(`products/${products[0].filename}`)})`;
          await dbQuery(addImg);

          let addStock = `INSERT into stock values (null, ${addProduct.insertId
            }, 2, ${db.escape(stock[0].qty)}, ${db.escape(
              stock[0].total_netto
            )}, null, 1);`;
          await dbQuery(addStock);

          res
            .status(200)
            .send({ status: 200, messages: "Add product berhasil!" });
        } catch (error) {
          next(error);
        }
      })
    } catch (error) {
      next(error);
    }
  },
  deleteProduct: async (req, res, next) => {
    try {
      let deleteProduct = `UPDATE stock set idstatus = 3 where id = ${db.escape(
        req.params.idstock
      )};`;
      await dbQuery(deleteProduct);
      // console.log(deleteProduct)
      res.status(200).send({ status: 200, messages: "Product deleted!" });
    } catch (error) { }
  },
  getProducts: async (req, res, next) => {
    try {
      // let category = req.query.category;
      // let pack_price = req.query.pack_price;
      // console.log(req.query);

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
  editProduct: async (req, res, next) => {
    try {
      const upload = uploader("/products", "IMG").fields([
        { name: "products" },
      ]);
      upload(req, res, async (error) => {
        try {
          console.log("edit");
          let {
            idproduct,
            product_name,
            brand,
            idcategory,
            description,
            effect,
            usage,
            dosage,
            indication,
            netto,
            pack_price,
            unit,
            stock,
          } = JSON.parse(req.body.data);
          let editProduct = `UPDATE product p set product_name = ${db.escape(
            product_name
          )}, brand = ${db.escape(brand)}, idcategory = ${db.escape(
            idcategory
          )}, 
                    description = ${db.escape(
            description
          )}, effect = ${db.escape(effect)}, p.usage = ${db.escape(
            usage
          )}, dosage = ${db.escape(dosage)}, indication = ${db.escape(
            indication
          )}, 
                    netto = ${db.escape(netto)}, pack_price = ${db.escape(
            pack_price
          )}, unit = ${db.escape(unit)} where id = ${idproduct};`;

          await dbQuery(editProduct);
          let total_netto = stock[0].qty * netto;
          let editStock = `UPDATE stock set idtype = 1, qty = ${db.escape(
            stock[0].qty
          )}, total_netto = ${db.escape(
            total_netto
          )}, idstatus = 1 where id = ${db.escape(stock[0].id)};`;

          await dbQuery(editStock);

          let getImg = `SELECT * from product_image where idproduct = ${stock[0].idproduct};`;
          getImg = await dbQuery(getImg);
          if (req.files.products) {
            console.log(getImg[0].image_url);
            console.log(getImg[0].image_url.includes("http"));
            if (getImg[0].image_url.includes("http") == false) {
              fs.unlinkSync(`./public/${getImg[0].image_url}`);
            }
            const { products } = req.files;
            let updateImage = `Update product_image set image_url = ${db.escape(
              `products/${products[0].filename}`
            )} where idproduct = ${idproduct};`;
            await dbQuery(updateImage);
          }

          res
            .status(200)
            .send({ status: 200, messages: "Edit product berhasil!" });
        } catch (error) {
          // hapus gambar yang sudah di upload
          if (req.files.products[0].originalname.match(/(jpg|jpeg|png)/)) {
            fs.unlinkSync(
              `./public/products/${req.files.products[0].filename}`
            );
            // error db query
            console.log("error catch", error);
          } else {
            console.log("invalid file format", error);
          }
          res.status(400).send("ERROR");
        }
      });
    } catch (error) {
      next(error);
    }
  },
  editProductCustom: async (req, res, next) => {
    try {
      const upload = uploader("/products", "IMG").fields([
        { name: "products" },
      ]);
      upload(req, res, async (error) => {
        try {
          console.log("edit");
          let {
            idproduct,
            product_name,
            brand,
            idcategory,
            description,
            effect,
            usage,
            dosage,
            indication,
            netto,
            pack_price,
            unit,
            stock,
          } = JSON.parse(req.body.data);
          let editProduct = `UPDATE product p set product_name = ${db.escape(
            product_name
          )}, brand = ${db.escape(brand)}, idcategory = ${db.escape(
            idcategory
          )}, 
                    description = ${db.escape(
            description
          )}, effect = ${db.escape(effect)}, p.usage = ${db.escape(
            usage
          )}, dosage = ${db.escape(dosage)}, indication = ${db.escape(
            indication
          )}, 
                    netto = ${db.escape(netto)}, pack_price = ${db.escape(
            pack_price
          )}, unit = ${db.escape(unit)} where id = ${idproduct};`;

          await dbQuery(editProduct);
          let total_netto = stock[0].qty * netto;
          let editStock = `UPDATE stock set idtype = 2, qty = ${db.escape(
            stock[0].qty
          )}, total_netto = ${db.escape(
            total_netto
          )}, idstatus = 1 where id = ${db.escape(stock[0].id)};`;

          await dbQuery(editStock);

          let getImg = `SELECT * from product_image where idproduct = ${stock[0].idproduct};`;
          getImg = await dbQuery(getImg);
          if (req.files.products) {
            console.log(getImg[0].image_url);
            console.log(getImg[0].image_url.includes("http"));
            if (getImg[0].image_url.includes("http") == false) {
              fs.unlinkSync(`./public/${getImg[0].image_url}`);
            }
            const { products } = req.files;
            let updateImage = `Update product_image set image_url = ${db.escape(
              `products/${products[0].filename}`
            )} where idproduct = ${idproduct};`;
            await dbQuery(updateImage);
          }

          res
            .status(200)
            .send({ status: 200, messages: "Edit product berhasil!" });
        } catch (error) {
          // hapus gambar yang sudah di upload
          if (req.files.products[0].originalname.match(/(jpg|jpeg|png)/)) {
            fs.unlinkSync(
              `./public/products/${req.files.products[0].filename}`
            );
            // error db query
            console.log("error catch", error);
          } else {
            console.log("invalid file format", error);
          }
          res.status(400).send("ERROR");
        }
      });
    } catch (error) {
      next(error);
    }
  },
  addToCart: async (req, res, next) => {
    try {
      let { iduser, idproduct, qty, total_netto, price, product_name } = req.body;
      // cartItem = getUserCartItem(iduser, idproduct)
      // if (cartItem == null) {
      //   // add new item to cart
      //   await addItemToCart(iduser, idproduct, qty)
      // } else {
      //   // increment cart item quantity
      //   stock = await getItemStock(idproduct)
      //   qtyIsAvailable = stock.qty >= qty
      //   if (!qtyIsAvailable) {
      //     return 400 - "qty is not enough"
      //   }
      //   await updateCartItemQty(iduser, idproduct, cartItem.qty + qty)

      // }


      getCartSort = await dbQuery(
        `SELECT * FROM cart WHERE iduser=${db.escape(
          iduser
        )} AND idproduct=${db.escape(idproduct)}`
      );

      getStock = await dbQuery(
        `SELECT * FROM stock WHERE idproduct=${db.escape(idproduct)} `
      );
      // console.log(req.body)
      if (getCartSort[0] === undefined) {
        let addCart = await dbQuery(
          `INSERT INTO cart VALUES (null,${db.escape(iduser)},${db.escape(
            idproduct
          )},${db.escape(qty)},${db.escape(total_netto)},${db.escape(
            price
          )},now(),now());`
        );
        res.status(200).send(`Success add to cart ${product_name}`);
      } else {
        if (getCartSort[0].iduser === iduser && getCartSort[0].idproduct === idproduct) {
          if (qty + getCartSort[0].qty <= getStock[0].qty) {
            let updateCart = await dbQuery(
              `UPDATE cart SET qty = ${db.escape(
                getCartSort[0].qty + qty
              )}, total_netto = ${db.escape(
                getCartSort[0].total_netto + total_netto
              )},price = ${db.escape(
                getCartSort[0].price + price
              )} WHERE idproduct = ${db.escape(idproduct)}`
            );
          }

        } else {
          if (getCartSort[0].iduser === iduser && getCartSort[0].idproduct === idproduct) {
            if (qty + getCartSort[0].qty <= getStock[0].qty) {
              let updateCart = await dbQuery(
                `UPDATE cart SET qty = ${db.escape(
                  getCartSort[0].qty + qty
                )}, total_netto = ${db.escape(
                  getCartSort[0].total_netto + total_netto
                )},price = ${db.escape(getCartSort[0].price + price)} WHERE idproduct = ${db.escape(idproduct)}`);
              res.status(200).send(`Success add to cart ${product_name}`);
            } else {
              res.status(200).send(`Out Of Stock ${product_name}`);
            }
          }
        }
      }
    } catch (error) {
      next(error);
    }
  },
  incrementStock: async (req, res, next) => {
    try {
      let { iduser, idproduct, qty, price } = req.body;

      let stock = await dbQuery(
        `SELECT * FROM stock s join product p on p.id = s.idproduct  WHERE idproduct =${db.escape(
          idproduct
        )}`
      );

      if (qty < stock[0].qty) {
        let addStock = await dbQuery(
          `UPDATE cart SET qty= ${db.escape(qty + 1)},price= ${db.escape(
            stock[0].pack_price * (qty + 1)
          )} WHERE idproduct=${db.escape(idproduct)} AND iduser=${db.escape(
            iduser
          )}`
        );
        res.status(200).send(`Increment success`);
      } else {
        res.status(200).send({ message: `Out Of Stock Product` });
      }
    } catch (error) {
      next(error);
    }
  },
  decrementStock: async (req, res, next) => {
    try {
      let { iduser, idproduct, qty, price } = req.body;

      let stock = await dbQuery(
        `SELECT * FROM stock s join product p on p.id = s.idproduct  WHERE idproduct =${db.escape(
          idproduct
        )}`
      );

      if (qty > 1) {
        let incrementStock = await dbQuery(
          `UPDATE cart SET qty=${db.escape(qty - 1)},price = ${db.escape(
            stock[0].pack_price * (qty - 1)
          )} WHERE idproduct=${db.escape(idproduct)} AND iduser=${db.escape(
            iduser
          )}`
        );
        res.status(200).send(`Decrement success`);
      } else {
        res.status(200).send({ message: `quantity can't null` });
      }
    } catch (error) {
      next(error);
    }
  },
  deleteProductCart: async (req, res, next) => {
    try {
      let { idproduct, iduser } = req.query;

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
  getReviews: async (req, res, next) => {
    try {
      let idproduct
      if(req.query.product){
        let { product } = req.query
        idproduct = product.split('-')[product.split('-').length - 1]
      } else {
        idproduct = 0
      }
      dataReview = await productService.getReviews(idproduct)
      res.status(200).send(dataReview)
    } catch (error) {
      next(error)
    }
  },
  addReviews: async (req, res, next) =>{
    try {
      await productService.addReviews(req.user.iduser, req.body)
      await productService.updateReview(req.user.iduser, req.body)
      res.status(200).send({status: 200, message: 'Add Review Success!'})
    } catch (error) {
      console.log(error)
    }
  }
};
