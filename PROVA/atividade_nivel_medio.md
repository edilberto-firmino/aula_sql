# Cyber SQL - Nivel Medio

https://docs.google.com/forms/d/e/1FAIpQLSdq8Q-F0_fW6Wuv5pnCB7MU84acqajv6kdJ-yaHIYn-IZSOeg/viewform

## Missao

A empresa DataSecure Systems identificou um acesso suspeito em seu sistema. Sua tarefa e descobrir quem realizou a acao, qual arquivo foi envolvido e quais evidencias aparecem no banco de dados.

Use apenas:

- `SELECT`
- `WHERE`
- `JOIN`
- `ORDER BY`

## Banco de dados

Execute primeiro o arquivo `cyber_sql_nivel_medio.sql`.

## Perguntas

Responda as 10 perguntas abaixo com base no banco:

1. Quais usuarios estao cadastrados no sistema?  -  0,5
2. Quais dispositivos estao cadastrados?  -  0,5
3. Quais arquivos estao cadastrados?  -  0,5
4. Qual id do log registra um acesso externo?  -  0,5
5. Qual usuario fez o acesso externo?  -  1
6. Qual dispositivo foi usado nesse acesso externo?  -  1
7. Qual IP foi usado nesse acesso externo?  -  1
8. Qual arquivo foi baixado no registro suspeito?  -  1
9. Qual setor pertence ao usuario investigado?  -  1
10. Qual e a conclusao final da investigacao?  -  3

## Regras

- Responda cada pergunta com texto.
- Mostre a consulta SQL usada em cada resposta.
- Use consultas simples e organizadas.

## Dica

Comece vendo os dados das tabelas e depois cruze as informacoes do acesso externo com usuario, dispositivo, IP e arquivo.
