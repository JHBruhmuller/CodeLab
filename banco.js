const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'CodeLabDb',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

async function conectarBD() {
    return pool;
}


async function buscarUsuario({ email, senha }) {
    const conexao = await conectarBD();

    const sql = "SELECT * FROM Usuario WHERE email = ?";
    const [resultado] = await conexao.query(sql, [email]);

    if (resultado.length === 0) return null;

    const usuario = resultado[0];

    const senhaCorreta = await bcrypt.compare(senha, usuario.senha);

    if (senhaCorreta) {
        return usuario;
    }

    return null;
}

async function buscarUsuarioPorEmail(email) {
    const conexao = await conectarBD();

    const sql = "SELECT * FROM Usuario WHERE email = ?";
    const [resultado] = await conexao.query(sql, [email]);

    return (resultado.length > 0) ? resultado[0] : null;
}

async function criarUsuario({ nome, email, senha }) {
    const conexao = await conectarBD();

    const hash = await bcrypt.hash(senha, 10); // força 10

    const sql = "INSERT INTO Usuario (nome, email, senha) VALUES (?, ?, ?)";
    await conexao.query(sql, [nome, email, hash]);
}

async function listarLinguagens() {
    const conexao = await conectarBD();

    const sql = "SELECT * FROM Linguagem";
    const [linguagens] = await conexao.query(sql);

    return linguagens;
}

async function listarDesafiosPorLinguagem(nomeLinguagem, { busca, estrelas } = {}) {
    const conexao = await conectarBD();

    let sql = `
        SELECT 
            d.id_desafio AS id, 
            d.titulo, 
            d.descricao,
            d.estrelas, 
            d.bits 
        FROM Desafio d
        JOIN Linguagem l ON d.id_linguagem = l.id_linguagem
        WHERE l.nome = ?
    `;

    const params = [nomeLinguagem];

    if (busca) {
        sql += ' AND d.titulo LIKE ?';
        params.push(`%${busca}%`);
    }

    if (estrelas) {
        sql += ' AND d.estrelas = ?';
        params.push(estrelas);
    }

    const [desafios] = await conexao.query(sql, params);

    return desafios;
}

async function obterRankingUsuarios(limit = 10) {
    const conexao = await conectarBD();

    const sql = `
        SELECT 
            id_usuario,
            nome,
            titulo,
            bits,
            foto_perfil
        FROM Usuario
        ORDER BY bits DESC
        LIMIT ?
    `;

    const [usuarios] = await conexao.query(sql, [limit]);
    return usuarios;
}

async function buscarDesafioPorId(idDesafio) {
    const conexao = await conectarBD();

    const sql = `
        SELECT d.*, l.nome AS linguagem
        FROM Desafio d
        JOIN Linguagem l ON d.id_linguagem = l.id_linguagem
        WHERE d.id_desafio = ?
    `;

    const [resultado] = await conexao.query(sql, [idDesafio]);

    return resultado.length > 0 ? resultado[0] : null;
}

async function listarComentariosPorDesafio(idDesafio) {
    const conexao = await conectarBD();

    const sql = `
        SELECT c.texto, u.nome AS usuario
        FROM Comentario c
        JOIN Usuario u ON c.id_usuario = u.id_usuario
        WHERE c.id_desafio = ?
        ORDER BY c.data_comentario DESC
    `;

    const [comentarios] = await conexao.query(sql, [idDesafio]);

    return comentarios;
}

async function inserirComentario(idUsuario, idDesafio, texto) {
    const conexao = await conectarBD();

    const sql = `
        INSERT INTO Comentario (id_usuario, id_desafio, texto)
        VALUES (?, ?, ?)
    `;

    await conexao.query(sql, [idUsuario, idDesafio, texto]);
}

async function limparUsuarios() {
  const conexao = await conectarBD();
  await conexao.query("DELETE FROM Usuario");
}

async function obterAprendizadoDoUsuario(id_usuario) {
    const conexao = await conectarBD();


    const sql = `
        SELECT
            l.id_linguagem,
            l.nome AS nome_linguagem,
            d.id_desafio,
            d.titulo,
            d.estrelas,
            d.bits,
            s.status_conclusao
        FROM Submissao s
        JOIN Desafio d ON s.id_desafio = d.id_desafio
        JOIN Linguagem l ON d.id_linguagem = l.id_linguagem
        WHERE s.id_usuario = ?
        GROUP BY l.id_linguagem, d.id_desafio
        ORDER BY l.nome, d.titulo
    `;


    const [linhas] = await conexao.query(sql, [id_usuario]);


    // Agrupa os resultados por linguagem
    const resultado = {};
    for (const linha of linhas) {
        if (!resultado[linha.nome_linguagem]) {
            resultado[linha.nome_linguagem] = {
                id_linguagem: linha.id_linguagem,
                desafios: []
            };
        }


        resultado[linha.nome_linguagem].desafios.push({
            id: linha.id_desafio,
            titulo: linha.titulo,
            estrelas: linha.estrelas,
            bits: linha.bits,
            concluido: linha.status_conclusao === 1
        });
    }


    return resultado;
}


module.exports = {
    conectarBD,
    buscarUsuario,
    buscarUsuarioPorEmail,
    criarUsuario,
    listarLinguagens,
    listarDesafiosPorLinguagem,
    obterRankingUsuarios,
    buscarDesafioPorId,
    listarComentariosPorDesafio,
    inserirComentario,
    obterAprendizadoDoUsuario,
    limparUsuarios
};

