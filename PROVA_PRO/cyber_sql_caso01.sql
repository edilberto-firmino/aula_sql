-- Cyber SQL - Caso 01
-- Banco de dados para aula investigativa de SQL
-- Compatível com MySQL 8+

DROP DATABASE IF EXISTS cyber_sql;
CREATE DATABASE cyber_sql;
USE cyber_sql;

CREATE TABLE setores (
    id INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL
);

CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(120) NOT NULL,
    setor_id INT NOT NULL,
    cargo VARCHAR(80) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (setor_id) REFERENCES setores(id)
);

CREATE TABLE dispositivos (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    modelo VARCHAR(80) NOT NULL,
    sistema_operacional VARCHAR(50) NOT NULL,
    patrimonio VARCHAR(30) NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE enderecos_ip (
    id INT PRIMARY KEY,
    ip VARCHAR(45) NOT NULL,
    origem VARCHAR(80) NOT NULL,
    risco VARCHAR(20) NOT NULL
);

CREATE TABLE arquivos (
    id INT PRIMARY KEY,
    nome_arquivo VARCHAR(150) NOT NULL,
    classificacao VARCHAR(30) NOT NULL,
    setor_responsavel INT NOT NULL,
    FOREIGN KEY (setor_responsavel) REFERENCES setores(id)
);

CREATE TABLE logs_acesso (
    id INT PRIMARY KEY,
    usuario_id INT NOT NULL,
    dispositivo_id INT NOT NULL,
    ip_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    acao VARCHAR(60) NOT NULL,
    sucesso BOOLEAN NOT NULL,
    observacao VARCHAR(200),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(id),
    FOREIGN KEY (ip_id) REFERENCES enderecos_ip(id)
);

CREATE TABLE downloads (
    id INT PRIMARY KEY,
    log_id INT NOT NULL,
    usuario_id INT NOT NULL,
    arquivo_id INT NOT NULL,
    data_download DATETIME NOT NULL,
    status_download VARCHAR(30) NOT NULL,
    justificativa VARCHAR(200),
    FOREIGN KEY (log_id) REFERENCES logs_acesso(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (arquivo_id) REFERENCES arquivos(id)
);

CREATE TABLE mensagens (
    id INT PRIMARY KEY,
    remetente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    assunto VARCHAR(120) NOT NULL,
    conteudo VARCHAR(255) NOT NULL,
    FOREIGN KEY (remetente_id) REFERENCES usuarios(id),
    FOREIGN KEY (destinatario_id) REFERENCES usuarios(id)
);

INSERT INTO setores (id, nome) VALUES
(1, 'Infraestrutura'),
(2, 'Financeiro'),
(3, 'Comercial'),
(4, 'Seguranca da Informacao'),
(5, 'Diretoria');

INSERT INTO usuarios (id, nome, email, setor_id, cargo, ativo) VALUES
(1, 'Ana Ribeiro', 'ana.ribeiro@datasecure.com', 4, 'Analista de Seguranca', TRUE),
(2, 'Bruno Macedo', 'bruno.macedo@datasecure.com', 1, 'Tecnico de Suporte', TRUE),
(3, 'Carla Nunes', 'carla.nunes@datasecure.com', 2, 'Assistente Financeiro', TRUE),
(4, 'Diego Lima', 'diego.lima@datasecure.com', 3, 'Executivo de Contas', TRUE),
(5, 'Elaine Torres', 'elaine.torres@datasecure.com', 5, 'Diretora Operacional', TRUE),
(6, 'Fabio Costa', 'fabio.costa@datasecure.com', 1, 'Administrador de Redes', TRUE);

INSERT INTO dispositivos (id, usuario_id, tipo, modelo, sistema_operacional, patrimonio) VALUES
(1, 1, 'Notebook', 'Lenovo ThinkPad T14', 'Windows 11', 'DS-NT-014'),
(2, 2, 'Notebook', 'Dell Latitude 5420', 'Windows 10', 'DS-NT-021'),
(3, 3, 'Desktop', 'HP ProDesk 400', 'Windows 10', 'DS-DT-008'),
(4, 4, 'Notebook', 'Acer Aspire 5', 'Windows 11', 'DS-NT-032'),
(5, 5, 'Notebook', 'MacBook Pro 14', 'macOS', 'DS-NT-002'),
(6, 6, 'Desktop', 'Dell OptiPlex 7090', 'Ubuntu 22.04', 'DS-DT-003');

INSERT INTO enderecos_ip (id, ip, origem, risco) VALUES
(1, '10.0.0.15', 'Rede Interna - Matriz', 'BAIXO'),
(2, '10.0.0.23', 'Rede Interna - Financeiro', 'BAIXO'),
(3, '177.54.22.90', 'VPN Corporativa', 'MEDIO'),
(4, '45.227.18.91', 'Conexao Externa Desconhecida', 'ALTO'),
(5, '201.88.140.12', 'Provedor Residencial', 'MEDIO'),
(6, '10.0.0.45', 'Rede Interna - Diretoria', 'BAIXO');

INSERT INTO arquivos (id, nome_arquivo, classificacao, setor_responsavel) VALUES
(1, 'manual_onboarding.pdf', 'INTERNO', 1),
(2, 'folha_pagamento_abr_2026.xlsx', 'CONFIDENCIAL', 2),
(3, 'clientes_vip_2026.xlsx', 'SIGILOSO', 3),
(4, 'plano_expansao_2027.pptx', 'CONFIDENCIAL', 5),
(5, 'politica_senhas.docx', 'INTERNO', 4),
(6, 'contratos_parceiros.zip', 'CONFIDENCIAL', 3);

INSERT INTO logs_acesso (id, usuario_id, dispositivo_id, ip_id, data_hora, acao, sucesso, observacao) VALUES
(1, 1, 1, 1, '2026-04-11 08:05:11', 'LOGIN', TRUE, 'Entrada normal no inicio do expediente'),
(2, 2, 2, 1, '2026-04-11 08:12:44', 'LOGIN', TRUE, 'Acesso rotineiro do suporte'),
(3, 3, 3, 2, '2026-04-11 08:21:10', 'LOGIN', TRUE, 'Acesso do financeiro'),
(4, 4, 4, 3, '2026-04-11 09:02:51', 'LOGIN', TRUE, 'Acesso remoto aprovado'),
(5, 5, 5, 6, '2026-04-11 09:15:18', 'LOGIN', TRUE, 'Acesso da diretoria'),
(6, 2, 2, 1, '2026-04-11 15:40:33', 'VISUALIZOU_ARQUIVO', TRUE, 'Consulta a documento interno'),
(7, 3, 3, 2, '2026-04-11 16:05:47', 'DOWNLOAD_ARQUIVO', TRUE, 'Download autorizado da folha'),
(8, 6, 6, 1, '2026-04-11 18:10:25', 'LOGIN', TRUE, 'Acesso para manutencao de rede'),
(9, 2, 2, 4, '2026-04-12 02:14:33', 'LOGIN', TRUE, 'Login fora do horario a partir de IP externo'),
(10, 2, 2, 4, '2026-04-12 02:16:09', 'DOWNLOAD_ARQUIVO', TRUE, 'Download de arquivo sigiloso sem chamado registrado'),
(11, 2, 2, 4, '2026-04-12 02:18:44', 'LOGOUT', TRUE, 'Sessao encerrada rapidamente'),
(12, 1, 1, 1, '2026-04-12 07:48:02', 'LOGIN', TRUE, 'Analista acessa para verificar alertas'),
(13, 1, 1, 1, '2026-04-12 07:52:19', 'TENTOU_REMOVER_LOG', FALSE, 'Permissao negada para exclusao'),
(14, 4, 4, 3, '2026-04-12 09:11:56', 'DOWNLOAD_ARQUIVO', TRUE, 'Download de contrato aprovado'),
(15, 6, 6, 5, '2026-04-12 10:22:41', 'LOGIN', TRUE, 'Acesso remoto do administrador'),
(16, 2, 2, 1, '2026-04-12 10:40:05', 'LOGIN', TRUE, 'Acesso presencial no expediente');

INSERT INTO downloads (id, log_id, usuario_id, arquivo_id, data_download, status_download, justificativa) VALUES
(1, 7, 3, 2, '2026-04-11 16:05:47', 'AUTORIZADO', 'Rotina do fechamento mensal'),
(2, 10, 2, 3, '2026-04-12 02:16:09', 'SUSPEITO', 'Nao havia chamado nem autorizacao formal'),
(3, 14, 4, 6, '2026-04-12 09:11:56', 'AUTORIZADO', 'Envio para parceiro comercial');

INSERT INTO mensagens (id, remetente_id, destinatario_id, data_hora, assunto, conteudo) VALUES
(1, 5, 1, '2026-04-11 11:30:00', 'Auditoria interna', 'Precisamos revisar os acessos sensiveis ate segunda.'),
(2, 2, 4, '2026-04-11 23:48:12', 'Lista de clientes', 'Se eu conseguir puxar a planilha hoje, depois conversamos.'),
(3, 4, 2, '2026-04-11 23:50:03', 'RE: Lista de clientes', 'Faz rapido e apaga qualquer rastro estranho.'),
(4, 1, 6, '2026-04-12 07:55:44', 'Alerta de seguranca', 'Detectei login fora do horario com IP externo.'),
(5, 6, 1, '2026-04-12 08:02:17', 'RE: Alerta de seguranca', 'O usuario Bruno aparece ligado ao dispositivo DS-NT-021.'),
(6, 3, 5, '2026-04-12 08:35:29', 'Folha enviada', 'A planilha mensal ja foi encaminhada para a diretoria.');

-- Consultas de apoio rapido para o professor
-- SELECT * FROM logs_acesso ORDER BY data_hora;
-- SELECT * FROM downloads;
-- SELECT * FROM mensagens ORDER BY data_hora;
