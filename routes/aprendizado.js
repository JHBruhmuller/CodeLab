const express = require('express');
const router = express.Router();
const banco = require('../banco');

// Middleware de autenticação
function autenticado(req, res, next) {
    if (req.session.usuario) {
        next();
    } else {
        res.redirect('/login');
    }
}

// Aplica o middleware à rota
router.get('/', autenticado, async (req, res) => {
    try {
        const usuario = req.session.usuario;
        const linguagens = await banco.obterAprendizadoDoUsuario(usuario.id);

        res.render('aprendizado', {
            titulo: 'Meu Aprendizado',
            email: usuario.email,
            linguagens
        });
    } catch (erro) {
        console.error('Erro em buscar aprendizado:', erro);
        res.status(500).send("Erro interno do servidor");
    }
});

module.exports = router;
