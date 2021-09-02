const multer = require("multer");
const fs = require("fs");
// const sharp = require("sharp");

module.exports = {
  uploader: (directory, fileNamePrefix) => {
    let defaultDir = "./public";

    const storage = multer.diskStorage({
      destination: (req, file, cb) => {
        const pathDir = directory ? defaultDir + directory : defaultDir;

        if (fs.existsSync(pathDir)) {
          console.log("Directory Exist!✅");
          cb(null, pathDir);
        } else {
          fs.mkdir(pathDir, { recursive: true }, (error) => cb(error, pathDir));
          console.log("Directory success created✅✅");
        }
      },
      filename: (req, file, cb) => {
        let ext = file.originalname.split(".");
        let filename = fileNamePrefix + Date.now() + "." + ext[ext.length - 1];
        cb(null, filename);
      },
    });

    const fileFilter = (req, file, cb) => {
      const ext = /\.(jpg|png|jpeg)/gi;

      if (!file.originalname.match(ext)) {
        return cb(new Error("Your file type are denied"), false);
      }

      cb(null, true);
    };

    return multer({ storage, fileFilter });
  },
  uploaderProfile: (directory, fileNamePrefix) => {
    let defaultDir = "./public";

    const storage = multer.diskStorage({
      destination: (req, file, cb) => {
        const pathDir = directory ? defaultDir + directory : defaultDir;

        if (fs.existsSync(pathDir)) {
          console.log("Directory Exist!✅");
          cb(null, pathDir);
        } else {
          fs.mkdir(pathDir, { recursive: true }, (error) => cb(error, pathDir));
          console.log("Directory success created✅✅");
        }
      },
      filename: (req, file, cb) => {
        // console.log("isi filenya", file.mimetype.split("/")[1]);
        let ext = file.originalname.split(".");
        let filename = fileNamePrefix + `${file.mimetype.split("/")[1]}`;
        // + Date.now() + "." + ext[ext.length - 1];
        cb(null, filename);
      },
    });
    

    const fileFilter = (req, file, cb) => {
      const ext = /\.(jpg|jpeg)/gi;

      if (!file.originalname.match(ext)) {
        return cb(new Error("Your file type are denied"), false);
      }

      cb(null, true);
    };

    return multer({ storage, fileFilter });
  },
};
