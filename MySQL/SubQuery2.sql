-- Fazer uma relação de TODOS os clientes com :


-- 	Código do cliente
-- 	Nome do Cliente
--  Maior compra do cliente em valor
-- 	Data da ultima compra do cliente
-- 	Limite de crédito do cliente
-- 	Total de compras do cliente
-- 	Total de pagamentos do cliente



SELECT 
    cl.codigoCliente,
    cl.nomeCliente,
    (SELECT 
            MAX(vendas.valorPedido)
        FROM
            (SELECT 
                ped.codigoCliente,
                    ped.numeroPedido,
                    SUM(iped.quantidadeVendida * iped.precoUnitario) valorPedido
            FROM
                pedidos ped
            INNER JOIN itempedidos iped ON ped.numeroPedido = iped.numeroPedido
            GROUP BY ped.codigoCliente , ped.numeroPedido) AS vendas
        WHERE
            vendas.codigoCliente = cl.codigoCliente) MaiorVenda,
    (SELECT 
            MAX(vendas.dataPedido)
        FROM
            (SELECT 
                ped.codigoCliente,
                    ped.dataPedido,
                    SUM(iped.quantidadeVendida * iped.precoUnitario) valorPedido
            FROM
                pedidos ped
            INNER JOIN itempedidos iped ON ped.numeroPedido = iped.numeroPedido
            GROUP BY ped.codigoCliente , ped.dataPedido) AS vendas
        WHERE
            vendas.codigoCliente = cl.codigoCliente) UltimaVenda,
    cl.limiteCredito,
    (SELECT 
            SUM(pag.valor) TotalPago
        FROM
            pagamentos pag
        WHERE
            pag.codigoCliente = cl.codigoCliente) ValorPago
FROM
    classicos.clientes cl;
    

    

