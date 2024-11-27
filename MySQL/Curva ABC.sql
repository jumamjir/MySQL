create temporary table acumVendas as 
(with 

 vendas_prod as  (select i.codigoProduto, sum(i.quantidadeVendida * i.precoUnitario) valorVendido 
                   from classicos.itempedidos i group by i.codigoProduto),
 total_vendas as (select sum(i.quantidadeVendida * i.precoUnitario) totalVendido from classicos.itempedidos i)
 
 select vendas_prod.codigoProduto, vendas_prod.valorVendido, 
           round(valorVendido / totalVendido, 3) * 100 porcParticipacao 
   from vendas_prod, total_vendas order by 3 DESC

);
set @acum = 0; 
select *, @acum := @acum + porcParticipacao as acumulado, 
  case 
    when @acum <= 20 then 'A'
    when @acum <= 50 then 'B'
    else 'C'
 end as Curva
 from acumVendas;
 drop table acumVendas;
