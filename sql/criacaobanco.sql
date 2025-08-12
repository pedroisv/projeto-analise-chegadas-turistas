--==========================================================================================
--                                Criacao do Banco
--==========================================================================================



-- Criando a base de dados
CREATE DATABASE chegada_turistas_brasil;

-- Criando a tabela
CREATE TABLE chegada_turistas (
    continente VARCHAR(50),
    ordem_continente INTEGER,
    pais VARCHAR(100),
    ordem_pais INTEGER,
    uf VARCHAR(100),
    ordem_uf INTEGER,
    via_de_acesso VARCHAR(100),
    ordem_via_de_acesso INTEGER,
    ano INTEGER,
    mes VARCHAR(20),
    ordem_mes INTEGER,
    chegadas INTEGER
);


-- Importando dados
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1989.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1990.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1991.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1992.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1993.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1994.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1995.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1996.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1997.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1998.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_1999.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2000.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2001.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2002.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2003.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2004.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2005.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2006.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2007.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2008.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2009.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2010.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2011.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2012.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2013.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2014.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2015.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2016.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2017.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2018.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2019.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2020.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2021.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2022.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');
COPY chegada_turistas FROM 'C:/csv/utf8_chegadas_2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';');




