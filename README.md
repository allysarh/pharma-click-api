# Pharmaclick - API
There are three main controllers of *pharmaclick-api* : **User Controller**, **Product Controller** and **Transction Controller**. This code is build of javascript with express library. Other libraries that used are: **mysql**, **jwt**, **multer** and **nodemailer**.  


# 1. User API
User API is API that involves user activities  

## Acount Verification
Verify account to continue login     

- Method : ``POST``  
- Path: ``/user/verif``  
- Token: Required  

Respon Succes: 
```json
{
 "status": 200,
 "messages": "Verifikasi berhasil silahkan login!",
 "verif": true
}
```

Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
```

## Account Re-Verification
Resend verification mail     

- Method: ``POST``  
- Path: ``user/re-verif``  
- Request: Request Body  

```json
{ 
    "email": "user_email@mail.com" 
}
```

Respon Success: 
``` json
{
 "status": 200,
 "messages": "Verification email sent!",
 "reVerif": true
}```

Respon Error Email not Registered:
```json
{
 "status": 200,
 "messages": "Email not registered. Please register!",
 "reVerif": "error"
}
```

Respon Error: 
```json
{
 "status": 500,
 "messages" "error messages"
}
```

## Register
Register new account    

- Method: ``POST``  
- Path: ``user/register``  
- Request: Request body  

Response Success:  
```json
{
 "status": 200, 
 "messages":"Register Success",
 "register":true
}
``` 
Respon Error Invalid Password:  
```json
{
 "status": 400,
 "messages": "Invalid password format"
}
```

Note: Password must contain at least 6 characters including combination of numbers and alphabet    
Respon Error Invalid Email:  
```json
{
 "status": 400,
 "messages": "Invalid email format"
}
```  
Note: Email must be in a valid email format (ends with .com/.co.id and contains '@')  

## Login
Login into pharmaclick  
- Method:``POST``  
- Path: ``user/login``  
- Request: Request Body  

```json
{
 "email": "user_mail@mail.com",
 "password": "userpassword123"
}
```

Response Success:  
```json
{
 "iduser": 0,
 "fullname": "User Fullname",
 "gender": "",
 "age": "",
 "username":"username",
 "email": "user_email@mail.com",
 "role": "user",
 "status": "verified",
 "profile_image": "",
 "cart": [],
 "address": [],
 "phone_number": "",
 "token": "jwttoken",
 "response": 200
}
```  

Response Error Account Unverified:  
```json
{
 "response": 400,
 "status": "unverified",
 "messages": "Account not verified! Please verify"
}
```  

Response Error Wrong Password:  
```json
{
 "response": 400, 
 "messages": "Wrong Password!"
}
```  
Reponse Error Account not Found:  
```json
{
 "response": 400,
 "messages" "Account not found! Please register"
}
```

## Get User
Get all user information    

- Method: ``GET``  
- Path: ``user/get``  
- Token: required  
- Request: Request Query  
- Request query parameter: iduser, fullname, gender, age, role, status  

Response Success:  
```json
[
  {
    "iduser": 17,
    "fullname": "Admin 1",
    "gender": null,
    "age": null,
    "username": "admin1",
    "email": "admin@mail.com",
    "role": "admin",
    "status": "verified",
    "profile_image": null,
    "otp": "3isc9u",
    "created_at": "2021-07-21T23:07:38.000Z",
    "updated_at": "2021-07-25T09:19:36.000Z",
    "address": [],
    "cart": []
  },
  {
    "iduser": 20,
    "fullname": "raze mulo",
    "gender": "Male",
    "age": 17,
    "username": "razemulo",
    "email": "razemulo@mail.com",
    "role": "admin",
    "status": "verified",
    "profile_image": "",
    "otp": "kaovl2",
    "created_at": "2021-07-22T04:21:43.000Z",
    "updated_at": "2021-07-26T02:35:15.000Z",
    "address": [],
    "cart": []
  }
]
```

## Forget Password
API to send email reset password link    

- Method: ``POST``  
- Path: ``/user/forget-pass``  
- Request: Request Body  

```json
{
 "email": "user_email@mail.com"
}
```  

Respon Success:  
```json
{
 "status": 200,
 "messages": "Password reset link sent to your email!", 
 "verifyEmail": true
}
```  
Respon Error:  
```json
{
 "status": 404,
 "messages": "Email not found. Make sure your email is registered!",
 "verifyEmail": false
}
```

## Reset Password
Reset user password    

- Method: ``POST``  
- Path: ``/user/reset-pass``  
- Token: Required  
- Requst: Request Body

Respon Succes:  
```json
{ "status": 200, "messages": "Reset password success" }
```

Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
```
  
## Get Address
API to get user's address    

- Method: ``GET``  
- PATH : ``/user/get-address``  
- Desc :Inserting data into delivery status table, add delivery status, re-inserting to delivery table and updateing data, changing idstatus attribute.  
- 
Response Succcess:  
``` json
[
    {
        "id": 6,
        "tag": "Upin House",
        "recipient": "Upin ",
        "id_city_origin": 42,
        "iduser": 4,
        "name": "Banyuwangi",
        "address": "Komplek perumahan blok 19 no 51",
        "postal_code": 40511,
        "set_default": 2
    },
    {
        "id": 20,
        "tag": "Raze House",
        "recipient": "Raze Mulo",
        "id_city_origin": 151,
        "iduser": 20,
        "name": "Jakarta Barat",
        "address": "Komplek perumahan satchel blok 19 no 5",
        "postal_code": 40521,
        "set_default": 2
    },
    {
        "id": 25,
        "tag": "Rumah",
        "recipient": "Allysa",
        "id_city_origin": 107,
        "iduser": 22,
        "name": "Cimahi",
        "address": "Komplek Nusa Cisangkan Permai",
        "postal_code": 40526,
        "set_default": 2
    },
    {
        "id": 31,
        "tag": "Rumah Ucup",
        "recipient": "Ucup sanusi",
        "id_city_origin": 151,
        "iduser": 24,
        "name": "Jakarta Barat",
        "address": "Komplek pegangsaan timur no 118",
        "postal_code": 40413,
        "set_default": 1
    }
]
```

## Post Address
User can add new address    

- Method: ``POST``  
- Path: ``/ user/post-address``  
- Request : Request Body  
- Token: Required   
  
```json
{
    "tag": "Rakha House",
    "recipient": "Mochamad Rakha",
    "origin": 55,
    "postalCode": 40611,
    "address": "Komplek ujung berung indah blok 16 no 2",
    "iduser":3
    "token":
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
}
```  
Response Success: 
``` json
[
  {
    "message": "Success added new address"
  }
]
```  

## Patch Address
Edit user's address    

- Method: ``PATCH``  
- Path: /user/patch-address  
- Request : Request Body  

```json
{
    "idaddress":2,
    "tag": "Rakha House",
    "recipient": "Mochamad Rakha",
    "origin": 55,
    "postalCode": 40611,
    "address": "Komplek ujung berung indah blok 16 no 2",
    "token":
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
}
```
  
Respon Success :  
```json
[
  {
    "message": "Success edit address"
  }
]

```

## Delete Address
User can delete address    

- Method: ``DELETE``  
- Path: ``/user/delete-address?id=1``  
- Token: Required  
- Request: request body  

  ```json
  {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
  }
  ```

Response Success :  
```json
{
  "message": "Success delete selected address"
}
```

## Get History Transaction
Get user's transactions history    
 
- Method: ``GET``  
- Path: ``/user/sort-transactions?id_transaction_status=1``  
- Token: Required  
- Request : Request body  
  
```json
  {
   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
 }
```  
Response Success:  
```json
  [
    {
        "id": 106,
        "idtype": 1,
        "fullname": "Mochamad Rakha",
        "iduser": 16,
        "invoice": "PRM#CLICK1628592058265",
        "origin": "Bandung",
        "destination": "Bangka",
        "recipient": "Rakha Luthfi",
        "address": "Komplek Perumahan Ga tau blok berapa",
        "postal_code": 40513,
        "shipping_cost": 38000,
        "status_name": "onprogress",
        "total_price": 58000,
        "note": "",
        "img_order_url": null,
        "id_city_origin": 22,
        "id_city_destination": 27,
        "expedition": null,
        "service": null
    },
    {
        "id": 109,
        "idtype": 2,
        "fullname": "Mochamad Rakha",
        "iduser": 16,
        "invoice": "PRM#CLICK1628592351103",
        "origin": "Bandung",
        "destination": "Bangka",
        "recipient": "Rakha Luthfi",
        "address": "Komplek Perumahan Ga tau blok berapa",
        "postal_code": 40513,
        "shipping_cost": 42000,
        "status_name": "onprogress",
        "total_price": 285820,
        "note": "cek",
        "img_order_url": "perscription/IMG1628592351121.jpg",
        "id_city_origin": 22,
        "id_city_destination": 27,
        "expedition": "JNE",
        "service": "1"
    }
]
```

## Get Transaction Detail
Get detail of user's transactions    

- Method: ``GET``  
- Path: ``/user/detail-transactions/109``  

