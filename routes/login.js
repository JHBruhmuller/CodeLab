const express = require('express');
const router = express.Router();

router.get('/', function (req, res) {
  res.render('login', {
    titulo: 'Login',
    erro: req.session.erro,
    sucesso: req.session.sucesso
  });

  req.session.erro = null;
  req.session.sucesso = null;
});


router.post('/', async function (req, res) {
  const { email, senha } = req.body;
  const usuario = await global.banco.buscarUsuario({ email, senha });

  if (usuario && usuario.id_usuario) {
    req.session.id_usuario = usuario.id_usuario;
    req.session.email = usuario.email;
    res.redirect('/inicio');
  } else {
    req.session.erro = "Login inválido!";
    res.redirect('/login');
  }
});

module.exports = router;
