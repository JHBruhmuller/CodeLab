const express = require('express');
const router = express.Router();

// Exibe o formulário de login
router.get('/', function (req, res) {
  res.render('login', {
    titulo: 'Login'
  });

  // Limpa mensagens depois de exibir
  req.session.erro = null;
  req.session.sucesso = null;
});

// Processa o login
router.post('/', async function (req, res) {
  const { email, senha } = req.body;

  try {
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
  } catch (err) {
    console.error('Erro no login:', err);
    req.session.erro = "Erro interno no servidor.";
    res.redirect('/login');
  }
});

// Logout
router.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.error('Erro ao destruir sessão:', err);
      return res.redirect('/inicio');
    }
    res.clearCookie('connect.sid');
    res.redirect('/login');
  });
});

module.exports = router;
