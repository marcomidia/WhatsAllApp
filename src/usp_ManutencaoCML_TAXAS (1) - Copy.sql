ALTER PROCEDURE [dbo].[usp_ManutencaoCML_TAXAS]
	@tpOperacao char(1),
    @CODIGO int, 
	@NOME varchar(30), 
	@DATA datetime, 
	@VALOR numeric(18,2),
	@TIPO char(1), 
	@CODIGO_DO_COLABORADOR int,
	@RETORNO int = 0 OUT
AS
BEGIN
	IF @TpOperacao = 'I' BEGIN

		INSERT INTO CML_TAXAS(
			NOME, 
			DATA, 
			VALOR, 
			TIPO, 
			CODIGO_DO_COLABORADOR)
		VALUES (
			 UPPER(@NOME), 
			  @DATA, 
			  @VALOR, 
			  UPPER(@TIPO), 
			  @CODIGO_DO_COLABORADOR)
		SET @RETORNO = (SELECT SCOPE_IDENTITY())
	END
	ELSE IF (@TpOperacao = 'A') BEGIN
		UPDATE CML_TAXAS
				SET NOME = UPPER(@NOME), 
				DATA = @DATA, 
				VALOR = @VALOR, 
				TIPO = UPPER(@TIPO), 
				CODIGO_DO_COLABORADOR = @CODIGO_DO_COLABORADOR
			WHERE 
				CODIGO = @CODIGO
				SET @RETORNO = 1
		END
		ELSE IF (@TpOperacao = 'E') BEGIN
			DELETE FROM CML_TAXAS
			WHERE 
			CODIGO = @CODIGO
			SET @RETORNO = 1
		END
	END
------------------------------------------------------------
