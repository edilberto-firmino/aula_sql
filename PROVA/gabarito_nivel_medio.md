# Gabarito do Professor - Nivel Medio

## Respostas esperadas

1. Os usuarios cadastrados sao Alice Souza, Bruno Lima, Carlos Melo e Daniela Rocha.
2. Os dispositivos cadastrados incluem notebooks e desktop, com destaque para o Dell Latitude 3420 de patrimonio NT-101.
3. Os arquivos cadastrados sao `lista_clientes.xlsx`, `folha_pagamento.xlsx` e `manual_sistema.pdf`.
4. O log do acesso externo e o registro `id = 4`.
5. O usuario do acesso externo e **Bruno Lima**.
6. O dispositivo usado foi o **Dell Latitude 3420**, patrimonio **NT-101**.
7. O IP usado foi **189.45.33.80**.
8. O arquivo baixado no registro suspeito foi **lista_clientes.xlsx**.
9. O usuario investigado pertence ao setor de **Suporte**.
10. A conclusao esperada e que Bruno Lima realizou um acesso externo e, em seguida, fez download suspeito do arquivo `lista_clientes.xlsx`.

## 10 consultas de referencia

### 1. Quais usuarios estao cadastrados no sistema?

```sql
SELECT *
FROM usuarios
ORDER BY nome;
```

### 2. Quais dispositivos estao cadastrados?

```sql
SELECT *
FROM dispositivos
ORDER BY modelo;
```

### 3. Quais arquivos estao cadastrados?

```sql
SELECT *
FROM arquivos
ORDER BY nome_arquivo;
```

### 4. Qual log registra um acesso externo?

```sql
SELECT *
FROM logs_acesso
WHERE observacao = 'Acesso externo';
```

### 5. Qual usuario fez o acesso externo?

```sql
SELECT
    u.nome,
    l.data_hora,
    l.acao
FROM logs_acesso l
JOIN usuarios u ON u.id = l.usuario_id
WHERE l.observacao = 'Acesso externo';
```

### 6. Qual dispositivo foi usado nesse acesso externo?

```sql
SELECT
    d.modelo,
    d.patrimonio,
    l.data_hora
FROM logs_acesso l
JOIN dispositivos d ON d.id = l.dispositivo_id
WHERE l.observacao = 'Acesso externo';
```

### 7. Qual IP foi usado nesse acesso externo?

```sql
SELECT
    ip.ip,
    ip.origem
FROM logs_acesso l
JOIN enderecos_ip ip ON ip.id = l.ip_id
WHERE l.observacao = 'Acesso externo';
```

### 8. Qual arquivo foi baixado no registro suspeito?

```sql
SELECT
    a.nome_arquivo,
    d.status_download,
    d.data_download
FROM downloads d
JOIN arquivos a ON a.id = d.arquivo_id
WHERE d.status_download = 'SUSPEITO';
```

### 9. Qual setor pertence ao usuario investigado?

```sql
SELECT
    u.nome,
    s.nome AS setor
FROM usuarios u
JOIN setores s ON s.id = u.setor_id
WHERE u.nome = 'Bruno Lima';
```

### 10. Qual consulta junta os principais dados do caso?

```sql
SELECT
    u.nome AS usuario,
    a.nome_arquivo,
    l.data_hora,
    d.status_download
FROM downloads d
JOIN usuarios u ON u.id = d.usuario_id
JOIN arquivos a ON a.id = d.arquivo_id
JOIN logs_acesso l ON l.id = d.log_id
WHERE d.status_download = 'SUSPEITO';
```
