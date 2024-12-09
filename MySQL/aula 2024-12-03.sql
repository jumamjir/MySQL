select 
  c.codigoVendedor,
  fun.nome,
  year(p.dataPedido) ano,
  sum(i.quantidadeVendida * i.precoUnitario) valor
from
 clientes c 
	join pedidos p using (codigoCliente)
    join funcionarios fun on c.codigoVendedor = fun.codigoFuncionario
    join itempedidos i using (numeroPedido)
where
   p.status not like 'cancelled'
group by 
  c.codigoVendedor,
  fun.nome,
  ano
;


SELECT
    nome,
    ano,
    Vendas,
    RANK() OVER (PARTITION BY
                     ano
                 ORDER BY
                     Vendas DESC
                ) rankVendas
FROM
(select 
  c.codigoVendedor,
  fun.nome,
  year(p.dataPedido) ano,
  sum(i.quantidadeVendida * i.precoUnitario) vendas
from
 clientes c 
	join pedidos p using (codigoCliente)
    join funcionarios fun on c.codigoVendedor = fun.codigoFuncionario
    join itempedidos i using (numeroPedido)
where
 p.status not like 'cancelled'
group by 
  c.codigoVendedor,
  fun.nome,
  ano
) vendasAno
;


SELECT
         ano, pais, produto, vendas,
         SUM(vendas) OVER(partition by ano,pais) AS vendas_ano_pais,         
         SUM(vendas) OVER(partition by ano) AS total_vendas,
         SUM(vendas) OVER(PARTITION BY pais) AS vendas_pais,
         RANK() OVER (partition by ano, pais order by vendas DESC) RankAnoPais
       FROM 
         ( 
           select year(p.dataPedido) ano,
              ip.codigoProduto produto,
              c.pais pais,
              sum(ip.quantidadeVendida * ip.precoUnitario) vendas
            from
              clientes c join pedidos p      using (codigoCliente)
                         join itemPedidos ip using (numeroPedido)
            where
              p.status not like 'cancelled'
            group by
              ano, ip.codigoProduto, pais
          ) as vendasProdutos
       ORDER BY pais, ano, RankAnoPais;