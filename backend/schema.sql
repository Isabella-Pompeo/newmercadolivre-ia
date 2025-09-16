-- Tabela usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('comprador', 'vendedor')),
    data_cadastro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    google_id VARCHAR(255),
    avatar_url TEXT
);

-- Tabela vendedores
CREATE TABLE vendedores (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER UNIQUE NOT NULL REFERENCES usuarios(id),
    nome_loja VARCHAR(255) NOT NULL,
    descricao_loja TEXT,
    nota_media NUMERIC(3, 2),
    total_vendas INTEGER DEFAULT 0,
    dados_pagamento TEXT -- Consider encrypting this in a real application
);

-- Tabela produtos
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    vendedor_id INTEGER NOT NULL REFERENCES vendedores(id),
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10, 2) NOT NULL,
    arquivo_url TEXT NOT NULL,
    thumbnail_url TEXT,
    video_url TEXT,
    tipo_automacao VARCHAR(100),
    linguagem_prog VARCHAR(100),
    status VARCHAR(50) DEFAULT 'pendente' CHECK (status IN ('ativo', 'inativo', 'pendente')),
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela compatibilidade
CREATE TABLE compatibilidade (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL REFERENCES produtos(id),
    sistema_compativel VARCHAR(255) NOT NULL
);

-- Tabela avaliacoes
CREATE TABLE avaliacoes (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL REFERENCES produtos(id),
    comprador_id INTEGER NOT NULL REFERENCES usuarios(id),
    nota INTEGER NOT NULL CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    comprador_id INTEGER NOT NULL REFERENCES usuarios(id),
    produto_id INTEGER NOT NULL REFERENCES produtos(id),
    valor_total NUMERIC(10, 2) NOT NULL,
    status_pagamento VARCHAR(50) DEFAULT 'pendente' CHECK (status_pagamento IN ('pendente', 'aprovado', 'recusado')),
    data_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    mercado_pago_id VARCHAR(255)
);