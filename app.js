const express = require('express');
const path = require('path');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const session = require('express-session');

const loginRouter = require('./routes/login');
const cadastroRouter = require('./routes/cadastro');
const inicioRouter = require('./routes/inicio');

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
  secret: 'segredo',
  resave: false,
  saveUninitialized: true
}));


app.use('/login', loginRouter);
app.use('/cadastro', cadastroRouter);
app.use('/inicio', inicioRouter);

app.get('/', (req, res) => {
  res.redirect('/login');
});
app.use(function (req, res, next) {
  res.status(404).render('error', {
    message: "Página não encontrada",
    error: { status: 404, stack: "" } // <- isso evita o erro no .ejs
  });
});


module.exports = app;
