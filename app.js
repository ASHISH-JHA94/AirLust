const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const methodOverride = require("method-override");
const ejsMate=require("ejs-mate");


const app = express();

app.use(methodOverride("_method"));
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname,"/public")));
const port = 8080;
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.engine("ejs",ejsMate);




app.get("/",(req,res)=>{
      const connection = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'airline_db',
      password: 'ashish1234',
  
});
res.render("home.ejs")});

app.get('/flights/:flightId', (req, res) => {
  const flightId = req.params.flightId;
  
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'ashish1234',

});
let q=`SELECT f.departure_dt as departure, f.arrival_dt as arrival, f.airline_id as airliner, a1.iata_code as departs, a2.iata_code as arrives,ar.airline_name as airlinername FROM flights f 
JOIN airports a1 ON f.departure_icao=a1.icao_code 
JOIN airports a2 ON f.arrival_icao=a2.icao_code
JOIN airline ar ON f.airline_id=ar.airline_id WHERE f.flight_id='${flightId}'`;

connection.query(q, (err, results) => {
  if (err) {
    connection.end();
    console.error(err);
    res.send("An error occurred");
    return;
  }

  let bookinginfo=results;
  console.log(bookinginfo);

  res.render('Booking.ejs', { bookinginfo,flightId });

});
});




app.post("/flightInfo",(req,res)=>{
  const { From: frm, To: to,DepartureDate:deptdate,class:cls } = req.body;
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'ashish1234',

});
let q = `SELECT f.flight_id,f.flight_name as name,f.duration as duration,f.price as price,f.departure_dt as departure,
f.arrival_dt as arrival, f.airline_id as airliner, a1.iata_code as departs, a2.iata_code as arrives,
ar.airline_name as airlinername, a1.airport_name as deptair,a2.airport_name as arvair 
FROM flights f 
JOIN airports a1 ON f.departure_icao=a1.icao_code 
JOIN airports a2 ON f.arrival_icao=a2.icao_code
JOIN airline ar ON f.airline_id=ar.airline_id
WHERE f.departure_icao IN(SELECT icao_code from airports where city='${frm}') AND f.arrival_icao IN(SELECT icao_code from airports where city='${to}')`;
  connection.query(q, (err, results) => {
    if (err) {
      connection.end();
      console.error(err);
      res.send("An error occurred");
      return;
    }

    let AirInfo = results;
    console.log(AirInfo);
    


  res.render("flightInfo.ejs",{ AirInfo });

});
});


app.post('/ticket', (req, res) => {
 
  const { fname, lname, email, phoneno, dob } = req.body;

  
  const flightId = req.body.flightId;

  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'ashish1234',

});
const insertPassengerQuery = `
    INSERT INTO passengers (flight_id,first_name,last_name, email, phone, dob)
    VALUES (?,?,?,?,?,?);
  `;

 
  connection.query(
    insertPassengerQuery,
    [flightId,fname,lname, email, phoneno, dob],
    (err, results) => {
      if (err) {
        connection.end();
        console.error(err);
        res.send("An error occurred while inserting passenger data.");
        return;
      }

      
      const passengerId = results.insertId;

      
    }
  );




let q=`SELECT f.departure_dt as departure, f.arrival_dt as arrival, f.airline_id as airliner, a1.iata_code as departs, a2.iata_code as arrives,ar.airline_name as airlinername FROM flights f 
JOIN airports a1 ON f.departure_icao=a1.icao_code 
JOIN airports a2 ON f.arrival_icao=a2.icao_code
JOIN airline ar ON f.airline_id=ar.airline_id WHERE f.flight_id='${flightId}'`;

connection.query(q, (err, results) => {
  if (err) {
    connection.end();
    console.error(err);
    res.send("An error occurred");
    return;
  }
  let bookinginfo=results;
  res.render('ticketPage.ejs', {  flightId,fname,lname,email, phoneno, dob,bookinginfo });
});

});

app.get("/login",(req,res)=>{
  res.render("login.ejs");
});

app.post("/userinfo",(req,res)=>{
  const {email,dob}=req.body;
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'ashish1234',

});
  let q=`SELECT 
  p.first_name, p.last_name, p.email, p.phone, p.dob,
  ar.airline_name,
  f.flight_name, f.price, f.duration,
  a1.iata_code AS departure_iata, a1.airport_name AS departure_airport,
  a2.iata_code AS arrival_iata, a2.airport_name AS arrival_airport, 
  f.flight_status, f.departure_dt, f.arrival_dt 
FROM passengers p
JOIN flights f ON p.flight_id = f.flight_id  
JOIN airports a1 ON f.departure_icao = a1.icao_code
JOIN airports a2 ON f.arrival_icao = a2.icao_code
JOIN airline ar ON f.airline_id = ar.airline_id
WHERE (email = '${email}' AND dob = '${dob}');`;
  connection.query(q, (err, results) => {
    if (err) {
      connection.end();
      console.error(err);
      res.send("An error occurred");
      return;
    }
    let userInfo=results;
    console.log(userInfo);
    res.render('user.ejs', {userInfo});
  });  

});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});