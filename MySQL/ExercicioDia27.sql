-- ----------------------------------------------------------
-- Primeira Função: Calcula a margem de venda com base no preço de venda e custo
-- A margem é calculada pela fórmula: ((preço venda - preço custo) / preço venda)
-- Se o preço de venda for zero, a função retorna NULL.
-- O valor de margem será retornado como um número decimal com 2 casas decimais.

DROP FUNCTION IF EXISTS classicos.margem_venda;  -- Remove a função "margem_venda" caso ela já exista

DELIMITER //  -- Altera o delimitador para '//' para permitir a definição de funções

CREATE FUNCTION margem_venda(preco_venda DECIMAL(10,2), preco_custo DECIMAL(10,2))
RETURNS DECIMAL(10,2)  -- Define que a função retorna um valor decimal com 2 casas decimais
DETERMINISTIC  -- Indica que a função é determinística (sempre retorna o mesmo valor para os mesmos parâmetros)
BEGIN
    DECLARE margem DECIMAL(10,2);  -- Declara uma variável local para armazenar a margem calculada

    -- Se o preço de venda for zero, retorna NULL para evitar divisão por zero
    IF preco_venda = 0 THEN
        RETURN NULL;
    END IF;

    -- Calcula a margem e armazena o valor na variável "margem"
    SELECT ROUND(((preco_venda - preco_custo) / preco_venda), 2) INTO margem;

    -- Retorna o valor calculado da margem
    RETURN margem;
END //

DELIMITER ;  -- Restaura o delimitador padrão ';'

-- Consulta que utiliza a função "margem_venda" para calcular a margem de cada produto
SELECT 
    codigoProduto,  -- Código do produto
    nomeProduto,    -- Nome do produto
    precoCusto,     -- Preço de custo do produto
    precoVenda,     -- Preço de venda do produto
    margem_venda(precoVenda, precoCusto) * 100 AS margemVendaPercentual  -- Calcula a margem percentual de venda
FROM produtos;

-- ----------------------------------------------------------
-- Segunda Função: Calcula a margem de venda de um produto dado o código do produto e o preço de venda
-- A função retorna a margem percentual de venda para um produto baseado em seu preço de venda e seu custo
-- Se o preço de venda for zero ou o código do produto for nulo, retorna NULL.

DROP FUNCTION IF EXISTS classicos.margem_produto;  -- Remove a função "margem_produto" caso ela já exista

DELIMITER //

CREATE FUNCTION margem_produto(p_codigoProduto VARCHAR(15), p_preco_venda DECIMAL(10,2))
RETURNS DECIMAL(10,4)  -- A função retorna a margem com 4 casas decimais
NOT DETERMINISTIC  -- Indica que a função não é determinística (os valores podem variar dependendo do banco de dados)
READS SQL DATA  -- A função lê dados de uma tabela (utiliza um SELECT no banco)
BEGIN
    DECLARE margem DECIMAL(10,4);  -- Declara uma variável local para armazenar a margem
    DECLARE preco_custo DECIMAL(10,2);  -- Declara uma variável local para armazenar o preço de custo

    -- Se o preço de venda for zero, ou se o código do produto for nulo, retorna NULL
    IF p_preco_venda = 0 OR p_codigoProduto IS NULL THEN
        RETURN NULL;
    END IF;

    -- Obtém o preço de custo do produto a partir da tabela "produtos" baseado no código do produto
    SELECT pr.precoCusto
    INTO preco_custo
    FROM classicos.produtos pr
    WHERE pr.codigoProduto = p_codigoProduto;

    -- Se não encontrar o preço de custo (preco_custo for NULL), retorna NULL
    IF preco_custo IS NULL THEN
        RETURN NULL;
    END IF;

    -- Calcula a margem e armazena o valor na variável "margem"
    SELECT ROUND(((p_preco_venda - preco_custo) / p_preco_venda), 4) INTO margem;

    -- Retorna o valor calculado da margem
    RETURN margem;
END //

DELIMITER ;  -- Restaura o delimitador padrão ';'

-- ----------------------------------------------------------
-- Terceira Função: Calcula o preço de venda dado o preço de custo e a margem de venda
-- A fórmula para o cálculo do preço de venda é: preço de venda = preço de custo + (preço de custo * margem / 100)
-- A função retorna o preço de venda arredondado para 2 casas decimais.

DROP FUNCTION IF EXISTS classicos.preco_venda;  -- Remove a função "preco_venda" caso ela já exista

DELIMITER //

CREATE FUNCTION preco_venda(preco_custo DECIMAL(10,2), margem DECIMAL(10,2))
RETURNS DECIMAL(10,2)  -- A função retorna um valor decimal com 2 casas decimais (preço de venda)
DETERMINISTIC  -- Indica que a função é determinística (sempre retorna o mesmo valor para os mesmos parâmetros)
BEGIN
    DECLARE preco_final DECIMAL(10,2);  -- Declara uma variável local para armazenar o preço final

    -- Calcula o preço de venda com base no preço de custo e na margem
    SELECT ROUND(preco_custo + (preco_custo * margem / 100), 2) INTO preco_final;

    -- Retorna o preço final calculado
    RETURN preco_final;
END //

DELIMITER ;  -- Restaura o delimitador padrão ';'
