const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const methodOverride = require("method-override");
const ejsMate = require("ejs-mate");
const userController = require('./userDOB');
const app = express();

app.use(methodOverride("_method"));
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "/public")));
const port = 8080;
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.engine("ejs", ejsMate);


app.get("/", (req, res) => {
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'Q5d2qvhx6x!?1a2b3',

  });
  res.render("home.ejs")
});

app.get('/flights/:flightId/:seatClass', (req, res) => {
  const flightId = req.params.flightId;
  const seatClass = req.params.seatClass;
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'Q5d2qvhx6x!?1a2b3',
  });
  let q = `SELECT 
              f.departure_dt as departure, 
              f.arrival_dt as arrival, 
              f.airline_id as airliner, 
              a1.iata_code as departs, 
              a2.iata_code as arrives,
              ar.airline_name as airlinername,
              s.seat_status as seatstatus,
              s.seat_class as seatclass,
              s.seat_tax as tax
            FROM flights f 
            JOIN airports a1 ON f.departure_icao=a1.icao_code 
            JOIN airports a2 ON f.arrival_icao=a2.icao_code
            JOIN airline ar ON f.airline_id=ar.airline_id 
            JOIN seats s ON s.flight_id=f.flight_id
            WHERE f.flight_id='${flightId}' AND s.seat_status='AVAILABLE' AND s.seat_class='${seatClass}'
            ORDER BY RAND()
            LIMIT 1;`;

  connection.query(q, (err, results) => {
    if (err) {
      connection.end();
      console.error(err);
      res.send("An error occurred");
      return;
    }

    let bookinginfo = results;
    console.log(bookinginfo);

    res.render('Booking.ejs', { bookinginfo, flightId, seatClass,getSeat: userController.getSeat });

  });
});




app.post("/flightInfo", (req, res) => {
  const { From: frm, To: to, DepartureDate: deptdate, class: cls } = req.body;
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'Q5d2qvhx6x!?1a2b3',
  });

  let q = `SELECT  DISTINCT(f.flight_id),
  MAX(f.flight_name) as name,
  MAX(f.duration) as duration,
  MAX(f.price) as price,
  MAX(f.departure_dt) as departure,
  MAX(f.arrival_dt) as arrival,
  MAX(f.airline_id) as airliner,
  MAX(a1.iata_code) as departs,
  MAX(a2.iata_code) as arrives,
  MAX(ar.airline_name) as airlinername,
  MAX(a1.airport_name) as deptair,
  MAX(a2.airport_name) as arvair,
  s.seat_class as class,
  MAX(s.seat_tax) as tax,
  COUNT(s.seat_class) as class_count
  FROM flights f 
  JOIN airports a1 ON f.departure_icao=a1.icao_code 
  JOIN airports a2 ON f.arrival_icao=a2.icao_code
  JOIN airline ar ON f.airline_id=ar.airline_id
  JOIN seats s ON f.flight_id = s.flight_id
  WHERE f.departure_icao IN(SELECT icao_code from airports where city='${frm}') AND f.arrival_icao IN(SELECT icao_code from airports where city='${to}') AND DATE(f.departure_dt)='${deptdate}'
  AND s.seat_class='${cls}' AND s.seat_status='AVAILABLE' GROUP BY f.flight_id`;

  let noFlightsMessage = ''; // Initialize it as an empty string

  connection.query(q, (err, results) => {
    if (err) {
      connection.end();
      console.error(err);
      res.send("An error occurred");
      return;
    }
    let AirInfo = results;
    console.log(AirInfo);

    if (results.length === 0) {
      noFlightsMessage = 'No Flights Found !!';
    }
    res.render("flightInfo.ejs", { AirInfo, noFlightsMessage });
  });
});


app.post('/ticket/', (req, res) => {
  const { fname, lname, email, phoneno, dob } = req.body;
  const flightId = req.body.flightId;
  const seatClass = req.body.seatClass;

  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'Q5d2qvhx6x!?1a2b3',
  });

  const insertPassengerQuery = `
    INSERT INTO passengers (flight_id, first_name, last_name, email, phone, dob, seat_class, seat_number)
    SELECT s.flight_id, ?, ?, ?, ?, ?, ?, s.seat_number
    FROM seats s
    WHERE s.flight_id = ? AND s.seat_status = 'AVAILABLE' AND s.seat_class = ?
    ORDER BY RAND()
    LIMIT 1;
  `;

  connection.query(
    insertPassengerQuery,
    [fname, lname, email, phoneno, dob, seatClass, flightId, seatClass],
    (err, results) => {
      if (err) {
        connection.end();
        console.error(err);
        res.send("An error occurred while inserting passenger data.");
        return;
      }
      const passengerId = results.insertId;

      let q = `
        SELECT 
          f.departure_dt as departure, 
          f.arrival_dt as arrival, 
          f.airline_id as airliner, 
          a1.iata_code as departs, 
          a2.iata_code as arrives,
          ar.airline_name as airlinername,
          s.seat_status as seatstatus,
          s.seat_number as seatnumber,
          s.seat_class as seatclass,
          s.seat_tax as tax
        FROM flights f 
        JOIN airports a1 ON f.departure_icao = a1.icao_code 
        JOIN airports a2 ON f.arrival_icao = a2.icao_code
        JOIN airline ar ON f.airline_id = ar.airline_id 
        JOIN seats s ON s.flight_id = f.flight_id
        WHERE f.flight_id = '${flightId}' AND s.seat_status = 'AVAILABLE' AND s.seat_class = '${seatClass}'
        ORDER BY RAND()
        LIMIT 1;`;

      connection.query(q, (err, results) => {
        if (err) {
          connection.end();
          console.error(err);
          res.send("An error occurred");
          return;
        }
        let bookinginfo = results;
        res.render('ticketPage.ejs', {
          flightId,
          fname,
          lname,
          email,
          phoneno,
          dob,
          bookinginfo,
          formatDOB: userController.formatDOB,
          getSeat: userController.getSeat,
          seatClass,
        });
      });
    }
  );
});


app.get("/login", (req, res) => {
  res.render("login.ejs");
});

app.post("/userinfo", (req, res) => {
  const { email, dob } = req.body;
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'airline_db',
    password: 'Q5d2qvhx6x!?1a2b3',

  });
  let q = `SELECT 
  p.first_name, p.last_name, p.email, p.phone, p.dob,p.seat_number,p.seat_class,
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
    let userInfo = results;
    console.log(userInfo);
    res.render('user.ejs', { userInfo, formatDOB: userController.formatDOB, getSeat: userController.getSeat });
  });

});

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});