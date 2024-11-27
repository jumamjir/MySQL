DELIMITER //

CREATE FUNCTION preco_venda(
    p_preco_custo DECIMAL(10,2),
    p_margem DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE preco_venda DECIMAL(10,2);

    SET preco_venda = p_preco_custo + (p_preco_custo * p_margem);
    RETURN preco_venda;
END //

DELIMITER ;

select margem_produto ('s10_1068',105) * 100;

SELECT codigoProduto, nomeProduto, preco_venda (precoCusto, 20/100) Margem20, preco_venda(precoCusto,40/100) Margem40, preco_venda(precoCusto,80/100) Margem80 
from produtos;

SET @variavel = '15';
SELECT @variavel;