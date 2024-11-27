select pedidos.numeroPedido, codigoCliente, dataPedido, status, sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido
from classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
group by numeroPedido, codigoCliente, dataPedido, status;

drop view vw_pedidos;
create view vw_pedidos AS
select 
  pedidos.numeroPedido, 
  pedidos.codigoCliente, 
  clientes.nomeCliente,
  pedidos.dataPedido, 
   
 CASE
  WHEN pedidos.status = 'Shipped'    THEN 'Pedido enviado'
  WHEN pedidos.status = 'Cancelled'  THEN 'Pedido cancelado'
  WHEN pedidos.status = 'Disputed'   THEN 'Pedido em disputa'
  WHEN pedidos.status = 'In Process' THEN 'Pedido em processamento'
  WHEN pedidos.status = 'On Hold'    THEN 'Pedido em espera'
  WHEN pedidos.status = 'Resolved'   THEN 'Pedido resolvido'
 ELSE 'Outros' END status,

  sum(itempedidos.quantidadeVendida * itempedidos.precoUnitario) valorPedido
from classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
	 inner join classicos.clientes on pedidos.codigoCliente = clientes.codigoCliente
group by numeroPedido, codigoCliente, dataPedido;

select * from vw_pedidos;