const express = require('express');
const cors = require('cors');
const db = require('./db'); // Importa o módulo de conexão com o banco de dados

const app = express();
const port = process.env.PORT || 3001; // Usa a porta definida no .env ou 3001 como padrão

// Middlewares
app.use(cors()); // Permite requisições de diferentes origens
app.use(express.json()); // Permite que o servidor entenda JSON no corpo das requisições

// Rota de teste para verificar se o servidor está rodando
app.get('/', (req, res) => {
  res.send('Servidor do mercado-livre-ia está rodando!');
});

// Exemplo de como usar a conexão com o banco de dados (opcional, para teste)
app.get('/test-db', async (req, res) => {
  try {
    const result = await db.query('SELECT NOW()');
    res.json({ message: 'Conexão com o banco de dados bem-sucedida!', time: result.rows[0].now });
  } catch (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    res.status(500).json({ message: 'Erro ao conectar ao banco de dados.' });
  }
});

// Inicia o servidor
app.listen(port, () => {
  console.log(`Servidor backend rodando em http://localhost:${port}`);
});