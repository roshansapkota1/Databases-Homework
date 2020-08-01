const express = require("express");
const app = express();

const bodyParser = require("body-parser");
app.use(bodyParser.json());


app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});
const { Pool } = require('pg');
const { query } = require("express");


const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'cyf_ecommerce',
    password: 'roshansapkota1',
    port: 5432
});

app.get("/hola", function(req, res) {
    
        res.json('damn broo');
});

app.get("/product", function(req, res) {
    pool.query("SELECT * FROM products", (error, result) => {
        res.json(result.rows);
    });
});

app.get("/products", function (req, res) {
    pool.query(
      "select p.product_name, s2.supplier_name from products p join suppliers s2 on p.supplier_id = s2.id;",
      (error, result) => {
        res.json(result.rows);
      }
    );
  });

//Update the previous GET endpoint /products to filter the list of products by name using a query parameter, for example /products?name=Cup.
//This endpoint should still work even if you don't use the name query parameter!

app.get('/products/:name', function (req, res){
  const { name } = req.params;
  pool
  .query('select * from products where product_name=$1', [name])
  .then( (result) => res.json(result.rows))
  .catch( e => console.error(e))

});

//Add a new GET endpoint /customers/:customerId to load a single customer by ID.
app.get('/customers/:id', function (req, res ){
  const {id } = req.params;
  pool
  .query('select from customers where id=$1', [id])
  .then(result => res.json(result.rows))
  .catch(e => console.error(e))
})

//Add a new POST endpoint /customers to create a new customer.

app.post('/customers', function(req, res){
  const name = req.body.name;
  const  address = req.body.address;
  const city = req.body.city;
  const country = req.body.country;

  pool
  .query('insert into customers (name, address, city, country) VALUES ($1, $2, $3, $4)', [name, address, city, country])
  .then(() => res.send('The customer is created !!'))
  .catch(e => console.error(e))


})

//Add a new POST endpoint /products to create a new product (with a product name, a price and a supplier id).
// Check that the price is a positive integer and that the supplier ID exists in the database, otherwise return an error.
app.post('/products', function (req, res){
  const productName = req.body.productName;
  const unitPrice = req.body.unitPrice;
  const supplierId = req.body.supplierId;

  if (!Number.isInteger(unitPrice) || unitPrice <= 0){
    return res
    .status(400)
    .send('Unitprice should be a positive integer')
    }

  pool
  .query('select * from suppliers where id = $1', [supplierId])
  .then(result => {
    if (result.rows.length <= 0){
        return res
        .status(400)
        .send('This supplier id doesnot exist')
    }
    else {
      const query = 'insert into products (product_name, unit_price, supplier_id) values ($1, $2, $3)';
      pool
      .query(query, [productName, unitPrice, supplierId])
      .then( () => res.send("new product created"))
      .catch(e => console.error(e))


    }
  })
})

//Add a new POST endpoint /customers/:customerId/orders to create a new order (including an order date, and an order reference) for a customer.
// Check that the customerId corresponds to an existing customer or return an error.

app.post("/customers/:customerId/orders", function (req, res){
   const { customerId} = req.params;
   const orderReference = req.body.orderReference;
   const orderDate = req.body.orderDate;
   pool
   .query('select * from customers where id = $1', [customerId])
   .then(result => {
     if (result.rows.length <= 0){
       return res 
       .status(400)
       .send('This ID doesnot belong to the existing customer')
     }
     else {
       pool
       .query('insert into orders (order_date, order_reference, customer_id) values ($1, $2, $3)', [orderDate, orderReference, customerId])
       .then(() => res.send('Created new order for existing customer'))
       .catch(a => console.error(a))
     }

   })

})

//Add a new PUT endpoint /customers/:customerId to update an existing customer (name, address, city and country).

app.put("/customers/:customerId", function(req, res){
  const{ customerId } = req.params;
  const name = req.body.name;
  const address = req.body.address;
  const city = req.body.city;
  const country = req.body.country
  console.log(name);
  pool
  .query('select * from customers where id = $1 ', [customerId])
  .then(result => {
    if(result.rows.length <= 0){
      return res
      .status(400)
      .send('This id doesnot belong to the existing customer')
    }
    else {
      pool
      .query('update customers set name = $1, address= $2, city= $3, country = $4 where id = $5', [name, address, city, country, customerId])
      .then (() => res.send(`Updated the row from the customers where id = ${customerId}`))
      .catch(e => console.error(e))
    }
  })



})

//Add a new DELETE endpoint /orders/:orderId to delete an existing order along all the associated order items.

app.delete('/orders/:orderId', function(req, res){
  const { orderId } = req.params;
  console.log('id', orderId);

  pool
  .query('delete from order_items where order_id = $1', [orderId])
  .then (() => {
    pool
    .query('delete from orders where id = $1', [orderId])
    .then(() => res.send(`first deleted from order_items and deleted from the orders table where id = ${orderId} `))
    .catch(e => console.error(e))
  })
  .catch(e => console.error(e))
})


