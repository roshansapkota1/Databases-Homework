const express = require("express");
const app = express();


app.listen(3000, function() {
    console.log("Server is listening on port 3000. Ready to accept requests!");
});
const { Pool } = require('pg');

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
      "SELECT * FROM products JOIN suppliers on products.supplier_id = suppliers.id",
      (error, result) => {
        res.json(result.rows);
      }
    );
  });

