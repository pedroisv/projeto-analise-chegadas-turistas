--==========================================================================================
--                             Tema 3 - Pontos de chegada
--==========================================================================================


-- 1 Quais estados (UF) registraram o maior volume total de chegadas de turistas internacionais no período analisado?

-- Etapa 1: Cria uma CTE com o total geral de chegadas

WITH total_geral as (
	SELECT SUM(chegadas) as total_geral FROM chegada_turistas
),

-- Etapa 2 : Cria uma CTE com o total de chegadas agrupado por UF e junta com a CTE do total geral de chegadas 

total_geral_e_total_uf as (
	SELECT
		total_geral,
		UF,
		SUM(chegadas) as total_uf -- soma o total de chegadas por UF de chegada
	FROM chegada_turistas
	CROSS JOIN total_geral          -- faz um join para criar uma coluna em que todas as linhas tenham o total geral de chegadas 
	GROUP BY UF, total_geral      -- agrupa por UF de chegada
)

-- Etapa 3: Orderna as linhas pelas UF que mais recebem turistas, cria um ranking dessas UF's
--          e calcula a porcentagem que cada UF representa do total de turistas recebidos
SELECT 
	RANK() OVER (                -- faz o ranquemento
		ORDER BY total_uf DESC -- ordena pelo numero de turistas recebidos
	) as ranking,
	UF,
	total_uf,
	ROUND((total_uf * 1.0) / (total_geral * 1.0) ,4) as porcentagem -- calcula a porcentagem que cada uf representa do total
FROM total_geral_e_total_uf;



--=====================================================================================================================



-- 2 Quais regiões do Brasil concentram a maior parte das chegadas de turistas internacionais?

-- Etapa 1: Cria uma CTE com o total geral de chegadas no pais

WITH total_geral as (
	SELECT SUM(chegadas) as total_geral FROM chegada_turistas
),

-- Etapa 2: Agrupa as chegadas por região do Brasil e junta com o total geral
--           A coluna 'uf' é convertida em 'região' com base na divisão oficial do IBGE
total_geral_e_total_regiao as (
	SELECT
		total_geral,
		-- Converte o nome da UF em uma das cinco regiões brasileiras 
		CASE            
			WHEN uf IN ('São Paulo', 'Rio de Janeiro', 'Minas Gerais') THEN 'Sudeste'       
			WHEN uf IN ('Rio Grande do Sul', 'Paraná', 'Santa Catarina') THEN 'Sul'
			WHEN uf IN ('Bahia', 'Pernambuco', 'Ceará', 'Rio Grande do Norte') THEN 'Nordeste'
			WHEN uf IN ('Mato Grosso do Sul', 'Distrito Federal') THEN 'Centro-Oeste'
			WHEN uf IN ('Amazonas', 'Pará', 'Amapá', 'Acre', 'Roraima') THEN 'Norte'
			ELSE 'UF nao registrada' END -- Categoria para estados não mapeados explicitamente
			AS regiao,
		SUM(chegadas) as total_regiao -- Soma das chegadas para cada região
	FROM chegada_turistas
	CROSS JOIN total_geral            -- Junta para que todas as linhas tenham acesso ao total geral
	GROUP BY regiao, total_geral      -- Agrupa por região e inclui total_geral para manter disponível
)

-- Etapa 3: Ordena as regiões pelas que mais recebem turistas, ranqueia e calcula a porcentagem
SELECT 
	RANK() OVER (                  
		ORDER BY total_regiao DESC  -- Ordena do maior para o menor volume de chegadas
	) as ranking,
	regiao,
	total_regiao,
	-- Calcula a porcentagem que cada região representa do total nacional
	ROUND((total_regiao * 1.0) / (total_geral * 1.0) ,4) as porcentagem
FROM total_geral_e_total_regiao;




--=====================================================================================================================


-- 3 Como evoluiu o ranking anual dos estados (UF) com maior volume de chegadas de turistas internacionais?

-- Etapa 1: CTE para calcular o total de chegadas por UF em cada ano
WITH total_uf_ano AS (
    SELECT
        ano,
        uf,
        SUM(chegadas) AS total_chegadas_uf
    FROM chegada_turistas
    WHERE chegadas IS NOT NULL
    GROUP BY ano, uf
),

-- Etapa 2: CTE para ranquear os estados em cada ano de acordo com o volume de chegadas
top_5 AS (
    SELECT
        ano,
        uf,
        total_chegadas_uf,
        RANK() OVER (
            PARTITION BY ano 
            ORDER BY total_chegadas_uf DESC
        ) AS ranking
    FROM total_uf_ano
)

-- Etapa 3: Filtrar apenas os 5 primeiros colocados de cada ano
SELECT
    ano,
    uf,
    total_chegadas_uf,
    ranking
FROM top_5
WHERE ranking <= 5
ORDER BY ano, ranking;





		



