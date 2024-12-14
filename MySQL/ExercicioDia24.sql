-- Consulta inicial: Seleciona dados de pedidos e itens de pedidos, 
-- calculando o valor total do pedido
select 
  pedidos.numeroPedido,                            -- Número do pedido (identificador único do pedido)
  codigoCliente,                                   -- Código do cliente que fez o pedido
  dataPedido,                                     -- Data em que o pedido foi realizado
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) AS valorPedido
  -- Calcula o valor total do pedido multiplicando a quantidade vendida pelo preço unitário
from 
  classicos.pedidos                               -- Tabela de pedidos
  inner join classicos.itempedidos                -- Tabela de itens de pedidos
    on pedidos.numeroPedido = itempedidos.numeroPedido
    -- Junta a tabela "pedidos" com a tabela "itempedidos" usando o campo numeroPedido (chave estrangeira)
group by 
  numeroPedido, codigoCliente, dataPedido, status;
  -- Agrupa os resultados por número do pedido, código do cliente, data do pedido e status
  -- O "status" precisa estar na cláusula GROUP BY porque está sendo selecionado diretamente e não está em uma função agregada (como SUM, AVG, etc.)

-- Criação da visão (view) chamada "vw_pedidos"
create view vw_pedidos AS
select 
  pedidos.numeroPedido,                            -- Número do pedido (identificador único do pedido)
  codigoCliente,                                   -- Código do cliente que fez o pedido
  dataPedido,                                     -- Data do pedido
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) AS valorPedido
  -- Calcula o valor total do pedido (quantidade vendida * preço unitário)
from 
  classicos.pedidos                               -- Tabela de pedidos
  inner join classicos.itempedidos                -- Tabela de itens de pedidos
    on pedidos.numeroPedido = itempedidos.numeroPedido
    -- Junta a tabela "pedidos" com a tabela "itempedidos" usando o campo numeroPedido
group by 
  num
