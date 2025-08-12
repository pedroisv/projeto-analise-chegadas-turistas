--==========================================================================================
--                             Tema 2 - Origem
--==========================================================================================

-- 1  Quais são os países com maior volume absoluto de turistas enviados ao Brasil no período total analisado?

-- Etapa 1: Cria uma CTE com o total geral de chegadas

WITH total_geral as (
	SELECT SUM(chegadas) as total_geral FROM chegada_turistas
),

-- Etapa 2 : Cria uma CTE com o total de chegadas agrupado por pais de origem e junta com a CTE do total geral de chegadas 

total_geral_e_total_pais as (
	SELECT
		total_geral,
		pais,
		SUM(chegadas) as total_pais -- soma o total de chegadas por pais de origem
	FROM chegada_turistas
	CROSS JOIN total_geral          -- faz um join para criar uma coluna em que todas as linhas tenham o total geral de chegadas 
	GROUP BY pais, total_geral      -- agrupa por pais de origem
)

-- Etapa 3: Orderna as linhas pelos paises que mais enviaram turistas, cria um ranking desses paises
--          e calcula a porcentagem que cada pais representa do total de turistas enviados
SELECT 
	RANK() OVER (                -- faz o ranquemento
		ORDER BY total_pais DESC -- ordena pelo numero de turistas enviado decrescente
	) as ranking,
	pais,
	total_pais,
	ROUND((total_pais * 1.0) / (total_geral * 1.0) ,4) as porcentagem -- calcula a porcentagem que cada pais representa do total
FROM total_geral_e_total_pais
LIMIT 10; -- limitando aos 10 primeiros paises no ranking



--=====================================================================================================================


-- 2 Quais continentes de origem concentram a maior proporção dos turistas internacionais que chegam ao Brasil?

-- Etapa 1: Cria uma CTE com o total geral de chegadas

WITH total_geral as (
	SELECT SUM(chegadas) as total_geral FROM chegada_turistas
),

-- Etapa 2 : Cria uma CTE com o total de chegadas agrupado por continente de origem e junta com a CTE do total geral de chegadas 

total_geral_e_total_continente as (
	SELECT
		total_geral,
		continente,
		SUM(chegadas) as total_continente -- soma o total de chegadas por continente de origem
	FROM chegada_turistas
	CROSS JOIN total_geral          -- faz um join para criar uma coluna em que todas as linhas tenham o total geral de chegadas 
	GROUP BY continente, total_geral      -- agrupa por continente de origem
)

-- Etapa 3: Orderna as linhas pelos continentes que mais enviaram turistas, cria um ranking desses continentes
--          e calcula a porcentagem que cada continente representa do total de turistas enviados
SELECT 
	RANK() OVER (                -- faz o ranquemento
		ORDER BY total_continente DESC -- ordena pelo numero de turistas enviado decrescente
	) as ranking,
	continente,
	total_continente,
	ROUND((total_continente * 1.0) / (total_geral * 1.0) ,4) as porcentagem -- calcula a porcentagem que cada continente representa do total
FROM total_geral_e_total_continente;



--=====================================================================================================================



-- 3 Como evoluiu a participação percentual dos principais países emissores (top 5) no total de turistas internacionais ao longo dos anos?


-- Etapa 1: CTE con total de chegadas por ano (somando todas as continentes)
WITH total_por_ano AS (
	SELECT
		ano,
		SUM(chegadas) AS total_chegadas_por_ano
	FROM chegada_turistas
	GROUP BY ano
),

-- Etapa 2: CTE com ranking e participação percentual de cada pais no total de chegadas por ano
pct_por_ano AS (
	SELECT
		chegada.ano,

		-- Atribui um ranking por ano, com base no número total de chegadas da pais (do maior para o menor)
		ROW_NUMBER() OVER(
			PARTITION BY chegada.ano
			ORDER BY SUM(chegada.chegadas) DESC
		) AS ranking,
		
		chegada.pais,
		SUM(chegada.chegadas) AS chegadas_pais_ano, -- Total de chegadas do pais naquele ano
		ROUND((SUM(chegada.chegadas) * 1.0) / (total_ano.total_chegadas_por_ano * 1.0), 4) AS porcentagem -- Cálculo da participação percentual do pais no total nacional do ano
	FROM chegada_turistas AS chegada
	-- Junta com a tabela que contém o total de chegadas por ano
	INNER JOIN total_por_ano AS total_ano
		ON total_ano.ano = chegada.ano
	-- Agrupa por pais e ano (e total do ano para manter integridade na agregação)
	GROUP BY chegada.pais, chegada.ano, total_ano.total_chegadas_por_ano
)

-- Etapa 3: Filtra a consulta para apenas os TOP 5 paises emissores
SELECT
	*
FROM pct_por_ano
WHERE pais IN ('Argentina', 'Estados Unidos', 'Uruguai', 'Paraguai', 'Chile');


