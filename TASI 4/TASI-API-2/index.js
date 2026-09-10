const express = require('express');
const app = express();

app.use(express.json());

app.get('/', function(req, res) {
    res.send('Rota raiz');
});

app.post('/chamados', function(req, res) {
    const titulo = req.body.titulo;
    const descricao = req.body.descricao;
    const usuario = req.body.usuario;

    if (!usuario || usuario.trim() === '') {
        return res.status(400).json({
            "mensagem": "Erro: O campo 'usuario' não pode estar em branco."
        });
    }

    res.json({
        "mensagem": "informação recebida com sucesso",
        "informaçoes": { titulo, descricao, usuario }
    });
});

app.listen(3000, function() {
    console.log('servidor rodando na porta 3000');
});