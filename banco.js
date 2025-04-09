const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

async function conectarBD() {
    if (global.conexao && global.conexao.state !== 'disconnected') {
        return global.conexao;
    }

    const conexao = await mysql.createConnection({
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: '',
        database: 'CodeLabDb'
    });

    global.conexao = conexao;
    return conexao;
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

module.exports = {
    buscarUsuario,
    buscarUsuarioPorEmail,
    criarUsuario
};
