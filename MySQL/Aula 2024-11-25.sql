-- Seleciona dados de pedidos e itens de pedidos, calculando o valor total do pedido
select 
  pedidos.numeroPedido,                          -- Número do pedido
  codigoCliente,                                 -- Código do cliente que fez o pedido
  dataPedido,                                   -- Data em que o pedido foi feito
  status,                                       -- Status atual do pedido
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido -- Calcula o valor total do pedido (quantidade vendida * preço unitário)
from 
  classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
  -- Junta a tabela "pedidos" com a tabela "itempedidos" usando o campo numeroPedido
group by 
  numeroPedido, codigoCliente, dataPedido, status;
  -- Agrupa os resultados por número de pedido, código de cliente, data do pedido e status

-- Remove a visão (view) chamada "vw_pedidos", caso ela já exista
drop view vw_pedidos;

-- Cria uma nova visão chamada "vw_pedidos"
create view vw_pedidos AS
select 
  pedidos.numeroPedido,                        -- Número do pedido
  pedidos.codigoCliente,                       -- Código do cliente
  clientes.nomeCliente,                        -- Nome do cliente (obtido da tabela "clientes")
  pedidos.dataPedido,                          -- Data do pedido
  -- Utiliza um CASE para alterar o status do pedido de acordo com o valor do campo "status"
  CASE
    WHEN pedidos.status = 'Shipped'    THEN 'Pedido enviado'    -- Se o status for 'Shipped', exibe 'Pedido enviado'
    WHEN pedidos.status = 'Cancelled'  THEN 'Pedido cancelado'  -- Se o status for 'Cancelled', exibe 'Pedido cancelado'
    WHEN pedidos.status = 'Disputed'   THEN 'Pedido em disputa' -- Se o status for 'Disputed', exibe 'Pedido em disputa'
    WHEN pedidos.status = 'In Process' THEN 'Pedido em processamento' -- Se o status for 'In Process', exibe 'Pedido em processamento'
    WHEN pedidos.status = 'On Hold'    THEN 'Pedido em espera'  -- Se o status for 'On Hold', exibe 'Pedido em espera'
    WHEN pedidos.status = 'Resolved'   THEN 'Pedido resolvido' -- Se o status for 'Resolved', exibe 'Pedido resolvido'
    ELSE 'Outros' END status,                  -- Caso contrário, exibe 'Outros'
  
  -- Calcula o valor total do pedido (quantidade vendida * preço unitário)
  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido 
from 
  classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
  -- Junta as tabelas "pedidos" e "itempedidos" usando o campo numeroPedido
  inner join classicos.clientes on pedidos.codigoCliente = clientes.codigoCliente
  -- Junta a tabela "pedidos" com a tabela "clientes" usando o campo codigoCliente
group by 
  numeroPedido, codigoCliente, dataPedido;
  -- Agrupa os resultados por número de pedido, código de cliente e data do pedido

-- Exibe todos os dados da visão "vw_pedidos"
select * from vw_pedidos;
