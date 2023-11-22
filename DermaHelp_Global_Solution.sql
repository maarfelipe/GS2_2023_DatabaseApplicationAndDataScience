CREATE OR REPLACE PROCEDURE carregar_endereco
IS
    v_ds_logradouro endereco.ds_logradouro%TYPE;
    v_ds_complemento endereco.ds_complemento%TYPE;
    v_nm_cidade endereco.nm_cidade%TYPE;
    v_nm_estado endereco.nm_estado%TYPE;
    v_ds_cep endereco.ds_cep%TYPE;

    -- Exceção personalizada 1
    DUP_VAL_EXCEPTION EXCEPTION;
    PRAGMA EXCEPTION_INIT(DUP_VAL_EXCEPTION, -1);

    -- Exceção personalizada 2
    INVALID_CITY_EXCEPTION EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_CITY_EXCEPTION, -2);

    -- Exceção personalizada 3
    INVALID_STATE_EXCEPTION EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_STATE_EXCEPTION, -3);

BEGIN
    FOR i IN 1..10
    LOOP
        v_ds_logradouro := 'Rua ' || TO_CHAR(i);
        v_ds_complemento := 'Complemento ' || TO_CHAR(i);
        v_nm_cidade := CASE WHEN i <= 5 THEN 'Valid City' ELSE 'Invalid City' END;
        v_nm_estado := CASE WHEN i <= 5 THEN 'Valid State' ELSE 'Invalid State' END;
        v_ds_cep := '1234567' || TO_CHAR(i);

        BEGIN
            INSERT INTO endereco (ds_logradouro, ds_complemento, nm_cidade, nm_estado, ds_cep)
            VALUES (v_ds_logradouro, v_ds_complemento, v_nm_cidade, v_nm_estado, v_ds_cep);

            COMMIT;

        EXCEPTION
            WHEN DUP_VAL_EXCEPTION THEN
                INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
                VALUES (-1, 'Duplicated Value', SYSDATE, USER);
            WHEN INVALID_CITY_EXCEPTION THEN
                INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
                VALUES (-2, 'Invalid City', SYSDATE, USER);
            WHEN INVALID_STATE_EXCEPTION THEN
                INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
                VALUES (-3, 'Invalid State', SYSDATE, USER);
            WHEN OTHERS THEN
                INSERT INTO t_erro (cd_erro, nm_erro, dt_ocorrencia, nm_usuario)
                VALUES (-999, SQLERRM, SYSDATE, USER);
        END;
    END LOOP;
END carregar_endereco;

