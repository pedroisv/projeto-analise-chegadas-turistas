--==========================================================================================
--                             Tema 4 - Vias de acesso
--==========================================================================================
-- 1 Quais são as vias de acesso mais utilizadas por turistas internacionais para entrada no Brasil (período total)?
-- Etapa 1: Cria uma CTE com o total geral de chegadas
WITH total_geral as (
	SELECT SUM(chegadas) as total_geral FROM chegada_turistas
),

-- Etapa 2 : Cria uma CTE com o total de chegadas agrupado por via de acesso e junta com a CTE do total geral de chegadas 

total_geral_e_total_via_acesso as (
	SELECT
		total_geral,
		via_de_acesso,
		SUM(chegadas) as total_via_acesso -- soma o total de chegadas por via de acesso
	FROM chegada_turistas
	CROSS JOIN total_geral          -- faz um join para criar uma coluna em que todas as linhas tenham o total geral de chegadas 
	GROUP BY via_de_acesso, total_geral      -- agrupa por via de acesso usada
)

-- Etapa 3: Orderna as linhas pelas vias de acesso que os turistas mais usaram, cria um ranking delas
--          e calcula a porcentagem que cada via de acesso representa do total de turistas recebidos
SELECT 
	RANK() OVER (                      -- faz o ranquemento
		ORDER BY total_via_acesso DESC -- ordena pelo numero via de acesso
	) as ranking,
	via_de_acesso,
	total_via_acesso,
	ROUND((total_via_acesso * 1.0) / (total_geral * 1.0) ,4) as porcentagem -- calcula a porcentagem que cada uf representa do total
FROM total_geral_e_total_via_acesso;




--=====================================================================================================================



-- 2. Qual é a distribuição percentual das vias de acesso utilizadas em cada estado (UF)?
-- Etapa 1: CTE que calcula o total de chegadas por UF
WITH total_por_uf as(
	SELECT
		uf,
		SUM(chegadas) as total_chegadas_uf
	FROM chegada_turistas
	GROUP BY uf
),
-- Etapa 2: CTE que calcula o total de chegadas por UF e via de acesso,
-- alem de trazer o total geral por UF (para calculo de porcentagem)
chegadas_via_de_acesso_com_total as(
	SELECT
		chegadas.uf,
		chegadas.via_de_acesso,
		SUM(chegadas.chegadas) as chegadas,  -- total chegadas por UF e Via
		total_por_uf.total_chegadas_uf       -- total chegadas por UF da CTE anterior
	FROM chegada_turistas as chegadas
	JOIN total_por_uf ON  total_por_uf.uf = chegadas.uf -- JUnta pra trazer o total geral da UF
	GROUP BY chegadas.uf, chegadas.via_de_acesso, total_por_uf.total_chegadas_uf
)
-- Etapa 3: Consulta Geral que exibe o total de chegadas por UF e via de acesso
-- e calcula a porcentagem que cada via representa dentro do total da UF
SELECT
	uf,
	via_de_acesso,
	chegadas as total_chegadas,
	ROUND((chegadas * 1.0) / (total_chegadas_uf * 1.0) ,4) as porcentagem	-- Percentual da via dentro da UF
FROM chegadas_via_de_acesso_com_total
ORDER BY uf, chegadas DESC; -- Ordena pela UF e vias mais usadas



--=====================================================================================================================



-- 3. Para cada via de acesso, qual é a distribuição percentual de turistas por estado de destino?

-- Etapa 1: Calcula o total de chegadas para cada via de acesso
WITH total_por_via_de_acesso AS (
	SELECT
		via_de_acesso,
		SUM(chegadas) AS total_chegadas_via_de_acesso
	FROM chegada_turistas
	GROUP BY via_de_acesso
),

-- Etapa 2: Calcula o total de chegadas por UF e via de acesso,
--          e junta com o total geral por via (da CTE anterior)
chegadas_via_de_acesso_com_total AS (
	SELECT
		chegadas.via_de_acesso,
		chegadas.uf,
		SUM(chegadas.chegadas) AS chegadas,                    -- Total de chegadas por UF e via
		totais.total_chegadas_via_de_acesso                    -- Total de chegadas por via (para cálculo de porcentagem)
	FROM chegada_turistas AS chegadas
	JOIN total_por_via_de_acesso AS totais 
		ON totais.via_de_acesso = chegadas.via_de_acesso       -- Junta pelo tipo de via de acesso
	GROUP BY 
		chegadas.via_de_acesso, 
		chegadas.uf, 
		totais.total_chegadas_via_de_acesso
)

-- Etapa 3: Consulta final que exibe:
--          - total de chegadas por UF e via
--          - a porcentagem que cada UF representa dentro do total daquela via
SELECT
	via_de_acesso,
	uf,
	chegadas AS total_chegadas,
	
	-- Cálculo da porcentagem que cada UF representa dentro do total de chegadas por via
	ROUND((chegadas * 1.0) / (total_chegadas_via_de_acesso * 1.0), 4) AS porcentagem
	
FROM chegadas_via_de_acesso_com_total

-- Ordena por tipo de via e dentro de cada via, pelas UFs com mais chegadas
ORDER BY via_de_acesso, chegadas DESC;