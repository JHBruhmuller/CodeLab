const express = require('express');
const path = require('path');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const session = require('express-session');

const loginRouter = require('./routes/login');
const cadastroRouter = require('./routes/cadastro');
const inicioRouter = require('./routes/inicio');
const linguagemRoutes = require('./routes/linguagens');
const rankingRouter = require('./routes/ranking');
const desafioRouter = require('./routes/desafio');
const aprendizadoRouter = require('./routes/aprendizado');

const banco = require('./banco');
global.banco = banco;

const app = express();

// Configura EJS
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Middlewares
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: 'segredo',  // Ideal: use process.env.SECRET
  resave: false,
  saveUninitialized: true
}));

// Torna o usuário disponível em todas as views EJS
app.use((req, res, next) => {
  res.locals.usuario = req.session.usuario || null;
  res.locals.erro = req.session.erro || null;
  res.locals.sucesso = req.session.sucesso || null;
  next();
});

// Rotas
app.use('/login', loginRouter);
app.use('/cadastro', cadastroRouter);
app.use('/inicio', inicioRouter);
app.use('/linguagem', linguagemRoutes);
app.use('/ranking', rankingRouter);
app.use('/desafio', desafioRouter);
app.use('/aprendizado', aprendizadoRouter);

app.get('/', (req, res) => {
  res.redirect('/login');
});

// Tratamento 404
app.use((req, res) => {
  res.status(404).render('error', {
    message: "Página não encontrada",
    error: { status: 404, stack: "" }
  });
});

module.exports = app;
