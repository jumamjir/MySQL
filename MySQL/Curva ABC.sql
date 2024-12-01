-- Criação de uma tabela temporária chamada "acumVendas"
create temporary table acumVendas as 
(
    -- Define a subconsulta com duas partes: "vendas_prod" e "total_vendas"
    with 

    -- Subconsulta "vendas_prod": Calcula o valor vendido por produto (quantidade vendida * preço unitário)
    vendas_prod as (
        select 
            i.codigoProduto,  -- Código do produto
            sum(i.quantidadeVendida * i.precoUnitario) valorVendido  -- Calcula o valor total vendido por produto
        from classicos.itempedidos i  -- Tabela de itens de pedidos
        group by i.codigoProduto    -- Agrupa os resultados por código de produto
    ),

    -- Subconsulta "total_vendas": Calcula o total vendido de todos os produtos
    total_vendas as (
        select 
            sum(i.quantidadeVendida * i.precoUnitario) totalVendido  -- Soma o valor total de vendas de todos os produtos
        from classicos.itempedidos i  -- Tabela de itens de pedidos
    )

    -- Consulta principal: Calcula a participação percentual de cada produto no total de vendas
    select 
        vendas_prod.codigoProduto,         -- Código do produto
        vendas_prod.valorVendido,          -- Valor total vendido do produto
        round(valorVendido / totalVendido, 3) * 100 porcParticipacao  -- Participação percentual do produto no total de vendas (arredondado para 3 casas decimais)
    from vendas_prod, total_vendas      -- Junta as duas subconsultas
    order by 3 DESC                     -- Ordena pelo valor da participação percentual, em ordem decrescente
);

-- Inicializa uma variável de controle para armazenar o valor acumulado da participação
set @acum = 0;

-- Consulta principal que seleciona os dados da tabela temporária "acumVendas"
-- Calcula o valor acumulado da participação e classifica os produtos com base na curva ABC
select 
    *,  -- Seleciona todos os campos da tabela temporária
    @acum := @acum + porcParticipacao as acumulado,  -- Acumula a participação percentual
    case  -- Classifica os produtos de acordo com a curva ABC
        when @acum <= 20 then 'A'  -- Classe A: Se o acumulado for até 20%
        when @acum <= 50 then 'B'  -- Classe B: Se o acumulado for até 50%
        else 'C'  -- Classe C: Se o acumulado for maior que 50%
    end as Curva  -- Atribui a classificação ABC
from acumVendas;

-- Remove a tabela temporária "acumVendas" após o uso
drop table acumVendas;
