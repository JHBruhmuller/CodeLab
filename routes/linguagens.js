const express = require('express');
const router = express.Router();
const db = require('../banco');

router.get('/:nome', async (req, res) => {
    const nomeLinguagem = req.params.nome;
    const { busca, estrelas } = req.query;

    try {
        const linguagens = await db.listarLinguagens();
        const linguagemExiste = linguagens.some(l => l.nome.toLowerCase() === nomeLinguagem.toLowerCase());

        if (!linguagemExiste) {
            return res.status(404).send('Linguagem não encontrada');
        }

        const desafios = await db.listarDesafiosPorLinguagem(nomeLinguagem, { busca, estrelas });

        res.render('linguagens', {
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
