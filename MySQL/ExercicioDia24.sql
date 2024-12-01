-- Consulta inicial: Seleciona dados de pedidos e itens de pedidos, calculando o valor total do pedido
select 
  pedidos.numeroPedido,                            -- Número do pedido
  codigoCliente,                                   -- Código do cliente que fez o pedido
  dataPedido,                                     -- Data em que o pedido foi realizado
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido
  -- Calcula o valor total do pedido (quantidade vendida * preço unitário)
from 
  classicos.pedidos 
  inner join classicos.itempedidos 
    on pedidos.numeroPedido = itempedidos.numeroPedido
    -- Junta a tabela "pedidos" com a tabela "itempedidos" usando o campo numeroPedido
group by 
  numeroPedido, codigoCliente, dataPedido, status;
  -- Agrupa os resultados por número do pedido, código do cliente, data do pedido e status

-- Criação da visão (view) chamada "vw_pedidos"
create view vw_pedidos AS
select 
  pedidos.numeroPedido,                            -- Número do pedido
  codigoCliente,                                   -- Código do cliente
  dataPedido,                                     -- Data do pedido
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido
  -- Calcula o valor total do pedido (quantidade vendida * preço unitário)
from 
  classicos.pedidos 
  inner join classicos.itempedidos 
    on pedidos.numeroPedido = itempedidos.numeroPedido
    -- Junta a tabela "pedidos" com a tabela "itempedidos" usando o campo numeroPedido
group by 
  numeroPedido, codigoCliente, dataPedido, status;
  -- Agrupa os resultados por número do pedido, código do cliente, data do pedido e status

-- Exibe todos os dados da visão (view) "vw_pedidos"
select * from vw_pedidos;
