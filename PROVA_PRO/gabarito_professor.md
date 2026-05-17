# Gabarito do Professor - Cyber SQL Caso 01 - Nivel Ouro

## Respostas esperadas

1. O crime foi um download indevido de arquivo sigiloso, caracterizando vazamento de dados internos.
2. A acao principal ocorreu em `2026-04-12 02:16:09`.
3. O usuario envolvido foi **Bruno Macedo**.
4. O IP usado foi **45.227.18.91**.
5. O dispositivo utilizado foi o **Dell Latitude 5420**, patrimonio **DS-NT-021**.
6. O arquivo acessado de forma suspeita foi **clientes_vip_2026.xlsx**.
7. O usuario investigado trabalha no setor de **Infraestrutura**.
8. Sim. Houve login fora do horario em `2026-04-12 02:14:33`, ligado ao mesmo usuario e IP externo.
9. Sim. As mensagens entre Bruno Macedo e Diego Lima reforcam a suspeita.
10. O caso conecta o usuario Bruno Macedo, o notebook DS-NT-021, o IP 45.227.18.91 e o arquivo `clientes_vip_2026.xlsx`.
11. As consultas devem demonstrar essa ligacao com `JOIN` entre logs, downloads, usuarios, dispositivos, IPs e arquivos.
12. A conclusao esperada e que Bruno Macedo realizou, fora do horario normal, um login por IP externo e fez download indevido do arquivo sigiloso, com indicios complementares nas mensagens internas.

## Consultas de referencia

### 1. Encontrar acessos fora do horario

```sql
SELECT
    l.id,
    u.nome AS usuario,
    ip.ip,
    d.modelo AS dispositivo,
    l.data_hora,
    l.acao,
    l.observacao
FROM logs_acesso l
JOIN usuarios u ON u.id = l.usuario_id
JOIN dispositivos d ON d.id = l.dispositivo_id
JOIN enderecos_ip ip ON ip.id = l.ip_id
WHERE HOUR(l.data_hora) BETWEEN 0 AND 4
ORDER BY l.data_hora;
```

### 2. Verificar downloads suspeitos

```sql
SELECT
    u.nome AS usuario,
    a.nome_arquivo,
    a.classificacao,
    ip.ip,
    d.modelo AS dispositivo,
    dw.data_download,
    dw.status_download,
    dw.justificativa
FROM downloads dw
JOIN usuarios u ON u.id = dw.usuario_id
JOIN arquivos a ON a.id = dw.arquivo_id
JOIN logs_acesso l ON l.id = dw.log_id
JOIN enderecos_ip ip ON ip.id = l.ip_id
JOIN dispositivos d ON d.id = l.dispositivo_id
WHERE dw.status_download = 'SUSPEITO'
ORDER BY dw.data_download;
```

### 3. Relacionar usuario, IP, dispositivo e arquivo no mesmo caso

```sql
SELECT
    u.nome AS usuario,
    s.nome AS setor,
    d.modelo AS dispositivo,
    d.patrimonio,
    ip.ip,
    a.nome_arquivo,
    l.data_hora AS horario_login,
    dw.data_download
FROM downloads dw
JOIN logs_acesso l ON l.id = dw.log_id
JOIN usuarios u ON u.id = dw.usuario_id
JOIN setores s ON s.id = u.setor_id
JOIN dispositivos d ON d.id = l.dispositivo_id
JOIN enderecos_ip ip ON ip.id = l.ip_id
JOIN arquivos a ON a.id = dw.arquivo_id
WHERE dw.status_download = 'SUSPEITO'
ORDER BY dw.data_download;
```

### 4. Buscar mensagens relacionadas ao caso

```sql
SELECT
    r.nome AS remetente,
    dst.nome AS destinatario,
    m.data_hora,
    m.assunto,
    m.conteudo
FROM mensagens m
JOIN usuarios r ON r.id = m.remetente_id
JOIN usuarios dst ON dst.id = m.destinatario_id
WHERE m.conteudo LIKE '%planilha%'
   OR m.conteudo LIKE '%apaga qualquer rastro%'
ORDER BY m.data_hora;
```

### 5. Confirmar a linha do tempo do suspeito

```sql
SELECT
    u.nome AS usuario,
    l.data_hora,
    l.acao,
    ip.ip,
    d.modelo,
    l.observacao
FROM logs_acesso l
JOIN usuarios u ON u.id = l.usuario_id
JOIN enderecos_ip ip ON ip.id = l.ip_id
JOIN dispositivos d ON d.id = l.dispositivo_id
WHERE u.nome = 'Bruno Macedo'
ORDER BY l.data_hora;
```

## Sugestao de nota

- 1,0 ponto: identificou corretamente o crime
- 1,0 ponto: identificou corretamente o usuario
- 1,0 ponto: identificou corretamente o IP
- 1,0 ponto: identificou corretamente o dispositivo
- 1,0 ponto: identificou corretamente o arquivo
- 2,0 pontos: apresentou consultas SQL funcionais e coerentes
- 1,0 ponto: identificou a mensagem relevante
- 2,0 pontos: conclusao final bem justificada pelas evidencias
