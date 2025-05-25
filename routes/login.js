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
    req.session.usuario = {
      id: usuario.id_usuario,
      nome: usuario.nome,
      email: usuario.email,
      foto_perfil: usuario.foto_perfil,
      titulo: usuario.titulo,
      bits: usuario.bits,
      desafios_resolvidos: usuario.desafios_resolvidos
    };
    res.redirect('/inicio');
  } else {
    req.session.erro = "Login inválido!";
    res.redirect('/login');
  }
});

router.get('/logout', (req, res) => {
  req.session.destroy();
  res.redirect('/login');
});

module.exports = router;