Response Success:  
```json
[
    {
        "id": 35,
        "idproduct": 43,
        "idtype": 2,
        "qty": 19,
        "total_netto": 461,
        "unit_price": 280,
        "idstatus": 1,
        "iduser": 16,
        "id_transaction_status": 1,
        "invoice": "PRM#CLICK1628592351103",
        "id_city_origin": 22,
        "id_city_destination": 27,
        "address": "Komplek Perumahan Ga tau blok berapa",
        "recipient": "Rakha Luthfi",
        "postal_code": 40513,
        "expedition": "JNE",
        "service": "1",
        "shipping_cost": 42000,
        "total_price": 285820,
        "note": "cek",
        "img_order_url": "perscription/IMG1628592351121.jpg",
        "created_at": "2021-08-10T10:47:55.000Z",
        "update_at": null,
        "review": "0",
        "product_name": "Captopril 25 mg 10 Tablet",
        "brand": "Generic Manufacturer",
        "idcategory": 7,
        "description": "Captopril 25 mg 10 Tablet adalah obat antihipertensi yang termasuk golongan ACE inhibitor. Obat ini bekerja dengan menghambat perubahan angiotensin 1 menjadi angiotensin 2 sehingga terjadi vasodilatasi dan penurunan sekresi aldosteron. Vasodilatasi secara langsung akan menurunkan tekanan darah sedangkan berkurangnya aldosteron akan emnyebabkan ekskresi air dan natrium dan retensi kalium. Dalam menggunakan obat ini HARUS SESUAI DENGAN PETUNJUK DOKTER.",
        "effect": "Pruritus. +Gangguan indera pengcapan. +Gangguan proteinuria. +Meningkatnya nilai nitrogen urea darah dan kreatinin. +Neutropenia.",
        "usage": "Diminum saat perut kosong, 1 jam sebelum makan atau 2 jam setelah makan.",
        "dosage": " Awal : 3 kali sehari 12.5 mg. Ditingkatkan menjadi 25-50 mg 2-3 hari. Hipertensi berat: s/d 450 mg/hari. kategori kehamilan: D",
        "indication": "Hipertensi, Gagal jantung pasien dengan tekanan darah normal",
        "netto": 25,
        "pack_price": 7000,
        "unit": "mg",
        "updated_at": "2021-08-10T10:47:55.000Z",
        "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/2e42f9a1-89c1-4122-b2fb-8405edb22e1b_product_image_url.webp",
        "qty_buy": 1,
        "qty_buy_total_netto": 13,
        "transaction_detail_netto": 25
    },
    {
        "id": 39,
        "idproduct": 47,
        "idtype": 2,
        "qty": 16,
        "total_netto": 80,
        "unit_price": 16000,
        "idstatus": 1,
        "iduser": 16,
        "id_transaction_status": 1,
        "invoice": "PRM#CLICK1628592351103",
        "id_city_origin": 22,
        "id_city_destination": 27,
        "address": "Komplek Perumahan Ga tau blok berapa",
        "recipient": "Rakha Luthfi",
        "postal_code": 40513,
        "expedition": "JNE",
        "service": "1",
        "shipping_cost": 42000,
        "total_price": 285820,
        "note": "cek",
        "img_order_url": "perscription/IMG1628592351121.jpg",
        "created_at": "2021-08-10T10:47:55.000Z",
        "update_at": null,
        "review": "0",
        "product_name": "Recolfar 0.5 mg 10 Tablet",
        "brand": "Pratapa Nirmala",
        "idcategory": 8,
        "description": "Recolfar 0.5 mg 10 Tablet adalah obat yang mengandung Colchicine yang digunakan untuk mencegah dan mengatasi serangan gout (gejala asam urat). Terutama untuk gejala gout yang muncul mendadak dan menyebabkan rasa sakit yang intens yang biasanya hanya melibatkan satu atau beberapa sendi jari kaki, lutut atau pergelangan kaki. Cara kerja obat ini belum diketahui secara pasti, namun obat ini diangap dapat mengganggu siklus kristal monosodium urate pada jaringan sendi serta menghambat proses peradangan yang jadi penyebab serangan akut gout. Colchicine juga bekerja menghambat laju pembentukan sel darah putih disekitar area yang meradang sehingga memutus siklus radang serta menghambat deposisi kristal asam urat.",
        "effect": "Neuritis perifer. +Kelelahan otot. +Mual. +Muntah. +Nyeri abdomen. +Diare. +Ertikaria. +Anemia aplastik. +Agranulositosis. +Dermatitis. +Purpura. +Alopesia",
        "usage": "Sesudah makan",
        "dosage": "rtritis gout akut awal : 0.5 - 1.2 mg diikuti dengan 0.5 mg tiap 2 jam sampai nyeri mereda atau timbul mual, muntah atau diare. Dosis rata-rata : 4 - 8 mg. Profilaksis jangka pendek selama awal terapi dengan alopurinol dan obat urikosurik : 0.5 mg 1 kali seminggu atau samapai dengan 1 kali sehari",
        "indication": "Arthritis Gout Akut, profilaksis jangka pendek selama terapi awal dengan Alopurinol dan obat2 Urikosurik",
        "netto": 5,
        "pack_price": 80000,
        "unit": "g",
        "updated_at": "2021-08-10T10:47:55.000Z",
        "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/5d767cad-1c1f-46b6-ada9-ccc5536c6434_product_image_url.webp",
        "qty_buy": 3,
        "qty_buy_total_netto": 15,
        "transaction_detail_netto": 5
    }
]
```

## Upload Transaction
User can upload transaction proof    

- Method: ``POST``  
- Path: ``/user/uploadTransaction``  
- Request: Request body  

```json
{
       "idtransaction" : 4,
        "id_transaction_status": 5,
       " weight": 1000,
       " images": [
  {
    "fieldname": "images",
    "originalname": "bukti.jpg",
    "encoding": "7bit",
    "mimetype": "image/jpeg",
    "destination": "./public/transactions",
    "filename": "IMG1627549146289.jpeg",
    "path": "public\\ transactions \\IMG1627549146289.jpeg",
    "size": 107478
  }
],
       "token":
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
}

```

Response Success:  
```json
[
   {
     "message": "Success Upload Transaction Proof"
   }
]
```

## Patch User
User can edit profile    
- Method: ``POST``  
- Path: ``/user/patch-user``  
- Request: Request body  

```json
{
       "iduser": 16,
       " fullname" : "Mochamad Rakha Luthfi",
       "age": 23, 
       " phone_number" : 08112264420,
       "image_profile": [
  {
    "fieldname": "images",
    "originalname": "profil1.jpg",
    "encoding": "7bit",
    "mimetype": "image/jpeg",
    "destination": "./public/transactions",
    "filename":"IMGUSR16.jpeg",
    "path": "public\\ transactions \\ IMGUSR16.jpeg",
    "size": 107478
  }
],
       "token":
"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
}

```  
Response Success:  
```json
[
   {
     "message": "Success input profile"
   }
]
```

## Set Default
User can change main address    

- Method: ``PATCH``
- Path: ``/user/patch-user``
- Request: Request Body
  
```json
  {
       "iduser": 16,
       "idaddress" : 63,
       "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHVzZXIiOjE2LCJmdWxsbmFtZSI6Ik1vY2hhbWFkIFJha2hhIiwiZ2VuZGVyIjoiTWFsZSIsImFnZSI6MjIsInVzZXJuYW1lIjoibXJha2hhbGYiLCJlbWFpbCI6Im1vY2hhbWFkcmFraGFAZ21haWwuY29tIiwicm9sZSI6InVzZXIiLCJzdGF0dXMiOiJ2ZXJpZmllZCIsInByb2ZpbGVfaW1hZ2UiOiJwcm9maWxlcy9JTUdVU1IxNi5qcGVnIiwib3RwIjoia3lkMjJzIiwiaWF0IjoxNjI4NzIyNzY2LCJleHAiOjE2Mjg3NjU5NjZ9.lSg3ME0SUL0LeXA-9dOZG5yjSvMNNMVpkGvDmob99O4"
}
```  
Respon Success:  
```json
[
   {
     "message": "Success change default address"
   }
]
```  

## Get City
Get list of all cities    

- Method: ``GET``
- Path: ``/user/get-city``  

