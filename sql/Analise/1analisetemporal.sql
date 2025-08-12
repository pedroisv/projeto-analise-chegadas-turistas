--=====================================================================================================================
--                                           Tema 1 - Analise Temporal
--=====================================================================================================================



-- 1. Como evoluiu o fluxo de turistas internacionais no Brasil ao longo do período total analisado?

SELECT
	ano,
	SUM(chegadas) as chegadas -- Soma do total de chegadas por ano
FROM chegada_turistas
GROUP BY ano;                 -- Agrupa por ano para que cada linha seja um pais diferente



--=====================================================================================================================



-- 2.  Quais anos registraram as maiores variações percentuais (positivas ou negativas) no número de chegadas de turistas internacionais ao Brasil em comparação com o ano anterior?

-- Etapa 1: Cria uma CTE com o total de chegadas por ano e total de chegadas do ano anterior para comparacao
WITH comparacao_anos as(
	SELECT
		ano,
		SUM(chegadas) as chegadas, -- calcula o total de chegadas por ano
		LAG(SUM(chegadas)) OVER(   -- acessa a linha anterior do total de chegadas por ano
			ORDER BY ano           -- ordena pelo ano
		) as ano_anterior
	FROM chegada_turistas          
	GROUP BY ano                   -- agrupa por ano
)
-- Etapa 2: Calcula a variacao percentual do total de chegadas do ano com o anterior
SELECT
	ano,
	ROUND( ( (chegadas - ano_anterior) * 1.0 / ano_anterior) , 2) as variacao_pct -- variacao percentual
FROM comparacao_anos
WHERE ano_anterior IS NOT NULL	-- como nao existe ano anterior ao primeiro ano na base de dados
							    -- filtra para que o calculo seja feito apenas nas linhas onde a coluna
								-- ano anterior nao e NULL
								
ORDER BY variacao_pct DESC;  	-- ordena pela variacao percentual



--=====================================================================================================================



-- 3. Quais meses registram, em média, o maior volume de chegadas de turistas internacionais? 
-- Etapa 1: Cria uma CTE com o total de chegadas por mes em cada ano
WITH chegadas_mes as ( 
	SELECT
		ano,
		ordem_mes,
		mes,
		SUM(chegadas) as chegadas -- calcula o total de chegadas por ano e por mes 
	FROM chegada_turistas
	GROUP BY ano, ordem_mes, mes  -- agrupa o por ano e por mes
)
-- Etapa 2: Calcula a media de chegadas agrupadas por mes
SELECT
	ordem_mes,
	mes,
	ROUND(AVG(chegadas),0) as media_chegadas -- calcula a media arredondada por mes
FROM chegadas_mes
GROUP BY mes, ordem_mes  -- agrupa por mes
ORDER BY ordem_mes;      -- orderna pela coluna ordem mes para garantir que os meses estejam na ordem certa



	   

