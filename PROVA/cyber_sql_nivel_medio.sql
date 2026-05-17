-- Cyber SQL - Nivel Medio
-- Caso simplificado para turmas de ensino medio
-- Compatível com MySQL 8+

DROP DATABASE IF EXISTS cyber_sql_nivel_medio;
CREATE DATABASE cyber_sql_nivel_medio;
USE cyber_sql_nivel_medio;

CREATE TABLE setores (
    id INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    setor_id INT NOT NULL,
    FOREIGN KEY (setor_id) REFERENCES setores(id)
);

CREATE TABLE dispositivos (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    modelo VARCHAR(80) NOT NULL,
    patrimonio VARCHAR(30) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE enderecos_ip (
    id INT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL,
    origem VARCHAR(80) NOT NULL
);

CREATE TABLE arquivos (
    id INT PRIMARY KEY,
    nome_arquivo VARCHAR(120) NOT NULL,
    classificacao VARCHAR(20) NOT NULL
);

CREATE TABLE logs_acesso (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    dispositivo_id INT NOT NULL,
    ip_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    acao VARCHAR(50) NOT NULL,
    observacao VARCHAR(200),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(id),
    FOREIGN KEY (ip_id) REFERENCES enderecos_ip(id)
);

CREATE TABLE downloads (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    arquivo_id INT NOT NULL,
    log_id INT NOT NULL,
    status_download VARCHAR(20) NOT NULL,
    data_download DATETIME NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (arquivo_id) REFERENCES arquivos(id),
    FOREIGN KEY (log_id) REFERENCES logs_acesso(id)
);

INSERT INTO setores (id, nome) VALUES
(1, 'Financeiro'),
(2, 'Suporte'),
(3, 'Comercial');

INSERT INTO usuarios (id, nome, setor_id) VALUES
(1, 'Alice Souza', 1),
(2, 'Bruno Lima', 2),
(3, 'Carlos Melo', 3),
(4, 'Daniela Rocha', 1);

INSERT INTO dispositivos (id, usuario_id, tipo, modelo, patrimonio) VALUES
(1, 1, 'Notebook', 'Lenovo ThinkBook 14', 'NT-100'),
(2, 2, 'Notebook', 'Dell Latitude 3420', 'NT-101'),
(3, 3, 'Desktop', 'HP ProDesk 400', 'DT-200'),
(4, 4, 'Notebook', 'Acer Aspire 5', 'NT-102');

INSERT INTO enderecos_ip (id, ip, origem) VALUES
(1, '10.0.0.10', 'Rede Interna'),
(2, '10.0.0.25', 'Rede Interna'),
(3, '189.45.33.80', 'Acesso Externo');

INSERT INTO arquivos (id, nome_arquivo, classificacao) VALUES
(1, 'lista_clientes.xlsx', 'SIGILOSO'),
(2, 'folha_pagamento.xlsx', 'CONFIDENCIAL'),
(3, 'manual_sistema.pdf', 'INTERNO');

INSERT INTO logs_acesso (id, usuario_id, dispositivo_id, ip_id, data_hora, acao, observacao) VALUES
(1, 1, 1, 1, '2026-03-10 08:00:00', 'LOGIN', 'Entrada normal'),
(2, 2, 2, 2, '2026-03-10 08:10:00', 'LOGIN', 'Entrada normal'),
(3, 3, 3, 1, '2026-03-10 08:15:00', 'LOGIN', 'Entrada normal'),
(4, 2, 2, 3, '2026-03-10 22:30:00', 'LOGIN', 'Acesso externo'),
(5, 2, 2, 3, '2026-03-10 22:35:00', 'DOWNLOAD_ARQUIVO', 'Download fora do expediente'),
(6, 4, 4, 2, '2026-03-10 14:20:00', 'LOGIN', 'Entrada normal');

INSERT INTO downloads (id, usuario_id, arquivo_id, log_id, status_download, data_download) VALUES
(1, 2, 1, 5, 'SUSPEITO', '2026-03-10 22:35:00'),
(2, 1, 3, 1, 'AUTORIZADO', '2026-03-10 08:05:00'),
(3, 4, 2, 6, 'AUTORIZADO', '2026-03-10 14:30:00');
