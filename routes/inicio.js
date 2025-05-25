const express = require('express');
const router = express.Router();
const db = require('../banco'); 

router.get('/', async (req, res) => {
    try {
        const linguagens = await db.listarLinguagens();

        res.render('inicio', {
            titulo: 'Página Inicial',
            email: req.session?.email || 'Visitante',
            linguagens: linguagens 
        });
    } catch (error) {
        console.error('Erro ao carregar linguagens:', error);
        res.status(500).send('Erro interno ao carregar linguagens.');
    }
});

module.exports = router;
