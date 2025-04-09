const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.render('inicio', {
    titulo: 'Página Inicial',
    email: req.session?.email || 'Visitante'
  });
});

module.exports = router;
