const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const recordsRoutes = require('./routes/records');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use('/records', recordsRoutes);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