Response Success:  
```json
[
    {
        "id": 1,
        "name": "Aceh Barat"
    },
    {
        "id": 2,
        "name": "Aceh Barat Daya"
    },
    {
        "id": 3,
        "name": "Aceh Besar"
    },
    {
        "id": 4,
        "name": "Aceh Jaya"
    },
    {
        "id": 5,
        "name": "Aceh Selatan"
    },
    {
        "id": 6,
        "name": "Aceh Singkil"
    },
    {
        "id": 7,
        "name": "Aceh Tamiang"
    },
    {
        "id": 8,
        "name": "Aceh Tengah"
    },
    {
        "id": 9,
        "name": "Aceh Tenggara"
    },
    {
        "id": 10,
        "name": "Aceh Timur"
    },
    {
        "id": 11,
        "name": "Aceh Utara"
    },
    {
        "id": 12,
        "name": "Agam"
    },
    {
        "id": 13,
        "name": "Alor"
    },
    {
        "id": 14,
        "name": "Ambon"
    },
    {
        "id": 15,
        "name": "Asahan"
    },
    {
        "id": 16,
        "name": "Asmat"
    },
    {
        "id": 17,
        "name": "Badung"
    },
    {
        "id": 18,
        "name": "Balangan"
    },
    {
        "id": 19,
        "name": "Balikpapan"
    },
    {
        "id": 20,
        "name": "Banda Aceh"
    },
    {
        "id": 21,
        "name": "Bandar Lampung"
    },
    {
        "id": 22,
        "name": "Bandung"
    },
    {
        "id": 23,
        "name": "Bandung"
    },
    {
        "id": 24,
        "name": "Bandung Barat"
    },
    {
        "id": 25,
        "name": "Banggai"
    },
    {
        "id": 26,
        "name": "Banggai Kepulauan"
    },
    {
        "id": 27,
        "name": "Bangka"
    },
    {
        "id": 28,
        "name": "Bangka Barat"
    },
    {
        "id": 29,
        "name": "Bangka Selatan"
    },
    {
        "id": 30,
        "name": "Bangka Tengah"
    },
    {
        "id": 31,
        "name": "Bangkalan"
    },
    {
        "id": 32,
        "name": "Bangli"
    },
    {
        "id": 33,
        "name": "Banjar"
    },
    {
        "id": 34,
        "name": "Banjar"
    },
    {
        "id": 35,
        "name": "Banjarbaru"
    },
    {
        "id": 36,
        "name": "Banjarmasin"
    },
    {
        "id": 37,
        "name": "Banjarnegara"
    },
    {
        "id": 38,
        "name": "Bantaeng"
    },
    {
        "id": 39,
        "name": "Bantul"
    },
    {
        "id": 40,
        "name": "Banyuasin"
    },
    {
        "id": 41,
        "name": "Banyumas"
    },
    {
        "id": 42,
        "name": "Banyuwangi"
    },
    {
        "id": 43,
        "name": "Barito Kuala"
    },
    {
        "id": 44,
        "name": "Barito Selatan"
    },
    {
        "id": 45,
        "name": "Barito Timur"
    },
    {
        "id": 46,
        "name": "Barito Utara"
    },
    {
        "id": 47,
        "name": "Barru"
    },
    {
        "id": 48,
        "name": "Batam"
    },
    {
        "id": 49,
        "name": "Batang"
    },
    {
        "id": 50,
        "name": "Batang Hari"
    },
    {
        "id": 51,
        "name": "Batu"
    },
    {
        "id": 52,
        "name": "Batu Bara"
    },
    {
        "id": 53,
        "name": "Bau-Bau"
    },
    {
        "id": 54,
        "name": "Bekasi"
    },
    {
        "id": 55,
        "name": "Bekasi"
    },
    {
        "id": 56,
        "name": "Belitung"
    },
    {
        "id": 57,
        "name": "Belitung Timur"
    },
    {
        "id": 58,
        "name": "Belu"
    },
    {
        "id": 59,
        "name": "Bener Meriah"
    },
    {
        "id": 60,
        "name": "Bengkalis"
    },
    {
        "id": 61,
        "name": "Bengkayang"
    },
    {
        "id": 62,
        "name": "Bengkulu"
    },
    {
        "id": 63,
        "name": "Bengkulu Selatan"
    },
    {
        "id": 64,
        "name": "Bengkulu Tengah"
    },
    {
        "id": 65,
        "name": "Bengkulu Utara"
    },
    {
        "id": 66,
        "name": "Berau"
    },
    {
        "id": 67,
        "name": "Biak Numfor"
    },
    {
        "id": 68,
        "name": "Bima"
    },
    {
        "id": 69,
        "name": "Bima"
    },
    {
        "id": 70,
        "name": "Binjai"
    },
    {
        "id": 71,
        "name": "Bintan"
    },
    {
        "id": 72,
        "name": "Bireuen"
    },
    {
        "id": 73,
        "name": "Bitung"
    },
    {
        "id": 74,
        "name": "Blitar"
    },
    {
        "id": 75,
        "name": "Blitar"
    },
    {
        "id": 76,
        "name": "Blora"
    },
    {
        "id": 77,
        "name": "Boalemo"
    },
    {
        "id": 78,
        "name": "Bogor"
    },
    {
        "id": 79,
        "name": "Bogor"
    },
    {
        "id": 80,
        "name": "Bojonegoro"
    },
    {
        "id": 81,
        "name": "Bolaang Mongondow (Bolmong)"
    },
    {
        "id": 82,
        "name": "Bolaang Mongondow Selatan"
    },
    {
        "id": 83,
        "name": "Bolaang Mongondow Timur"
    },
    {
        "id": 84,
        "name": "Bolaang Mongondow Utara"
    },
    {
        "id": 85,
        "name": "Bombana"
    },
    {
        "id": 86,
        "name": "Bondowoso"
    },
    {
        "id": 87,
        "name": "Bone"
    },
    {
        "id": 88,
        "name": "Bone Bolango"
    },
    {
        "id": 89,
        "name": "Bontang"
    },
    {
        "id": 90,
        "name": "Boven Digoel"
    },
    {
        "id": 91,
        "name": "Boyolali"
    },
    {
        "id": 92,
        "name": "Brebes"
    },
    {
        "id": 93,
        "name": "Bukittinggi"
    },
    {
        "id": 94,
        "name": "Buleleng"
    },
    {
        "id": 95,
        "name": "Bulukumba"
    },
    {
        "id": 96,
        "name": "Bulungan (Bulongan)"
    },
    {
        "id": 97,
        "name": "Bungo"
    },
    {
        "id": 98,
        "name": "Buol"
    },
    {
        "id": 99,
        "name": "Buru"
    },
    {
        "id": 100,
        "name": "Buru Selatan"
    },
    {
        "id": 101,
        "name": "Buton"
    },
    {
        "id": 102,
        "name": "Buton Utara"
    },
    {
        "id": 103,
        "name": "Ciamis"
    },
    {
        "id": 104,
        "name": "Cianjur"
    },
    {
        "id": 105,
        "name": "Cilacap"
    },
    {
        "id": 106,
        "name": "Cilegon"
    },
    {
        "id": 107,
        "name": "Cimahi"
    },
    {
        "id": 108,
        "name": "Cirebon"
    },
    {
        "id": 109,
        "name": "Cirebon"
    },
    {
        "id": 110,
        "name": "Dairi"
    },
    {
        "id": 111,
        "name": "Deiyai (Deliyai)"
    },
    {
        "id": 112,
        "name": "Deli Serdang"
    },
    {
        "id": 113,
        "name": "Demak"
    },
    {
        "id": 114,
        "name": "Denpasar"
    },
    {
        "id": 115,
        "name": "Depok"
    },
    {
        "id": 116,
        "name": "Dharmasraya"
    },
    {
        "id": 117,
        "name": "Dogiyai"
    },
    {
        "id": 118,
        "name": "Dompu"
    },
    {
        "id": 119,
        "name": "Donggala"
    },
    {
        "id": 120,
        "name": "Dumai"
    },
    {
        "id": 121,
        "name": "Empat Lawang"
    },
    {
        "id": 122,
        "name": "Ende"
    },
    {
        "id": 123,
        "name": "Enrekang"
    },
    {
        "id": 124,
        "name": "Fakfak"
    },
    {
        "id": 125,
        "name": "Flores Timur"
    },
    {
        "id": 126,
        "name": "Garut"
    },
    {
        "id": 127,
        "name": "Gayo Lues"
    },
    {
        "id": 128,
        "name": "Gianyar"
    },
    {
        "id": 129,
        "name": "Gorontalo"
    },
    {
        "id": 130,
        "name": "Gorontalo"
    },
    {
        "id": 131,
        "name": "Gorontalo Utara"
    },
    {
        "id": 132,
        "name": "Gowa"
    },
    {
        "id": 133,
        "name": "Gresik"
    },
    {
        "id": 134,
        "name": "Grobogan"
    },
    {
        "id": 135,
        "name": "Gunung Kidul"
    },
    {
        "id": 136,
        "name": "Gunung Mas"
    },
    {
        "id": 137,
        "name": "Gunungsitoli"
    },
    {
        "id": 138,
        "name": "Halmahera Barat"
    },
    {
        "id": 139,
        "name": "Halmahera Selatan"
    },
    {
        "id": 140,
        "name": "Halmahera Tengah"
    },
    {
        "id": 141,
        "name": "Halmahera Timur"
    },
    {
        "id": 142,
        "name": "Halmahera Utara"
    },
    {
        "id": 143,
        "name": "Hulu Sungai Selatan"
    },
    {
        "id": 144,
        "name": "Hulu Sungai Tengah"
    },
    {
        "id": 145,
        "name": "Hulu Sungai Utara"
    },
    {
        "id": 146,
        "name": "Humbang Hasundutan"
    },
    {
        "id": 147,
        "name": "Indragiri Hilir"
    },
    {
        "id": 148,
        "name": "Indragiri Hulu"
    },
    {
        "id": 149,
        "name": "Indramayu"
    },
    {
        "id": 150,
        "name": "Intan Jaya"
    },
    {
        "id": 151,
        "name": "Jakarta Barat"
    },
    {
        "id": 152,
        "name": "Jakarta Pusat"
    },
    {
        "id": 153,
        "name": "Jakarta Selatan"
    },
    {
        "id": 154,
        "name": "Jakarta Timur"
    },
    {
        "id": 155,
        "name": "Jakarta Utara"
    },
    {
        "id": 156,
        "name": "Jambi"
    },
    {
        "id": 157,
        "name": "Jayapura"
    },
    {
        "id": 158,
        "name": "Jayapura"
    },
    {
        "id": 159,
        "name": "Jayawijaya"
    },
    {
        "id": 160,
        "name": "Jember"
    },
    {
        "id": 161,
        "name": "Jembrana"
    },
    {
        "id": 162,
        "name": "Jeneponto"
    },
    {
        "id": 163,
        "name": "Jepara"
    },
    {
        "id": 164,
        "name": "Jombang"
    },
    {
        "id": 165,
        "name": "Kaimana"
    },
    {
        "id": 166,
        "name": "Kampar"
    },
    {
        "id": 167,
        "name": "Kapuas"
    },
    {
        "id": 168,
        "name": "Kapuas Hulu"
    },
    {
        "id": 169,
        "name": "Karanganyar"
    },
    {
        "id": 170,
        "name": "Karangasem"
    },
    {
        "id": 171,
        "name": "Karawang"
    },
    {
        "id": 172,
        "name": "Karimun"
    },
    {
        "id": 173,
        "name": "Karo"
    },
    {
        "id": 174,
        "name": "Katingan"
    },
    {
        "id": 175,
        "name": "Kaur"
    },
    {
        "id": 176,
        "name": "Kayong Utara"
    },
    {
        "id": 177,
        "name": "Kebumen"
    },
    {
        "id": 178,
        "name": "Kediri"
    },
    {
        "id": 179,
        "name": "Kediri"
    },
    {
        "id": 180,
        "name": "Keerom"
    },
    {
        "id": 181,
        "name": "Kendal"
    },
    {
        "id": 182,
        "name": "Kendari"
    },
    {
        "id": 183,
        "name": "Kepahiang"
    },
    {
        "id": 184,
        "name": "Kepulauan Anambas"
    },
    {
        "id": 185,
        "name": "Kepulauan Aru"
    },
    {
        "id": 186,
        "name": "Kepulauan Mentawai"
    },
    {
        "id": 187,
        "name": "Kepulauan Meranti"
    },
    {
        "id": 188,
        "name": "Kepulauan Sangihe"
    },
    {
        "id": 189,
        "name": "Kepulauan Seribu"
    },
    {
        "id": 190,
        "name": "Kepulauan Siau Tagulandang Biaro (Sitaro)"
    },
    {
        "id": 191,
        "name": "Kepulauan Sula"
    },
    {
        "id": 192,
        "name": "Kepulauan Talaud"
    },
    {
        "id": 193,
        "name": "Kepulauan Yapen (Yapen Waropen)"
    },
    {
        "id": 194,
        "name": "Kerinci"
    },
    {
        "id": 195,
        "name": "Ketapang"
    },
    {
        "id": 196,
        "name": "Klaten"
    },
    {
        "id": 197,
        "name": "Klungkung"
    },
    {
        "id": 198,
        "name": "Kolaka"
    },
    {
        "id": 199,
        "name": "Kolaka Utara"
    },
    {
        "id": 200,
        "name": "Konawe"
    },
    {
        "id": 201,
        "name": "Konawe Selatan"
    },
    {
        "id": 202,
        "name": "Konawe Utara"
    },
    {
        "id": 203,
        "name": "Kotabaru"
    },
    {
        "id": 204,
        "name": "Kotamobagu"
    },
    {
        "id": 205,
        "name": "Kotawaringin Barat"
    },
    {
        "id": 206,
        "name": "Kotawaringin Timur"
    },
    {
        "id": 207,
        "name": "Kuantan Singingi"
    },
    {
        "id": 208,
        "name": "Kubu Raya"
    },
    {
        "id": 209,
        "name": "Kudus"
    },
    {
        "id": 210,
        "name": "Kulon Progo"
    },
    {
        "id": 211,
        "name": "Kuningan"
    },
    {
        "id": 212,
        "name": "Kupang"
    },
    {
        "id": 213,
        "name": "Kupang"
    },
    {
        "id": 214,
        "name": "Kutai Barat"
    },
    {
        "id": 215,
        "name": "Kutai Kartanegara"
    },
    {
        "id": 216,
        "name": "Kutai Timur"
    },
    {
        "id": 217,
        "name": "Labuhan Batu"
    },
    {
        "id": 218,
        "name": "Labuhan Batu Selatan"
    },
    {
        "id": 219,
        "name": "Labuhan Batu Utara"
    },
    {
        "id": 220,
        "name": "Lahat"
    },
    {
        "id": 221,
        "name": "Lamandau"
    },
    {
        "id": 222,
        "name": "Lamongan"
    },
    {
        "id": 223,
        "name": "Lampung Barat"
    },
    {
        "id": 224,
        "name": "Lampung Selatan"
    },
    {
        "id": 225,
        "name": "Lampung Tengah"
    },
    {
        "id": 226,
        "name": "Lampung Timur"
    },
    {
        "id": 227,
        "name": "Lampung Utara"
    },
    {
        "id": 228,
        "name": "Landak"
    },
    {
        "id": 229,
        "name": "Langkat"
    },
    {
        "id": 230,
        "name": "Langsa"
    },
    {
        "id": 231,
        "name": "Lanny Jaya"
    },
    {
        "id": 232,
        "name": "Lebak"
    },
    {
        "id": 233,
        "name": "Lebong"
    },
    {
        "id": 234,
        "name": "Lembata"
    },
    {
        "id": 235,
        "name": "Lhokseumawe"
    },
    {
        "id": 236,
        "name": "Lima Puluh Koto/Kota"
    },
    {
        "id": 237,
        "name": "Lingga"
    },
    {
        "id": 238,
        "name": "Lombok Barat"
    },
    {
        "id": 239,
        "name": "Lombok Tengah"
    },
    {
        "id": 240,
        "name": "Lombok Timur"
    },
    {
        "id": 241,
        "name": "Lombok Utara"
    },
    {
        "id": 242,
        "name": "Lubuk Linggau"
    },
    {
        "id": 243,
        "name": "Lumajang"
    },
    {
        "id": 244,
        "name": "Luwu"
    },
    {
        "id": 245,
        "name": "Luwu Timur"
    },
    {
        "id": 246,
        "name": "Luwu Utara"
    },
    {
        "id": 247,
        "name": "Madiun"
    },
    {
        "id": 248,
        "name": "Madiun"
    },
    {
        "id": 249,
        "name": "Magelang"
    },
    {
        "id": 250,
        "name": "Magelang"
    },
    {
        "id": 251,
        "name": "Magetan"
    },
    {
        "id": 252,
        "name": "Majalengka"
    },
    {
        "id": 253,
        "name": "Majene"
    },
    {
        "id": 254,
        "name": "Makassar"
    },
    {
        "id": 255,
        "name": "Malang"
    },
    {
        "id": 256,
        "name": "Malang"
    },
    {
        "id": 257,
        "name": "Malinau"
    },
    {
        "id": 258,
        "name": "Maluku Barat Daya"
    },
    {
        "id": 259,
        "name": "Maluku Tengah"
    },
    {
        "id": 260,
        "name": "Maluku Tenggara"
    },
    {
        "id": 261,
        "name": "Maluku Tenggara Barat"
    },
    {
        "id": 262,
        "name": "Mamasa"
    },
    {
        "id": 263,
        "name": "Mamberamo Raya"
    },
    {
        "id": 264,
        "name": "Mamberamo Tengah"
    },
    {
        "id": 265,
        "name": "Mamuju"
    },
    {
        "id": 266,
        "name": "Mamuju Utara"
    },
    {
        "id": 267,
        "name": "Manado"
    },
    {
        "id": 268,
        "name": "Mandailing Natal"
    },
    {
        "id": 269,
        "name": "Manggarai"
    },
    {
        "id": 270,
        "name": "Manggarai Barat"
    },
    {
        "id": 271,
        "name": "Manggarai Timur"
    },
    {
        "id": 272,
        "name": "Manokwari"
    },
    {
        "id": 273,
        "name": "Manokwari Selatan"
    },
    {
        "id": 274,
        "name": "Mappi"
    },
    {
        "id": 275,
        "name": "Maros"
    },
    {
        "id": 276,
        "name": "Mataram"
    },
    {
        "id": 277,
        "name": "Maybrat"
    },
    {
        "id": 278,
        "name": "Medan"
    },
    {
        "id": 279,
        "name": "Melawi"
    },
    {
        "id": 280,
        "name": "Merangin"
    },
    {
        "id": 281,
        "name": "Merauke"
    },
    {
        "id": 282,
        "name": "Mesuji"
    },
    {
        "id": 283,
        "name": "Metro"
    },
    {
        "id": 284,
        "name": "Mimika"
    },
    {
        "id": 285,
        "name": "Minahasa"
    },
    {
        "id": 286,
        "name": "Minahasa Selatan"
    },
    {
        "id": 287,
        "name": "Minahasa Tenggara"
    },
    {
        "id": 288,
        "name": "Minahasa Utara"
    },
    {
        "id": 289,
        "name": "Mojokerto"
    },
    {
        "id": 290,
        "name": "Mojokerto"
    },
    {
        "id": 291,
        "name": "Morowali"
    },
    {
        "id": 292,
        "name": "Muara Enim"
    },
    {
        "id": 293,
        "name": "Muaro Jambi"
    },
    {
        "id": 294,
        "name": "Muko Muko"
    },
    {
        "id": 295,
        "name": "Muna"
    },
    {
        "id": 296,
        "name": "Murung Raya"
    },
    {
        "id": 297,
        "name": "Musi Banyuasin"
    },
    {
        "id": 298,
        "name": "Musi Rawas"
    },
    {
        "id": 299,
        "name": "Nabire"
    },
    {
        "id": 300,
        "name": "Nagan Raya"
    },
    {
        "id": 301,
        "name": "Nagekeo"
    },
    {
        "id": 302,
        "name": "Natuna"
    },
    {
        "id": 303,
        "name": "Nduga"
    },
    {
        "id": 304,
        "name": "Ngada"
    },
    {
        "id": 305,
        "name": "Nganjuk"
    },
    {
        "id": 306,
        "name": "Ngawi"
    },
    {
        "id": 307,
        "name": "Nias"
    },
    {
        "id": 308,
        "name": "Nias Barat"
    },
    {
        "id": 309,
        "name": "Nias Selatan"
    },
    {
        "id": 310,
        "name": "Nias Utara"
    },
    {
        "id": 311,
        "name": "Nunukan"
    },
    {
        "id": 312,
        "name": "Ogan Ilir"
    },
    {
        "id": 313,
        "name": "Ogan Komering Ilir"
    },
    {
        "id": 314,
        "name": "Ogan Komering Ulu"
    },
    {
        "id": 315,
        "name": "Ogan Komering Ulu Selatan"
    },
    {
        "id": 316,
        "name": "Ogan Komering Ulu Timur"
    },
    {
        "id": 317,
        "name": "Pacitan"
    },
    {
        "id": 318,
        "name": "Padang"
    },
    {
        "id": 319,
        "name": "Padang Lawas"
    },
    {
        "id": 320,
        "name": "Padang Lawas Utara"
    },
    {
        "id": 321,
        "name": "Padang Panjang"
    },
    {
        "id": 322,
        "name": "Padang Pariaman"
    },
    {
        "id": 323,
        "name": "Padang Sidempuan"
    },
    {
        "id": 324,
        "name": "Pagar Alam"
    },
    {
        "id": 325,
        "name": "Pakpak Bharat"
    },
    {
        "id": 326,
        "name": "Palangka Raya"
    },
    {
        "id": 327,
        "name": "Palembang"
    },
    {
        "id": 328,
        "name": "Palopo"
    },
    {
        "id": 329,
        "name": "Palu"
    },
    {
        "id": 330,
        "name": "Pamekasan"
    },
    {
        "id": 331,
        "name": "Pandeglang"
    },
    {
        "id": 332,
        "name": "Pangandaran"
    },
    {
        "id": 333,
        "name": "Pangkajene Kepulauan"
    },
    {
        "id": 334,
        "name": "Pangkal Pinang"
    },
    {
        "id": 335,
        "name": "Paniai"
    },
    {
        "id": 336,
        "name": "Parepare"
    },
    {
        "id": 337,
        "name": "Pariaman"
    },
    {
        "id": 338,
        "name": "Parigi Moutong"
    },
    {
        "id": 339,
        "name": "Pasaman"
    },
    {
        "id": 340,
        "name": "Pasaman Barat"
    },
    {
        "id": 341,
        "name": "Paser"
    },
    {
        "id": 342,
        "name": "Pasuruan"
    },
    {
        "id": 343,
        "name": "Pasuruan"
    },
    {
        "id": 344,
        "name": "Pati"
    },
    {
        "id": 345,
        "name": "Payakumbuh"
    },
    {
        "id": 346,
        "name": "Pegunungan Arfak"
    },
    {
        "id": 347,
        "name": "Pegunungan Bintang"
    },
    {
        "id": 348,
        "name": "Pekalongan"
    },
    {
        "id": 349,
        "name": "Pekalongan"
    },
    {
        "id": 350,
        "name": "Pekanbaru"
    },
    {
        "id": 351,
        "name": "Pelalawan"
    },
    {
        "id": 352,
        "name": "Pemalang"
    },
    {
        "id": 353,
        "name": "Pematang Siantar"
    },
    {
        "id": 354,
        "name": "Penajam Paser Utara"
    },
    {
        "id": 355,
        "name": "Pesawaran"
    },
    {
        "id": 356,
        "name": "Pesisir Barat"
    },
    {
        "id": 357,
        "name": "Pesisir Selatan"
    },
    {
        "id": 358,
        "name": "Pidie"
    },
    {
        "id": 359,
        "name": "Pidie Jaya"
    },
    {
        "id": 360,
        "name": "Pinrang"
    },
    {
        "id": 361,
        "name": "Pohuwato"
    },
    {
        "id": 362,
        "name": "Polewali Mandar"
    },
    {
        "id": 363,
        "name": "Ponorogo"
    },
    {
        "id": 364,
        "name": "Pontianak"
    },
    {
        "id": 365,
        "name": "Pontianak"
    },
    {
        "id": 366,
        "name": "Poso"
    },
    {
        "id": 367,
        "name": "Prabumulih"
    },
    {
        "id": 368,
        "name": "Pringsewu"
    },
    {
        "id": 369,
        "name": "Probolinggo"
    },
    {
        "id": 370,
        "name": "Probolinggo"
    },
    {
        "id": 371,
        "name": "Pulang Pisau"
    },
    {
        "id": 372,
        "name": "Pulau Morotai"
    },
    {
        "id": 373,
        "name": "Puncak"
    },
    {
        "id": 374,
        "name": "Puncak Jaya"
    },
    {
        "id": 375,
        "name": "Purbalingga"
    },
    {
        "id": 376,
        "name": "Purwakarta"
    },
    {
        "id": 377,
        "name": "Purworejo"
    },
    {
        "id": 378,
        "name": "Raja Ampat"
    },
    {
        "id": 379,
        "name": "Rejang Lebong"
    },
    {
        "id": 380,
        "name": "Rembang"
    },
    {
        "id": 381,
        "name": "Rokan Hilir"
    },
    {
        "id": 382,
        "name": "Rokan Hulu"
    },
    {
        "id": 383,
        "name": "Rote Ndao"
    },
    {
        "id": 384,
        "name": "Sabang"
    },
    {
        "id": 385,
        "name": "Sabu Raijua"
    },
    {
        "id": 386,
        "name": "Salatiga"
    },
    {
        "id": 387,
        "name": "Samarinda"
    },
    {
        "id": 388,
        "name": "Sambas"
    },
    {
        "id": 389,
        "name": "Samosir"
    },
    {
        "id": 390,
        "name": "Sampang"
    },
    {
        "id": 391,
        "name": "Sanggau"
    },
    {
        "id": 392,
        "name": "Sarmi"
    },
    {
        "id": 393,
        "name": "Sarolangun"
    },
    {
        "id": 394,
        "name": "Sawah Lunto"
    },
    {
        "id": 395,
        "name": "Sekadau"
    },
    {
        "id": 396,
        "name": "Selayar (Kepulauan Selayar)"
    },
    {
        "id": 397,
        "name": "Seluma"
    },
    {
        "id": 398,
        "name": "Semarang"
    },
    {
        "id": 399,
        "name": "Semarang"
    },
    {
        "id": 400,
        "name": "Seram Bagian Barat"
    }
]
```  

