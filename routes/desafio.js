const express = require('express');
const router = express.Router();
const db = require('../banco');

function autenticado(req, res, next) {
    if (req.session.usuario) {
        next();
    } else {
        res.redirect('/login');
    }
}

router.get('/:id', autenticado, async (req, res) => {
    const idDesafio = req.params.id;

    try {
        const desafio = await db.buscarDesafioPorId(idDesafio);

        if (!desafio) {
            return res.status(404).send('Desafio não encontrado');
        }

        const comentarios = await db.listarComentariosPorDesafio(idDesafio);

        res.render('desafio', {
            desafio,
            comentarios
        });

    } catch (error) {
        console.error('Erro ao buscar desafio:', error);
        res.status(500).send('Erro interno');
    }
});

router.post('/:id/comentario', async (req, res) => {
    const idDesafio = req.params.id;
    const { texto } = req.body;
    const idUsuario = req.session.usuario?.id; // Pega id do usuário logado

    if (!idUsuario) {
        req.session.erro = 'Você precisa estar logado para comentar.';
        return res.redirect('/login');
    }

    if (!texto || texto.trim() === '') {
        req.session.erro = 'Comentário não pode ser vazio.';
        return res.redirect(`/desafio/${idDesafio}`);
    }

    try {
        await db.inserirComentario(idUsuario, idDesafio, texto);
        res.redirect(`/desafio/${idDesafio}`);
    } catch (error) {
        console.error('Erro ao inserir comentário:', error);
        res.status(500).send('Erro interno');
    }
});


module.exports = router;
