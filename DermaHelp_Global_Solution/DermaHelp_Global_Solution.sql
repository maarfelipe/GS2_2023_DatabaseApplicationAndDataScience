set serveroutput on
set verify off


--------------------PROCEDURE INSERT PARA ENDERECO-----------------------------
CREATE OR REPLACE PROCEDURE insert_enderecos AS
BEGIN
  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (1,'Rua Augusta', 'Sala 203', 'Sao Paulo', 'SP', '01305-000');
  
  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (2,'Avenida Boa Viagem', 'Apto 501', 'Recife', 'PE', '51021-000');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (3,'Rua das Palmeiras', 'Casa 15', 'Belo Horizonte', 'MG', '30112-020');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (4,'Avenida Paulista', 'Andar 10', 'Sao Paulo', 'SP', '01311-000');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (5,'Rua da Consolacao', 'Loja 3', 'Sao Paulo', 'SP', NULL);
  
  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (6,'Centro', 'Loja JL', 'Sao Paulo', 'SP', '07400-605');

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Duplicidade de chave primaria ao inserir', SYSDATE, USER);

  WHEN OTHERS THEN
    IF SQLCODE = -1400 THEN
      INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
      VALUES ('Nao é permitido inserir nulo', SYSDATE, USER);
    ELSE
      INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
      VALUES ('Erro desconhecido ao inserir dados', SYSDATE, USER);
    END IF;
END insert_enderecos;

BEGIN
  insert_enderecos;
END;


select * from endereco;
SELECT * FROM t_erro;


--------------------PROCEDURE INSERT PARA CONSULTORIO-----------------------------
CREATE OR REPLACE PROCEDURE insert_consultorios AS
BEGIN
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (1, 1, 'Clinica ABC', '12345678901234');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (2, 2, 'Hospital XYZ', '56789012345678');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (3, 3, 'Centro Medico DEF', '90123456789012');
  
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (4, 4, 'Clinica XYZ', '34567890123456');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (5, 5, 'Hospital ABC', '67890123456789');
  
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (6, 6, 'Centro Medico GHI', '01234567890123');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (7, 7, 'Clinica Delta', '12345098765432');

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Duplicidade de chave primaria ao inserir', SYSDATE, USER);

  WHEN VALUE_ERROR THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Não é permitido inserir nulo)', SYSDATE, USER);

  WHEN OTHERS THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Erro desconhecido ao inserir dados', SYSDATE, USER);
END insert_consultorios;

BEGIN
  insert_consultorios;
END;

SELECT * FROM t_erro;
SELECT * FROM CONSULTORIO;


-----------------------PROCEDURE INSERT PARA USUARIO----------------------------
CREATE OR REPLACE PROCEDURE insert_usuarios AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (1, 'João Silva', '12345678901', 'joao@email.com', 'senha123', 'M');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (2, 'Maria Oliveira', '98765432109', 'maria@email.com', 'senha456', 'F');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (3, 'Carlos Santos', '11122334455', 'carlos@email.com', 'senha789', 'M');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (4, 'Ana Pereira', '22233445566', 'ana@email.com', 'senhaabc', 'F');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (5, 'Pedro Costa', '33344556677', 'pedro@email.com', 'senhaxyz', 'M');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (6, 'Fernanda Oliveira', '44455667788', 'fernanda@email.com', 'senha123', 'F');

INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
VALUES (7, 'Ricardo Silva', '55566778899', 'ricardo@email.com', NULL, 'M');

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicação de chave primária ao inserir dados';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir usuário';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir';
    WHEN TOO_MANY_ROWS THEN
      v_erro_msg := 'Foram passados valores a mais ao inserir dados';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir usuário: ' || SQLERRM;
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 200);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END insert_usuarios;

BEGIN
  insert_usuarios;
END;


SELECT * FROM t_erro;
SELECT * FROM usuario;