## Confirmation Payment
Get confirmation of transaction proof    

- Method: ``PATCH``
- Path: ``/user/confirmation-payment/102``  

Respon Success:  
```json
[
    {
        "id": 15,
        "idtransaction": 102,
        "id_transaction_status": 5,
        "image_url": "transactions/IMG1628588981132.jpg",
        "created_at": "2021-08-10T09:49:42.000Z",
        "updated_at": "2021-08-10T09:49:42.000Z"
    }
]
```

# 2. Product API
API to interac with products  

## Add Product
Add packed product    

- Method: ``POST``  
- Path: ``/product``  
- Token: Required  
- Request: Request Body (Form data)  

```json
{
 "product_name":"Betadine",
 "brand": "Mundipharma Healthcare Indonesia",
 "idcategory": "10",
 "description": "product description ... ",
 "effect": "Side effect of this product...",
 "usage": "How to use this product ...",
 "dosage": "Dosage to use this product ..",
 "indication": "Product indication..",
 "netto": 10,
 "pack_price": 10000,
 "unit": "ml",
 "stock": 10,
 "products": [
  {
    "fieldname": "products",
    "originalname": "products-pic.jpg",
    "encoding": "7bit",
    "mimetype": "image/jpeg",
    "destination": "./public/products",
    "filename": "IMG1627549146289.jpeg",
    "path": "public\\ products \\IMG1627549146289.jpeg",
    "size": 107478
  }
]
}
``` 
Respon Success:  
```json
{
 "status": 200,
 "messages": "Add product berhasil!"
}
```
  
Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
``` 
  
## Delete Product
Change product status to unavailable  

Method: ``DELETE``  
Path: ``/product``  
Token: Required  
Request: Request Body  
```json
{ "idstok": 1 }
```

Respon Success:  
```json
{
 "status": 200,
 "messages": "Product deleted!"
}
```
Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
```  

