--==========================================================================================
--                                Tranformacoes
--==========================================================================================

-- Corrigindo valores de meses

BEGIN; -- comecando uma transaction                      
	
	UPDATE chegada_turistas -- aplicando lower em todas as strings de mes
	SET mes = lower(mes);

	SELECT DISTINCT(mes) -- ainda temos mes de "marco" e "março"
	FROM chegada_turistas;
	
COMMIT; -- aplicanto as tranformacoes



BEGIN; -- comecando uma transaction
	
	UPDATE chegada_turistas -- mudando todas as strings "marco" para "março"  
	SET mes = 'março'
	WHERE mes = 'marco';

	SELECT DISTINCT(mes) -- tudo correto
	FROM chegada_turistas;

COMMIT; -- aplicando as tranformacoes



-- Corrigindo valores de vias de acesso

BEGIN; -- comecando uma transaction

	UPDATE chegada_turistas -- mudando todos os 'Aéreo' por 'Aérea'
	SET via_de_acesso = 'Aérea'
	WHERE via_de_acesso = 'Aéreo';
	
	SELECT DISTINCT "via_de_acesso" -- tudo correto
	FROM chegada_turistas;  

COMMIT;	 -- aplicando as trasformacoes


BEGIN; -- comecando uma transaction

	UPDATE chegada_turistas -- mudando todos os 'Marítimo' por 'Marítima'
	SET via_de_acesso = 'Marítima'
	WHERE via_de_acesso = 'Marítimo';
	
	SELECT DISTINCT "via_de_acesso" -- tudo correto
	FROM chegada_turistas;  

COMMIT;	-- aplicando as trasformacoes