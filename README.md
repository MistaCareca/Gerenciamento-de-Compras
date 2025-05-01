
# Gerenciamento de Compras

## Descrição
Este projeto implementa um sistema de gerenciamento de compras em SQL, permitindo o cadastro de clientes, produtos e compras, além de consultas analíticas sobre os dados.

## Estrutura do Banco de Dados
O banco de dados `compras` contém três tabelas principais:
- **cliente**: Armazena informações dos clientes (id, nome, email, total de compras).
- **produto**: Registra os produtos disponíveis (id, nome, preço, estoque).
- **compra**: Registra as compras realizadas (id, id do cliente, id do produto, quantidade, data da compra).

### Relacionamentos
- A tabela `compra` possui chaves estrangeiras que referenciam `cliente` e `produto`, com exclusão em cascata (`ON DELETE CASCADE`).

## Pré-requisitos
- MySQL ou outro SGBD compatível com SQL.
- Permissões para criar e manipular bancos de dados.

## Instalação
1. Execute o script SQL fornecido (`db_compras.sql`) para criar o banco de dados, tabelas e inserir os dados iniciais.
   ```bash
   mysql -u [usuário] -p < db_compras.sql
   ```
2. Conecte-se ao banco de dados `compras`:
   ```sql
   USE compras;
   ```

## Estrutura do Script
O script contém:
1. **Criação do Banco de Dados**:
   - Cria o banco `compras` e seleciona-o para uso.
2. **Criação das Tabelas**:
   - Tabelas `cliente`, `produto` e `compra` com seus respectivos atributos e restrições.
3. **Inserção de Dados**:
   - Dados de exemplo para clientes, produtos e compras.
4. **Consultas Analíticas**:
   - Lista de todas as compras com detalhes de cliente e produto.
   - Total gasto por cliente.
   - Produtos mais vendidos, ordenados por quantidade.

## Consultas Disponíveis
1. **Listar Compras com Detalhes**:
   - Exibe o ID da compra, nome do cliente, nome do produto, quantidade, valor total e data.
2. **Total Gasto por Cliente**:
   - Calcula o total gasto por cada cliente, incluindo clientes sem compras.
3. **Produtos Mais Vendidos**:
   - Mostra a quantidade total vendida de cada produto, ordenada do mais vendido ao menos vendido.

## Exemplo de Uso
Para executar uma consulta, como o total gasto por cliente:
```sql
SELECT 
    cl.nome,
    COALESCE(SUM(p.preco * c.quantidade), 0) AS total_gasto
FROM cliente cl
LEFT JOIN compra c ON cl.id_cliente = c.id_cliente
LEFT JOIN produto p ON c.id_produto = p.id_produto
GROUP BY cl.id_cliente, cl.nome;
```

## Observações
- Os dados inseridos são exemplos e podem ser modificados conforme necessário.
- As consultas utilizam `JOIN` e `COALESCE` para lidar com casos de clientes ou produtos sem compras.
- O campo `total_compras` na tabela `cliente` não é atualizado automaticamente; pode ser mantido via *trigger* ou aplicação.