-----------------------PROCEDURE INSERT PARA IMAGEM----------------------------
CREATE OR REPLACE PROCEDURE insert_imagens AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (1, 1, TO_TIMESTAMP('2023-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 1');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (2, 2, TO_TIMESTAMP('2023-01-02 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 2');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (3, 3, TO_TIMESTAMP('2023-01-03 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 3');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (4, 4, TO_TIMESTAMP('2023-01-04 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 4');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (5, 5, TO_TIMESTAMP('2023-01-05 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 5');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (6, 6, TO_TIMESTAMP('2023-01-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 6');

    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (7, 7, TO_TIMESTAMP('2023-01-07 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Resultado 7');

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicação de chave primária ao inserir dados';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir imagem';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir';
    WHEN TOO_MANY_ROWS THEN
      v_erro_msg := 'Foram passados valores a mais ao inserir dados';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir imagem: ' || SQLERRM;
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 200);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END insert_imagens;


BEGIN
  insert_imagens;
END;

SELECT * FROM t_erro;
SELECT * FROM imagem;



-----------------------PROCEDURE INSERT PARA MEDICO----------------------------
CREATE OR REPLACE PROCEDURE insert_medicos AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (1, 'Dr. Joaquim Almeida', 'CRM11111', 'joaquim.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (2, 'Dra. Camila Pereira', 'CRM22222', 'camila.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (3, 'Dr. Roberto Oliveira', 'CRM33333', 'roberto.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (4, 'Dra. Luiza Santos', 'CRM44444', 'luiza.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (5, 'Dr. Eduardo Costa', 'CRM55555', 'eduardo.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (6, 'Dra. Gabriela Rocha', 'CRM66666', 'gabriela.medico@email.com');

    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (7, 'Dr. André Lima', 'CRM77777', 'andre.medico@email.com');

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicação de chave primária ao inserir dados';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir médico';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir médico';
    WHEN TOO_MANY_ROWS THEN
      v_erro_msg := 'Foram passados valores a mais ao inserir dados';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir médico: ' || SQLERRM;
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 200);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END insert_medicos;

BEGIN
  insert_medicos;
END;

SELECT * FROM t_erro;
SELECT * FROM medico;



-----------------------PROCEDURE INSERT PARA CONSULTA----------------------------
CREATE OR REPLACE PROCEDURE insert_consultas AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (1, 1, 1, 1, TO_TIMESTAMP('2023-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (2, 1, 2, 2, TO_TIMESTAMP('2023-01-02 10:30:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (3, 3, 3, 3, TO_TIMESTAMP('2023-01-03 13:45:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (4, 1, 4, 4, TO_TIMESTAMP('2023-01-04 15:15:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (5, 2, 5, 5, TO_TIMESTAMP('2022-01-05 17:20:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (6, 3, 6, 6, TO_TIMESTAMP('2022-01-06 09:45:00', 'YYYY-MM-DD HH24:MI:SS'));

    INSERT INTO consulta (id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora)
    VALUES (7, 1, 7, 7, TO_TIMESTAMP('2022-01-07 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));

  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicação de chave primária ao inserir dados';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir consulta';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir';
    WHEN TOO_MANY_ROWS THEN
      v_erro_msg := 'Foram passados valores a mais ao inserir dados';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir consulta: ' || SQLERRM;
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 200);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END insert_consultas;


BEGIN
  insert_consultas;
END;

SELECT * FROM t_erro;
SELECT * FROM consulta;

-----------------------PROCEDURE LISTA CONSULTA----------------------------
--procedure que me retorna uma lista de todas as consultas que foram feitas em 2022
--obs nos inserts da consulta tem 3 que são de 2022 porem uma esta com "erro"
-- entao ela nao vai aparecer.
CREATE OR REPLACE PROCEDURE consultas_2022 AS
    CURSOR cur_consultas_2022 IS
        SELECT id_consulta, id_consultorio, id_medico, id_usuario, dt_data_hora
        FROM consulta
        WHERE EXTRACT(YEAR FROM dt_data_hora) = 2022;

BEGIN
    FOR rec IN cur_consultas_2022 LOOP
        DBMS_OUTPUT.PUT_LINE('Consulta ID: ' || rec.id_consulta || ', Consultório ID: ' || rec.id_consultorio || ', Médico ID: ' || rec.id_medico || ', Usuário ID: ' || rec.id_usuario || ', Data e Hora: ' || rec.dt_data_hora);
    END LOOP;
END consultas_2022;


BEGIN
    consultas_2022;
END;





---------------------------------------------------------
-- Pesquisa feita com procedure para listar todas as consultas e medicos 
-- que foram feitas num determinado consultório
CREATE OR REPLACE PROCEDURE listar_consultorios(
    p_id_consultorio IN NUMBER
) AS
    CURSOR c_medicos_por_consultorio IS
        SELECT
            c.id_consulta,
            co.nm_empresa AS nome_consultorio,
            m.nm_medico
        FROM
            consulta c
        JOIN
            medico m ON c.id_medico = m.id_medico
        JOIN
            consultorio co ON c.id_consultorio = co.id_consultorio
        WHERE
            c.id_consultorio = p_id_consultorio;

    v_medico_info c_medicos_por_consultorio%ROWTYPE;

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    
    OPEN c_medicos_por_consultorio;

    LOOP
        FETCH c_medicos_por_consultorio INTO v_medico_info;

        EXIT WHEN c_medicos_por_consultorio%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Consulta ID: ' || v_medico_info.id_consulta || ', Consultório: ' || v_medico_info.nome_consultorio || ', Médico: ' || v_medico_info.nm_medico);
    END LOOP;

    CLOSE c_medicos_por_consultorio;
END listar_consultorios;


BEGIN
    listar_consultorios(1); -- Substitua pelo ID do usuário desejado(deixei dessa forma para facilitar)
END;



-------------------------------------------------------------------------
--function que calcula quantos dias se passaram apos a consulta de um usuario/paciente
CREATE OR REPLACE FUNCTION calculo_dias_consulta (
    p_id_consulta IN NUMBER
) RETURN NUMBER AS
    v_dias_diff NUMBER;
BEGIN
    SELECT TRUNC(SYSDATE) - TRUNC(c.dt_data_hora)
    INTO v_dias_diff
    FROM consulta c
    WHERE c.id_consulta = p_id_consulta;

    RETURN v_dias_diff;
END calculo_dias_consulta;

DECLARE
    v_id_usuario CONSTANT NUMBER := 1; -- Substitua pelo ID do usuário desejado(deixei dessa forma para facilitar)
    v_nome_usuario VARCHAR2(100); 
    v_data_consulta DATE;
    v_dias_diff NUMBER;
BEGIN
    SELECT u.nm_usuario
    INTO v_nome_usuario
    FROM usuario u
    WHERE u.id_usuario = v_id_usuario;
    
    SELECT MAX(c.dt_data_hora)
    INTO v_data_consulta
    FROM consulta c
    WHERE c.id_usuario = v_id_usuario;

    v_dias_diff := TRUNC(SYSDATE) - TRUNC(v_data_consulta);

    -- Exibir a informação
    DBMS_OUTPUT.PUT_LINE('Nome do Usuário: ' || v_nome_usuario ||', Consulta mais recente: ' || TO_CHAR(v_data_consulta, 'DD/MM/YYYY') || 
    ', Dias desde a consulta: ' || v_dias_diff);
END;










