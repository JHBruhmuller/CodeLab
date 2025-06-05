const express = require('express');
const router = express.Router();
const db = require('../banco'); 

// Middleware para proteger rotas
function autenticado(req, res, next) {
    if (req.session.usuario) {
        next();
    } else {
        req.session.erro = "Você precisa estar logado.";
        res.redirect('/login');
    }
}

router.get('/', autenticado, async (req, res) => {
    try {
        const linguagens = await db.listarLinguagens();

        res.render('inicio', {
            titulo: 'Página Inicial',
            linguagens: linguagens 
            // res.locals.usuario já contém o usuário na view automaticamente
        });
    } catch (error) {
        console.error('Erro ao carregar linguagens:', error);
        res.status(500).render('error', {
            message: 'Erro interno ao carregar linguagens.',
            error
        });
    }
});

module.exports = router;
