const express = require('express');
const router = express.Router();

const db = require('../banco');

router.get('/:nome', async (req, res) => {
    const nomeLinguagem = req.params.nome;
    const { busca, estrelas } = req.query;

    try {
        const desafios = await db.listarDesafiosPorLinguagem(nomeLinguagem, { busca, estrelas });

        res.render('desafios', {
            linguagem: nomeLinguagem,
            desafios,
            busca,
            estrelas
        });
    } catch (error) {
        console.error('Erro ao listar desafios:', error);
        res.status(500).send('Erro interno.');
    }
});

module.exports = router;