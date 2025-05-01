-- cire o banco de dados
CREATE DATABASE compras;
USE compras;

-- Cracao de Tabelas com atributos
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    total_compras INT DEFAULT 0
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE compra (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_produto INT,
    quantidade INT NOT NULL,
    data_compra DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto) ON DELETE CASCADE
);

-- Inseririndo dados nas tabelas
INSERT INTO cliente (nome, email, total_compras) VALUES
('João Silva', 'joao.silva@email.com', 2),
('Maria Oliveira', 'maria.oliveira@email.com', 1),
('Pedro Santos', 'pedro.santos@email.com', 0);

INSERT INTO produto (nome, preco, estoque) VALUES
('Pão de Mel', 5.00, 10),
('Pão de Queijo', 3.50, 15),
('Pão de Sal', 2.00, 50);

INSERT INTO compra (id_cliente, id_produto, quantidade, data_compra) VALUES
(1, 1, 1, '2025-04-01'), -- João compra 1 espada
(1, 3, 2, '2025-04-02'), -- João compra 2 poções
(2, 2, 1, '2025-04-03'); -- Maria compra 1 escudo

-- Consultas usando JOINs

-- 1. Listar todas as compras com detalhes do cliente e produto
SELECT 
    c.id_compra,
    cl.nome AS cliente,
    p.nome AS produto,
    c.quantidade,
    p.preco * c.quantidade AS valor_total,
    c.data_compra
FROM compra c
INNER JOIN cliente cl ON c.id_cliente = cl.id_cliente
INNER JOIN produto p ON c.id_produto = p.id_produto;

-- 2. Total gasto por cliente
SELECT 
    cl.nome,
    COALESCE(SUM(p.preco * c.quantidade), 0) AS total_gasto
FROM cliente cl
LEFT JOIN compra c ON cl.id_cliente = c.id_cliente
LEFT JOIN produto p ON c.id_produto = p.id_produto
GROUP BY cl.id_cliente, cl.nome;

-- 3. Produtos mais vendidos
SELECT 
    p.nome,
    COALESCE(SUM(c.quantidade), 0) AS total_vendido
FROM produto p
LEFT JOIN compra c ON p.id_produto = c.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_vendido DESC;