drop function classicos.margem_venda;
DELIMITER //
CREATE FUNCTION margem_venda(preco_venda decimal(10,2), preco_custo decimal(10,2)) 
RETURNS decimal(10,2) 
DETERMINISTIC
BEGIN
    DECLARE margem decimal(10,2);
    if preco_venda = 0 then
      return null;
	end if;
    select round(((preco_venda - preco_custo) / preco_venda), 2) into margem;
    RETURN margem;
END //
DELIMITER ;

select codigoProduto, nomeProduto, precoCusto, precoVenda, margem_venda(precoVenda, precoCusto) * 100
   from produtos;

/*-- ---------------------------------------------------------------------------
-- Segunda função : Dados o código do produto e o preço de venda, retornar a margem de venda   
drop function classicos.margem_produto;
DELIMITER //
CREATE FUNCTION margem_produto(p_codigoProduto varchar(15), p_preco_venda decimal(10,2)) 
RETURNS decimal(10,4) 
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE margem      decimal(10,4);
    DECLARE preco_custo decimal(10,2);
    if p_preco_venda = 0 then
      return null;
	end if;
    if p_codigoProduto is null then
      return null;
	end if;

    select pr.precoCusto from classicos.produtos pr where codigoProduto = p_codigoProduto into preco_custo;
    if preco_custo is null then
       return null;
	end if;

    select round(((p_preco_venda - preco_custo) / p_preco_venda), 4) into margem;
    RETURN margem;
END //
DELIMITER ;

-- ----------------------------------------------------------------------------------------
-- Terceira função : Dados o preço de custo e a margem de venda, retornar o preco de venda  

drop function classicos.preco_venda;
DELIMITER //
CREATE FUNCTION preco_venda(preco_custo decimal(10,2), margem decimal(10,2)) 
RETURNS decimal(10,2) 
DETERMINISTIC
BEGIN
    DECLARE preco_final decimal(10,2);
    select round(preco_custo + (preco_custo * margem / 100), 2) into preco_final;
    RETURN preco_final;
END //
DELIMITER ;
*/