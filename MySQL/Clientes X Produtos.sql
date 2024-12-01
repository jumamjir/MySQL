-- Consulta 1: Para cada cliente, calcula a soma das quantidades vendidas de produtos específicos
select 
  c.codigoCliente,                                 -- Código do cliente
  c.nomeCliente,                                   -- Nome do cliente
  -- Soma da quantidade vendida do produto 'S10_1678' para o cliente específico
  (select sum(ip.quantidadeVendida) 
   from itempedidos ip 
   inner join pedidos p on ip.numeroPedido = p.numeroPedido 
   where p.codigoCliente = c.codigoCliente 
     and ip.codigoProduto = 'S10_1678') S10_1678,
  
  -- Soma da quantidade vendida do produto 'S10_4698' para o cliente específico
  (select sum(ip.quantidadeVendida) 
   from itempedidos ip 
   inner join pedidos p on ip.numeroPedido = p.numeroPedido 
   where p.codigoCliente = c.codigoCliente 
     and ip.codigoProduto = 'S10_4698') S10_4698,

  -- Soma da quantidade vendida do produto 'S12_1099' para o cliente específico
  (select sum(ip.quantidadeVendida) 
   from itempedidos ip 
   inner join pedidos p on ip.numeroPedido = p.numeroPedido 
   where p.codigoCliente = c.codigoCliente 
     and ip.codigoProduto = 'S12_1099') S12_1099,

  -- Soma da quantidade vendida do produto 'S12_3891' para o cliente específico
  (select sum(ip.quantidadeVendida) 
   from itempedidos ip 
   inner join pedidos p on ip.numeroPedido = p.numeroPedido 
   where p.codigoCliente = c.codigoCliente 
     and ip.codigoProduto = 'S12_3891') S12_3891,

  -- Soma da quantidade vendida do produto 'S18_1097' para o cliente específico
  (select sum(ip.quantidadeVendida) 
   from itempedidos ip 
   inner join pedidos p on ip.numeroPedido = p.numeroPedido 
   where p.codigoCliente = c.codigoCliente 
     and ip.codigoProduto = 'S18_1097') S18_1097
from
  classicos.clientes c;                            -- Tabela de clientes

-- Consulta 2: Utiliza uma abordagem mais eficiente para calcular as quantidades de produtos vendidos
select 
  c.codigoCliente,                                 -- Código do cliente
  c.nomeCliente,                                   -- Nome do cliente
  -- Soma das quantidades vendidas do produto 'S10_1678', considerando apenas as vendas desse produto
  sum(case when ip.codigoProduto = 'S10_1678' then ip.quantidadeVendida else 0 end) S10_1678,
  
  -- Soma das quantidades vendidas do produto 'S10_4698'
  sum(case when ip.codigoProduto = 'S10_4698' then ip.quantidadeVendida else 0 end) S10_4698,

  -- Soma das quantidades vendidas do produto 'S12_1099'
  sum(case when ip.codigoProduto = 'S12_1099' then ip.quantidadeVendida else 0 end) S12_1099,

  -- Soma das quantidades vendidas do produto 'S12_3891'
  sum(case when ip.codigoProduto = 'S12_3891' then ip.quantidadeVendida else 0 end) S12_3891,

  -- Soma das quantidades vendidas do produto 'S18_1097'
  sum(case when ip.codigoProduto = 'S18_1097' then ip.quantidadeVendida else 0 end) S18_1097
from
  classicos.clientes c
  inner join pedidos p      on p.codigoCliente = c.codigoCliente          -- Junta a tabela "clientes" com "pedidos" com base no código do cliente
  inner join itempedidos ip on ip.numeroPedido = p.numeroPedido          -- Junta a tabela "pedidos" com "itempedidos" com base no número do pedido
 where 
  ip.codigoProduto in ('S10_1678', 'S10_4698', 'S12_1099', 'S12_3891', 'S18_1097') 
  -- Filtra para considerar apenas os produtos especificados
group by
  c.codigoCliente, c.nomeCliente;                    -- Agrupa os resultados por cliente (código e nome)
