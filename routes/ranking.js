const express = require('express');
const router = express.Router();

router.get('/', async function (req, res) {
  const ranking = await global.banco.obterRankingUsuarios();

  res.render('ranking', {
    ranking
  });
});

module.exports = router;
