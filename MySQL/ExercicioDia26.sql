-- Define o delimitador para o final do código da função
DELIMITER //

-- Criação de uma função chamada 'preco_venda' que calcula o preço de venda com base no custo e na margem
CREATE FUNCTION preco_venda(
    p_preco_custo DECIMAL(10,2),  -- Parâmetro de entrada para o preço de custo do produto
    p_margem DECIMAL(10,2)        -- Parâmetro de entrada para a margem (percentual) de lucro
)
RETURNS DECIMAL(10,2)             -- A função retorna um valor decimal com 2 casas decimais (preço de venda)
DETERMINISTIC                    -- Indica que a função sempre retornará o mesmo valor para os mesmos parâmetros
BEGIN
    DECLARE preco_venda DECIMAL(10,2);  -- Declaração de uma variável local para armazenar o preço de venda calculado

    -- Calcula o preço de venda baseado no preço de custo e na margem
    SET preco_venda = p_preco_custo + (p_preco_custo * p_margem);
    
    -- Retorna o valor calculado do preço de venda
    RETURN preco_venda;
END //   -- Finaliza o código da função

-- Restaura o delimitador para o padrão (que é o ponto e vírgula)
DELIMITER ;

-- Exemplo de chamada de uma função, passando um código de produto e um valor para calcular a margem de venda
select margem_produto ('s10_1068', 105) * 100;
-- Presumivelmente, 'margem_produto' é uma função já existente para calcular a margem, o que provavelmente deveria ser multiplicado por 100 para dar a porcentagem.

-- Consulta para obter os preços de venda com diferentes margens aplicadas aos produtos
SELECT 
    codigoProduto,                                -- Código do produto
    nomeProduto,                                  -- Nome do produto
    preco_venda(precoCusto, 20/100) AS Margem20,  -- Preço de venda com uma margem de 20%
    preco_venda(precoCusto, 40/100) AS Margem40,  -- Preço de venda com uma margem de 40%
    preco_venda(precoCusto, 80/100) AS Margem80   -- Preço de venda com uma margem de 80%
FROM 
    produtos;  -- Tabela de produtos

-- Definição e exibição de uma variável de usuário
SET @variavel = '15';  -- Atribui o valor '15' à variável @variavel
SELECT @variavel;      -- Exibe o valor da variável @variavel, que será '15'