## Get Product
Get packed product list    

- Method: ``GET``  
- PATH: ``/product``  
- Token: Required  
- Request: Request Query, Request Params  

Request Params:  
```json 
{ "idtype": 1 }
```
1 = packed product  
2 = custom product   

Request Query :  
- Parameter: product_name, brand, category, price, sort  
- Value :  
 a. Range: use ``[and]``  
 Example: ``product?price=2000[and]10000``  
 b. Includes: use ``%charactershere%``  
 Example: ``product?product_name=%san%``  
 c. Sort: use ``key:order``  
 Order can be asc or desc, key can be parameter  
 Example: ``product?sort=product_name:asc``  

Respon Success:  
```json
[
  {
    "idproduct": 50,
    "product_name": "Acyclovir 5% Cream 5 g",
    "brand": "Generic Manufacturer",
    "category": "kulit",
    "description": "Acyclovir 5% Cream 5 g merupakan obat generik yang mengandung zat aktif Acyclovir. Krim ini digunakan untuk mengatasi infeksi herpes simpleks pada kulit dan selaput lendir yang biasanya berupa luka melepuh yang terjadi disekitar bibir atau wajah. Selain itu, obat ini juga digunakan untuk mengobati herpes genital dan labial awal serta rekuren. Acyclovir 5% Cream 5 g bekerja dengan menurunkan kemampuan virus dalam menggandakan diri, yaitu melalui penghambatan DNA polymerase dan replikasi DNA virus, sehingga mencegah pembentukan DNA virus tanpa mempengaruhi sel normal (sel tubuh).",
    "effect": "+Sensasi terbakar atau menyengat. +Ertitema atau kemerahan. +Kulit kering (ringan). +Peneglupasan kulit.",
    "usage": "Dioleskan pada area infeksi/yang sakit setelah kulit dibersihkan dan dikeringkan.",
    "dosage": "Oleskan 5 kali per hari tiap 4 jam tanpa dosis malam. Lanjutkan pengobatan setidaknya selama 5 hari, dalam beberapa kasus pengobatan dilanjutkan hingga 10 hari.",
    "indication": "Mengatasi infeksi herpes simpleks pada kulit dan selaput lendir, termasuk herpes genital dal labial awal serta rekuren.",
    "netto": 5,
    "pack_price": 15000,
    "unit": "g",
    "created_at": "2021-07-22T09:19:58.000Z",
    "updated_at": "2021-07-22T17:34:09.000Z",
    "stock": [
      {
        "id": 114,
        "idproduct": 50,
        "type": "pack",
        "qty": 20,
        "total_netto": 100,
        "unit_price": null,
        "status": "available"
      }
    ],
    "images": [
      "https://d2qjkwm11akmwu.cloudfront.net/products/99b5c214-4dfb-40fb-ba9c-569a1bac27cc_product_image_url.webp"
    ]
  },
  {
    "idproduct": 6,
    "product_name": "Ailin Tetes Mata 10 ml",
    "brand": "Erela",
    "category": "mata",
    "description": "Ailin tetes mata merupakan obat tetes mata yang mengandung zat aktif Tetrahidzolin HCL. Obat ini digunakan untuk mengatasi mata merah karena iritasi ringan yang disebabkan oleh debu, asap, cuaca dingin, pemakaian lensa kontak, terlalu lama bekerja dengan komputer atau iritasi saat berenang.",
    "effect": "Tidak ditemukan",
    "usage": "Teteskan pada mata kanan dan kiri atau pada mata yang sakit.",
    "dosage": "Teteskan 1-2 tetes pada masing-masing mata. Obat diteteskan 3-4 kali sehari, kecuali bila ada petunjuk dokter.",
    "indication": "Meredakan mata merah karena iritasi ringan.",
    "netto": 10,
    "pack_price": 34000,
    "unit": "ml",
    "created_at": "2021-07-22T09:19:58.000Z",
    "updated_at": "2021-07-22T17:34:08.000Z",
    "stock": [
      {
        "id": 6,
        "idproduct": 6,
        "type": "pack",
        "qty": 49,
        "total_netto": 490,
        "unit_price": null,
        "status": "available"
      }
    ],
    "images": [
      "http://erela.co.id/wp-content/uploads/2014/03/Ailin.jpg"
    ]
  }
]
```
Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
```

## Edit Product
Edit packed product    

- Method: ``GET``  
- PATH: ``/product``  
- Token: Required  
- Request: Request Body  
``` json
{
 "idproduct": 1,
 "product_name": "Edited Product",
 "brand": "Product Brand",
 "idcategory": 2,
 "description": "Desc",
 "effect": "Edited effect",
 "usage": "Edited usage",
 "dosage": "Edited dosage",
 "indication": "Edited indication",
 "netto": 30,
 "pack_price": 3000,
 "unit": "mg",
 "stock": 1000
 "products": [
  {
    "fieldname": "products",
    "originalname": "products-pic.jpg",
    "encoding": "7bit",
    "mimetype": "image/jpeg",
    "destination": "./public/products",
    "filename": "IMG1627549146289.jpeg",
    "path": "public\\ products \\IMG1627549146289.jpeg",
    "size": 107478
  }
]
}
```
Respon Success:  
```json
{ "status": 200, "messages": "Edit product berhasil!"}  
```

Respon Error:  
```json
{
 "status": 500,
 "messages": "error messages"
}
```  

## Add to Cart
Add new items into cart    

- Method: ``POST``  
- PATH: ``/product/add-to-cart``  
- Desc : User can make new address  
- Request: Request Body  

```json
{
    "iduser": 16,
    "idproduct": 2,
    "qty": 1,
    "total_netto": 4,
    "price": 20000,
    "product_name": "Sanmol Pereda Nyeri 4 Tablet"
}

