const express = require('express');
const mysql = require('mysql');

const router = express.Router();

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'tempat_sholat_id'
});

db.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL');
});

router.get('/', (req, res) => {
  db.query('SELECT * FROM records', (err, results) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json(results);
  });
});

router.post('/', (req, res) => {
  const record = req.body;
  db.query('INSERT INTO records SET ?', record, (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.status(201).json({ id: result.insertId, ...record });
  });
});

router.put('/:id', (req, res) => {
  const id = req.params.id;
  const newRecord = req.body;
  db.query('UPDATE records SET ? WHERE id = ?', [newRecord, id], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json({ id, ...newRecord });
  });
});

router.delete('/:id', (req, res) => {
  const id = req.params.id;
  db.query('DELETE FROM records WHERE id = ?', [id], (err, result) => {
    if (err) {
      return res.status(500).send(err);
    }
    res.json({ id });
  });
});

module.exports = router;
