#!/bin/bash
apt update -y
apt install -y nodejs npm
mkdir -p /app
cd /app
cat <<APP > server.js
const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
  res.send('Hello from App Tier (Node.js)');
});

app.listen(port, () => {
  console.log(\`App running on port \${port}\`);
});
APP

npm init -y
npm install express
nohup node server.js > app.log 2>&1 &
