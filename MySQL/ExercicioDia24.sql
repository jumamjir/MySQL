select pedidos.numeroPedido,codigoCliente, dataPedido, sum(itempedidos.quantidadeVendida * itemPedidos.precoUnitario) valorPedido
from classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
group by numeroPedido, codigoCliente, dataPedido, status;

create view vw_pedidos AS
select pedidos.numeroPedido,codigoCliente, dataPedido, sum(itempedidos.quantidadeVendida * itemPedidos.precoUnitario) valorPedido
from classicos.pedidos inner join classicos.itempedidos on pedidos.numeroPedido = itempedidos.numeroPedido
group by numeroPedido, codigoCliente, dataPedido, status;

select * from vw_pedidos;

