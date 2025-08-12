--==========================================================================================
--                                Validacao
--==========================================================================================
-- Verificando duplicadas
SELECT 
    COUNT(*) AS total_registros,
    SUM(CASE WHEN continente IS NULL THEN 1 ELSE 0 END) AS nulos_continente,
    
    SUM(CASE WHEN ordem_continente IS NULL THEN 1 ELSE 0 END) AS nulos_ordem_continente,
    
    SUM(CASE WHEN pais IS NULL THEN 1 ELSE 0 END) AS nulos_pais,
    
    SUM(CASE WHEN ordem_pais IS NULL THEN 1 ELSE 0 END) AS nulos_ordem_pais,
    
    SUM(CASE WHEN uf IS NULL THEN 1 ELSE 0 END) AS nulos_uf,
    
    SUM(CASE WHEN ordem_uf IS NULL THEN 1 ELSE 0 END) AS nulos_ordem_uf,
    
    SUM(CASE WHEN via_de_acesso IS NULL THEN 1 ELSE 0 END) AS nulos_via_de_acesso,
    
    SUM(CASE WHEN ordem_via_de_acesso IS NULL THEN 1 ELSE 0 END) AS nulos_ordem_via_de_acesso,
    
    SUM(CASE WHEN ano IS NULL THEN 1 ELSE 0 END) AS nulos_ano,
    
    SUM(CASE WHEN mes IS NULL THEN 1 ELSE 0 END) AS nulos_mes,

	SUM(CASE WHEN chegadas IS NULL THEN 1 ELSE 0 END) AS nulos_chegadas,
    
    SUM(CASE WHEN ordem_mes IS NULL THEN 1 ELSE 0 END) AS nulos_ordem_mes
FROM chegada_turistas;

-- checando as linhas com valores nulos
SELECT * FROM chegada_turistas
WHERE chegadas IS NULL

-- Temos 9852 linhas com chegadas valores nulos




-- Verificando valores distintos em cada coluna;
SELECT DISTINCT "continente"
FROM chegada_turistas;

SELECT DISTINCT "ordem_continente"
FROM chegada_turistas;

SELECT DISTINCT "pais"
FROM chegada_turistas;

SELECT DISTINCT "ordem_pais"
FROM chegada_turistas;

SELECT DISTINCT "uf"
FROM chegada_turistas;

SELECT DISTINCT "ordem_uf"
FROM chegada_turistas;

SELECT DISTINCT "via_de_acesso"       ------ 
FROM chegada_turistas;                ------ INCORENCIA - Aerea Aereo, maritmo e maritma
SELECT DISTINCT "ordem_via_de_acesso" ------
FROM chegada_turistas;


SELECT DISTINCT "ano"
FROM chegada_turistas;

SELECT DISTINCT "mes"                 ------ 
FROM chegada_turistas;			  ------- INCOERENCIA - Meses com letra maiuscula e minuscula
SELECT DISTINCT "ordem_mes"			  ------- 
FROM chegada_turistas;