```  
Response Success:  
```json
[
  {
    "message": " Success add to cart Sanmol Pereda Nyeri 4 Tablet" 
  }
]
```

## Add Custom Product
Add product for custom order inventory    

- Method: ``POST``
- Path: ``/product/custom``
- Desc : User can make new address  
- Request : Request Body
  
```json
  {
    "product_name": "Sanmol Pereda Nyeri 4 Tablet",
    "brand": "Sanbe Farma",
    "idcategory": 5,
    "desciption": "Sanmol Tablet diformulasikan khusus dengan parasetamol dan berkhasiat untuk meredakan demam yang disertai dengan nyeri seperti sakit kepala, nyeri di pundak, nyeri ringan pada persendian, sekaligus meredakan sakit gigi.",
    "effect": "Mual.+Muntah.+Feses berwarna gelap.+ruam.+Nyeri perut bagian atasa.+Tubuh merasa kelelahan.",
    "usage": "Dikonsumsi sebelum makan atau bersama dengan makanan.",
    "dosage": "Anak-anak usia 6 hingga 12 tahun: ½-1 tablet sebanyak 3 kali/hari, Dewasa atau anak diatas 12 tahun: 1 tablet sebanyak 3 kali/hari.",
    "indication": "Meredakan demam pada anak dan dewasa.+Meringankan nyeri sendi dan nyeri otot pada tubuh.+Meredakan sakit gigi dan sakit kepala.+Mengobati nyeri dan demam akibat flu.",
    "netto": 4,
    "pack_price": 20000,
    "unit": "tablet",
    "stock": [ { "idtype": 2, "qty": 50, "total_netto": 200, "idstatus": 1 } ]
}
```
  
Response Success:  
```json
[
  {
    "messages": "Add product berhasil!"
  }
]
```

## Edit Custom Product
Edit custom product inventory    

- Method: PATCH
- Path: /product/custom
- Desc : User bisa membuat alamat baru.
- Request : Request Body

``` json
{
    "product_name": "Sanmol Pereda Nyeri 4 Tablet",
    "brand": "Sanbe Farma",
    "idcategory": 5,
    "desciption": "Sanmol Tablet diformulasikan khusus dengan parasetamol dan berkhasiat untuk meredakan demam yang disertai dengan nyeri seperti sakit kepala, nyeri di pundak, nyeri ringan pada persendian, sekaligus meredakan sakit gigi.",
    "effect": "Mual.+Muntah.+Feses berwarna gelap.+ruam.+Nyeri perut bagian atasa.+Tubuh merasa kelelahan.",
    "usage": "Dikonsumsi sebelum makan atau bersama dengan makanan.",
    "dosage": "Anak-anak usia 6 hingga 12 tahun: ½-1 tablet sebanyak 3 kali/hari, Dewasa atau anak diatas 12 tahun: 1 tablet sebanyak 3 kali/hari.",
    "indication": "Meredakan demam pada anak dan dewasa.+Meringankan nyeri sendi dan nyeri otot pada tubuh.+Meredakan sakit gigi dan sakit kepala.+Mengobati nyeri dan demam akibat flu.",
    "netto": 4,
    "pack_price": 20000,
    "unit": "tablet",
    "stock": [ { "idtype": 2, "qty": 50, "total_netto": 200, "idstatus": 1 } ]
}

