const express = require("express");
const app = express();
var http = require('http');
app.use(express.json());
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.listen(4000, () => {
  console.log("Listening on port 4000 ");
});

const productAllData = [];

app.get("/", (req, res) => {
  res.send("Connected");
});


app.post("/api/addproduct", (req, res) => {
  console.log("Result", req.body);

  const singleProductData = {
    id: productAllData.length + 1,
    pname: req.body.pname,
    pprice: req.body.pprice,
    pdetails: req.body.pdetails,
  };

  productAllData.push(singleProductData);
  res.status(200).send({
    code: 200,
    message: "Product added successfully",
    addedproduct: singleProductData,
  });
});

app.get("/api/getProduct", (req, res) => {
  if (productAllData.length > 0) {
    res.status(200).send({ code: "200", productData: productAllData });
  } else {
    res.status(200).send({ code: 200, productData: [] });
  }
});
app.get("/getdata", (req, res) => { 
    var data = { // this is the data you're sending back during the GET request 
        data1: "mee", 
        data2: "po" 
    } 
    res.status(200).json(data) 
}); 
