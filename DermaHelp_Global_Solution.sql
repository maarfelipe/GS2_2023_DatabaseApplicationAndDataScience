set serveroutput on
set verify off


--------------------PROCEDURE INSERT PARA ENDERECO-----------------------------
CREATE OR REPLACE PROCEDURE carregar_enderecos AS
BEGIN
  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (1,'Rua Augusta', 'Sala 203', 'São Paulo', 'SP', '01305-000');
  
  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (2,'Avenida Boa Viagem', 'Apto 501', 'Recife', 'PE', '51021-000');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (3,'Rua das Palmeiras', 'Casa 15', 'Belo Horizonte', 'MG', '30112-020');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (4,'Avenida Paulista', 'Andar 10', 'São Paulo', 'SP', '01311-000');

  INSERT INTO endereco (id_endereco, ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
  VALUES (5,'Rua da Consolação', 'Loja 3', 'São Paulo', 'SP', NULL);

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Duplicidade de chave primária ao inserir endereço', SYSDATE, USER);

  WHEN OTHERS THEN
    IF SQLCODE = -1400 THEN
      INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
      VALUES ('Violacao de NOT NULL ao inserir endereço', SYSDATE, USER);
    ELSE
      INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
      VALUES ('Erro desconhecido ao inserir endereço', SYSDATE, USER);
    END IF;
END carregar_enderecos;

BEGIN
  carregar_enderecos;
END;


select * from endereco;
SELECT * FROM t_erro;


--------------------PROCEDURE INSERT PARA CONSULTORIO-----------------------------
CREATE OR REPLACE PROCEDURE carregar_consultorios AS
BEGIN
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (1, 1, 'Clínica ABC', '12345678901234');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (2, 2, 'Hospital XYZ', '56789012345678');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (3, 3, 'Centro Médico DEF', '90123456789012');
  
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (4, 4, 'Clínica XYZ', '34567890123456');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (5, 5, 'Hospital ABC', '67890123456789');
  
  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (6, 6, 'Centro Médico GHI', '01234567890123');

  INSERT INTO consultorio (id_consultorio, id_endereco, nm_empresa, nr_cnpj)
  VALUES (7, 7, 'Clínica Delta', '12345098765432');

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Duplicidade de chave primária ao inserir consultório', SYSDATE, USER);

  WHEN VALUE_ERROR THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Erro de valor ao inserir consultório (por exemplo, NOT NULL violado)', SYSDATE, USER);

  WHEN OTHERS THEN
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES ('Erro desconhecido ao inserir consultório', SYSDATE, USER);
END carregar_consultorios;

BEGIN
  carregar_consultorios;
END;

SELECT * FROM t_erro;
SELECT * FROM CONSULTORIO;


-----------------------PROCEDURE INSERT PARA USUARIO----------------------------
CREATE OR REPLACE PROCEDURE carregar_usuarios AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (1, 'João Silva', '12345678901', 'joao.silva@email.com', 'senha123', 'M');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (2, 'Maria Oliveira', '23456789012', 'maria.oliveira@email.com', 'senha456', 'F');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (3, 'Carlos Santos', '34567890123', 'carlos.santos@email.com', 'senha789', 'M');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (4, 'Ana Pereira', '45678901234', 'ana.pereira@email.com', 'senhaABC', 'F');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (5, 'Paulo Oliveira', '56789012345', 'paulo.oliveira@email.com', 'senhaDEF', 'M');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (6, 'Mariana Santos', '67890123456', 'mariana.santos@email.com', 'senhaGHI', 'F');

    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
    VALUES (7, 'Pedro Silva', '78901234567', 'pedro.silva@email.com', 'senhaJKL', 'M');
    
    INSERT INTO usuario (id_usuario, nm_usuario, nr_cpf, ds_email, ds_senha, ds_genero)
  VALUES (8, NULL, '12345678901', 'teste@email.com', 'senha123', 'M');
  
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicidade de chave primária ao inserir usuário';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir usuário (por exemplo, NOT NULL violado)';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir usuário';
    WHEN TOO_MANY_ROWS THEN
      v_erro_msg := 'Múltiplos registros encontrados ao inserir usuário';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir usuário: ' || SQLERRM;
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 200);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END carregar_usuarios;


BEGIN
  carregar_usuarios;
END;

SELECT * FROM t_erro;
SELECT * FROM usuario;


-----------------------PROCEDURE INSERT PARA IMAGEM----------------------------
CREATE OR REPLACE PROCEDURE carregar_imagens AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    FOR i IN 1..7 LOOP
      INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
      VALUES (i, MOD(i, 3) + 1, SYSTIMESTAMP, 'Resultado ' || TO_CHAR(i));
    END LOOP;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicidade ao inserir imagem';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir imagem (por exemplo, NOT NULL violado)';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir imagem';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir imagem';
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 50);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;

  BEGIN
    INSERT INTO imagem (id_imagem, id_usuario, dt_data_hora, ds_resultado)
    VALUES (8, 1, SYSTIMESTAMP, NULL);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicidade ao inserir imagem';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir imagem (por exemplo, NOT NULL violado)';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir imagem';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir imagem';
  END;

  IF v_erro_msg IS NOT NULL THEN
    v_erro_msg := SUBSTR(v_erro_msg, 1, 50);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END carregar_imagens;

BEGIN
  carregar_imagens;
END;

SELECT * FROM t_erro;
SELECT * FROM imagem;



-----------------------PROCEDURE INSERT PARA MEDICO----------------------------
CREATE OR REPLACE PROCEDURE carregar_medicos AS
  v_erro_msg VARCHAR2(255);
BEGIN
  BEGIN
    -- Inserir 5 linhas na tabela medico
    FOR i IN 1..5 LOOP
      INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
      VALUES (i, 'Médico ' || TO_CHAR(i), 'CRM' || TO_CHAR(i), 'medico' || TO_CHAR(i) || '@hospital.com');
    END LOOP;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicidade ao inserir médico';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir médico (por exemplo, NOT NULL violado)';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir médico';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir médico';
  END;

  IF v_erro_msg IS NOT NULL THEN
    -- Truncar a mensagem para o tamanho máximo permitido
    v_erro_msg := SUBSTR(v_erro_msg, 1, 50);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;

  BEGIN
    -- Tentar inserir um e-mail muito longo em ds_email
    INSERT INTO medico (id_medico, nm_medico, ds_crm, ds_email)
    VALUES (6, 'Médico 6', 'CRM6', NULL);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      v_erro_msg := 'Duplicidade ao inserir médico';
    WHEN VALUE_ERROR THEN
      v_erro_msg := 'Erro ao inserir médico (por exemplo, NOT NULL violado)';
    WHEN NO_DATA_FOUND THEN
      v_erro_msg := 'Nenhum dado encontrado ao inserir médico';
    WHEN OTHERS THEN
      v_erro_msg := 'Erro desconhecido ao inserir médico';
  END;

  IF v_erro_msg IS NOT NULL THEN
    -- Truncar a mensagem para o tamanho máximo permitido
    v_erro_msg := SUBSTR(v_erro_msg, 1, 50);
    INSERT INTO t_erro (nm_erro, dt_ocorrencia, nm_usuario)
    VALUES (v_erro_msg, SYSDATE, USER);
  END IF;
END carregar_medicos;


BEGIN
  carregar_medicos;
END;

SELECT * FROM t_erro;
SELECT * FROM medico;
