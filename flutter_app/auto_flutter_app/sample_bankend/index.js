const express = require('express');
const app = express();

const server = '192.168.178.122';
const port = 80;

let started = false;
let contact = false;

const delay = ms => new Promise(res => setTimeout(res, ms));

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
	
  res.send();
});

let counter = 0;

app.get('/car/status', async function (req, res) {
  statusText = "";
  if(!contact)
	  statusText += "The car is off contact";
  else
	  statusText += "The car is on contact";
  if(!started)
	  statusText += " and is not running.";
  else
	  statusText += " and is running.";
  
  let delayTime;
  
  const d = Math.random();
  if (d < .2)
	delayTime = 0
  else if (d < .7)
	delayTime = 300
  else 
	delayTime = 2500

	  
  var currentdate = new Date(); 
  var datetime = currentdate.getDate() + "/"
                + (currentdate.getMonth()+1)  + "/" 
                + currentdate.getFullYear() + " @ "  
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds();
  
  console.log(`${datetime} ${statusText} with delay: ${delayTime}`);
  
    await delay(delayTime);
	
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
