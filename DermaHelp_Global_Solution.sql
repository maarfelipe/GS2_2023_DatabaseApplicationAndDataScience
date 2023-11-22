CREATE OR REPLACE PROCEDURE realizar_carga_inicial AS
BEGIN
    -- Tratamento de exceção para erros específicos
    DECLARE
        l_divisor NUMBER := 0;
    BEGIN
        -- Bloco 1
        INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
        VALUES ('Rua A', 'Apto 101', 'Cidade A', 'Estado A', '12345678');

        -- Bloco 2
        INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
        VALUES ('Rua B', 'Apto 102', 'Cidade B', 'Estado B', '23456789');

        -- Bloco 3
        l_divisor := 1 / 0; -- Gera um erro de divisão por zero
        INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
        VALUES ('Rua C', 'Apto 103', 'Cidade C', 'Estado C', '34567890');

        -- Bloco 4
        INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
        VALUES ('Rua D', 'Apto 104', 'Cidade D', 'Estado D', '45678901');

        -- Bloco 5
        INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
        VALUES ('Rua E', 'Apto 105', 'Cidade E', 'Estado E', '56789012');
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            -- Tratamento para erro de divisão por zero
            INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
            VALUES (1, 'Erro de Divisão por Zero', SYSDATE, USER);
        WHEN NO_DATA_FOUND THEN
            -- Tratamento para erro de nenhum dado encontrado
            INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
            VALUES (2, 'Nenhum Dado Encontrado', SYSDATE, USER);
        WHEN OTHERS THEN
            -- Tratamento genérico para outros erros
            INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
            VALUES (3, SQLERRM, SYSDATE, USER);
    END;

    -- Outros blocos de INSERTs podem ser adicionados aqui

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Tratamento genérico para erros durante a execução da procedure
        INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
        VALUES (4, SQLERRM, SYSDATE, USER);
        ROLLBACK;
END realizar_carga_inicial;
/