```

Response Success:  
```json
[
  {
    "messages": "Edit product berhasil!"
  }
]
```


## Get Reviews
Get product's review    

- Method: ``GET``  
- PATH: ``/product/review``  
- Token: Required  
- Request: Request query (Not required)  

```json
{ "idproduct": 1 }
```

Respon Success:  
```json
  {
    "idreview": 1,
    "iduser": 4,
    "fullname": "Upin Upin",
    "idproduct": 1,
    "review": "Obat ini baik sekali, karena saya bisa sembuh dengan cepat setelah mengkonsumsi obat ini.",
    "rating": "5",
    "created_at": "2021-07-21T18:00:18.000Z",
    "updated_at": "2021-07-22T01:00:18.000Z"
  },
  {
    "idreview": 2,
    "iduser": 5,
    "fullname": "Upin Upin",
    "idproduct": 1,
    "review": "Obatnya baik untuk saya dan anak, cocok sekali karena anak saya dan saya langsung sembuh dengan cepat.",
    "rating": "4",
    "created_at": "2021-07-21T18:00:18.000Z",
    "updated_at": "2021-07-22T01:00:18.000Z"
  },
  {
    "idreview": 3,
    "iduser": 6,
    "fullname": "Upin",
    "idproduct": 3,
    "review": "Keren obatnya manjur sekali pada saat saya gunakan, karena menurunkan panas dengan sangat cepat dibandingkan obat lain.",
    "rating": "5",
    "created_at": "2021-07-21T18:00:18.000Z",
    "updated_at": "2021-07-28T14:14:01.000Z"
  },
  {
    "idreview": 4,
    "iduser": 22,
    "fullname": "Allysa",
    "idproduct": 1,
    "review": "bagus banget",
    "rating": "4",
    "created_at": "2021-08-04T00:08:50.000Z",
    "updated_at": "2021-08-04T07:10:25.000Z"
  },
  {
    "idreview": 5,
    "iduser": 22,
    "fullname": "Allysa",
    "idproduct": 2,
    "review": "bagus aja sih",
    "rating": "4",
    "created_at": "2021-08-04T00:08:50.000Z",
    "updated_at": "2021-08-04T07:10:25.000Z"
  },
  {
    "idreview": 6,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 1,
    "review": "Bagus product ini",
    "rating": "4",
    "created_at": "2021-08-04T00:35:49.000Z",
    "updated_at": "2021-08-04T07:35:49.000Z"
  },
  {
    "idreview": 7,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 2,
    "review": "Kurang bagus untuk sakit kepala",
    "rating": "2",
    "created_at": "2021-08-04T00:35:49.000Z",
    "updated_at": "2021-08-04T07:35:49.000Z"
  },
  {
    "idreview": 8,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 1,
    "review": "Bagus banget",
    "rating": "4",
    "created_at": "2021-08-04T00:36:43.000Z",
    "updated_at": "2021-08-04T07:36:43.000Z"
  },
  {
    "idreview": 9,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 2,
    "review": "Kurang bagus",
    "rating": "2",
    "created_at": "2021-08-04T00:36:43.000Z",
    "updated_at": "2021-08-04T07:36:43.000Z"
  },
  {
    "idreview": 10,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 7,
    "review": "Salep matanya kurang ampuh",
    "rating": "3",
    "created_at": "2021-08-04T00:45:28.000Z",
    "updated_at": "2021-08-04T07:45:28.000Z"
  },
  {
    "idreview": 11,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 5,
    "review": "Anak saya langsung sembuh setelah minum ini",
    "rating": "5",
    "created_at": "2021-08-04T00:48:01.000Z",
    "updated_at": "2021-08-04T07:48:01.000Z"
  },
  {
    "idreview": 14,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 1,
    "review": "bagus banget",
    "rating": "3",
    "created_at": "2021-08-04T05:55:29.000Z",
    "updated_at": "2021-08-04T12:55:29.000Z"
  },
  {
    "idreview": 15,
    "iduser": 21,
    "fullname": "Renjun Huang",
    "idproduct": 2,
    "review": "sangat bagussdssds",
    "rating": "5",
    "created_at": "2021-08-04T05:55:29.000Z",
    "updated_at": "2021-08-04T12:55:29.000Z"
  },
  {
    "idreview": 16,
    "iduser": 32,
    "fullname": "Test Register 6",
    "idproduct": 10,
    "review": "bagus",
    "rating": "5",
    "created_at": "2021-08-11T21:04:49.000Z",
    "updated_at": "2021-08-11T21:04:49.000Z"
  },
  {
    "idreview": 17,
    "iduser": 32,
    "fullname": "Test Register 6",
    "idproduct": 10,
    "review": "bagus",
    "rating": "5",
    "created_at": "2021-08-11T21:04:58.000Z",
    "updated_at": "2021-08-11T21:04:58.000Z"
  },
  {
    "idreview": 18,
    "iduser": 32,
    "fullname": "Test Register 6",
    "idproduct": 10,
    "review": "bagus",
    "rating": "5",
    "created_at": "2021-08-11T21:04:59.000Z",
    "updated_at": "2021-08-11T21:04:59.000Z"
  },
  {
    "idreview": 19,
    "iduser": 32,
    "fullname": "Test Register 6",
    "idproduct": 10,
    "review": "bagus",
    "rating": "5",
    "created_at": "2021-08-11T21:05:00.000Z",
    "updated_at": "2021-08-11T21:05:00.000Z"
  }
]
```

## Add Review
Add product's review    

Method: ``POST``  
PATH: ``/product/review``  
Token: Required  
Request: Request body  
```json
{
 "iduser": 1,
 "idproduct": 2,
 "rating": 5,
 "review": "This is product review..."
}  
```
Respon Success:  
```json
{
 "status": 200,
 "message": "Add review success!" 
}
```

# 3. Transaction API

## Sales Report
Get sales report    

Method: ``GET``  
PATH: ``/transaction/sales-report``  
Token: Required  
Request: Request query (not required)  
```json 
{ 
 "start": "2020-01-01",
 "end": "2021-12-31"
}  
```
Note: YYYY/MM/DD  

Response Success:  
``` json
[
  {
    "total_product": 13,
    "total_qty": 24,
    "detail": [
      {
        "idtransaction": 60,
        "iduser": 16,
        "idproduct": 32,
        "product_name": "Zinc 20 mg 10 Tablet",
        "qty_buy": 2,
        "created_at": "8/7/2021",
        "status": "onprogress",
        "month": 8,
        "day": 7,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 61,
        "iduser": 16,
        "idproduct": 34,
        "product_name": "Inpepsa Sirup 100 ml",
        "qty_buy": 1,
        "created_at": "8/7/2021",
        "status": "onprogress",
        "month": 8,
        "day": 7,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 74,
        "iduser": 21,
        "idproduct": 2,
        "product_name": "Sanmol Pereda Nyeri 4 Tablet",
        "qty_buy": 1,
        "created_at": "8/9/2021",
        "status": "onprogress",
        "month": 8,
        "day": 9,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 84,
        "iduser": 24,
        "idproduct": 11,
        "product_name": "Bodrexin Flu dan Batuk Sirup Rasa Jeruk 56 mL",
        "qty_buy": 2,
        "created_at": "8/10/2021",
        "status": "onprogress",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 85,
        "iduser": 24,
        "idproduct": 8,
        "product_name": "Polidemisin Salep Mata 3.5 g",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "onprogress",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 86,
        "iduser": 16,
        "idproduct": 37,
        "product_name": "Lodia 2 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 87,
        "iduser": 16,
        "idproduct": 32,
        "product_name": "Zinc 20 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 88,
        "iduser": 16,
        "idproduct": 34,
        "product_name": "Inpepsa Sirup 100 ml",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 89,
        "iduser": 24,
        "idproduct": 32,
        "product_name": "Zinc 20 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 90,
        "iduser": 24,
        "idproduct": 35,
        "product_name": "Lacidofil Sachet 1 Gram",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 91,
        "iduser": 24,
        "idproduct": 42,
        "product_name": "Norvask 5 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/11/2021",
        "status": "onprogress",
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 93,
        "iduser": 16,
        "idproduct": 11,
        "product_name": "Bodrexin Flu dan Batuk Sirup Rasa Jeruk 56 mL",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 94,
        "iduser": 16,
        "idproduct": 12,
        "product_name": "Paramex Flu Dan Batuk 4 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 95,
        "iduser": 16,
        "idproduct": 10,
        "product_name": "Cendo Pithalmic Gel Mata 5 g",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 97,
        "iduser": 32,
        "idproduct": 10,
        "product_name": "Cendo Pithalmic Gel Mata 5 g",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "done",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 98,
        "iduser": 32,
        "idproduct": 32,
        "product_name": "Zinc 20 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 99,
        "iduser": 32,
        "idproduct": 42,
        "product_name": "Norvask 5 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 100,
        "iduser": 32,
        "idproduct": 14,
        "product_name": "Imudator Kaplet 6 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 104,
        "iduser": 21,
        "idproduct": 32,
        "product_name": "Zinc 20 mg 10 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 105,
        "iduser": 33,
        "idproduct": 13,
        "product_name": "Transpulmin Balsam 20 g",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 106,
        "iduser": 33,
        "idproduct": 55,
        "product_name": "Betadine Solution 15 ml",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 107,
        "iduser": 33,
        "idproduct": 2,
        "product_name": "Sanmol Pereda Nyeri 4 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "onprogress",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      }
    ],
    "unconfirmed": [
      {
        "idtransaction": 72,
        "iduser": 16,
        "idproduct": 2,
        "product_name": "Sanmol Pereda Nyeri 4 Tablet",
        "qty_buy": 1,
        "created_at": "8/8/2021",
        "status": "request",
        "month": 8,
        "day": 8,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 73,
        "iduser": 16,
        "idproduct": 3,
        "product_name": "Sumagesic Tablet  4 Tablet",
        "qty_buy": 2,
        "created_at": "8/8/2021",
        "status": "request",
        "month": 8,
        "day": 8,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 79,
        "iduser": 21,
        "idproduct": 1,
        "product_name": "Paracetamol MEF Kaplet 500 mg",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "waiting",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 80,
        "iduser": 16,
        "idproduct": 57,
        "product_name": "Rivanol Liquid 100 ml",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "request",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 81,
        "iduser": 16,
        "idproduct": 56,
        "product_name": "Nexcare Micropore Plester Roll 1 Inch",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "request",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 82,
        "iduser": 16,
        "idproduct": 6,
        "product_name": "Ailin Tetes Mata 10 ml",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "request",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 83,
        "iduser": 16,
        "idproduct": 5,
        "product_name": "Praxion Sirup Anak 60 ml",
        "qty_buy": 1,
        "created_at": "8/10/2021",
        "status": "request",
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "idtransaction": 96,
        "iduser": 31,
        "idproduct": 3,
        "product_name": "Sumagesic Tablet  4 Tablet",
        "qty_buy": 1,
        "created_at": "8/12/2021",
        "status": "request",
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      }
    ],
    "total_unconfirmed": 9
  }
]
```

## Revenue
Get product's revenue    


- Method: ``GET``  
- PATH: ``/transaction/revenue``  
- Token: Required  
- Request: Request query (not required)  
```json
{ 
 "start": "2020-01-01",
 "end": "2021-12-31"
}  
```
Note: YYYY/MM/DD  

Response Success:  
```json
[
  {
    "total_revenue": 622160,
    "total_user": 5,
    "total_transactions": 11,
    "transactions": [
      {
        "id": 61,
        "iduser": 16,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628303150254",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha",
        "postal_code": 40611,
        "expedition": "JNE",
        "service": "1",
        "shipping_cost": 10000,
        "total_price": 213500,
        "note": "Cek perscription",
        "img_order_url": "perscription/IMG1628303150293.jpg",
        "created_at": "8/7/2021",
        "update_at": null,
        "month": 8,
        "day": 7,
        "year": 2021,
        "week": 1
      },
      {
        "id": 70,
        "iduser": 16,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628404056952",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha",
        "postal_code": 40611,
        "expedition": "JNE",
        "service": "0",
        "shipping_cost": 8000,
        "total_price": 19370,
        "note": "cek transaksi",
        "img_order_url": "perscription/IMG1628404056976.jpg",
        "created_at": "8/8/2021",
        "update_at": null,
        "month": 8,
        "day": 8,
        "year": 2021,
        "week": 1
      },
      {
        "id": 72,
        "iduser": 21,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628484123799",
        "id_city_origin": 107,
        "id_city_destination": 22,
        "address": "Komplek Nusa Cisangkan Permai Blok H no 23",
        "recipient": "Kaka",
        "postal_code": 40526,
        "expedition": null,
        "service": null,
        "shipping_cost": 8000,
        "total_price": 28000,
        "note": "Tolong packing yang rapi",
        "img_order_url": null,
        "created_at": "8/9/2021",
        "update_at": null,
        "month": 8,
        "day": 9,
        "year": 2021,
        "week": 1
      },
      {
        "id": 78,
        "iduser": 24,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628639396679",
        "id_city_origin": 22,
        "id_city_destination": 151,
        "address": "Komplek pegangsaan timur no 118",
        "recipient": "Ucup sanusi",
        "postal_code": 40413,
        "expedition": null,
        "service": null,
        "shipping_cost": 10000,
        "total_price": 82000,
        "note": "",
        "img_order_url": null,
        "created_at": "8/10/2021",
        "update_at": null,
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "id": 81,
        "iduser": 24,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628643216087",
        "id_city_origin": 22,
        "id_city_destination": 151,
        "address": "Komplek pegangsaan timur no 118",
        "recipient": "Ucup sanusi",
        "postal_code": 40413,
        "expedition": "JNE",
        "service": "0",
        "shipping_cost": 10000,
        "total_price": 20490,
        "note": "Resep dari dokter agus",
        "img_order_url": "perscription/IMG1628643216233.jpg",
        "created_at": "8/11/2021",
        "update_at": null,
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "id": 83,
        "iduser": 16,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628733945499",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha Luthfi",
        "postal_code": 40611,
        "expedition": null,
        "service": null,
        "shipping_cost": 8000,
        "total_price": 107000,
        "note": "Jangan ditindih ya !",
        "img_order_url": null,
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "id": 85,
        "iduser": 32,
        "status": "done",
        "invoice": "PRM#CLICK1628740556530",
        "id_city_origin": 22,
        "id_city_destination": 107,
        "address": "GACC",
        "recipient": "Allysa",
        "postal_code": 40526,
        "expedition": null,
        "service": null,
        "shipping_cost": 8000,
        "total_price": 55000,
        "note": "bungkus yang rapi",
        "img_order_url": null,
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "id": 86,
        "iduser": 32,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628740670131",
        "id_city_origin": 22,
        "id_city_destination": 107,
        "address": "GACC",
        "recipient": "Allysa",
        "postal_code": 40526,
        "expedition": "JNE",
        "service": "0",
        "shipping_cost": 8000,
        "total_price": 38600,
        "note": "test custom order",
        "img_order_url": "perscription/IMG1628740668878.jpg",
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "id": 87,
        "iduser": 32,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628748189828",
        "id_city_origin": 22,
        "id_city_destination": 107,
        "address": "GACC",
        "recipient": "Allysa",
        "postal_code": 40526,
        "expedition": null,
        "service": null,
        "shipping_cost": 10000,
        "total_price": 41000,
        "note": "Packing rapi",
        "img_order_url": null,
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "id": 90,
        "iduser": 21,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628754748652",
        "id_city_origin": 22,
        "id_city_destination": 107,
        "address": "Komp ncp",
        "recipient": "Allysa",
        "postal_code": 40526,
        "expedition": "JNE",
        "service": "0",
        "shipping_cost": 8000,
        "total_price": 15200,
        "note": "test2",
        "img_order_url": "perscription/IMG1628754748665.jpg",
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      },
      {
        "id": 91,
        "iduser": 33,
        "status": "onprogress",
        "invoice": "PRM#CLICK1628760935655",
        "id_city_origin": 22,
        "id_city_destination": 115,
        "address": "Taman Induk 44 Cipayung, Cipayung Depok",
        "recipient": "Afi",
        "postal_code": 16437,
        "expedition": null,
        "service": null,
        "shipping_cost": 18000,
        "total_price": 108000,
        "note": "",
        "img_order_url": null,
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      }
    ],
    "unconfirmedTransactions": [
      {
        "id": 71,
        "iduser": 16,
        "status": "request",
        "invoice": "PRM#CLICK1628413210878",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha",
        "postal_code": 40611,
        "expedition": null,
        "service": null,
        "shipping_cost": 10000,
        "total_price": 60000,
        "note": "Jangan ditindih ntar remuk, tolong mas !!",
        "img_order_url": null,
        "created_at": "8/8/2021",
        "update_at": null,
        "month": 8,
        "day": 8,
        "year": 2021,
        "week": 1
      },
      {
        "id": 75,
        "iduser": 21,
        "status": "waiting",
        "invoice": "PRM#CLICK1628565013736",
        "id_city_origin": 107,
        "id_city_destination": 22,
        "address": "Komplek Nusa Cisangkan Permai Blok H no 23",
        "recipient": "Kaka",
        "postal_code": 40526,
        "expedition": null,
        "service": null,
        "shipping_cost": 10000,
        "total_price": 40000,
        "note": "bungkus yang rapi",
        "img_order_url": null,
        "created_at": "8/10/2021",
        "update_at": null,
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "id": 76,
        "iduser": 16,
        "status": "request",
        "invoice": "PRM#CLICK1628637649897",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung Berung Indah blok 16 no 2",
        "recipient": "Rakha Luthfi",
        "postal_code": 40611,
        "expedition": null,
        "service": null,
        "shipping_cost": 8000,
        "total_price": 83000,
        "note": "Test",
        "img_order_url": null,
        "created_at": "8/10/2021",
        "update_at": null,
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "id": 77,
        "iduser": 16,
        "status": "request",
        "invoice": "PRM#CLICK1628638786428",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha Luthfi",
        "postal_code": 40611,
        "expedition": null,
        "service": null,
        "shipping_cost": 8000,
        "total_price": 69000,
        "note": "Jangan ditindih ya mas !! makasih ",
        "img_order_url": null,
        "created_at": "8/10/2021",
        "update_at": null,
        "month": 8,
        "day": 10,
        "year": 2021,
        "week": 1
      },
      {
        "id": 80,
        "iduser": 16,
        "status": "request",
        "invoice": "PRM#CLICK1628641697907",
        "id_city_origin": 22,
        "id_city_destination": 22,
        "address": "Komplek Ujung berung indah blok 16 no 2",
        "recipient": "Rakha Luthfi",
        "postal_code": 40611,
        "expedition": "JNE",
        "service": "0",
        "shipping_cost": 0,
        "total_price": 0,
        "note": "Jangan dibanting ",
        "img_order_url": "perscription/IMG1628641698020.jpg",
        "created_at": "8/11/2021",
        "update_at": null,
        "month": 8,
        "day": 11,
        "year": 2021,
        "week": 1
      },
      {
        "id": 84,
        "iduser": 31,
        "status": "request",
        "invoice": "PRM#CLICK1628738493366",
        "id_city_origin": 22,
        "id_city_destination": 1,
        "address": "Komplek Nusa Cisangkan Permai Blok H no 23",
        "recipient": "Renjun",
        "postal_code": 40526,
        "expedition": null,
        "service": null,
        "shipping_cost": 47000,
        "total_price": 62000,
        "note": "test",
        "img_order_url": null,
        "created_at": "8/12/2021",
        "update_at": null,
        "month": 8,
        "day": 12,
        "year": 2021,
        "week": 1
      }
    ],
    "total_unconfirmed_trans": 6,
    "total_unconfirmed_revenue": 231000
  }
]
```
## Product Sales
Get each product sales report    

- Method: ``GET``  
- PATH: ``/transaction/prouct-sales``  
- Token: Required  

Response Success:  
```json
[
  {
    "id": 1,
    "idproduct": 1,
    "product_name": "Paracetamol MEF Kaplet 500 mg",
    "image_url": "https://images.k24klik.com/product/large/apotek_online_k24klik_2020102202003123085_Edit-Produk-13.jpg",
    "type": "pack",
    "qty": 80,
    "total_netto": 8000,
    "unit_price": null,
    "pack_price": 30000,
    "unit": "mg",
    "status": "available",
    "orders": []
  },
  {
    "id": 2,
    "idproduct": 2,
    "product_name": "Sanmol Pereda Nyeri 4 Tablet",
    "image_url": "https://images.k24klik.com/product/large/apotek_online_k24klik_20200810090629359225_SANMOL-4-TAB.jpg",
    "type": "pack",
    "qty": 89,
    "total_netto": 356,
    "unit_price": null,
    "pack_price": 20000,
    "unit": "tablet",
    "status": "available",
    "orders": [
      {
        "idtransaction": 72,
        "invoice": "PRM#CLICK1628484123799",
        "type": "pack",
        "iduser": 21,
        "fullname": "Renjun Huang",
        "idproduct": 2,
        "created_at": "8/9/2021",
        "total_netto": 4,
        "transaction_status": "onprogress",
        "qty": 1
      }
    ]
  },
  {
    "id": 3,
    "idproduct": 3,
    "product_name": "Sumagesic Tablet  4 Tablet",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/789758_31-3-2019_15-23-57.jpg",
    "type": "pack",
    "qty": 69,
    "total_netto": 276,
    "unit_price": null,
    "pack_price": 15000,
    "unit": "tablet",
    "status": "available",
    "orders": []
  },
  {
    "id": 4,
    "idproduct": 4,
    "product_name": "Panadol Kaplet 500 mg",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/827019_2-7-2021_20-11-32.jpeg",
    "type": "pack",
    "qty": 50,
    "total_netto": 5000,
    "unit_price": null,
    "pack_price": 31000,
    "unit": "mg",
    "status": "available",
    "orders": []
  },
  {
    "id": 5,
    "idproduct": 5,
    "product_name": "Praxion Sirup Anak 60 ml",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/1867.jpg",
    "type": "pack",
    "qty": 59,
    "total_netto": 3540,
    "unit_price": null,
    "pack_price": 27000,
    "unit": "ml",
    "status": "available",
    "orders": [
      {
        "idtransaction": 83,
        "invoice": "PRM#CLICK1628733945499",
        "type": "pack",
        "iduser": 16,
        "fullname": "Rakha Luthfi",
        "idproduct": 5,
        "created_at": "8/12/2021",
        "total_netto": 60,
        "transaction_status": "onprogress",
        "qty": 1
      }
    ]
  },
  {
    "id": 6,
    "idproduct": 6,
    "product_name": "Ailin Tetes Mata 10 ml",
    "image_url": "http://erela.co.id/wp-content/uploads/2014/03/Ailin.jpg",
    "type": "pack",
    "qty": 49,
    "total_netto": 490,
    "unit_price": null,
    "pack_price": 34000,
    "unit": "ml",
    "status": "available",
    "orders": [
      {
        "idtransaction": 82,
        "invoice": "PRM#CLICK1628654002945",
        "type": "pack",
        "iduser": 21,
        "fullname": "Renjun Huang",
        "idproduct": 6,
        "created_at": "8/11/2021",
        "total_netto": 10,
        "transaction_status": "reject",
        "qty": 1
      }
    ]
  },
  {
    "id": 7,
    "idproduct": 7,
    "product_name": "Chloramphenicol 1% Salep Mata 3.5 g",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/6504.jpg",
    "type": "pack",
    "qty": 39,
    "total_netto": 117,
    "unit_price": null,
    "pack_price": 15000,
    "unit": "g",
    "status": "available",
    "orders": []
  },
  {
    "id": 8,
    "idproduct": 8,
    "product_name": "Polidemisin Salep Mata 3.5 g",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/3364.jpg",
    "type": "pack",
    "qty": 69,
    "total_netto": 207,
    "unit_price": null,
    "pack_price": 25000,
    "unit": "g",
    "status": "available",
    "orders": [
      {
        "idtransaction": 85,
        "invoice": "PRM#CLICK1628740556530",
        "type": "pack",
        "iduser": 32,
        "fullname": "Test Register 6",
        "idproduct": 8,
        "created_at": "8/12/2021",
        "total_netto": 3,
        "transaction_status": "done",
        "qty": 1
      }
    ]
  },
  {
    "id": 9,
    "idproduct": 9,
    "product_name": "Cendo Tobroson Salep Mata 3.5 g",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/15680.jpg",
    "type": "pack",
    "qty": 80,
    "total_netto": 240,
    "unit_price": null,
    "pack_price": 28000,
    "unit": "g",
    "status": "available",
    "orders": []
  },
  {
    "id": 10,
    "idproduct": 10,
    "product_name": "Cendo Pithalmic Gel Mata 5 g",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/123137_27-7-2020_0-15-38.jpeg",
    "type": "pack",
    "qty": 2,
    "total_netto": 10,
    "unit_price": null,
    "pack_price": 47000,
    "unit": "g",
    "status": "available",
    "orders": []
  },
  {
    "id": 11,
    "idproduct": 11,
    "product_name": "Bodrexin Flu dan Batuk Sirup Rasa Jeruk 56 mL",
    "image_url": "https://cf.shopee.co.id/file/5027d9033f3d9fed1d73df67f45ab483",
    "type": "pack",
    "qty": 8,
    "total_netto": 448,
    "unit_price": null,
    "pack_price": 23500,
    "unit": "ml",
    "status": "available",
    "orders": [
      {
        "idtransaction": 84,
        "invoice": "PRM#CLICK1628738493366",
        "type": "pack",
        "iduser": 31,
        "fullname": "Test Register 5",
        "idproduct": 11,
        "created_at": "8/12/2021",
        "total_netto": 112,
        "transaction_status": "request",
        "qty": 2
      }
    ]
  },
  {
    "id": 12,
    "idproduct": 12,
    "product_name": "Paramex Flu Dan Batuk 4 Tablet",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/9963.jpg",
    "type": "pack",
    "qty": 6,
    "total_netto": 24,
    "unit_price": null,
    "pack_price": 28500,
    "unit": "tablet",
    "status": "available",
    "orders": []
  },
  {
    "id": 13,
    "idproduct": 13,
    "product_name": "Transpulmin Balsam 20 g",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/666978_2-6-2021_18-16-23.jpeg",
    "type": "pack",
    "qty": 49,
    "total_netto": 980,
    "unit_price": null,
    "pack_price": 40000,
    "unit": "g",
    "status": "available",
    "orders": []
  },
  {
    "id": 14,
    "idproduct": 14,
    "product_name": "Imudator Kaplet 6 Tablet",
    "image_url": "https://images.k24klik.com/product/large/apotek_online_k24klik_20201204100810359225_IMUDATOR.jpg",
    "type": "pack",
    "qty": 38,
    "total_netto": 228,
    "unit_price": null,
    "pack_price": 31000,
    "unit": "tablet",
    "status": "available",
    "orders": []
  },
  {
    "id": 15,
    "idproduct": 15,
    "product_name": "Blackmores 60 Tablet",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/8349_16-8-2019_10-40-40.jpg",
    "type": "pack",
    "qty": 50,
    "total_netto": 1000,
    "unit_price": null,
    "pack_price": 23000,
    "unit": "tablet",
    "status": "available",
    "orders": []
  },
  {
    "id": 16,
    "idproduct": 16,
    "product_name": "Cardiomin 4  Kapsul",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/8764.jpg",
    "type": "pack",
    "qty": 20,
    "total_netto": 80,
    "unit_price": null,
    "pack_price": 27500,
    "unit": "kapsul",
    "status": "available",
    "orders": []
  },
  {
    "id": 17,
    "idproduct": 17,
    "product_name": "Ultravita Cap 4 Tablet",
    "image_url": "https://d2qjkwm11akmwu.cloudfront.net/products/images/8999.jpg",
    "type": "pack",
    "qty": 5,
    "total_netto": 20,
    "unit_price": null,
    "pack_price": 13000,
    "unit": "tablet",
    "status": "available",
    "orders": []
  }
]
```