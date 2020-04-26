const express = require('express');
const app = express();

const server = '192.168.43.30';
const port = 80;

let started = false;
let contact = false;

//between 0 and 2 (floating point), the higher the number, the bigger the chance of succes.
let errorSimulator = 1.4; 

app.get('/car/start/contact', function (req, res) {
  contact = true;
  console.log('Car on contact.');
  res.send('contact');
});

app.get('/car/stop/contact', function (req, res) {
  contact = false;
  started = false;
  console.log('Car off contact.');
  res.send();
}); 

app.get('/car/start/ignition', function (req, res) {
  console.log("igniting");
  const number = Math.round(Math.random() * errorSimulator);
  if(number == 1){ //let some randomness occur to not start the car.
	started = true;
	console.log("Starting car with ignitionTime:" + req.query.ignitionTime);
  }else{
	console.log("Simulating an error.");
  }
	
  const delay = ms => new Promise(res => setTimeout(res, ms));
  res.send();
});

app.get('/car/status', function (req, res) {
  statusText = "";
  if(!contact)
	  statusText += "The car is off contact";
  else
	  statusText += "The car is on contact";
  if(!started)
	  statusText += " and is not running.";
  else
	  statusText += " and is running.";
  
  console.log(statusText);
	
  if(!started && !contact){ //this can also be random based on the number.
	res.send("-2");  
  }else if(!started && contact){ //this can also be random based on the number.
	res.send("-1");  
  } else if(started && contact) {
	res.send(Math.round(Math.random() * (100 - 1) + 1).toString());
  }
  
  
});

app.listen(port, server, function () {
  console.log(`Starting car sample backend on: ${server + ":" + port}`);
});
