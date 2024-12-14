-- Fazer uma relação de TODOS os clientes com :
--  - Código do cliente
--  - Nome do Cliente
--  - Maior compra do cliente em valor
--  - Data da ultima compra do cliente
--  - Limite de crédito do cliente
--  - Total de compras do cliente
--  - Total de pagamentos do cliente

SELECT 
    cl.codigoCliente,  -- Seleciona o código do cliente
    cl.nomeCliente,    -- Seleciona o nome do cliente
    
    -- Subconsulta para encontrar o valor da maior compra do cliente
    (SELECT 
            MAX(vendas.valorPedido)  -- Obtém o valor máximo de pedido
        FROM
            (SELECT 
                ped.codigoCliente,       -- Código do cliente
                ped.numeroPedido,        -- Número do pedido
                SUM(iped.quantidadeVendida * iped.precoUnitario) AS valorPedido  -- Soma do valor total de cada item no pedido
            FROM
                pedidos ped              -- Tabela de pedidos
            INNER JOIN itempedidos iped ON ped.numeroPedido = iped.numeroPedido  -- Junção com a tabela de itens de pedido
            GROUP BY ped.codigoCliente, ped.numeroPedido) AS vendas  -- Agrupa por código de cliente e número do pedido para calcular o total por pedido
        WHERE
            vendas.codigoCliente = cl.codigoCliente) AS MaiorVenda,  -- Filtra a maior venda para o cliente específico
    
    -- Subconsulta para encontrar a data da última compra do cliente
    (SELECT 
            MAX(vendas.dataPedido)  -- Obtém a data máxima de pedido, ou seja, a mais recente
        FROM
            (SELECT 
                ped.codigoCliente,      -- Código do cliente
                ped.dataPedido,         -- Data do pedido
                SUM(iped.quantidadeVendida * iped.precoUnitario) 
