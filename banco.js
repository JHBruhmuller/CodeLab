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

module.exports = {
    buscarUsuario,
    buscarUsuarioPorEmail,
    criarUsuario,
    listarLinguagens,
    listarDesafiosPorLinguagem,
    obterRankingUsuarios 
};
