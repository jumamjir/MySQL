select c.codigoCliente, c.nomeCliente,
  (select sum(ip.quantidadeVendida) from itempedidos ip inner join pedidos p on ip.numeroPedido = p.numeroPedido where p.codigoCliente = c.codigoCliente and ip.codigoProduto = 'S10_1678') S10_1678,
  (select sum(ip.quantidadeVendida) from itempedidos ip inner join pedidos p on ip.numeroPedido = p.numeroPedido where p.codigoCliente = c.codigoCliente and ip.codigoProduto = 'S10_4698') S10_4698,
  (select sum(ip.quantidadeVendida) from itempedidos ip inner join pedidos p on ip.numeroPedido = p.numeroPedido where p.codigoCliente = c.codigoCliente and ip.codigoProduto = 'S12_1099') S12_1099,
  (select sum(ip.quantidadeVendida) from itempedidos ip inner join pedidos p on ip.numeroPedido = p.numeroPedido where p.codigoCliente = c.codigoCliente and ip.codigoProduto = 'S12_3891') S12_3891,
  (select sum(ip.quantidadeVendida) from itempedidos ip inner join pedidos p on ip.numeroPedido = p.numeroPedido where p.codigoCliente = c.codigoCliente and ip.codigoProduto = 'S18_1097') S18_1097
from
 classicos.clientes c;
 
 select c.codigoCliente, c.nomeCliente,
  sum(case when ip.codigoProduto = 'S10_1678' then ip.quantidadeVendida else 0 end) S10_1678,
  sum(case when ip.codigoProduto = 'S10_4698' then ip.quantidadeVendida else 0 end) S10_4698,
  sum(case when ip.codigoProduto = 'S12_1099' then ip.quantidadeVendida else 0 end) S12_1099,
  sum(case when ip.codigoProduto = 'S12_3891' then ip.quantidadeVendida else 0 end) S12_3891,
  sum(case when ip.codigoProduto = 'S18_1097' then ip.quantidadeVendida else 0 end) S18_1097
from
 classicos.clientes c
   inner join pedidos p      on p.codigoCliente = c.codigoCliente
   inner join itempedidos ip on ip.numeroPedido = p.numeroPedido
 where ip.codigoProduto in ('S10_1678','S10_4698','S12_1099','S12_3891','S18_1097')
group by
 c.codigoCliente, c.nomeCliente;