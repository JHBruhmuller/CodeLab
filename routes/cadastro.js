const express = require('express');
const router = express.Router();

router.get('/', function (req, res) {
  res.render('cadastro', {
    titulo: 'Cadastro',
    erro: req.session.erro,
    sucesso: req.session.sucesso
  });

  req.session.erro = null;
  req.session.sucesso = null;
});
router.post('/', async function (req, res) {
  const { nome, email, senha } = req.body;

  const existente = await global.banco.buscarUsuarioPorEmail(email);
  if (existente) {
    req.session.erro = "Email já cadastrado!";
    return res.redirect('/cadastro');
  }

  await global.banco.criarUsuario({ nome, email, senha });
  req.session.sucesso = "Cadastro realizado!";
  res.redirect('/login');
});

module.exports = router;
