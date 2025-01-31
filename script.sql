create or replace PACKAGE scct.pc_conc
AS
   PROCEDURE sp_parse_igcp(I_ID_UTILIZADOR IN NUMBER);

   TYPE r_cursor IS REF CURSOR;

   TYPE ids_list IS TABLE OF NUMBER;

   PROCEDURE sp_get_igcp_header(i_linha_file_orig IN VARCHAR2, o_nome_ficheiro OUT VARCHAR2);

   PROCEDURE sp_get_igcp_header_lote(
      i_linha_file_orig          IN       VARCHAR2,
      o_nome_banco               OUT      VARCHAR2,
      o_numero_conta             OUT      VARCHAR2
                                                                                                --,
   --o_codigo_nib        OUT      VARCHAR2
   );
   ---

   PROCEDURE sp_get_igcp_detalhe(
      i_linha_file_orig          IN       VARCHAR2,
      o_balcao                   OUT      VARCHAR2,
      o_dt_extracto              OUT      VARCHAR2,
      o_dt_movimento             OUT      VARCHAR2,
      o_tipo_movimento           OUT      VARCHAR2,
      o_tipo_operacao            OUT      VARCHAR2,
      o_montante                 OUT      VARCHAR2,
      o_descricao                OUT      VARCHAR2
   );

   --

   PROCEDURE sp_parse_cgd(I_ID_UTILIZADOR IN NUMBER);

   --

   PROCEDURE sp_get_cgd(
      i_linha_file_orig          IN       VARCHAR2,
      o_num_conta                OUT      VARCHAR2,
      o_balcao                   OUT      VARCHAR2,
      o_dt_extracto              OUT      VARCHAR2,
      o_dt_movimento             OUT      VARCHAR2,
      o_tipo_movimento           OUT      VARCHAR2,
      o_tipo_operacao            OUT      VARCHAR2,
      o_montante                 OUT      VARCHAR2,
      o_descricao                OUT      VARCHAR2,
      o_num_documento            OUT      VARCHAR2,
      o_num_cheque               OUT      VARCHAR2,
      o_tipo_registo             OUT      NUMBER,
      o_cod_divisao              OUT      NUMBER,
      o_nm_divisao               OUT      VARCHAR2
   );
   ---

   PROCEDURE sp_executa_job (o_cod_erro   OUT   NUMBER);

   --

   PROCEDURE sp_pre_concilia(
      i_id_utilizador                  IN       NUMBER,
      i_num_conta                      IN       VARCHAR2,
      i_tp_conciliacao                 IN       NUMBER,--debito ou credito
      i_tipo_registo                   IN       NUMBER, --para saber tipo
      i_dt_inicio                      IN       DATE,
      i_dt_fim                         IN       DATE,
      i_desc_intervalo                 IN       NUMBER,--i_desc_intervalo
      i_val_intervalo                  IN       NUMBER,
      i_data_intervalo                 IN       NUMBER,
      i_cod_divisao                    IN       NUMBER,
      o_cod_erro                      OUT       NUMBER,
      i_batch_flag                     IN       NUMBER
   );
--

   PROCEDURE sp_pre_concilia_aux(
      i_id_utilizador                  IN       NUMBER,
      i_num_conta                      IN       VARCHAR2,
      i_tp_conciliacao                 IN       NUMBER,--debito ou credito
      i_tipo_registo                   IN       NUMBER, --para saber tipo
      i_dt_inicio                      IN       DATE,
      i_dt_fim                         IN       DATE,
      i_desc_intervalo                 IN       NUMBER,--i_desc_intervalo
      i_val_intervalo                  IN       NUMBER,
      i_data_intervalo                 IN       NUMBER,
      i_cod_divisao                    IN       NUMBER,
      o_cod_erro                      OUT       NUMBER,
      i_batch_flag                     IN       NUMBER
   );


--

   PROCEDURE sp_trata_descricao_cgd(io_descricao_movimento IN OUT VARCHAR2);
--


   PROCEDURE sp_tipifica_registo_cgd(
      o_num_cheque            OUT     NUMBER,
      O_TIPO_REGISTO          OUT     NUMBER,
      IO_DESCRICAO_MOVIMENTO  IN OUT  CONC_MOVIMENTO_EXTRACTO.DESCRICAO_MOVIMENTO%TYPE,
      I_NUM_DOCUMENTO         IN      CONC_MOVIMENTO_EXTRACTO.NUM_DOCUMENTO%TYPE,
      I_ORIGEM_MOVIMENTO      IN      VARCHAR2,
      I_TIPO_MOVIMENTO        IN      VARCHAR2
   );
   --


   PROCEDURE sp_trata_tx_devolucao_ci(i_num_conta IN NUMBER,I_ID_UTILIZADOR IN NUMBER);
--

   PROCEDURE sp_trata_ci_dados_grupo(I_ID_UTILIZADOR IN NUMBER);

--

   PROCEDURE sp_trata_tpa_detalhe(I_ID_UTILIZADOR IN NUMBER);

--

   PROCEDURE sp_trata_tpa_detalhe_ndias(I_ID_UTILIZADOR IN NUMBER);

--

   PROCEDURE sp_trata_tpa_detalhe_ndias_aux(
      I_NUM_DIAS IN NUMBER,
      I_ID_UTILIZADOR IN NUMBER
   );
--

   PROCEDURE sp_obtem_cod_divisao_td(
      o_cod_divisao              OUT      NUMBER,
      i_talao_deposito           IN       VARCHAR2,
      i_dt_movimento             IN       DATE,
      o_nm_divisao          OUT      VARCHAR2
   );
--

   PROCEDURE sp_obtem_cod_divisao_pac(
      o_cod_divisao  OUT NUMBER,
      i_num_talao_pac IN NUMBER,
      i_dt_movimento  IN DATE,
      o_nm_divisao   OUT VARCHAR2
   );

--

   PROCEDURE sp_reconcilia_td_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   );

--

   PROCEDURE sp_reconcilia_td_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    );

--

   PROCEDURE sp_reconcilia_pac_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    );

--

   PROCEDURE sp_reconcilia_pac_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   );

--

   PROCEDURE sp_reconcilia_mb_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    );

--

PROCEDURE sp_reconcilia_mb_receita_aux(
      i_dt_inicio				 IN DATE,
      i_dt_fim                   IN DATE,
      i_id_utilizador            IN NUMBER,
      i_batch_flag               IN NUMBER,
      i_desc_intervalo           IN NUMBER,
      i_data_intervalo           IN NUMBER,
      i_val_intervalo            IN NUMBER,
      i_desc_flag                IN NUMBER,
      i_val_flag                 IN NUMBER,
      i_data_flag                IN NUMBER,
      i_num_conta                IN NUMBER,
      i_cod_divisao          	 IN NUMBER
   );



--

   PROCEDURE sp_reconcilia_ci_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    );


--
   PROCEDURE sp_reconcilia_ci_receita_aux(
         i_dt_inicio                IN       DATE,
         i_dt_fim                   IN       DATE,
         i_id_utilizador            IN       NUMBER,
         i_batch_flag               IN       NUMBER,
         i_desc_intervalo           IN       NUMBER,
         i_data_intervalo           IN       NUMBER,
         i_val_intervalo            IN       NUMBER,
         i_desc_flag                IN       NUMBER,
         i_val_flag                 IN       NUMBER,
         i_data_flag                IN       NUMBER,
         i_num_conta                IN       NUMBER,
         i_cod_divisao              IN       NUMBER
      );

--

   PROCEDURE sp_reconcilia_tpa_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    );

--

   PROCEDURE sp_reconcilia_tpa_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   );

--

  -- PROCEDURE sp_teste_array(lista IN ids_list);

--
  /**
   * Tabela de interface para criacao das associacoes dos movimentos de detalhe
   * com os movimentos de extracto.
   */
  PROCEDURE SP_ASSOC_DETALHE_INTERFACE(
      I_ID_MOV_EXTRACTO          IN       NUMBER,
      I_ID_MOV_DETALHE           IN       NUMBER,
      I_TP_MOV_DETALHE           IN       NUMBER,
      IO_AGRUPADOR               IN OUT   NUMBER,
      I_ID_UTILIZADOR            IN       NUMBER,
      COD_ERRO                   OUT      NUMBER
   );

--
   PROCEDURE sp_conc_interface(
      i_id_mov                   IN       NUMBER,
      i_tp_mov                   IN       VARCHAR2,
      io_agrupador               IN OUT   VARCHAR2,
      i_id_utilizador            IN       NUMBER,
      cod_erro                   OUT      NUMBER
   );

--
   PROCEDURE sp_conc_grava_conciliacao(
      i_agrupador                IN       NUMBER,
      i_id_utilizador            IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      cod_erro                   OUT      NUMBER,
      O_MSG_RETORNO              OUT VARCHAR2
   );
--
 PROCEDURE sp_anula_conc_mov(
      I_AGRUPADOR    IN    NUMBER,
      I_ID_UTILIZADOR IN NUMBER,
      O_COD_ERRO     OUT   NUMBER
   );
--

   PROCEDURE sp_actualiza_val_agrupadores(
      i_id_utilizador    NUMBER,
      i_tipo_registo     NUMBER
   );

--
  PROCEDURE sp_trata_agrup_refmb_extracto(I_ID_UTILIZADOR IN NUMBER);

--

   PROCEDURE sp_trata_mpsibs_detalhe(I_ID_UTILIZADOR IN NUMBER);


--

   FUNCTION sp_obtem_descricao_grupo(

      i_tipo_registo    IN    CONC_TIPO_REGISTO.ID_TIPO_REGISTO%TYPE,
      i_agrupador       IN    NUMBER
   ) RETURN CONC_MOVIMENTO_SCCT.DESCRICAO_GRUPO%TYPE;

  PROCEDURE SP_TRATA_CONC_REGULARIZACAO(
      I_AGRUPADOR    IN    NUMBER,
       I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
      I_FL_INICIAL IN NUMBER,
      O_COD_ERRO OUT NUMBER,
      O_MSG_ERRO OUT VARCHAR
   );


  /**
    * Procedimento que insere os movimentos envolvidos num processo de conciliação para regularização
    * numa tabela de interface para que posteriormente possam ser tratados pelo procedimento SP_TRATA_CONC_REGULARIZACAO.
    *
    */

   PROCEDURE SP_CONC_WF_REG_INTERFACE(
      I_ID_MOV    IN     NUMBER,
      I_TP_MOV    IN     VARCHAR2,
      I_ID_UTILIZADOR IN NUMBER,
      O_COD_ERRO    OUT    NUMBER,
      O_MSG_ERRO OUT VARCHAR2
   );


    /**
  * Cancela um pedido de conciliação para regularização, colocando os movimentos
  * envolvidos novamente disponíveis para conciliação e recalculando novamente todos
  * os agrupadores envolvidos.
	* RETURN CODES:
	* 1 - ARGS NULL
	* 2 - Movimentos ãlterados durante o processamento.
  */
   PROCEDURE SP_CANCELA_CONC_REGULARIZACAO(
      I_AGRUPADOR    IN    NUMBER,
      I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
      O_COD_ERRO OUT NUMBER,
      O_MSG_ERRO OUT VARCHAR
   );

   /**
   * Procedimento responsavel por realizar as alterações necessárias em termos de reclassificação
   * de movimentos e por actualizar toda a informação subjacente a esta alteração.
   * CODIGOS DE ERRO:
   * ------------------
   * 1 - Campo obrigatório por preencher.
   * 2 - Não existe um utilizador com o identificador fornecido.
   * 3 - Não existem movimentos com o identificador fornecido.
   * 4 - O novo tipo de registo não e válido.
   * 5 - O indicador de origem do movimento é inválido. Apenas os valores D e E são autorizados.
   */
    PROCEDURE SP_UPDT_POS_RECLASSIFICACAO(
      I_ID_MOVIMENTO            IN  NUMBER,
      I_ORIGEM_MOVIMENTO        IN  CHAR,
      I_ID_ANTIGO_TIPO_REGISTO  IN  NUMBER,
      I_ID_NOVO_TIPO_REGISTO    IN  NUMBER,
      I_COD_NOVA_DIVISAO        IN  NUMBER,
      I_ID_UTILIZADOR           IN  NUMBER,
      O_COD_ERRO                OUT NUMBER,
      O_MSG_ERRO                OUT VARCHAR
   );


	/**
	* Executa a conciliação automática de movimentos equivalentes, débito/crédito, para os movimentos do ficheiro importado
	*  I_ID_FICHEIRO_IMPORTADO - id do ficheiro importado para o qual se procura
	*  I_ID_UTILIZADOR - id do utilizador a executar a operacao
	*
	* RETURN CODES:
	* 20 - Erro na execução do PC_CONC.SP_CONC_INTERFACE
	* 21 - Erro na execução do PC_CONC.SP_CONC_GRAVA_CONCILIACAO
	*/
	PROCEDURE SP_CONC_DEB_CRED_EXTRACTO(
	      I_ID_FICHEIRO_IMPORTADO    IN    NUMBER,
	      I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
	      O_COD_ERRO OUT NUMBER,
	      O_MSG_ERRO OUT VARCHAR
	);

	/*
	 * Permite remover movimentos do scct para abrir uma caixa e executar a criacao de um novo talao de deposito
	 */
	PROCEDURE sp_remove_mov_scct_by_caixa(
      I_ID_CAIXA    IN    NUMBER,
      I_ID_UTILIZADOR IN NUMBER
   );

	/*
	 * Executa a associacao entre movimentos de detalhe de banco e movimentos de extracto
	 * que tenham já sido associados atraves da tabela  de interface (SP_ASSOC_DETALHE_INTERFACE)
	 */
	PROCEDURE SP_CONC_GRAVA_ASSOC_DETALHE(
      I_AGRUPADOR               IN NUMBER,
	  I_TP_DETALHE				IN NUMBER,
      I_ID_UTILIZADOR           IN NUMBER,      
      COD_ERRO                  OUT NUMBER
   );

	/**
	 * Anulacao de associacao entre um detalhe de banco e o extracto correspondente
	 * 
	 * RETURN CODES:
	 * 10 - I_TP_REGISTO enviou um valor desconhecido/nao esperado para processamento
	 */
	PROCEDURE SP_CONC_ANULA_ASSOC_DETALHE(
	  I_TP_REGISTO				IN NUMBER,
      I_AGRUPADOR               IN NUMBER,
      I_ID_UTILIZADOR           IN NUMBER,      
      COD_ERRO                  OUT NUMBER
   );

   /**
    * Procedure que executa a conciliação automática, por triangulação, das referências MB por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_ref_mb_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

--

	/**
    * Procedure que executa a conciliação parcial (DETALHE MPSIBS - SCCT) automática das referências MB por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_parc_ref_mb_auto(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

---
	
  /**
    * Procedure que executa a conciliação automática dos talões de depósito por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_taloes_dep_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

--

  /**
    * Procedure que executa a conciliação automática dos talões PAC por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_taloes_pac_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

--

   /**
    * Procedure que executa a conciliação automática de TPAs por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_tpa_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

--

	/**
    * Procedure que executa a conciliação parcial automática de TPA 
    */
   PROCEDURE sp_conc_parc_tpa_auto(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2);

--

	/**
    * Importação manual de dados de uma referencia MB para conciliação
    */
  PROCEDURE SP_PROCESSA_MOVIMENTO_REF_MB(I_ID_REF_MB IN REFERENCIA_MULTIBANCO.ID_REFERENCIA_MULTIBANCO%TYPE, I_OBSERVACOES IN VARCHAR2, I_NM_USER IN DGV.DGV_USER.NM_USER%TYPE);


END pc_conc;
/

create or replace PACKAGE BODY scct.pc_conc
AS

   /**
    * Função responsável pot tipificar movimentos do IGCP.
    */
   FUNCTION FN_TIPIFICA_MOV_IGCP(I_NUM_CONTA IN NUMBER,I_TIPO_MOVIMENTO IN CONC_MOVIMENTO_EXTRACTO.TIPO_MOVIMENTO%TYPE,I_DESCRICAO IN CONC_MOVIMENTO_EXTRACTO.DESCRICAO_MOVIMENTO%TYPE)
      RETURN NUMBER
   IS
   BEGIN

      -- Se é este o número de conta do movimento, com tipo de movimento TRC e descricao 1/INSTITUTO GESTAO, então trata-se de um TPA.
      IF I_NUM_CONTA = 6478 AND I_TIPO_MOVIMENTO = 'TRC' AND I_DESCRICAO = '1/INSTITUTO GESTAO' THEN
        RETURN 3;
      -- Se é este número de conta e o tipo de movimento é ATM, então trata-se de uma referência multibanco.
      ELSIF I_NUM_CONTA = 1120013221 AND I_TIPO_MOVIMENTO = 'ATM' THEN
        RETURN 4;
	  -- Caso movimento transferencia bancaria
	  ELSIF I_TIPO_MOVIMENTO IN ('TRC','TRD','RGC','RGD') THEN
       RETURN 8;
      -- caso contrário vai para "Outros" e terá posteriormente de ser reclassificado de forma manual.
      ELSE
        RETURN 7;
      END IF;

   END FN_TIPIFICA_MOV_IGCP;


   /**
    * procedure responsavel por tratar cada linha do ficheiro proveniente do IGCP
    */
   PROCEDURE sp_parse_igcp(I_ID_UTILIZADOR IN NUMBER)
   IS
      v_linha_movimentos_extracto   conc_movimento_extracto%ROWTYPE;
      v_id_mov_banco                conc_movimento_extracto.id_mov_banco%TYPE;
      v_linha_ficheiro_original     conc_movimento_extracto.linha_ficheiro_original%TYPE;
      v_nome_ficheiro               conc_movimento_extracto.nome_ficheiro%TYPE;
      --v_origem_ficheiro             conc_movimento_extracto.origem_ficheiro%TYPE;--pensar na origem ficheiro
      v_nome_banco                  conc_movimento_extracto.nome_banco%TYPE;
      v_balcao                      conc_movimento_extracto.balcao%TYPE;
      v_num_conta                conc_movimento_extracto.num_conta%TYPE;
      --v_codigo_nib                  conc_movimento_extracto.codigo_nib%TYPE;
      v_dt_extracto                conc_movimento_extracto.dt_extracto%TYPE;
      v_dt_movimento                    conc_movimento_extracto.dt_movimento%TYPE;
      v_tipo_movimento              conc_movimento_extracto.tipo_movimento%TYPE;
      v_tipo_operacao               conc_movimento_extracto.tipo_operacao%TYPE;
      v_montante                    conc_movimento_extracto.montante%TYPE;
      V_DESCRICAO                   CONC_MOVIMENTO_EXTRACTO.DESCRICAO_MOVIMENTO%TYPE;
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
      V_TIPO_REGISTO                CONC_MOVIMENTO_EXTRACTO.TIPO_REGISTO%TYPE;
      v_cod_divisao                 conc_movimento_extracto.cod_divisao%TYPE;
      v_nm_divisao                 conc_movimento_extracto.nm_divisao_grupo%TYPE;

      --este cursor obtem as linhas que ainda nao foram tratadas(id_estado='Registada')
      CURSOR c_lines
      IS
         SELECT *
           FROM CONC_MOVIMENTO_EXTRACTO
          WHERE id_estado = 1 AND origem_ficheiro = 'IGCP' ORDER BY ID_MOV_BANCO ASC;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;


      OPEN c_lines;

      -- ciclo no qual e feito o parse de cada linha do ficheiro
      LOOP
         FETCH C_LINES INTO V_LINHA_MOVIMENTOS_EXTRACTO;

         EXIT WHEN C_LINES%NOTFOUND;

         V_LINHA_FICHEIRO_ORIGINAL := V_LINHA_MOVIMENTOS_EXTRACTO.LINHA_FICHEIRO_ORIGINAL;
         V_ID_MOV_BANCO := V_LINHA_MOVIMENTOS_EXTRACTO.ID_MOV_BANCO;

         -- HEADER
         IF SUBSTR(V_LINHA_FICHEIRO_ORIGINAL, 1, 1) = '0' THEN

            SP_GET_IGCP_HEADER(V_LINHA_FICHEIRO_ORIGINAL, V_NOME_FICHEIRO);

            DELETE FROM CONC_MOVIMENTO_EXTRACTO WHERE ID_MOV_BANCO = V_ID_MOV_BANCO;

         -- HEADER de LOTE
         ELSIF SUBSTR(V_LINHA_FICHEIRO_ORIGINAL, 1, 1) = '1' THEN

          SP_GET_IGCP_HEADER_LOTE(V_LINHA_FICHEIRO_ORIGINAL, V_NOME_BANCO, V_NUM_CONTA);

          DELETE FROM CONC_MOVIMENTO_EXTRACTO WHERE ID_MOV_BANCO = V_ID_MOV_BANCO;

         -- DETALHE
         ELSIF SUBSTR(v_linha_ficheiro_original, 1, 1) = '2' THEN

          SP_GET_IGCP_DETALHE(V_LINHA_FICHEIRO_ORIGINAL,V_BALCAO,V_DT_EXTRACTO,V_DT_MOVIMENTO,V_TIPO_MOVIMENTO,V_TIPO_OPERACAO,V_MONTANTE,V_DESCRICAO);

          -- obtem tipo de registo de acordo com a conta originaria do movimento.
          V_TIPO_REGISTO := FN_TIPIFICA_MOV_IGCP(V_NUM_CONTA,V_TIPO_MOVIMENTO,V_DESCRICAO);
          
          --REGRAS ASSOCIACAO DIVISAO
          IF V_NUM_CONTA = '01120012643' THEN
          	--ASSOCIAR CENTRAIS 02-11-2012
          	v_cod_divisao := 0;
          	
          	SELECT ddv.nm_divisao into v_nm_divisao
         	FROM DGV.DGV_DIVISAO ddv
       		WHERE ddv.cod_divisao = v_cod_divisao;
          ELSE
          	v_cod_divisao := null;
          END IF;

          UPDATE
             CONC_MOVIMENTO_EXTRACTO
          SET
             NOME_BANCO = V_NOME_BANCO,
             BALCAO = V_BALCAO,
             NUM_CONTA = V_NUM_CONTA,
             DT_EXTRACTO = V_DT_EXTRACTO,
             DT_MOVIMENTO = V_DT_MOVIMENTO,
             MONTANTE = V_MONTANTE,
             DESCRICAO_MOVIMENTO = V_DESCRICAO,
             TIPO_MOVIMENTO = V_TIPO_MOVIMENTO,
             TIPO_OPERACAO = V_TIPO_OPERACAO,
             TIPO_REGISTO = V_TIPO_REGISTO,
             ID_ESTADO = 2,
             COD_DIVISAO = v_cod_divisao,
             -- VALORES AGRUPADOS (PARA EFEITOS DE VISUALIZACAO MANUAL)
             AGRUPADOR = SQ_ID_MOVIMENTO_ASSOCIADO.NEXTVAL,
             VALOR_GRUPO = V_MONTANTE,
             DATA_GRUPO = V_DT_MOVIMENTO,
             DATA_EXTRACTO_GRUPO = V_DT_EXTRACTO,
             DESCRICAO_GRUPO = V_DESCRICAO,
             COD_DIVISAO_GRUPO = v_cod_divisao,
             NM_DIVISAO_GRUPO = v_nm_divisao,
             TP_MOV_GRUPO = V_TIPO_OPERACAO,
             ID_TIPO_REG_GRUPO = V_TIPO_REGISTO,
             TIPO_REG_GRUPO = (SELECT TP_REG.VALOR FROM CONC_TIPO_REGISTO TP_REG WHERE TP_REG.ID_TIPO_REGISTO = V_TIPO_REGISTO),
             NUM_CONTA_GRUPO = V_NUM_CONTA,
             NUM_MOVIMENTOS = 1,
             -- CAMPOS DE AUDITORIA.
             DH_UPDT = CURRENT_TIMESTAMP,
             DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE
             ID_MOV_BANCO = V_ID_MOV_BANCO;

         --TRAILER de LOTE
         ELSIF SUBSTR(V_LINHA_FICHEIRO_ORIGINAL, 1, 1) = '8' THEN

            DELETE FROM CONC_MOVIMENTO_EXTRACTO WHERE ID_MOV_BANCO = V_ID_MOV_BANCO;

         --TRAILER
         ELSIF SUBSTR(V_LINHA_FICHEIRO_ORIGINAL, 1, 1) = '9' THEN

           DELETE FROM CONC_MOVIMENTO_EXTRACTO WHERE ID_MOV_BANCO = V_ID_MOV_BANCO;

         END IF;
      END LOOP;

      CLOSE C_LINES;

   END SP_PARSE_IGCP;

   /**
    * procedure que obtem dados do header
    */
   PROCEDURE sp_get_igcp_header(i_linha_file_orig IN VARCHAR2, o_nome_ficheiro OUT VARCHAR2)
   IS
   BEGIN
      o_nome_ficheiro := SUBSTR(i_linha_file_orig, 21, 4);
   END sp_get_igcp_header;

   /**
    * procedure que obtem dados do header de lote
    */
   PROCEDURE sp_get_igcp_header_lote(
      i_linha_file_orig          IN       VARCHAR2,
      o_nome_banco               OUT      VARCHAR2,
      o_numero_conta             OUT      VARCHAR2                                               --,
   --o_codigo_nib        OUT      VARCHAR2
   )
   IS
   BEGIN
      o_nome_banco := SUBSTR(i_linha_file_orig, 2, 8);
      o_numero_conta := SUBSTR(i_linha_file_orig, 10, 11);
   --o_codigo_nib := SUBSTR (i_linha_file_orig, 21, 2);
   END sp_get_igcp_header_lote;

   /**
   * procedure que obtem dados dos detalhes
   */
   PROCEDURE sp_get_igcp_detalhe(
      i_linha_file_orig          IN       VARCHAR2,
      o_balcao                   OUT      VARCHAR2,
      o_dt_extracto             OUT      VARCHAR2,
      o_dt_movimento                 OUT      VARCHAR2,
      o_tipo_movimento           OUT      VARCHAR2,
      o_tipo_operacao            OUT      VARCHAR2,
      o_montante                 OUT      VARCHAR2,
      o_descricao                OUT      VARCHAR2
--      ,
--      o_cod_divisao              OUT      VARCHAR2
   )
   IS

--      v_id_valor_param_geral  NUMBER;

   BEGIN
      o_balcao := SUBSTR(i_linha_file_orig, 2, 4);
      o_dt_extracto := TO_DATE(SUBSTR(i_linha_file_orig, 6, 8), 'YYYY-MM-DD');
      o_dt_movimento := TO_DATE(SUBSTR(i_linha_file_orig, 14, 8), 'YYYY-MM-DD');
      o_tipo_movimento := SUBSTR(i_linha_file_orig, 22, 3);
      o_tipo_operacao := SUBSTR(i_linha_file_orig, 25, 1);
      o_montante := SUBSTR(i_linha_file_orig, 26, 17);
      o_descricao := SUBSTR(i_linha_file_orig, 43, 18);
      o_montante := o_montante * 0.01;               --atribuic?o de 2 casas decimais aos montantes

      IF o_tipo_operacao = '-' THEN
         o_tipo_operacao := 'D';
      ELSIF o_tipo_operacao = '+' THEN
         o_tipo_operacao := 'C';
      END IF;


   END sp_get_igcp_detalhe;

------------------------------------CGD---------------------------------------
  /**
   *  procedure responsavel por tratar cada linha do ficheiro proveniente da CGD
   */
   PROCEDURE sp_parse_cgd(I_ID_UTILIZADOR IN NUMBER)
   IS
      v_linha_movimentos_extracto   conc_movimento_extracto%ROWTYPE;
      v_id_mov_banco                conc_movimento_extracto.id_mov_banco%TYPE;
      v_linha_ficheiro_original     conc_movimento_extracto.linha_ficheiro_original%TYPE;
      --v_nome_ficheiro               conc_movimento_extracto.nome_ficheiro%TYPE;
      v_nome_banco                  conc_movimento_extracto.nome_banco%TYPE;
      v_balcao                      conc_movimento_extracto.balcao%TYPE;
      v_num_conta                   conc_movimento_extracto.num_conta%TYPE;
      v_dt_extracto                 conc_movimento_extracto.dt_extracto%TYPE;
     v_dt_movimento                 conc_movimento_extracto.dt_movimento%TYPE;
      v_tipo_movimento              conc_movimento_extracto.tipo_movimento%TYPE;
      v_tipo_operacao               conc_movimento_extracto.tipo_operacao%TYPE;
      v_montante                    conc_movimento_extracto.montante%TYPE;
      v_descricao                   conc_movimento_extracto.descricao_movimento%TYPE;
      v_num_documento               conc_movimento_extracto.num_documento%TYPE;
      v_num_cheque                  CONC_MOVIMENTO_EXTRACTO.NUM_CHEQUE%TYPE;
      v_tipo_registo                CONC_MOVIMENTO_EXTRACTO.TIPO_REGISTO%TYPE;
      v_cod_divisao                 CONC_MOVIMENTO_EXTRACTO.COD_DIVISAO%TYPE;
      V_NM_DIVISAO                  DGV.DGV_DIVISAO.NM_DIVISAO%TYPE;
      V_NM_UTILIZADOR               DGV.DGV_USER.NM_USER%TYPE;

      CURSOR c_lines
      IS
         SELECT *
           FROM conc_movimento_extracto
          WHERE id_estado = 1 AND origem_ficheiro = 'CGD';

   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      OPEN c_lines;

      LOOP
         FETCH c_lines
          INTO v_linha_movimentos_extracto;

         EXIT WHEN c_lines%NOTFOUND;
         v_id_mov_banco := v_linha_movimentos_extracto.id_mov_banco;
         v_linha_ficheiro_original := v_linha_movimentos_extracto.linha_ficheiro_original;



         sp_get_cgd(v_linha_ficheiro_original,
                    v_num_conta,
                    v_balcao,
                    v_dt_extracto,
                    v_dt_movimento,
                    v_tipo_movimento,
                    v_tipo_operacao,
                    v_montante,
                    v_descricao,
                    v_num_documento,
                    v_num_cheque,
                    v_tipo_registo,
                    v_cod_divisao,
                    v_nm_divisao
                   );
         --v_nome_ficheiro := 'nome_ficheiro_dummy';
         v_nome_banco := 'CGD';

         IF(v_num_cheque IS NOT NULL)THEN

           UPDATE conc_movimento_extracto
              SET nome_banco = v_nome_banco,
                  num_conta = v_num_conta,
                  balcao = v_balcao,
                  dt_extracto = v_dt_extracto,
                  dt_movimento = v_dt_movimento,
                  montante = v_montante,
                  descricao_movimento = v_descricao,
                  tipo_movimento = v_tipo_movimento,
                  tipo_operacao = v_tipo_operacao,
                  id_estado = 2,
                  num_documento = v_num_documento,
                  num_cheque = v_num_cheque,
                  tipo_registo = v_tipo_registo,
                  cod_divisao = v_cod_divisao,
                  nm_divisao_grupo = v_nm_divisao
                  ,DH_UPDT = CURRENT_TIMESTAMP
                  ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
            WHERE id_mov_banco = v_id_mov_banco;
          ELSE
            UPDATE conc_movimento_extracto
              SET nome_banco = v_nome_banco,
                  num_conta = v_num_conta,
                  balcao = v_balcao,
                  dt_extracto = v_dt_extracto,
                  dt_movimento = v_dt_movimento,
                  montante = v_montante,
                  descricao_movimento = v_descricao,
                  tipo_movimento = v_tipo_movimento,
                  tipo_operacao = v_tipo_operacao,
                  id_estado = 2,
                  num_documento = v_num_documento,
                  tipo_registo = v_tipo_registo,
                  cod_divisao = v_cod_divisao,
                  --colunas de grupo
                  data_grupo = v_dt_movimento,
				  DATA_EXTRACTO_GRUPO = v_dt_extracto,
                  descricao_grupo = v_descricao,
                  cod_divisao_grupo =  v_cod_divisao,
                  nm_divisao_grupo = v_nm_divisao,
                  tp_mov_grupo = v_tipo_operacao,
                  id_tipo_reg_grupo = v_tipo_registo,
                  tipo_reg_grupo = (select ctr.valor
                                      from conc_tipo_registo ctr
                                      where CTR.ID_TIPO_REGISTO = v_tipo_registo),
                  num_conta_grupo = v_num_conta,
                  valor_grupo = v_montante,
                  num_movimentos = 1
                  ,DH_UPDT = CURRENT_TIMESTAMP
                  ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
            WHERE id_mov_banco = v_id_mov_banco;
         END IF;

      END LOOP;

      CLOSE c_lines;

      FOR cursor1 IN (SELECT DISTINCT num_conta
                        FROM conc_movimento_extracto
                       WHERE tipo_registo = 5)

      LOOP
         sp_trata_tx_devolucao_ci(cursor1.num_conta,I_ID_UTILIZADOR);
      END LOOP;


      UPDATE conc_movimento_extracto
         SET AGRUPADOR = SQ_ID_MOVIMENTO_ASSOCIADO.NEXTVAL
            ,DH_UPDT = CURRENT_TIMESTAMP
            ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
       WHERE agrupador IS NULL
         AND tipo_registo != 5
         AND tipo_registo != 4
         AND ID_ESTADO = 2;

      sp_trata_agrup_refmb_extracto(I_ID_UTILIZADOR);

   END sp_parse_cgd;


/**
 * procedure que extrai os detalhes de uma linha do ficheiro
 */
   PROCEDURE sp_get_cgd(
      i_linha_file_orig          IN       VARCHAR2,
      o_num_conta                OUT      VARCHAR2,
      o_balcao                   OUT      VARCHAR2,
      o_dt_extracto              OUT      VARCHAR2,
      o_dt_movimento             OUT      VARCHAR2,
      o_tipo_movimento           OUT      VARCHAR2,
      o_tipo_operacao            OUT      VARCHAR2,
      o_montante                 OUT      VARCHAR2,
      o_descricao                OUT      VARCHAR2,
      o_num_documento            OUT      VARCHAR2,
      o_num_cheque               OUT      VARCHAR2,
      o_tipo_registo             OUT      NUMBER,
      o_cod_divisao              OUT      NUMBER,
      o_nm_divisao               OUT      VARCHAR2
   )
   IS
    IN_ORIGEM_MOVIMENTO VARCHAR2(4);
   BEGIN

      o_num_conta := SUBSTR(i_linha_file_orig, 1, 13);
      o_balcao := SUBSTR(i_linha_file_orig, 1, 4);
      o_dt_extracto := TO_DATE(SUBSTR(i_linha_file_orig, 32, 8), 'YYYY-MM-DD');
      o_dt_movimento := TO_DATE(SUBSTR(i_linha_file_orig, 40, 8), 'YYYY-MM-DD');
      O_TIPO_MOVIMENTO := SUBSTR(I_LINHA_FILE_ORIG, 110, 3);
      IN_ORIGEM_MOVIMENTO := SUBSTR(I_LINHA_FILE_ORIG,53,4);
      o_tipo_operacao := SUBSTR(i_linha_file_orig, 57, 1);
      o_montante := SUBSTR(i_linha_file_orig, 62, 14);
      o_descricao := SUBSTR(i_linha_file_orig, 110, 21);
      o_num_documento := SUBSTR(i_linha_file_orig, 131, 10);
      o_montante := o_montante * 0.01;                 --para atribuir 2 casas decimais ao montante

      SP_TRATA_DESCRICAO_CGD(O_DESCRICAO);

      PC_CONC.SP_TIPIFICA_REGISTO_CGD(O_NUM_CHEQUE,O_TIPO_REGISTO,O_DESCRICAO,O_NUM_DOCUMENTO,IN_ORIGEM_MOVIMENTO,O_TIPO_MOVIMENTO);

      IF(o_tipo_registo = 1)THEN
         sp_obtem_cod_divisao_td(o_cod_divisao,o_descricao,o_dt_movimento,o_nm_divisao);
      END IF;

      IF(o_tipo_registo = 2) THEN
         sp_obtem_cod_divisao_pac(o_cod_divisao,o_descricao,o_dt_movimento,o_nm_divisao);
      END IF;


   END sp_get_cgd;
--

   /**
 * procedure que insere um caracter numa determinada posic?o de uma string e devolve a string alterada
 */
   PROCEDURE sp_insert_char(
      i_str                      IN       VARCHAR2,
      i_position                 IN       NUMBER,
      i_char                     IN       VARCHAR2,
      o_final_str                OUT      VARCHAR2
   )
   IS
      left_str    VARCHAR2(255);
      right_str   VARCHAR2(255);
   BEGIN
      left_str := SUBSTR(i_str, 1, i_position);
      right_str := SUBSTR(i_str,(i_position + 1),(LENGTH(i_str) - i_position));
      o_final_str := CONCAT(left_str, i_char);
      o_final_str := CONCAT(o_final_str, right_str);
   END sp_insert_char;

--


 /**
 * func?o que retorna 1 se a convers?o para number for possivel e 0 quando
 * n?o e possivel
 */
   FUNCTION converte_para_number(v_descricao VARCHAR)
      RETURN NUMBER
   IS
      v_temp      NUMBER;
      v_sucesso   NUMBER;
   BEGIN
      v_temp := TO_NUMBER(v_descricao);
      RETURN 1;
   EXCEPTION
      WHEN OTHERS THEN
         RETURN 0;
   END;

--




  /**
 * Procedure que retira espacos em branco de registos que s?o numeros.
 * As strings s?o convertidas em numeros(ficam sem espacoes em branco) e novamente em strings
 * As strings que comecam com um '0'n?o podem ser convertidas em numero pois caso
 * o fossem, o 0 mais a direita deixava de existir.
 * Tem que ser chamada apos a execuc?o da sp_parse_cgd
 */

   PROCEDURE sp_trata_descricao_cgd(io_descricao_movimento IN OUT VARCHAR2)
   IS
      --v_descricao_movimento   conc_movimento_extracto.descricao_movimento%TYPE;
      v_number                NUMBER;
      v_go                    NUMBER;--flag que indica se uma string pode ser convertida em numero (1-true 0-false)

   BEGIN

         IF SUBSTR(io_descricao_movimento, 1, 1) = '0' THEN
            v_go := 0;                     -- a string comeca por 0, a convers?o n?o pode ser feita
         ELSE
            v_go := converte_para_number(io_descricao_movimento);
         END IF;

         IF v_go = 1 THEN
            v_number := TO_NUMBER(io_descricao_movimento);
            io_descricao_movimento := TO_CHAR(v_number);
         END IF;

   END sp_trata_descricao_cgd;


-----

 PROCEDURE sp_tipifica_registo_cgd(

      O_NUM_CHEQUE            OUT     NUMBER,
      O_TIPO_REGISTO          OUT     NUMBER,
      IO_DESCRICAO_MOVIMENTO  IN OUT  CONC_MOVIMENTO_EXTRACTO.DESCRICAO_MOVIMENTO%TYPE,
      I_NUM_DOCUMENTO         IN      CONC_MOVIMENTO_EXTRACTO.NUM_DOCUMENTO%TYPE,
      I_ORIGEM_MOVIMENTO      IN      VARCHAR2,
      I_TIPO_MOVIMENTO        IN      VARCHAR2
      )

   IS

   BEGIN

         IF LENGTH(io_descricao_movimento) = 6 THEN
            --se o tamanho for 6 significa que e um talao deposito, talao pac ou reg de cheque
            IF SUBSTR(io_descricao_movimento, 1, 1) = 2 THEN
    			-- se comecar por um 2 entao PAC (foi a Dra Teresa que deu esta indicacao)
               o_tipo_registo := 2;                                                --PAC
            ELSIF SUBSTR(io_descricao_movimento, 1, 1) = 9 THEN
    			-- se comecar por 9 entao e uma regularizacao Talao Deposito (foi a MAFALDA que deu esta indicacao, 03-12-2012)
               o_tipo_registo := 5;                                                --Cheque Irregular
            ELSE
               o_tipo_registo := 1;                                                --Talao Deposito
            END IF;
         --o tamanho e diferente de 6
         ELSE
            IF INSTR(io_descricao_movimento, 'POS VENDAS') > 0 THEN
               o_tipo_registo := 3;                                                         --TPA
               IO_DESCRICAO_MOVIMENTO := SUBSTR(IO_DESCRICAO_MOVIMENTO,3,6);
            ELSE
               IF INSTR(io_descricao_movimento, 'COB PAG SERV') > 0 THEN
                  o_tipo_registo := 4;                                                     --Ref MB
               ELSE
                  IF    INSTR(io_descricao_movimento, 'CHEQUE') > 0
                     OR INSTR(io_descricao_movimento, 'CHQ') > 0 THEN
                     o_tipo_registo := 5;                                        --Cheque Irregular

                     IF SUBSTR(io_descricao_movimento, 0, 3) = 'DVL' THEN

                        IF(SUBSTR(io_descricao_movimento, 4, 7) = 'CHEQUE')THEN
                           o_tipo_registo := 5;
                        ELSE
                           o_num_cheque := SUBSTR(io_descricao_movimento, 9, 10);

                           o_num_cheque := TO_NUMBER(o_num_cheque);
                        END IF;

                     ELSIF SUBSTR(io_descricao_movimento,1,19) = 'DEVOLUCAO DE CHEQUE' THEN --significa que o numero de cheque esta no campo 'num_documento'

                        o_num_cheque := TO_NUMBER(i_num_documento);

                     END IF;

                  ELSE
                     IF INSTR(IO_DESCRICAO_MOVIMENTO, 'PAGT MT') > 0 THEN
                        O_TIPO_REGISTO := 6;                                         --Comissoes MB
                     ELSIF I_TIPO_MOVIMENTO IN ('TRF','TRA','PAG') THEN
                        O_TIPO_REGISTO := 8;  --transf bancaria.
                     ELSE
                        o_tipo_registo := 7;                                               --Outros
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;

         EXCEPTION
            WHEN VALUE_ERROR THEN
            o_tipo_registo := 5;

   END sp_tipifica_registo_cgd;


-------

   /**
   * obtencao do cod_divisao de acordo com o numero do talao deposito.
   */
   PROCEDURE sp_obtem_cod_divisao_td(

      o_cod_divisao         OUT      NUMBER,
      i_talao_deposito      IN       VARCHAR2,
      i_dt_movimento        IN       DATE,
      o_nm_divisao          OUT      VARCHAR2
   )

   IS

   BEGIN

       SELECT decode(CDD.ID_DGV_DIVISAO,NULL,NULL,CDD.ID_DGV_DIVISAO,CDD.ID_DGV_DIVISAO) INTO o_cod_divisao
        FROM CARACTERISTICA_DGV_DIVISAO cdd,--TODO: alterar tabela para caraterisctica_dgv_divisao
             PARAM_GERAL_TEMPORAL pgt,--TODO: alterar tabela para para_geral_temporal
             VALOR_PARAM_GERAL vpg
       WHERE cdd.max_intervalo_talao >= to_number(i_talao_deposito)
         AND cdd.min_intervalo_talao <= to_number(i_talao_deposito)
         AND cdd.id_valor_param_geral = PGT.ID_VALOR_PARAM_GERAL
         AND i_dt_movimento <= decode(PGT.DATA_FIM,NULL,sysdate, PGT.DATA_FIM,PGT.DATA_FIM)
         and i_dt_movimento >= PGT.DATA_INICIO
         and vpg.id_valor_param_geral = pgt.id_valor_param_geral
         and vpg.activo = 1;

       SELECT ddv.nm_divisao into o_nm_divisao
         FROM DGV.DGV_DIVISAO ddv
        WHERE ddv.cod_divisao = o_cod_divisao;

         EXCEPTION
         WHEN NO_DATA_FOUND
         THEN  o_cod_divisao := NULL;

   END sp_obtem_cod_divisao_td;

--

   /**
   * obtencao do cod_divisao de acordo com o numero do talao pac.
   */
   PROCEDURE sp_obtem_cod_divisao_pac(
      o_cod_divisao  OUT NUMBER,
      i_num_talao_pac IN NUMBER,
      i_dt_movimento  IN DATE,
      o_nm_divisao   OUT VARCHAR2
   )

   IS
   BEGIN

--      SELECT distinct CCDD.ID_DGV_DIVISAO INTO o_cod_divisao
--        FROM CARACTERISTICA_DGV_DIVISAO ccdd
--       WHERE CCDD.DESCRITIVO_PAC = i_num_talao_pac;

      SELECT DECODE(cdd.id_dgv_divisao, NULL,NULL, cdd.id_dgv_divisao, cdd.id_dgv_divisao) into o_cod_divisao
        FROM CARACTERISTICA_DGV_DIVISAO cdd,      --TODO: alterar tabela para caraterisctica_dgv_divisao
             PARAM_GERAL_TEMPORAL pgt,    --TODO: alterar tabela para param_geral_temporal
             VALOR_PARAM_GERAL vpg        --TODO: alterar tabela para valor_param_geral
       WHERE cdd.descritivo_pac = i_num_talao_pac
         AND cdd.id_valor_param_geral = pgt.id_valor_param_geral
         AND i_dt_movimento <= DECODE(pgt.data_fim, NULL, SYSDATE, pgt.data_fim, pgt.data_fim)
         AND i_dt_movimento >= pgt.data_inicio
         and VPG.ID_VALOR_PARAM_GERAL = pgt.ID_VALOR_PARAM_GERAL
         and vpg.activo = 1;

      SELECT distinct ddv.nm_divisao into o_nm_divisao
        FROM DGV.DGV_DIVISAO ddv
       WHERE ddv.cod_divisao = o_cod_divisao;

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN  o_cod_divisao := NULL;

   END sp_obtem_cod_divisao_pac;




--

   /**
    *Este procedure tenta associar as taxas de devolucao de cheques aos movimentos de cheques irregulares.
    *Recebe como argumento um numero de conta.
    *Este procedimento deve ser executado, para cada numero de conta.
    */
   PROCEDURE SP_TRATA_TX_DEVOLUCAO_CI(
      i_num_conta    IN    NUMBER,
      I_ID_UTILIZADOR IN NUMBER
   )
   IS

      v_id_mov_tx          conc_movimento_extracto.id_mov_banco%TYPE;
      v_tipo_registo       CONC_MOVIMENTO_EXTRACTO.TIPO_REGISTO%TYPE;
      v_num_cheque         CONC_MOVIMENTO_EXTRACTO.NUM_CHEQUE%TYPE;
      V_AGRUPADOR          NUMBER;
      V_NM_UTILIZADOR      DGV.DGV_USER.NM_USER%TYPE;

   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      FOR cursor1 IN (SELECT id_mov_banco
                      FROM conc_movimento_extracto cme
                       WHERE CME.NUM_CONTA = i_num_conta
                         AND CME.tipo_registo = 5
                         AND num_cheque IS NULL
                         AND cme.agrupador IS NULL
                       ORDER BY cme.id_mov_banco)
      LOOP

         --obter o movimento anterior. Foi-nos dito que as taxas dos cheques irregulares
         -- aparecem sempre a seguir ao registo do cheque (sequencialmente, ou seja: cheque,taxa | cheque,taxa ...)
         SELECT cme.tipo_registo, num_cheque INTO v_tipo_registo, v_num_cheque
           FROM CONC_MOVIMENTO_EXTRACTO cme
          WHERE cme.id_mov_banco = cursor1.id_mov_banco - 1;

          SELECT sq_id_movimento_associado.nextval
           INTO v_agrupador
           FROM dual;

         IF (v_tipo_registo = 5 AND v_num_cheque IS NOT NULL) THEN

            UPDATE CONC_MOVIMENTO_EXTRACTO
               SET NUM_CHEQUE_TX = V_NUM_CHEQUE
                  ,DH_UPDT = CURRENT_TIMESTAMP
                  ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
               WHERE id_mov_banco = cursor1.id_mov_banco;

            UPDATE CONC_MOVIMENTO_EXTRACTO cme
               SET cme.agrupador = v_agrupador--cursor1.id_movimento - 1
                  ,DH_UPDT = CURRENT_TIMESTAMP
                  ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE id_mov_banco = cursor1.id_mov_banco;

            UPDATE CONC_MOVIMENTO_EXTRACTO cme
               SET cme.agrupador = v_agrupador--cursor1.id_movimento
                  ,DH_UPDT = CURRENT_TIMESTAMP
                  ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE id_mov_banco = cursor1.id_mov_banco -1;

         END IF;

      END LOOP;

      sp_trata_ci_dados_grupo(I_ID_UTILIZADOR);

   END sp_trata_tx_devolucao_ci;


--
   /**
   *calculo dos valores para as colunas de grupo
   */
   PROCEDURE sp_trata_ci_dados_grupo(I_ID_UTILIZADOR IN NUMBER)

   IS
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      FOR c_regs IN ( SELECT descricao_movimento,
                             agrupador,
                             dt_movimento,
							 dt_extracto,
                             tipo_operacao,
                             tipo_registo,
                             num_conta
                        FROM conc_movimento_extracto
                       WHERE num_cheque_tx IS NULL
                         AND agrupador IS NOT NULL
                         AND descricao IS NULL
                         and tipo_registo = 5)
      LOOP
          UPDATE conc_movimento_extracto
             SET descricao_grupo = c_regs.descricao_movimento,
                 data_grupo = c_regs.dt_movimento,
				 DATA_EXTRACTO_GRUPO = c_regs.dt_extracto,
                 tp_mov_grupo = c_regs.tipo_operacao,
                 id_tipo_reg_grupo = c_regs.tipo_registo,
                 tipo_reg_grupo = (SELECT valor
                                     FROM conc_tipo_registo
                                    WHERE id_tipo_registo = c_regs.tipo_registo),
                 num_conta_grupo = c_regs.num_conta
                 ,DH_UPDT = CURRENT_TIMESTAMP
                 ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
           WHERE agrupador = c_regs.agrupador;

      END LOOP;



      --calcular num_movimentos por agrupador
      FOR cursor1 IN (SELECT count(agrupador) qtd, agrupador
                        FROM conc_movimento_extracto
                       WHERE tipo_registo = 5
                         AND agrupador is not null
                    GROUP BY agrupador)
       LOOP

          UPDATE conc_movimento_extracto
             SET num_movimentos = cursor1.qtd
                 ,DH_UPDT = CURRENT_TIMESTAMP
                 ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
           WHERE agrupador = cursor1.agrupador;

       END LOOP;



       --calcular valor do agrupador
       FOR cursor1 IN (SELECT sum(montante) total, agrupador
                         FROM conc_movimento_extracto
                        WHERE tipo_registo = 5
                        group by agrupador )

       LOOP

         UPDATE conc_movimento_extracto
            SET valor_grupo = cursor1.total
                ,DH_UPDT = CURRENT_TIMESTAMP
                ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE agrupador = cursor1.agrupador;

       END LOOP;




       ----------tratar registos cujo agrupador n?o foi preenchido


       UPDATE conc_movimento_extracto
         SET AGRUPADOR = SQ_ID_MOVIMENTO_ASSOCIADO.NEXTVAL
             ,DH_UPDT = CURRENT_TIMESTAMP
             ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
       WHERE agrupador IS NULL
         AND tipo_registo = 5
         and id_estado = 2;


   END sp_trata_ci_dados_grupo;

--
	/**
	 * Procedure auxiliar para actualizar um movimento de tpa detalhe com a associacao com um movimento de extracto - APENAS UM MOVIMENTO DE EXTRACTO
	 */
	PROCEDURE sp_actualiza_tpa_assoc(I_ID_MOV_TPA NUMBER, 
		I_ID_MOV_BANCO NUMBER, I_AGRUPADOR_BANCO NUMBER, 
		I_NUM_MOVIMENTOS_EXTRACTO NUMBER,
		I_NUM_CONTA_EXTRACTO NUMBER,
		I_NM_UTILIZADOR VARCHAR,
		IO_NOVO_AGRUPADOR IN OUT NUMBER)

	IS
	BEGIN
		IF (I_NUM_MOVIMENTOS_EXTRACTO = 1) THEN
			--se num_movimentos do agrupador = 1 o agrupador do banco esta de acordo com a nova associacao, so tem um movimento
		    UPDATE CONC_MOVIMENTO_TPA_DETALHE cmtd
			SET CMTD.ID_MOV_BANCO = I_ID_MOV_BANCO,
				CMTD.AGRUPADOR_MOV_BANCO = I_AGRUPADOR_BANCO,
				CMTD.ID_ESTADO = (CASE CMTD.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMTD.ID_ESTADO END),	
				cmtd.NM_UTILIZADOR_ASSOC = I_NM_UTILIZADOR, 
				cmtd.DATA_ASSOCIACAO = CURRENT_TIMESTAMP,
				cmtd.NUM_CONTA_GRUPO = I_NUM_CONTA_EXTRACTO
				,DH_UPDT = CURRENT_TIMESTAMP
				,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			WHERE CMTD.ID_MOV_TPA = I_ID_MOV_TPA;
				
		ELSIF (I_NUM_MOVIMENTOS_EXTRACTO > 1) THEN
			
			--se num_movimentos do agrupador > 1 o agrupador do banco NAO esta de acordo com a nova associacao, tem que ser criado um novo agrupador
			-- obter novo agrupador para o grupo do extracto - deve ser criado um novo grupo de extracto que simboliza esta associacao
			IF (IO_NOVO_AGRUPADOR IS NULL) THEN
				select sq_id_movimento_associado.NEXTVAL INTO IO_NOVO_AGRUPADOR FROM DUAL;
			END IF;
							
			--actualiza os dados na tabela TPA_DETALHE com o novo agrupador
			UPDATE CONC_MOVIMENTO_TPA_DETALHE cmtd
			SET CMTD.ID_MOV_BANCO = I_ID_MOV_BANCO,
					CMTD.AGRUPADOR_MOV_BANCO = IO_NOVO_AGRUPADOR,
					CMTD.ID_ESTADO = (CASE CMTD.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMTD.ID_ESTADO END),
					cmtd.NM_UTILIZADOR_ASSOC = I_NM_UTILIZADOR, 
					cmtd.DATA_ASSOCIACAO = CURRENT_TIMESTAMP,
					cmtd.NUM_CONTA_GRUPO = I_NUM_CONTA_EXTRACTO
					,DH_UPDT = CURRENT_TIMESTAMP
					,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			WHERE CMTD.ID_MOV_TPA = I_ID_MOV_TPA;
			
		END IF;

		--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
		--se ja estava conciliado parcialmente agora ficou completamente conciliado
		UPDATE 
			CONC_MOVIMENTO_CONCILIADO CMC
		SET
			CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
			CMC.DH_UPDT = CURRENT_TIMESTAMP,
		  	CMC.dsc_util_updt = I_NM_UTILIZADOR
		WHERE
			CMC.ID_MOV_TPA = I_ID_MOV_TPA;

	END sp_actualiza_tpa_assoc;

--
	/**
	 * Procedure auxiliar para actualizar um movimento de extracto com a associacao de um movimento de detalhe tpa
	 */
	PROCEDURE sp_actualiza_ext_tpa_assoc(
		I_ID_MOV_BANCO NUMBER, 
		I_NUM_MOVIMENTOS_EXTRACTO NUMBER, 
		I_NM_UTILIZADOR VARCHAR,
		I_NOVO_AGRUPADOR IN NUMBER, IO_AGRUPADORES_ACTUALIZAR IN OUT TP_SYNC_TAB_UPDT_GROUP)

	IS

		V_COUNT_MOV_POR_CONCILIAR 	NUMBER;
		V_COUNT_MOV_CONCILIADO 		NUMBER;
	BEGIN

		IF (I_NUM_MOVIMENTOS_EXTRACTO = 1) THEN

			--verifica se todos os movimentos TPA deste grupo ja estao conciliados com SCCT
			SELECT COUNT(1) INTO V_COUNT_MOV_POR_CONCILIAR FROM CONC_MOVIMENTO_TPA_DETALHE WHERE ID_MOV_BANCO = I_ID_MOV_BANCO
						AND ID_MOV_TPA NOT IN (SELECT CMC.ID_MOV_TPA FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_TPA = ID_MOV_TPA);

			--verifica se algum dos movimentos ja esta conciliado
			SELECT COUNT(1) INTO V_COUNT_MOV_CONCILIADO FROM CONC_MOVIMENTO_TPA_DETALHE WHERE ID_MOV_BANCO = I_ID_MOV_BANCO
						AND ID_MOV_TPA IN (SELECT CMC.ID_MOV_TPA FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_TPA = ID_MOV_TPA);

			--update do extracto - passa a ter detalhe associado -> FL_COM_DETALHE
		    UPDATE CONC_MOVIMENTO_EXTRACTO MOV
		    SET
		    	MOV.ID_ESTADO = CASE WHEN V_COUNT_MOV_POR_CONCILIAR > 0 THEN (CASE WHEN V_COUNT_MOV_CONCILIADO > 0 THEN 6 ELSE MOV.ID_ESTADO END) ELSE 4 END,
		    	MOV.FL_COM_DETALHE = 1,
		        MOV.DSC_UTIL_UPDT = I_NM_UTILIZADOR,
		        MOV.DH_UPDT = CURRENT_TIMESTAMP
		    WHERE MOV.id_mov_banco = I_ID_MOV_BANCO;
		    
		ELSIF (I_NUM_MOVIMENTOS_EXTRACTO > 1) THEN

			--verifica se todos os movimentos TPA deste grupo ja estao conciliados com SCCT
			SELECT COUNT(1) INTO V_COUNT_MOV_POR_CONCILIAR FROM CONC_MOVIMENTO_TPA_DETALHE WHERE AGRUPADOR_MOV_BANCO = I_NOVO_AGRUPADOR
						AND ID_MOV_TPA NOT IN (SELECT CMC.ID_MOV_TPA FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_TPA = ID_MOV_TPA);

			--verifica se algum dos movimentos ja esta conciliado
			SELECT COUNT(1) INTO V_COUNT_MOV_CONCILIADO FROM CONC_MOVIMENTO_TPA_DETALHE WHERE AGRUPADOR_MOV_BANCO = I_NOVO_AGRUPADOR
						AND ID_MOV_TPA IN (SELECT CMC.ID_MOV_TPA FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_TPA = ID_MOV_TPA);
			
			--update do extracto - passa a ter detalhe associado -> FL_COM_DETALHE, num novo agrupador e a revisao dos dados do grupo
		    UPDATE CONC_MOVIMENTO_EXTRACTO MOV
		    SET
				MOV.ID_ESTADO = CASE WHEN V_COUNT_MOV_POR_CONCILIAR > 0 THEN (CASE WHEN V_COUNT_MOV_CONCILIADO > 0 THEN 6 ELSE MOV.ID_ESTADO END) ELSE 4 END,
		    	MOV.AGRUPADOR = I_NOVO_AGRUPADOR,
		        MOV.NUM_MOVIMENTOS = 1,
		        MOV.VALOR_GRUPO = MOV.MONTANTE,
		        MOV.TP_MOV_GRUPO = MOV.TIPO_OPERACAO,
		        MOV.DESCRICAO_GRUPO = MOV.DESCRICAO_MOVIMENTO,
		        MOV.DATA_GRUPO = MOV.DT_MOVIMENTO,
				MOV.DATA_EXTRACTO_GRUPO = MOV.DT_EXTRACTO,
		        MOV.COD_DIVISAO_GRUPO = MOV.COD_DIVISAO,
		        MOV.NM_DIVISAO_GRUPO = NULL,
		        MOV.ID_TIPO_REG_GRUPO = 3,
		        MOV.TIPO_REG_GRUPO = 'TPA',
		        MOV.NUM_CONTA_GRUPO = MOV.NUM_CONTA,
		        MOV.FL_COM_DETALHE = 1,
		        MOV.DSC_UTIL_UPDT = I_NM_UTILIZADOR,
		        MOV.DH_UPDT = CURRENT_TIMESTAMP
		     WHERE MOV.id_mov_banco = I_ID_MOV_BANCO;
		    
		     --guarda o agrupador antigo para actualizar os valores do grupo
		     SELECT (IO_AGRUPADORES_ACTUALIZAR MULTISET UNION ALL (CAST(MULTISET(SELECT TP_SYNC_UPDT_GROUP(I_NOVO_AGRUPADOR, null) FROM DUAL) AS TP_SYNC_TAB_UPDT_GROUP))) INTO IO_AGRUPADORES_ACTUALIZAR  FROM DUAL;
		END IF;


	END sp_actualiza_ext_tpa_assoc;
--

--
	/**
	 * Procedure auxiliar para actualizar um movimento de extracto com a associacao de um movimento de detalhe tpa
	 */
	PROCEDURE sp_actualiza_agrup_extracto(
		I_NM_UTILIZADOR VARCHAR,I_AGRUPADORES_ACTUALIZAR IN TP_SYNC_TAB_UPDT_GROUP)

	IS
	BEGIN

		--actualiza agrupadores alterados
   		FOR GRUPO IN (SELECT DISTINCT AGRUPADOR FROM TABLE(I_AGRUPADORES_ACTUALIZAR))

        LOOP
  
	        FOR c_banco IN (SELECT
	                                  SUM(
	                                     CASE WHEN ID_ESTADO = 2 THEN
	                                        CASE WHEN TIPO_OPERACAO = 'D' THEN
	                                            MONTANTE * -1
	                                          ELSE MONTANTE END
	                                     ELSE 0 END
	                                  ) soma,
	                                  agrupador, 
	                  				  count(1) qtd,
	                                  max(descricao_movimento) descricao_movimento,
	                                  min(dt_movimento) dt_movimento,
	                                  min(dt_extracto) dt_extracto,
	                                  CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
	                                    NULL
	                                  ELSE MIN(COD_DIVISAO) END COD_DIVISAO,
	                                  CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
	                                      'Diversas'
	                                  ELSE MAX(nm_divisao_grupo) END nm_divisao_grupo,
	                                  MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
	                                  max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
	                                  max(num_conta)num_conta
	                               FROM CONC_MOVIMENTO_EXTRACTO
	                               WHERE AGRUPADOR = GRUPO.AGRUPADOR
	                               GROUP BY agrupador)
	  
	                LOOP
	                   UPDATE conc_movimento_extracto cme
	                      SET cme.valor_grupo = abs(c_banco.soma),
	                          cme.num_movimentos = c_banco.qtd,
	                          CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
	                          CME.DATA_GRUPO = c_banco.dt_movimento,
							  CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
	                          CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
	                          CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
	                          CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
	                          CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
	                          CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
	                          CME.NUM_CONTA_GRUPO = c_banco.num_conta
	                          ,DH_UPDT = CURRENT_TIMESTAMP
	                          ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
	                    WHERE cme.agrupador = c_banco.agrupador;
	                END LOOP;
              
    	END LOOP;
	END sp_actualiza_agrup_extracto;


   --procedure que associa uma linha do extracto aos varios movimentos de tpa correspondentes
   PROCEDURE SP_TRATA_TPA_DETALHE(I_ID_UTILIZADOR IN NUMBER)

   IS

      V_COD_DIVISAO 				NUMBER;
      V_NM_UTILIZADOR           	DGV.DGV_USER.NM_USER%TYPE;
	  V_EXT_AGRUPADOR				NUMBER;
	  V_ENCONTRADO_DETALHE			NUMBER(1);
	  agrupadores_actualizar		TP_SYNC_TAB_UPDT_GROUP := TP_SYNC_TAB_UPDT_GROUP();
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

	FOR c_tpas IN (SELECT num_tpa, dt_valor
                       FROM conc_movimento_tpa_detalhe
                      WHERE cod_divisao IS NULL)
      LOOP

         --preencher os cod_divisao de acordo com o numero de tpa
         UPDATE CONC_MOVIMENTO_TPA_DETALHE DETALHE
            SET detalhe.cod_divisao =
                     (SELECT MAX(DECODE(cdd.id_dgv_divisao, NULL, NULL, cdd.id_dgv_divisao, cdd.id_dgv_divisao))
                        FROM CARACTERISTICA_DGV_DIVISAO cdd,--TODO: alterar tabela para caraterisctica_dgv_divisao
                             PARAM_GERAL_TEMPORAL pgt,--TODO: alterar tabela para para_geral_temporal
                             VALOR_PARAM_GERAL vpg
                       WHERE cdd.lista_tpa LIKE '%' || c_tpas.num_tpa || '%'
                         AND cdd.id_valor_param_geral = pgt.id_valor_param_geral
                         AND c_tpas.dt_valor <= DECODE(pgt.data_fim, NULL, SYSDATE, pgt.data_fim, pgt.data_fim)
                         AND c_tpas.dt_valor >= pgt.data_inicio
                         AND vpg.id_valor_param_geral = pgt.id_valor_param_geral
                         AND vpg.activo = 1
                    GROUP BY CDD.ID_DGV_DIVISAO)
                ,DETALHE.DH_UPDT = CURRENT_TIMESTAMP
                ,DETALHE.DSC_UTIL_UPDT = V_NM_UTILIZADOR
            WHERE num_tpa = c_tpas.num_tpa and detalhe.cod_divisao IS NULL;

      END LOOP;


      -- gerar agrupadores e guardar na tabela temporaria.
       -- NOVA VERSÃO COM MELHORAMENTOS DE DESEMPENHO - gerar agrupadores e guardar na tabela temporaria.
      FOR GRUPOS IN (
        SELECT
           SUM(
            CASE
              WHEN D.TIPO_OPERACAO = 'D' THEN
                D.MONTANTE*(-1)
              ELSE D.MONTANTE END) VALOR_GRUPO,
           COUNT(1) num_movimentos,
           d.cod_divisao cod_divisao_grupo,
           div.nm_divisao nm_divisao_grupo,
           D.DT_VALOR DATA_GRUPO,
           MIN(D.DT_MOVIMENTO) DATA_MOV_GRUPO,
           '10' || d.cod_divisao || TO_CHAR(d.dt_valor, 'ddmmyyy') agrupador
        FROM
           CONC_MOVIMENTO_TPA_DETALHE D
           LEFT JOIN
           DGV.DGV_DIVISAO DIV
           ON DIV.COD_DIVISAO = D.COD_DIVISAO
        WHERE
          D.COD_DIVISAO IS NOT NULL
        GROUP BY D.COD_DIVISAO, DIV.NM_DIVISAO, D.DT_VALOR)
        LOOP

          INSERT INTO CONC_PARSE_DETALHE_TPA_AUX
          (ID_MOV, AGRUPADOR, VALOR_GRUPO,
          NUM_MOVIMENTOS, COD_DIVISAO_GRUPO, NM_DIVISAO_GRUPO,
          DATA_GRUPO,DATA_MOV_GRUPO,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT)
          (SELECT
            DET.ID_MOV_TPA,
            GRUPOS.AGRUPADOR,
            GRUPOS.VALOR_GRUPO,
            GRUPOS.NUM_MOVIMENTOS,
            GRUPOS.COD_DIVISAO_GRUPO,
            GRUPOS.NM_DIVISAO_GRUPO,
            GRUPOS.DATA_GRUPO,
			GRUPOS.DATA_MOV_GRUPO,
            CURRENT_TIMESTAMP,
            'SCCTAPP',
            CURRENT_TIMESTAMP,
            'SCCTAPP'
           FROM
            (SELECT ID_MOV_TPA,COD_DIVISAO, DT_VALOR, DATA_MOV_GRUPO  FROM CONC_MOVIMENTO_TPA_DETALHE WHERE COD_DIVISAO = GRUPOS.COD_DIVISAO_GRUPO AND DT_VALOR = GRUPOS.DATA_GRUPO) DET
           WHERE  '10'||DET.COD_DIVISAO||TO_CHAR(DET.DT_VALOR,'ddmmyyy') = GRUPOS.AGRUPADOR
          );

        END LOOP;


      -- preencher colunas de valores agrupados.
      UPDATE conc_movimento_tpa_detalhe det
         SET (DET.AGRUPADOR, DET.VALOR_GRUPO, DET.TP_MOV_GRUPO, DET.NUM_MOVIMENTOS, DET.COD_DIVISAO_GRUPO,
              det.nm_divisao_grupo, det.data_grupo, det.data_mov_grupo,det.dh_updt,det.dsc_util_updt) =
                (SELECT da.agrupador,
                        abs(da.valor_grupo),
						(CASE WHEN da.valor_grupo > 0 THEN 'C' ELSE 'D' END),
                        da.num_movimentos,
                        da.cod_divisao_grupo,
                        DA.NM_DIVISAO_GRUPO,
                        DA.DATA_GRUPO,
						DA.DATA_MOV_GRUPO,
                        CURRENT_TIMESTAMP DH_UPDT,
                        V_NM_UTILIZADOR DSC_UTIL_UPDT
                   FROM CONC_PARSE_DETALHE_TPA_AUX da
                  WHERE da.id_mov = det.id_mov_tpa);

	--percorre todos os movimentos de extracto TPA do IGCP que nao tenham detalhe associado
	--e verifica se, para cada movimento, e encontrado um conjunto de movimentos de detalhe correspondente
	FOR c_reg_banco IN (SELECT id_mov_banco,
								dt_movimento,
								montante,
								agrupador,
								NUM_MOVIMENTOS,
								NUM_CONTA
                            FROM CONC_MOVIMENTO_EXTRACTO cme
                           WHERE tipo_registo=3
                             AND origem_ficheiro='IGCP'
                             AND FL_COM_DETALHE = 0
                           ORDER BY dt_movimento)
    	LOOP

		V_ENCONTRADO_DETALHE := 0;
		V_EXT_AGRUPADOR := NULL;

		--procura todos os grupos de movimentos que estejam dentro da "data do movimento" e tenham o mesmo montante para executar a triangulacao
		FOR c_registos IN (select * from (SELECT dt_movimento,
                                        num_tpa,
                                        id_mov_tpa,
                                        SUM(
                                          CASE
                                            WHEN TIPO_OPERACAO = 'D' THEN
                                              MONTANTE*-1
                                            ELSE MONTANTE END
                                        ) OVER(PARTITION BY dt_movimento) soma_valor
                                   FROM CONC_MOVIMENTO_TPA_DETALHE
                                  WHERE AGRUPADOR_MOV_BANCO IS NULL 
										--AND NUM_TPA IS NOT NULL --considerar todos os movimentos, mesmo os sem TPA, porque serao reflectidos tambem no extracto
										AND c_reg_banco.dt_movimento >= dt_movimento
										AND c_reg_banco.dt_movimento-dt_movimento < 7)
							where soma_valor = c_reg_banco.montante) --maximo de 30 dias de diferenca entre valor dt_movimento do extracto e dt_movimento do detalhe
      		LOOP
				V_ENCONTRADO_DETALHE := 1;
					
				sp_actualiza_tpa_assoc(c_registos.id_mov_tpa, c_reg_banco.id_mov_banco, c_reg_banco.AGRUPADOR, 
						c_reg_banco.NUM_MOVIMENTOS, c_reg_banco.NUM_CONTA, V_NM_UTILIZADOR, V_EXT_AGRUPADOR);

			END LOOP;

			--actualiza o movimento de extracto se este foi associado a algum detalhe
			IF (V_ENCONTRADO_DETALHE = 1) THEN
				sp_actualiza_ext_tpa_assoc(c_reg_banco.id_mov_banco, c_reg_banco.NUM_MOVIMENTOS, V_NM_UTILIZADOR, V_EXT_AGRUPADOR, agrupadores_actualizar);

			END IF;


		END LOOP;

  		sp_actualiza_agrup_extracto(V_NM_UTILIZADOR,agrupadores_actualizar);
     
     	sp_trata_tpa_detalhe_ndias(I_ID_UTILIZADOR);

      	-- Marcar todos os movimentos agora registados como processados.
      	UPDATE CONC_MOVIMENTO_TPA_DETALHE SET ID_ESTADO = 2,DH_UPDT = CURRENT_TIMESTAMP,DSC_UTIL_UPDT = V_NM_UTILIZADOR  WHERE ID_ESTADO = 1;


   END sp_trata_tpa_detalhe;

--


--

   PROCEDURE sp_trata_tpa_detalhe_ndias(I_ID_UTILIZADOR IN NUMBER)

   IS

   BEGIN
      SP_TRATA_TPA_DETALHE_NDIAS_AUX(4,I_ID_UTILIZADOR);
      sp_trata_tpa_detalhe_ndias_aux(6,I_ID_UTILIZADOR);
   END sp_trata_tpa_detalhe_ndias;

--

   --procedure que associa uma linha do extracto aos varios movimentos de tpa correspondentes
   --tendo em conta uma diferenca de datas
   PROCEDURE sp_trata_tpa_detalhe_ndias_aux(
      I_NUM_DIAS IN NUMBER,
      I_ID_UTILIZADOR IN NUMBER
   )
   IS

      v_montante_tpa       			NUMBER(15,2);
      v_montante_tpa_d2    			NUMBER(15,2);
	  V_EXT_AGRUPADOR				NUMBER;
      V_NM_UTILIZADOR           	DGV.DGV_USER.NM_USER%TYPE;
	  V_ENCONTRADO_DETALHE			NUMBER(1);
	  agrupadores_actualizar		TP_SYNC_TAB_UPDT_GROUP := TP_SYNC_TAB_UPDT_GROUP();
   BEGIN

    SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

	--percorre todos os movimentos de extracto TPA do IGCP que nao tenham detalhe associado
	--e verifica se, para cada movimento, e encontrado um conjunto de movimentos de detalhe correspondente
	FOR c_reg_banco IN (SELECT id_mov_banco,dt_movimento,montante,agrupador,
								NUM_MOVIMENTOS, NUM_CONTA
                            FROM CONC_MOVIMENTO_EXTRACTO cme
                           WHERE tipo_registo=3
                             AND origem_ficheiro='IGCP'
                             AND FL_COM_DETALHE = 0
                           ORDER BY 2)
    LOOP

		V_ENCONTRADO_DETALHE := 0;
		V_EXT_AGRUPADOR := NULL;

		--soma TODOS os movimentos TPA ainda nao associados, com data igual ou com diferenca de I_NUM_DIAS (Dias) da data do extracto
		--e agrupa estes movimentos por data
        FOR c_reg_tpa IN (SELECT sum(CASE WHEN TIPO_OPERACAO = 'D' THEN
	                                            MONTANTE * -1
	                                          ELSE MONTANTE END) soma_montante, dt_movimento
        					FROM CONC_MOVIMENTO_TPA_DETALHE
                            WHERE agrupador_mov_banco IS NULL
                              AND c_reg_banco.dt_movimento - dt_movimento = i_num_dias
                           	GROUP BY dt_movimento
                           	ORDER BY 2)
          LOOP

			--verifica a soma total do dia seguinte
            SELECT sum(CASE WHEN TIPO_OPERACAO = 'D' THEN
	                                            MONTANTE * -1
	                                          ELSE MONTANTE END) INTO v_montante_tpa
              FROM conc_movimento_tpa_detalhe
             WHERE agrupador_mov_banco is NULL
               AND dt_movimento = c_reg_tpa.dt_movimento + 1;

			--verifica a soma total do 2º dia seguinte
            SELECT sum(CASE WHEN TIPO_OPERACAO = 'D' THEN
	                                            MONTANTE * -1
	                                          ELSE MONTANTE END) INTO v_montante_tpa_d2
              FROM conc_movimento_tpa_detalhe
             WHERE agrupador_mov_banco is NULL
               AND dt_movimento = c_reg_tpa.dt_movimento + 2;

			--soma o valor do dia seguinte e do 2º dia seguinte
            v_montante_tpa_d2 := v_montante_tpa_d2 + v_montante_tpa;--para casos em que o registo do extracto corresponde a 3 datas de movimentos tpas.

			--verifica se o valor do extracto corresponde a soma total do DETALHE de 2 dias (data do movimento + dia seguinte)
             IF(c_reg_tpa.soma_montante + v_montante_tpa = c_reg_banco.montante) THEN
             
                  V_ENCONTRADO_DETALHE := 1;
				

	              --valida se pode usar o mesmo agrupador do banco -> so pode usa-lo se corresponder a apenas um movimento
	              IF (c_reg_banco.NUM_MOVIMENTOS = 1) THEN
	                       UPDATE conc_movimento_tpa_detalhe
	                          SET id_mov_banco = c_reg_banco.id_mov_banco
	                    		,agrupador_mov_banco = c_reg_banco.agrupador
								,ID_ESTADO = (CASE ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE ID_ESTADO END)
	                    		,NM_UTILIZADOR_ASSOC = V_NM_UTILIZADOR 
	                    		,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
								,num_conta_grupo = c_reg_banco.num_conta
	                            ,DH_UPDT = CURRENT_TIMESTAMP
	                            ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
	                        WHERE dt_movimento = c_reg_tpa.dt_movimento
	                           OR dt_movimento = c_reg_tpa.dt_movimento + 1;
							
							--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
					    	--se ja estava conciliado parcialmente agora ficou completamente conciliado
							UPDATE 
								CONC_MOVIMENTO_CONCILIADO CMC
							SET
								CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
								CMC.DH_UPDT = CURRENT_TIMESTAMP,
							  	CMC.dsc_util_updt = V_NM_UTILIZADOR
							WHERE
								CMC.ID_MOV_TPA in (select id_mov_tpa from conc_movimento_tpa_detalhe where id_mov_banco = c_reg_banco.id_mov_banco);

	              ELSIF (c_reg_banco.NUM_MOVIMENTOS > 1) THEN
	                --se num_movimentos do agrupador > 1 o agrupador do banco NAO esta de acordo com a nova associacao, tem que ser criado um novo agrupador
	                -- obter novo agrupador para o grupo do extracto - deve ser criado um novo grupo de extracto que simboliza esta associacao
	                    IF (V_EXT_AGRUPADOR IS NULL) THEN
	                      select sq_id_movimento_associado.NEXTVAL INTO V_EXT_AGRUPADOR FROM DUAL;
		                END IF;
		    
		                 UPDATE conc_movimento_tpa_detalhe
		                          SET id_mov_banco = c_reg_banco.id_mov_banco
		                    		,agrupador_mov_banco = V_EXT_AGRUPADOR
									,ID_ESTADO = (CASE ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE ID_ESTADO END)
		                    		,NM_UTILIZADOR_ASSOC = V_NM_UTILIZADOR
		                    		,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
									,num_conta_grupo = c_reg_banco.num_conta
		                            ,DH_UPDT = CURRENT_TIMESTAMP
		                            ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
		                        WHERE dt_movimento = c_reg_tpa.dt_movimento
		                           OR dt_movimento = c_reg_tpa.dt_movimento + 1;
		    
						--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
					    --se ja estava conciliado parcialmente agora ficou completamente conciliado
						UPDATE 
								CONC_MOVIMENTO_CONCILIADO CMC
						SET
								CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
								CMC.DH_UPDT = CURRENT_TIMESTAMP,
							  	CMC.dsc_util_updt = V_NM_UTILIZADOR
						WHERE
								CMC.ID_MOV_TPA in (select id_mov_tpa from conc_movimento_tpa_detalhe where agrupador_mov_banco = V_EXT_AGRUPADOR);
	              END IF;

             ELSIF(c_reg_tpa.soma_montante + v_montante_tpa_d2 = c_reg_banco.montante) THEN
				
				--se o valor do extracto corresponde a soma total do DETALHE de 2 dias (data do movimento + os 2 dias seguinte)
				V_ENCONTRADO_DETALHE := 1;
        
				--valida se pode usar o mesmo agrupador do banco -> so pode usa-lo se corresponder a apenas um movimento
				IF (c_reg_banco.NUM_MOVIMENTOS = 1) THEN
	               UPDATE conc_movimento_tpa_detalhe
	                  SET id_mov_banco = c_reg_banco.id_mov_banco
						  ,agrupador_mov_banco = c_reg_banco.agrupador
						  ,ID_ESTADO = (CASE ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE ID_ESTADO END)
						  ,NM_UTILIZADOR_ASSOC = V_NM_UTILIZADOR
						  ,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
						  ,num_conta_grupo = c_reg_banco.num_conta
	                      ,DH_UPDT = CURRENT_TIMESTAMP
	                      ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
	                WHERE dt_movimento = c_reg_tpa.dt_movimento
	                   OR dt_movimento = c_reg_tpa.dt_movimento + 1
	                   OR dt_movimento = c_reg_tpa.dt_movimento + 2;

					--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
					--se ja estava conciliado parcialmente agora ficou completamente conciliado
					UPDATE 
						CONC_MOVIMENTO_CONCILIADO CMC
					SET
						CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
						CMC.DH_UPDT = CURRENT_TIMESTAMP,
						CMC.dsc_util_updt = V_NM_UTILIZADOR
					WHERE
						CMC.ID_MOV_TPA in (select id_mov_tpa from conc_movimento_tpa_detalhe where id_mov_banco = c_reg_banco.id_mov_banco);		
					
				ELSIF (c_reg_banco.NUM_MOVIMENTOS > 1) THEN
						--se num_movimentos do agrupador > 1 o agrupador do banco NAO esta de acordo com a nova associacao, tem que ser criado um novo agrupador
						-- obter novo agrupador para o grupo do extracto - deve ser criado um novo grupo de extracto que simboliza esta associacao
						IF (V_EXT_AGRUPADOR IS NULL) THEN
				        	select sq_id_movimento_associado.NEXTVAL INTO V_EXT_AGRUPADOR FROM DUAL;
						END IF;

						UPDATE conc_movimento_tpa_detalhe
		                SET id_mov_banco = c_reg_banco.id_mov_banco
							  ,agrupador_mov_banco = V_EXT_AGRUPADOR
							  ,ID_ESTADO = (CASE ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE ID_ESTADO END)
							  ,NM_UTILIZADOR_ASSOC = V_NM_UTILIZADOR
						  	  ,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
							  ,num_conta_grupo = c_reg_banco.num_conta
		                      ,DH_UPDT = CURRENT_TIMESTAMP
		                      ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
		                WHERE dt_movimento = c_reg_tpa.dt_movimento
		                   OR dt_movimento = c_reg_tpa.dt_movimento + 1
		                   OR dt_movimento = c_reg_tpa.dt_movimento + 2;

						--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
					    --se ja estava conciliado parcialmente agora ficou completamente conciliado
						UPDATE 
							CONC_MOVIMENTO_CONCILIADO CMC
						SET
							CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
							CMC.DH_UPDT = CURRENT_TIMESTAMP,
						  	CMC.dsc_util_updt = V_NM_UTILIZADOR
						WHERE
							CMC.ID_MOV_TPA in (select id_mov_tpa from conc_movimento_tpa_detalhe where agrupador_mov_banco = V_EXT_AGRUPADOR);
					END IF;
             END IF;

          END LOOP;

		--actualiza o movimento de extracto se este foi associado a algum detalhe
		IF (V_ENCONTRADO_DETALHE = 1) THEN
			sp_actualiza_ext_tpa_assoc(c_reg_banco.id_mov_banco, c_reg_banco.NUM_MOVIMENTOS, V_NM_UTILIZADOR, V_EXT_AGRUPADOR, agrupadores_actualizar);

		END IF;
            
     END LOOP;

	 --actualiza agrupadores alterados
	 sp_actualiza_agrup_extracto(V_NM_UTILIZADOR,agrupadores_actualizar);


   END sp_trata_tpa_detalhe_ndias_aux;

--


/**
 *Procedure responsavel por invocar cada procedure de conciliacao
 */

   PROCEDURE sp_executa_job (o_cod_erro   OUT   NUMBER)
   IS
      v_id_utilizador    NUMBER;

   BEGIN

    SELECT id_user INTO v_id_utilizador
    FROM DGV.DGV_USER du
    WHERE du.nm_user = 'SCCTAPP';

    --apagar os registos preconciliados do utilizador
    DELETE FROM conc_mov_preconciliado cmp
    WHERE  cmp.id_utilizador = v_id_utilizador;


    DELETE FROM CONC_MOV_TPA_PRECONCILIADO cmp
    WHERE  cmp.id_utilizador = v_id_utilizador;

    DELETE FROM CONC_MOV_MPSIBS_PRECONCILIADO CMP
    WHERE  cmp.id_utilizador = v_id_utilizador;

    FOR C_NUM_CONTA IN (SELECT DISTINCT NUM_CONTA
                          FROM CONTA_BANCARIA)

     LOOP


        sp_pre_concilia(v_id_utilizador,
                        c_num_conta.num_conta,
                        1,
                        1,
                        TO_DATE('2010-01-01','YYYY-MM-DD'),
                        CURRENT_DATE,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        o_cod_erro,
                        1);

     END LOOP; --c_num_conta

   END sp_executa_job;

---

	PROCEDURE sp_pre_concilia_auto(
      i_id_utilizador                  IN       NUMBER,
      i_num_conta                      IN       VARCHAR2,
      i_tp_conciliacao                 IN       NUMBER,--debito ou credito
      i_tipo_registo                   IN       NUMBER, --para saber tipo
      i_dt_inicio                      IN       DATE,
      i_dt_fim                         IN       DATE,
      i_desc_intervalo                 IN       NUMBER,--i_desc_intervalo
      i_val_intervalo                  IN       NUMBER,
      i_data_intervalo                 IN       NUMBER,
      i_cod_divisao                    IN       NUMBER,
      o_cod_erro                      OUT       NUMBER,
      i_batch_flag                     IN       NUMBER
   )
   AS
    PRAGMA AUTONOMOUS_TRANSACTION;

   BEGIN

		sp_pre_concilia(
	      i_id_utilizador,
	      i_num_conta,
	      i_tp_conciliacao,--debito ou credito
	      i_tipo_registo , --para saber tipo
	      i_dt_inicio,
	      i_dt_fim,
	      i_desc_intervalo,--i_desc_intervalo
	      i_val_intervalo,
	      i_data_intervalo,
	      i_cod_divisao,
	      o_cod_erro,
	      i_batch_flag);

	
		IF (O_COD_ERRO <> 0) THEN 
			ROLLBACK;		
		ELSE
			COMMIT;
		END IF;
	
	EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;

		  o_cod_erro := -10;

		
   END sp_pre_concilia_auto;

---

   PROCEDURE sp_pre_concilia(
      i_id_utilizador                  IN       NUMBER,
      i_num_conta                      IN       VARCHAR2,
      i_tp_conciliacao                 IN       NUMBER,--debito ou credito
      i_tipo_registo                   IN       NUMBER, --para saber tipo
      i_dt_inicio                      IN       DATE,
      i_dt_fim                         IN       DATE,
      i_desc_intervalo                 IN       NUMBER,--i_desc_intervalo
      i_val_intervalo                  IN       NUMBER,
      i_data_intervalo                 IN       NUMBER,
      i_cod_divisao                    IN       NUMBER,
      o_cod_erro                      OUT       NUMBER,
      i_batch_flag                     IN       NUMBER
   )
   IS

   BEGIN

     IF I_BATCH_FLAG = 0 THEN

      --apagar os registos preconciliados do utilizador
      DELETE FROM conc_mov_preconciliado cmp
      WHERE  cmp.id_utilizador = i_id_utilizador;


      DELETE FROM CONC_MOV_TPA_PRECONCILIADO cmp
      WHERE  cmp.id_utilizador = i_id_utilizador;

      DELETE FROM CONC_MOV_MPSIBS_PRECONCILIADO cmp
      WHERE  CMP.ID_UTILIZADOR = I_ID_UTILIZADOR;

    END IF;


      IF(i_tipo_registo IS NULL)THEN --reconciliar todos

         FOR i IN (SELECT id_tipo_registo
                     FROM conc_tipo_registo)
         LOOP
            PC_CONC.sp_pre_concilia_aux(i_id_utilizador,
                                        i_num_conta,
                                        i_tp_conciliacao,
                                        i.id_tipo_registo,
                                        i_dt_inicio,
                                        i_dt_fim,
                                        i_desc_intervalo,
                                        i_val_intervalo,
                                        i_data_intervalo,
                                        i_cod_divisao,
                                        o_cod_erro,
                                        i_batch_flag
                                        );
         END LOOP;

      ELSE
          PC_CONC.sp_pre_concilia_aux(i_id_utilizador,
                                      i_num_conta,
                                      i_tp_conciliacao,
                                      i_tipo_registo,
                                      i_dt_inicio,
                                      i_dt_fim,
                                      i_desc_intervalo,
                                      i_val_intervalo,
                                      i_data_intervalo,
                                      i_cod_divisao,
                                      o_cod_erro,
                                      i_batch_flag
                                      );
      END IF;

   END sp_pre_concilia;

---

PROCEDURE sp_reconcilia_others_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      I_ID_UTILIZADOR         IN NUMBER,
      i_batch_flag            IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      I_DESC_FLAG             IN NUMBER,
      I_VAL_FLAG              IN NUMBER,
      i_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER
    )
    IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;
      v_id_utilizador        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 7;

   BEGIN

      V_ID_UTILIZADOR := I_ID_UTILIZADOR;

      IF (i_batch_flag = 1) THEN

         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 3;

         END IF;


      ELSE --batch=0

         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

      END IF;

      -- VALOR | DESCRICAO | DATA
      IF  (V_VAL_FLAG = 1 AND V_DESC_FLAG = 1 AND V_DATA_FLAG = 1) THEN

         PC_CONC_AUX.SP_CONC_OTHERS_VAL_DT_DESC_AUX(
                          V_DATA_INTERVALO,
                          V_VAL_INTERVALO,
                          V_DESC_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
         );

      -- VALOR | DESCRICAO
      ELSIF (V_VAL_FLAG = 1 AND V_DESC_FLAG = 1 AND V_DATA_FLAG = 0) THEN

        PC_CONC_AUX.SP_CONC_OTHERS_VAL_DESC_AUX(
                          V_VAL_INTERVALO,
                          V_DESC_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
         );

      -- VALOR | DATA
      ELSIF (V_VAL_FLAG = 1 AND V_DESC_FLAG = 0 AND V_DATA_FLAG = 1) THEN

        PC_CONC_AUX.SP_CONC_OTHERS_VAL_DT_AUX(
                          V_DATA_INTERVALO,
                          V_VAL_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
        );

      -- VALOR
      ELSIF (V_VAL_FLAG = 1 AND V_DESC_FLAG = 0 AND V_DATA_FLAG = 0) THEN

         PC_CONC_AUX.SP_CONC_OTHERS_VAL_AUX(
                          V_VAL_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
        );

      END IF;

END sp_reconcilia_others_receita;

---

PROCEDURE sp_reconcilia_trf_banc_receita
(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      I_ID_UTILIZADOR         IN NUMBER,
      i_batch_flag            IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      I_DESC_FLAG             IN NUMBER,
      I_VAL_FLAG              IN NUMBER,
      i_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER
    )
    IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;
      v_id_utilizador        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 8;

   BEGIN

      V_ID_UTILIZADOR := I_ID_UTILIZADOR;

      IF (i_batch_flag = 1) THEN

         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 8 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 8 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 8 AND id_dimensao = 3;

         END IF;


      ELSE --batch=0

         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

      END IF;

      -- VALOR | DATA
      IF (V_VAL_FLAG = 1 AND V_DESC_FLAG = 0 AND V_DATA_FLAG = 1) THEN

        PC_CONC_AUX.SP_CONC_TRF_BANC_VAL_DT_AUX(
                          V_DATA_INTERVALO,
                          V_VAL_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
        );

      -- VALOR
      ELSIF (V_VAL_FLAG = 1 AND V_DESC_FLAG = 0 AND V_DATA_FLAG = 0) THEN

         PC_CONC_AUX.SP_CONC_TRF_BANC_VAL_AUX(
                          V_VAL_INTERVALO,
                          I_DT_INICIO,
                          I_DT_FIM,
                          V_ID_UTILIZADOR,
                          I_NUM_CONTA
        );

      END IF;

END sp_reconcilia_trf_banc_receita;


---

   PROCEDURE sp_pre_concilia_aux(
      i_id_utilizador                  IN       NUMBER,
      i_num_conta                      IN       VARCHAR2,
      i_tp_conciliacao                 IN       NUMBER,--debito ou credito
      i_tipo_registo                   IN       NUMBER, --para saber tipo
      i_dt_inicio                      IN       DATE,
      i_dt_fim                         IN       DATE,
      i_desc_intervalo                 IN       NUMBER,--i_desc_intervalo
      i_val_intervalo                  IN       NUMBER,
      i_data_intervalo                 IN       NUMBER,
      i_cod_divisao                    IN       NUMBER,
      o_cod_erro                      OUT       NUMBER,
      i_batch_flag                     IN       NUMBER
   )

   IS
      v_dt_inicio          DATE;
      v_dt_fim             DATE;
      v_desc_flag          NUMBER;
      v_val_flag           NUMBER;
      v_data_flag          NUMBER;
      v_tipo_registo       NUMBER;

   BEGIN
      o_cod_erro := 1;

      V_DT_INICIO := I_DT_INICIO;
      v_dt_fim := i_dt_fim;

      --tratamento das datas
       IF(v_dt_inicio IS NULL)THEN
            v_dt_inicio := to_date('01-01-2000','DD-MM-RRRR');
         END IF;

       IF(v_dt_fim IS NULL)THEN
          V_DT_FIM := SYSDATE;
       END IF;

      IF(i_batch_flag = 0) THEN

         --v_batch := 0;

         --obtencao dos valores das flags
         IF(i_desc_intervalo IS NULL)THEN
            v_desc_flag := 0;
         ELSE
            v_desc_flag := 1;
         END IF;

         IF(i_data_intervalo IS NULL)THEN
            v_data_flag := 0;
         ELSE
            v_data_flag := 1;
         END IF;

         IF(i_val_intervalo IS NULL)THEN
            v_val_flag := 0;
         ELSE
            v_val_flag := 1;
         END IF;

      END IF;

      IF(i_tipo_registo = 1)THEN

         --DBMS_OUTPUT.put_line('sp_reconcilia_td_receita');

            pc_conc.sp_reconcilia_td_receita(v_dt_inicio,
                                             v_dt_fim,
                                             i_id_utilizador,
                                             i_batch_flag,
                                             i_desc_intervalo,
                                             i_data_intervalo,
                                             i_val_intervalo,
                                             v_desc_flag,
                                             v_val_flag,
                                             v_data_flag,
                                             to_number(i_num_conta),
                                             i_cod_divisao);
          o_cod_erro:=0;

      ELSIF(i_tipo_registo = 2)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_pac_receita');

         pc_conc.sp_reconcilia_pac_receita(v_dt_inicio,
                                           v_dt_fim,
                                           i_id_utilizador,
                                           i_batch_flag,
                                           i_desc_intervalo,
                                           i_data_intervalo,
                                           i_val_intervalo,
                                           v_desc_flag,
                                           v_val_flag,
                                           v_data_flag,
                                           to_number(i_num_conta),
                                           i_cod_divisao);


         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 3)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_tpa_receita');

         pc_conc.sp_reconcilia_tpa_receita(v_dt_inicio,
                                           v_dt_fim,
                                           i_id_utilizador,
                                           i_batch_flag,
                                           i_desc_intervalo,
                                           i_data_intervalo,
                                           i_val_intervalo,
                                           v_desc_flag,
                                           v_val_flag,
                                           v_data_flag,
                                           to_number(i_num_conta),
                                           i_cod_divisao);

         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 4)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_MB_receita');

         pc_conc.sp_reconcilia_mb_receita(v_dt_inicio,
                                           v_dt_fim,
                                           i_id_utilizador,
                                           i_batch_flag,
                                           i_desc_intervalo,
                                           i_data_intervalo,
                                           i_val_intervalo,
                                           v_desc_flag,
                                           v_val_flag,
                                           v_data_flag,
                                           to_number(i_num_conta),
										   i_cod_divisao);

         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 5)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_cheq_irr_receita');

         PC_CONC.SP_RECONCILIA_CI_RECEITA(v_dt_inicio,
                                          v_dt_fim,
                                          i_id_utilizador,
                                          i_batch_flag,
                                          i_desc_intervalo,
                                          i_data_intervalo,
                                          i_val_intervalo,
                                          v_desc_flag,
                                          v_val_flag,
                                          v_data_flag,
                                          to_number(i_num_conta),
                                          i_cod_divisao);

         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 6)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_cmb_receita');

--         PC_CONC.SP_RECONCILIA_CI_RECEITA(v_dt_inicio,
--                                          v_dt_fim,
--                                          i_id_utilizador,
--                                          i_batch_flag,
--                                          i_desc_intervalo,
--                                          i_data_intervalo,
--                                          i_val_intervalo,
--                                          v_desc_flag,
--                                          v_val_flag,
--                                          v_data_flag,
--                                          to_number(i_num_conta),
--                                          i_cod_divisao);
--

         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 7)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_outros_receita');

         pc_conc.sp_reconcilia_others_receita(v_dt_inicio,
                                           v_dt_fim,
                                           i_id_utilizador,
                                           i_batch_flag,
                                           i_desc_intervalo,
                                           i_data_intervalo,
                                           i_val_intervalo,
                                           v_desc_flag,
                                           v_val_flag,
                                           V_DATA_FLAG,
                                           to_number(i_num_conta));


         o_cod_erro:=0;
      ELSIF(i_tipo_registo = 8)THEN
         --DBMS_OUTPUT.put_line('sp_reconcilia_trf_banc_receita');

         pc_conc.sp_reconcilia_trf_banc_receita(v_dt_inicio,
                                           v_dt_fim,
                                           i_id_utilizador,
                                           i_batch_flag,
                                           i_desc_intervalo,
                                           i_data_intervalo,
                                           i_val_intervalo,
                                           v_desc_flag,
                                           v_val_flag,
                                           V_DATA_FLAG,
                                           to_number(i_num_conta));


         o_cod_erro:=0;
      END IF;

   END sp_pre_concilia_aux;

--

   PROCEDURE sp_reconcilia_td_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    )
    IS

    BEGIN
      IF(i_cod_divisao IS NULL AND i_batch = 0)THEN --todos os cod_divisao a que user pertence

         FOR cursor1 IN (SELECT DISTINCT (cod_divisao)
                             FROM (SELECT *
                                     FROM (SELECT     dgv.dgv_divisao.*
                                                 FROM dgv.dgv_divisao
                                           START WITH dgv.dgv_divisao.cod_divisao_pai IN(
                                                         SELECT dgv.dgv_divisao.cod_divisao
                                                           FROM dgv.dgv_divisao,
                                                                dgv.dgv_user,
                                                                dgv.dgv_user_divisao
                                                          WHERE dgv.dgv_user.id_user = i_id_utilizador
                                                            AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                                            AND dgv.dgv_user_divisao.cod_divisao =
                                                                                           dgv.dgv_divisao.cod_divisao)
                                           CONNECT BY NOCYCLE PRIOR dgv.dgv_divisao.cod_divisao =
                                                                                       dgv.dgv_divisao.cod_divisao_pai)
                                   UNION
                                   SELECT dgv.dgv_divisao.*
                                     FROM dgv.dgv_divisao,
                                          dgv.dgv_user,
                                          dgv.dgv_user_divisao
                                    WHERE dgv.dgv_user.id_user = i_id_utilizador
                                      AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                      AND dgv.dgv_user_divisao.cod_divisao = dgv.dgv_divisao.cod_divisao)
                         ORDER BY cod_divisao)

           LOOP
             PC_CONC.SP_RECONCILIA_TD_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;

	  ELSIF(i_batch = 1)THEN --se batch trata todas as divisoes

         FOR cursor1 IN (SELECT cod_divisao FROM dgv.dgv_divisao)

           LOOP
             PC_CONC.SP_RECONCILIA_TD_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;
      ELSE --apenas o que user selecionou e as que est?o abaixo dessa
           PC_CONC.SP_RECONCILIA_TD_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            i_cod_divisao);
      END IF;

   END sp_reconcilia_td_receita;

--
   PROCEDURE sp_reconcilia_td_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   )
   IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 1;

   BEGIN

	IF (i_batch_flag = 1) THEN
         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 1 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 1 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 1 AND id_dimensao = 3;

         END IF;
      ELSE --batch=0
         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

      END IF;

      IF  v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         --DBMS_OUTPUT.put_line('concilia_VAL');
         pc_conc_aux.sp_conc_td_val_aux(v_val_intervalo,
                                        i_dt_inicio,
                                        i_dt_fim,
                                        i_id_utilizador,
                                        i_num_conta,
                                        i_cod_divisao
                                       );
      ELSIF  v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         --DBMS_OUTPUT.put_line('concilia_DESC_VAL');
         pc_conc_aux.sp_conc_td_desc_val_aux(v_desc_intervalo,
                                             v_val_intervalo,
                                             i_dt_inicio,
                                             i_dt_fim,
                                             i_id_utilizador,
                                             i_num_conta,
                                             i_cod_divisao
                                            );
      ELSIF v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         --DBMS_OUTPUT.put_line('concilia_DESC_VAL_DATA');
         pc_conc_aux.sp_conc_td_desc_val_data_aux(v_desc_intervalo,
                                                  v_val_intervalo,
                                                  v_data_intervalo,
                                                  i_dt_inicio,
                                                  i_dt_fim,
                                                  i_id_utilizador,
                                                  i_num_conta,
                                                  i_cod_divisao
                                                 );
      ELSIF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         --DBMS_OUTPUT.put_line('concilia_VAL_DT');
         pc_conc_aux.sp_conc_td_val_data_aux(v_val_intervalo,
                                             v_data_intervalo,
                                             i_dt_inicio,
                                             i_dt_fim,
                                             i_id_utilizador,
                                             i_num_conta,
                                             i_cod_divisao
                                            );
      END IF;
   END sp_reconcilia_td_receita_aux;

---

   PROCEDURE sp_reconcilia_pac_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    )
    IS

    BEGIN
      IF(i_cod_divisao IS NULL and i_batch = 0)THEN --todos os cod_divisao a que user pertence

         FOR cursor1 IN (SELECT DISTINCT (cod_divisao)
                             FROM (SELECT *
                                     FROM (SELECT     dgv.dgv_divisao.*
                                                 FROM dgv.dgv_divisao
                                           START WITH dgv.dgv_divisao.cod_divisao_pai IN(
                                                         SELECT dgv.dgv_divisao.cod_divisao
                                                           FROM dgv.dgv_divisao,
                                                                dgv.dgv_user,
                                                                dgv.dgv_user_divisao
                                                          WHERE dgv.dgv_user.id_user = i_id_utilizador
                                                            AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                                            AND dgv.dgv_user_divisao.cod_divisao =
                                                                                           dgv.dgv_divisao.cod_divisao)
                                           CONNECT BY NOCYCLE PRIOR dgv.dgv_divisao.cod_divisao =
                                                                                       dgv.dgv_divisao.cod_divisao_pai)
                                   UNION
                                   SELECT dgv.dgv_divisao.*
                                     FROM dgv.dgv_divisao,
                                          dgv.dgv_user,
                                          dgv.dgv_user_divisao
                                    WHERE dgv.dgv_user.id_user = i_id_utilizador
                                      AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                      AND dgv.dgv_user_divisao.cod_divisao = dgv.dgv_divisao.cod_divisao)
                         ORDER BY cod_divisao)

           LOOP
             PC_CONC.SP_RECONCILIA_PAC_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;
	  ELSIF(i_batch = 1)THEN --se batch trata todas as divisoes

         FOR cursor1 IN (SELECT cod_divisao FROM dgv.dgv_divisao)

			LOOP

             PC_CONC.SP_RECONCILIA_PAC_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;

      ELSE --apenas o que user selecionou
           PC_CONC.SP_RECONCILIA_PAC_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            i_cod_divisao);
      END IF;
    END sp_reconcilia_pac_receita;

---

   PROCEDURE sp_reconcilia_pac_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   )
   IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          NUMBER;
      v_tipo_registo         NUMBER;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 2;

   BEGIN

      IF (i_batch_flag = 1) THEN

         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 2 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 2 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 2 AND id_dimensao = 3;

         END IF;
      ELSE --batch=0
         v_desc_flag      := i_desc_flag;
         v_val_flag       := i_val_flag;
         v_data_flag      := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo  := i_val_intervalo;
      END IF;

      IF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         pc_conc_aux.sp_conc_pac_val_aux(v_val_intervalo,
                                         i_dt_inicio,
                                         i_dt_fim,
                                         i_id_utilizador,
                                         i_num_conta,
                                         i_cod_divisao
                                        );





      ELSIF v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         pc_conc_aux.sp_conc_pac_desc_val_aux(v_desc_intervalo,
                                              v_val_intervalo,
                                              i_dt_inicio,
                                              i_dt_fim,
                                              i_id_utilizador,
                                              i_num_conta,
                                              i_cod_divisao
                                             );

      ELSIF v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         pc_conc_aux.sp_conc_pac_desc_val_data_aux(v_desc_intervalo,
                                                   v_val_intervalo,
                                                   v_data_intervalo,
                                                   i_dt_inicio,
                                                   i_dt_fim,
                                                   i_id_utilizador,
                                                   i_num_conta,
                                                   i_cod_divisao
                                                  );

      ELSIF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         pc_conc_aux.sp_conc_pac_val_data_aux(v_val_intervalo,
                                              v_data_intervalo,
                                              i_dt_inicio,
                                              i_dt_fim,
                                              i_id_utilizador,
                                              i_num_conta,
                                              i_cod_divisao
                                             );
      END IF;
   END sp_reconcilia_pac_receita_aux;

--

   PROCEDURE sp_reconcilia_mb_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    )
    IS

    BEGIN

		--trata a conciliacao sempre por divisao de modo a que os grupos fiquem bem definidos desta forma
		IF(i_cod_divisao IS NULL and i_batch = 0)THEN --todos os cod_divisao a que user pertence

         FOR cursor1 IN (SELECT DISTINCT (cod_divisao)
                             FROM (SELECT *
                                     FROM (SELECT     dgv.dgv_divisao.*
                                                 FROM dgv.dgv_divisao
                                           START WITH dgv.dgv_divisao.cod_divisao_pai IN(
                                                         SELECT dgv.dgv_divisao.cod_divisao
                                                           FROM dgv.dgv_divisao,
                                                                dgv.dgv_user,
                                                                dgv.dgv_user_divisao
                                                          WHERE dgv.dgv_user.id_user = i_id_utilizador
                                                            AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                                            AND dgv.dgv_user_divisao.cod_divisao =
                                                                                           dgv.dgv_divisao.cod_divisao)
                                           CONNECT BY NOCYCLE PRIOR dgv.dgv_divisao.cod_divisao =
                                                                                       dgv.dgv_divisao.cod_divisao_pai)
                                   UNION
                                   SELECT dgv.dgv_divisao.*
                                     FROM dgv.dgv_divisao,
                                          dgv.dgv_user,
                                          dgv.dgv_user_divisao
                                    WHERE dgv.dgv_user.id_user = i_id_utilizador
                                      AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                      AND dgv.dgv_user_divisao.cod_divisao = dgv.dgv_divisao.cod_divisao)
                         ORDER BY cod_divisao)

           LOOP
		         PC_CONC.SP_RECONCILIA_MB_RECEITA_AUX(i_dt_inicio,
		                                            i_dt_fim,
		                                            i_id_utilizador,
		                                            i_batch,
		                                            i_desc_intervalo,
		                                            i_data_intervalo,
		                                            i_val_intervalo,
		                                            v_desc_flag,
		                                            v_val_flag,
		                                            v_data_flag,
		                                            i_num_conta,
													i_cod_divisao);
			END LOOP;

	ELSIF(i_batch = 1)THEN --se batch trata todas as divisoes

         FOR cursor1 IN (SELECT cod_divisao FROM dgv.dgv_divisao)

			LOOP
				PC_CONC.SP_RECONCILIA_MB_RECEITA_AUX(i_dt_inicio,
		                                            i_dt_fim,
		                                            i_id_utilizador,
		                                            i_batch,
		                                            i_desc_intervalo,
		                                            i_data_intervalo,
		                                            i_val_intervalo,
		                                            v_desc_flag,
		                                            v_val_flag,
		                                            v_data_flag,
		                                            i_num_conta,
													i_cod_divisao);
			END LOOP;

	ELSE
		PC_CONC.SP_RECONCILIA_MB_RECEITA_AUX(i_dt_inicio,
		                                            i_dt_fim,
		                                            i_id_utilizador,
		                                            i_batch,
		                                            i_desc_intervalo,
		                                            i_data_intervalo,
		                                            i_val_intervalo,
		                                            v_desc_flag,
		                                            v_val_flag,
		                                            v_data_flag,
		                                            i_num_conta,
													i_cod_divisao);
	END IF;

   END sp_reconcilia_mb_receita;

----

   PROCEDURE sp_reconcilia_mb_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
	  i_cod_divisao				 IN		  NUMBER)
   IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;
      v_id_utilizador        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 4;

   BEGIN

      v_id_utilizador := i_id_utilizador;

      IF (i_batch_flag = 1) THEN

         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 3;

         END IF;

         IF  (V_DESC_FLAG = 1 AND V_VAL_FLAG = 0 AND V_DATA_FLAG = 0) THEN
            /**pc_conc_aux.sp_conc_mb_desc_aux(v_desc_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta);
               */
               NULL;
         ELSIF (v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 0) THEN
            pc_conc_aux.sp_conc_mb_desc_val_aux(v_desc_intervalo,
                                                v_val_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta,
												i_batch_flag);

         ELSIF (V_DESC_FLAG = 1 AND V_VAL_FLAG = 0 AND V_DATA_FLAG = 1) THEN
           /** pc_conc_aux.sp_conc_mb_desc_dt_aux(v_desc_intervalo,
                                                v_data_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta);
              */
              NULL;
         ELSIF (v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 1) THEN
            pc_conc_aux.sp_conc_mb_desc_val_dt_aux(v_desc_intervalo,
                                                v_data_intervalo,
                                                v_val_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta,
												i_batch_flag);
         END IF;


      ELSE --batch=0

         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

         IF  (V_DESC_FLAG = 1 AND V_VAL_FLAG = 0 AND V_DATA_FLAG = 0) THEN
            /**pc_conc_aux.sp_conc_mb_desc_aux(v_desc_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta);
               */
               NULL;
         ELSIF (v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 0) THEN
            pc_conc_aux.sp_conc_mb_desc_val_aux(v_desc_intervalo,
                                                v_val_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta,
												i_batch_flag);

         ELSIF (V_DESC_FLAG = 1 AND V_VAL_FLAG = 0 AND V_DATA_FLAG = 1) THEN
           /** pc_conc_aux.sp_conc_mb_desc_dt_aux(v_desc_intervalo,
                                                v_data_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta);
              */
              NULL;
         ELSIF (v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 1) THEN
            pc_conc_aux.sp_conc_mb_desc_val_dt_aux(v_desc_intervalo,
                                                v_data_intervalo,
                                                v_val_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta,
												i_batch_flag);
         END IF;




      END IF;
   END sp_reconcilia_mb_receita_aux;

-----


   PROCEDURE sp_reconcilia_ci_receita(
         i_dt_inicio             IN DATE,
         i_dt_fim                IN DATE,
         i_id_utilizador         IN NUMBER,
         i_batch                 IN NUMBER,
         i_desc_intervalo        IN NUMBER,
         i_data_intervalo        IN NUMBER,
         i_val_intervalo         IN NUMBER,
         v_desc_flag             IN NUMBER,
         v_val_flag              IN NUMBER,
         v_data_flag             IN NUMBER,
         i_num_conta             IN NUMBER,
         i_cod_divisao           IN NUMBER
       )
       IS

       BEGIN



         IF(i_cod_divisao IS NULL)THEN --todos os cod_divisao a que user pertence

            FOR cursor1 IN (SELECT DISTINCT (cod_divisao)
                                FROM (SELECT *
                                        FROM (SELECT     dgv.dgv_divisao.*
                                                    FROM dgv.dgv_divisao
                                              START WITH dgv.dgv_divisao.cod_divisao_pai IN(
                                                            SELECT dgv.dgv_divisao.cod_divisao
                                                              FROM dgv.dgv_divisao,
                                                                   dgv.dgv_user,
                                                                   dgv.dgv_user_divisao
                                                             WHERE dgv.dgv_user.id_user = i_id_utilizador
                                                               AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                                               AND dgv.dgv_user_divisao.cod_divisao =
                                                                                              dgv.dgv_divisao.cod_divisao)
                                              CONNECT BY NOCYCLE PRIOR dgv.dgv_divisao.cod_divisao =
                                                                                          dgv.dgv_divisao.cod_divisao_pai)
                                      UNION
                                      SELECT dgv.dgv_divisao.*
                                        FROM dgv.dgv_divisao,
                                             dgv.dgv_user,
                                             dgv.dgv_user_divisao
                                       WHERE dgv.dgv_user.id_user = i_id_utilizador
                                         AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                         AND dgv.dgv_user_divisao.cod_divisao = dgv.dgv_divisao.cod_divisao)
                            ORDER BY cod_divisao)
              LOOP

                -- dbms_output.put_line('calling sp_reconcilia_ci_receita_aux');

                PC_CONC.SP_RECONCILIA_CI_RECEITA_AUX(i_dt_inicio,
                                               i_dt_fim,
                                               i_id_utilizador,
                                               i_batch,
                                               i_desc_intervalo,
                                               i_data_intervalo,
                                               i_val_intervalo,
                                               v_desc_flag,
                                               v_val_flag,
                                               v_data_flag,
                                               i_num_conta,
                                               cursor1.cod_divisao);
              END LOOP;
         ELSE --apenas o que user selecionou
              PC_CONC.SP_RECONCILIA_CI_RECEITA_AUX(i_dt_inicio,
                                               i_dt_fim,
                                               i_id_utilizador,
                                               i_batch,
                                               i_desc_intervalo,
                                               i_data_intervalo,
                                               i_val_intervalo,
                                               v_desc_flag,
                                               v_val_flag,
                                               v_data_flag,
                                               i_num_conta,
                                               i_cod_divisao);
         END IF;
       END sp_reconcilia_ci_receita;

---

   PROCEDURE sp_reconcilia_ci_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   )
   IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;
     -- v_id_utilizador        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 5;

   BEGIN

      IF (i_batch_flag = 1) THEN
         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE id_dimensao = 1 and tipo_registo=5;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE id_dimensao = 2 and tipo_registo=5;


         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE id_dimensao = 3 and tipo_registo=5;

         END IF;
      ELSE
         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

      END IF;

      IF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         --DBMS_OUTPUT.put_line('concilia_VAL');
         pc_conc_aux.sp_conc_ci_val_aux(v_val_intervalo,
                                         i_dt_inicio,
                                         i_dt_fim,
                                         i_id_utilizador,
                                         i_num_conta,
                                         i_cod_divisao
                                        );

      ELSIF v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         --DBMS_OUTPUT.put_line('concilia_DESC_VAL');
         pc_conc_aux.sp_conc_ci_desc_val_aux(v_desc_intervalo,
                                              v_val_intervalo,
                                              i_dt_inicio,
                                              i_dt_fim,
                                              i_id_utilizador,
                                              i_num_conta,
                                              i_cod_divisao
                                             );
      ELSIF v_desc_flag = 1 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         --DBMS_OUTPUT.put_line('concilia_DESC_VAL_DT');
         pc_conc_aux.sp_conc_ci_desc_val_data_aux(v_desc_intervalo,
                                                   v_val_intervalo,
                                                   v_data_intervalo,
                                                   i_dt_inicio,
                                                   i_dt_fim,
                                                   i_id_utilizador,
                                                   i_num_conta,
                                                   i_cod_divisao
                                                  );

      ELSIF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 1 THEN
         --DBMS_OUTPUT.put_line('concilia_VAL_DT');
         pc_conc_aux.sp_conc_ci_val_data_aux(v_val_intervalo,
                                              v_data_intervalo,
                                              i_dt_inicio,
                                              i_dt_fim,
                                              i_id_utilizador,
                                              i_num_conta,
                                              i_cod_divisao
                                             );
      END IF;
   END sp_reconcilia_ci_receita_aux;


----

   PROCEDURE sp_reconcilia_tpa_receita(
      i_dt_inicio             IN DATE,
      i_dt_fim                IN DATE,
      i_id_utilizador         IN NUMBER,
      i_batch                 IN NUMBER,
      i_desc_intervalo        IN NUMBER,
      i_data_intervalo        IN NUMBER,
      i_val_intervalo         IN NUMBER,
      v_desc_flag             IN NUMBER,
      v_val_flag              IN NUMBER,
      v_data_flag             IN NUMBER,
      i_num_conta             IN NUMBER,
      i_cod_divisao           IN NUMBER
    )
    IS

    BEGIN

	IF(i_cod_divisao IS NULL and i_batch = 0) THEN --todos os cod_divisao a que user pertence

         FOR cursor1 IN (SELECT DISTINCT (cod_divisao)
                             FROM (SELECT *
                                     FROM (SELECT     dgv.dgv_divisao.*
                                                 FROM dgv.dgv_divisao
                                           START WITH dgv.dgv_divisao.cod_divisao_pai IN(
                                                         SELECT dgv.dgv_divisao.cod_divisao
                                                           FROM dgv.dgv_divisao,
                                                                dgv.dgv_user,
                                                                dgv.dgv_user_divisao
                                                          WHERE dgv.dgv_user.id_user = i_id_utilizador
                                                            AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                                            AND dgv.dgv_user_divisao.cod_divisao =
                                                                                           dgv.dgv_divisao.cod_divisao)
                                           CONNECT BY NOCYCLE PRIOR dgv.dgv_divisao.cod_divisao =
                                                                                       dgv.dgv_divisao.cod_divisao_pai)
                                   UNION
                                   SELECT dgv.dgv_divisao.*
                                     FROM dgv.dgv_divisao,
                                          dgv.dgv_user,
                                          dgv.dgv_user_divisao
                                    WHERE dgv.dgv_user.id_user = i_id_utilizador
                                      AND dgv.dgv_user.id_user = dgv.dgv_user_divisao.id_user
                                      AND dgv.dgv_user_divisao.cod_divisao = dgv.dgv_divisao.cod_divisao)
                         ORDER BY cod_divisao)

           LOOP

			PC_CONC.SP_RECONCILIA_TPA_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;
	  ELSIF(i_batch = 1)THEN --se batch trata todas as divisoes

         FOR cursor1 IN (SELECT cod_divisao FROM dgv.dgv_divisao)

			LOOP

             PC_CONC.SP_RECONCILIA_TPA_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            cursor1.cod_divisao);
           END LOOP;

      ELSE --apenas o que user selecionou
           PC_CONC.SP_RECONCILIA_TPA_RECEITA_AUX(i_dt_inicio,
                                            i_dt_fim,
                                            i_id_utilizador,
                                            i_batch,
                                            i_desc_intervalo,
                                            i_data_intervalo,
                                            i_val_intervalo,
                                            v_desc_flag,
                                            v_val_flag,
                                            v_data_flag,
                                            i_num_conta,
                                            i_cod_divisao);
      END IF;

   END sp_reconcilia_tpa_receita;

--

   PROCEDURE sp_reconcilia_tpa_receita_aux(
      i_dt_inicio                IN       DATE,
      i_dt_fim                   IN       DATE,
      i_id_utilizador            IN       NUMBER,
      i_batch_flag               IN       NUMBER,
      i_desc_intervalo           IN       NUMBER,
      i_data_intervalo           IN       NUMBER,
      i_val_intervalo            IN       NUMBER,
      i_desc_flag                IN       NUMBER,
      i_val_flag                 IN       NUMBER,
      i_data_flag                IN       NUMBER,
      i_num_conta                IN       NUMBER,
      i_cod_divisao              IN       NUMBER
   )
   IS
      v_desc_flag            NUMBER;
      v_val_flag             NUMBER;
      v_data_flag            NUMBER;
      v_id_dimensao          conc_parametrizacao.id_dimensao%TYPE;
      v_tipo_registo         conc_parametrizacao.tipo_registo%TYPE;
      v_desc_intervalo       NUMBER;
      v_data_intervalo       NUMBER;
      v_val_intervalo        NUMBER;
      v_id_utilizador        NUMBER;

      CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 3;

   BEGIN

      v_id_utilizador := i_id_utilizador;

      IF (i_batch_flag = 1) THEN

         v_desc_flag := 0;
         v_val_flag := 0;
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 1 THEN
               v_desc_flag := 1;
            ELSIF v_id_dimensao = 2 THEN
               v_val_flag := 1;
            ELSIF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         --obter intervalos (para evitar sucessivos selects posteriormente
         IF v_desc_flag = 1 THEN
            SELECT intervalo
              INTO v_desc_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 3 AND id_dimensao = 1;

         END IF;

         IF v_val_flag = 1 THEN
            SELECT intervalo
              INTO v_val_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 3 AND id_dimensao = 2;

         END IF;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 3 AND id_dimensao = 3;

         END IF;

         IF  v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 0 THEN
            --DBMS_OUTPUT.put_line('concilia_VAL');
            pc_conc_aux.sp_conc_tpa_val_aux(v_val_intervalo,
                                        i_dt_inicio,
                                        i_dt_fim,
                                        v_id_utilizador,
                                        i_num_conta,
										i_cod_divisao
                                       );
          ELSIF v_desc_flag = 0 AND v_val_flag = 0 AND v_data_flag = 1 THEN
             --DBMS_OUTPUT.put_line('concilia_DESC_VAL_DATA');
             pc_conc_aux.sp_conc_tpa_data_aux(v_data_intervalo,
                                                  i_dt_inicio,
                                                  i_dt_fim,
                                                  v_id_utilizador,
                                                  i_num_conta,
												  i_cod_divisao
                                                     );
          ELSIF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 1 THEN
             --DBMS_OUTPUT.put_line('concilia_VAL_DT');
             pc_conc_aux.sp_conc_tpa_val_data_aux(v_val_intervalo,
                                                 v_data_intervalo,
                                                 i_dt_inicio,
                                                 i_dt_fim,
                                                 v_id_utilizador,
                                                 i_num_conta,
                                                 i_cod_divisao);
         END IF;


      ELSE --batch=0

         v_desc_flag := i_desc_flag;
         v_val_flag := i_val_flag;
         v_data_flag := i_data_flag;
         v_desc_intervalo := i_desc_intervalo;
         v_data_intervalo := i_data_intervalo;
         v_val_intervalo := i_val_intervalo;

         IF  v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 0 THEN
         --DBMS_OUTPUT.put_line('concilia_VAL');
         pc_conc_aux.sp_conc_tpa_val_aux(v_val_intervalo,
                                        i_dt_inicio,
                                        i_dt_fim,
                                        v_id_utilizador,
                                        i_num_conta,
                                        i_cod_divisao);
         ELSIF v_desc_flag = 0 AND v_val_flag = 0 AND v_data_flag = 1 THEN
            --DBMS_OUTPUT.put_line('concilia_DESC_VAL_DATA');
            pc_conc_aux.sp_conc_tpa_data_aux(v_data_intervalo,
                                                 i_dt_inicio,
                                                 i_dt_fim,
                                                 v_id_utilizador,
                                                 i_num_conta,
                                                 i_cod_divisao);
         ELSIF v_desc_flag = 0 AND v_val_flag = 1 AND v_data_flag = 1 THEN
            --DBMS_OUTPUT.put_line('concilia_VAL_DT');
            pc_conc_aux.sp_conc_tpa_val_data_aux(v_val_intervalo,
                                                v_data_intervalo,
                                                i_dt_inicio,
                                                i_dt_fim,
                                                v_id_utilizador,
                                                i_num_conta,
                                                i_cod_divisao);
         END IF;

      END IF;

   END sp_reconcilia_tpa_receita_aux;

---




 --
   /**
    *Procedure que insere os movimentos conciliados numa tabela de interface
    *Quando a conciliac?o terminar, os movimentos envolvidos nessa conciliacao,
    *sao inseridos na tabela de movimentos conciliados pelo PROCEDURE sp_conc_grava_conciliacao
    */

   PROCEDURE sp_conc_interface(
      i_id_mov    IN     NUMBER,
      i_tp_mov    IN     VARCHAR2,
      io_agrupador   IN OUT    VARCHAR2,
      i_id_utilizador IN NUMBER,
      cod_erro    OUT    NUMBER
   )

   IS
      id_null EXCEPTION;
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      IF(i_id_mov IS NULL) THEN
         RAISE id_null;
      ELSE

        IF (io_agrupador IS NULL) THEN
           select SQ_CONC_CONCILIACAO.nextval INTO io_agrupador FROM DUAL;
        END IF;

        INSERT INTO CONC_MOVIMENTO_INTERFACE(AGRUPADOR,ID_MOV,TP_MOV,ID_UTILIZADOR,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT)
        VALUES (io_agrupador,i_id_mov,i_tp_mov,i_id_utilizador,CURRENT_TIMESTAMP,V_NM_UTILIZADOR,CURRENT_TIMESTAMP,V_NM_UTILIZADOR);

        cod_erro := 0;--sucesso

      END IF;


      EXCEPTION
         WHEN id_null THEN
         io_agrupador := -1;
         cod_erro := 1;--erro

   END sp_conc_interface;


   /**
	 * Executa a primeira fase de associacao entre movimentos de detalhe de banco e movimentos de extracto
	 * atraves da tabela  de interface
	 */
     PROCEDURE SP_ASSOC_DETALHE_INTERFACE(
      I_ID_MOV_EXTRACTO          IN       NUMBER,
      I_ID_MOV_DETALHE           IN       NUMBER,
      I_TP_MOV_DETALHE           IN       NUMBER,
      IO_AGRUPADOR               IN OUT   NUMBER,
      I_ID_UTILIZADOR            IN       NUMBER,
      COD_ERRO                   OUT      NUMBER
    )
    
    IS
      ID_NULL EXCEPTION;
       V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
    BEGIN
       
       SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;
     	
      IF(I_ID_MOV_EXTRACTO IS NULL OR I_ID_MOV_DETALHE IS NULL OR I_TP_MOV_DETALHE IS NULL OR I_ID_UTILIZADOR IS NULL) THEN
         RAISE ID_NULL;
      ELSE
      
        IF (IO_AGRUPADOR IS NULL) THEN
           select SQ_CONC_ASSOC_DETALHE.nextval INTO IO_AGRUPADOR FROM DUAL; 
        END IF;
        
        INSERT INTO CONC_ASSOC_DETALHE_INTERFACE(ID_MOV_EXTRACTO,ID_MOV_DETALHE,TP_MOV_DETALHE,AGRUPADOR,ID_UTILIZADOR,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT)
          VALUES (I_ID_MOV_EXTRACTO,I_ID_MOV_DETALHE,I_TP_MOV_DETALHE,IO_AGRUPADOR,I_ID_UTILIZADOR,CURRENT_TIMESTAMP,V_NM_UTILIZADOR,CURRENT_TIMESTAMP,V_NM_UTILIZADOR);

        cod_erro := 0;--sucesso 
        
      END IF;  
      
      --commit;
        
      EXCEPTION
         WHEN id_null THEN
         IO_AGRUPADOR := -1;
         cod_erro := 1;--erro
     
     
     
    END SP_ASSOC_DETALHE_INTERFACE;

--
 	/**
	 * Anulacao de associacao entre um detalhe de banco e o extracto correspondente
	 * 
	 * RETURN CODES:
	 * 10 - I_TP_REGISTO enviou um valor desconhecido/nao esperado para processamento
	 */
	PROCEDURE SP_CONC_ANULA_ASSOC_DETALHE(
	  I_TP_REGISTO				IN NUMBER,
      I_AGRUPADOR               IN NUMBER,
      I_ID_UTILIZADOR           IN NUMBER,      
      COD_ERRO                  OUT NUMBER
   )
   
   	IS 
		V_NM_USER           		DGV.DGV_USER.NM_USER%TYPE;
		V_COUNT_MOV_CONC_AUTO		NUMBER;

	BEGIN
		 -- Obter o nome de utilizador de quem realizou a associacao. 
    	SELECT nm_user INTO V_NM_USER FROM DGV.DGV_USER WHERE id_user = i_id_utilizador;

		--verifica se existem movimentos de extracto directamente associados na tabela de conciliacao - quer dizer que houve conciliacao automatica
		SELECT COUNT(1) INTO V_COUNT_MOV_CONC_AUTO
							FROM
							  CONC_MOVIMENTO_CONCILIADO MOV_IN
							WHERE ID_MOV_BANCO IN (SELECT ID_MOV_BANCO FROM conc_movimento_extracto WHERE AGRUPADOR = I_AGRUPADOR);
		
		--se conciliacao for automatica todos os movimentos - SCCT, Extracto e detalhe devem ser "desconciliados" - ESTADO 2
		IF (V_COUNT_MOV_CONC_AUTO > 0) THEN
				-- verifica o tipo de registo que esta a ser anulado, consoante o tipo de registo e necessario actualizar tabelas diferentes				
				IF (I_TP_REGISTO = 4) THEN
					-- REFERENCIAS MULTIBANCO
					--remove associacao entre agrupador do banco/extracto e movimento MPSIBS - estado passa a por conciliar
					update conc_movimento_mpsibs 
					set AGRUPADOR_MOV_BANCO = null, id_mov_banco = null, ID_ESTADO = 2,
						NM_UTILIZADOR_ASSOC = V_NM_USER, DATA_ASSOCIACAO = CURRENT_TIMESTAMP,DSC_UTIL_UPDT = V_NM_USER, DH_UPDT = CURRENT_TIMESTAMP   
					where AGRUPADOR_MOV_BANCO = I_AGRUPADOR;					


					COD_ERRO := 0;

				ELSIF (I_TP_REGISTO = 3) THEN
					--TPA
					--remove associacao entre agrupador do banco/extracto e movimento TPA - estado passa a por conciliar
					update conc_movimento_tpa_detalhe set AGRUPADOR_MOV_BANCO = null, id_mov_banco = null, ID_ESTADO = 2,
						NM_UTILIZADOR_ASSOC = V_NM_USER, DATA_ASSOCIACAO = CURRENT_TIMESTAMP,DH_UPDT = CURRENT_TIMESTAMP,dsc_util_updt = v_nm_user  where AGRUPADOR_MOV_BANCO = I_AGRUPADOR;
				
					COD_ERRO := 0;

				ELSE 
					COD_ERRO := -10; -- tipo de registo desconhecido
				END IF;

				IF (COD_ERRO = 0) THEN
					--remove a conciliacao entre SCCT e Extracto
					FOR CONC_AGRUPADOR IN (SELECT
							  DISTINCT AGRUPADOR AGRUP
							FROM
							  CONC_MOVIMENTO_CONCILIADO MOV_IN
							WHERE ID_MOV_BANCO IN (SELECT ID_MOV_BANCO FROM conc_movimento_extracto WHERE AGRUPADOR = I_AGRUPADOR))
		
					LOOP
						--anula a conciliacao automatica
						SP_ANULA_CONC_MOV(CONC_AGRUPADOR.AGRUP, i_id_utilizador,COD_ERRO);
		
					END LOOP;

					--remove do extracto a flag de detalhe - o extracto deixou de ter detalhe associado
					update conc_movimento_extracto 
					set FL_COM_DETALHE = 0, DSC_UTIL_UPDT = V_NM_USER, DH_UPDT = CURRENT_TIMESTAMP 
					where agrupador = I_AGRUPADOR;
				END IF;
		
		ELSE

			--conciliacao executada nao foi automatica -> CONCILIACAO MANUAL
			
			--valida-se a associacao detalhe-extracto e SCCT-detalhe
			-- verifica o tipo de registo que esta a ser anulado, consoante o tipo de registo e necessario actualizar tabelas diferentes
			-- REFERENCIAS MULTIBANCO
			IF (I_TP_REGISTO = 4) THEN
					
				--se o movimento MPSIBS ja estava completamente conciliado com esta anulacao de associacao ficou parcilamente conciliado
				--E necessario actualizar o estado do movimento MPSIBS e da tabela de conciliados
				UPDATE 
					CONC_MOVIMENTO_CONCILIADO CMC
				SET
					CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 4 THEN 6 WHEN 5 THEN 7 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
					CMC.DH_UPDT = CURRENT_TIMESTAMP,
				  	CMC.dsc_util_updt = v_nm_user
				WHERE
					CMC.ID_MOV_MPSIBS IN (SELECT ID_MOV_MPSIBS FROM conc_movimento_mpsibs WHERE AGRUPADOR_MOV_BANCO = I_AGRUPADOR);
		
				-- para as referencias MB retira-se a associacao das tabelas de CONC_MOVIMENTO_MPSIBS
				update conc_movimento_mpsibs 
				set AGRUPADOR_MOV_BANCO = null, id_mov_banco = null, ID_ESTADO = (CASE ID_ESTADO WHEN 4 THEN 6 WHEN 5 THEN 7 ELSE ID_ESTADO END),
					NM_UTILIZADOR_ASSOC = V_NM_USER, DATA_ASSOCIACAO = CURRENT_TIMESTAMP,DSC_UTIL_UPDT = V_NM_USER, DH_UPDT = CURRENT_TIMESTAMP   
				where AGRUPADOR_MOV_BANCO = I_AGRUPADOR;
		
				COD_ERRO := 0;
				
			-- TPAs
			ELSIF (I_TP_REGISTO = 3) THEN
		
				--se o movimento TPA ja estava completamente conciliado com esta anulacao de associacao ficou parcilamente conciliado
				--E necessario actualizar o estado do movimento TPA e da tabela de conciliados - com o agrupador banco igual ao recebido
				UPDATE 
					CONC_MOVIMENTO_CONCILIADO CMC
				SET
					CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 4 THEN 6 WHEN 5 THEN 7 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
					CMC.DH_UPDT = CURRENT_TIMESTAMP,
				  	CMC.dsc_util_updt = v_nm_user
				WHERE
					CMC.ID_MOV_TPA IN (SELECT ID_MOV_TPA FROM conc_movimento_tpa_detalhe WHERE AGRUPADOR_MOV_BANCO = I_AGRUPADOR);
		
				-- para os TPAs retira-se a associacao das tabelas de CONC_MOVIMENTO_TPA_DETALHE com agrupador_banco igual ao agrupador recebido
				update conc_movimento_tpa_detalhe set AGRUPADOR_MOV_BANCO = null, id_mov_banco = null, ID_ESTADO = (CASE ID_ESTADO WHEN 4 THEN 6 WHEN 5 THEN 7 ELSE ID_ESTADO END),
						NM_UTILIZADOR_ASSOC = V_NM_USER, DATA_ASSOCIACAO = CURRENT_TIMESTAMP,DH_UPDT = CURRENT_TIMESTAMP,dsc_util_updt = v_nm_user  where AGRUPADOR_MOV_BANCO = I_AGRUPADOR;
					
		
				COD_ERRO := 0;
			
			ELSE 
			
				COD_ERRO := -10; -- tipo de registo desconhecido
			END IF;
		
			IF (COD_ERRO = 0) THEN
				--actualiza extracto 
				--utilizando o agrupador recebido retira-se a flag COM_DETALHE 
				--e o estado passa a ser por conciliar porque nao tem nenhuma associacao com os movimentos de detalhe - portanto nenhuma conciliacao
				--do registo da CONC_MOVIMENTO_EXTRACTO com o mesmo AGRUPADOR_MOV_BANCO que o agrupador recebido
				update conc_movimento_extracto 
				set FL_COM_DETALHE = 0, ID_ESTADO = 2,
					DSC_UTIL_UPDT = V_NM_USER, DH_UPDT = CURRENT_TIMESTAMP 
				where agrupador = I_AGRUPADOR;
			END IF;
		END IF;

	END SP_CONC_ANULA_ASSOC_DETALHE;

--
   PROCEDURE SP_CONC_GRAVA_ASSOC_DETALHE(
      I_AGRUPADOR               IN NUMBER,
	  I_TP_DETALHE				IN NUMBER,
      I_ID_UTILIZADOR           IN NUMBER,      
      COD_ERRO                  OUT NUMBER
   )
   
   IS      
      V_MONTANTE_BANCO    				CONC_MOVIMENTO_EXTRACTO.MONTANTE%TYPE;
      V_VALOR_DETALHE     				NUMBER;
      V_NM_USER           				DGV.DGV_USER.NM_USER%TYPE;
      V_DATA_ASSOCIACAO   				DATE;
      V_EXT_AGRUPADOR     				NUMBER;
      -- dados agrupados para o extracto
      V_EXT_NUM_MOVIMENTOS                NUMBER;
      V_EXT_DESCRICAO_MOVIMENTO           CONC_MOVIMENTO_EXTRACTO.DESCRICAO_MOVIMENTO%TYPE;
      V_EXT_COD_DIVISAO                   CONC_MOVIMENTO_EXTRACTO.COD_DIVISAO%TYPE;
      V_EXT_NM_DIVISAO                    CONC_MOVIMENTO_EXTRACTO.NM_DIVISAO_GRUPO%TYPE;
      V_EXT_ID_TIPO_REG                   CONC_MOVIMENTO_EXTRACTO.ID_TIPO_REG_GRUPO%TYPE;
      V_EXT_TIPO_MOV                      CONC_MOVIMENTO_EXTRACTO.TP_MOV_GRUPO%TYPE;
      V_EXT_TIPO_REG                      CONC_MOVIMENTO_EXTRACTO.TIPO_REG_GRUPO%TYPE;
      V_EXT_NUM_CONTA                     CONC_MOVIMENTO_EXTRACTO.NUM_CONTA%TYPE;
      V_EXT_DATA                          CONC_MOVIMENTO_EXTRACTO.DT_EXTRACTO%TYPE;
	  V_EXT_DATA_MOV                      CONC_MOVIMENTO_EXTRACTO.DT_EXTRACTO%TYPE;
	  V_EXT_ID_MOV_BANCO                  CONC_MOVIMENTO_EXTRACTO.ID_MOV_BANCO%TYPE;
	  V_ANTIGO_AGRUPADOR				  CONC_MOVIMENTO_EXTRACTO.ID_MOV_BANCO%TYPE;
	  V_ANTIGO_NUM_MOVIMENTOS             NUMBER;
	  V_GERADO_NOVO_AGRUPADOR             NUMBER := 0;
      -- dados agrupados para o detalhe 
	  V_COUNT_MOV_POR_CONCILIAR		   	NUMBER;
	  V_COUNT_MOV_UPDATE_CONC		   	NUMBER;
	  --obtem os agrupadores a actualizar apos a criacao de um novo agrupador para o grupo de extracto
	  CURSOR c_agrupadores IS
         		SELECT distinct agrupador
           			FROM CONC_MOVIMENTO_EXTRACTO
          		WHERE ID_MOV_BANCO IN (SELECT DISTINCT ID_MOV_EXTRACTO FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR);

   BEGIN
   
    -- Obter o nome de utilizador que realiza a associacao. 
    SELECT nm_user INTO v_nm_user FROM DGV.DGV_USER WHERE id_user = i_id_utilizador;
    
    -- Data em que foi estabelecida a associacao.
    V_DATA_ASSOCIACAO := current_timestamp;          
    
    --obter soma dos valores relativos aos movimentos do extracto e os valores do grupo de extracto
    --TODO: rever divisao colocada
    SELECT 
      SUM(CASE WHEN CME.TIPO_OPERACAO = 'D' THEN
            CME.MONTANTE * -1
           ELSE CME.MONTANTE END),
      COUNT(1) NUM_MOVIMENTOS,
      MAX(CME.DESCRICAO_MOVIMENTO) DESCRICAO_MOVIMENTO,
      MIN(CME.COD_DIVISAO) COD_DIVISAO,      
      MIN(CME.NM_DIVISAO_GRUPO) NM_DIVISAO_GRUPO,
      MAX(CME.ID_TIPO_REG_GRUPO) ID_TIPO_REG_GRUPO,
      (CASE WHEN (SUM(CASE WHEN CME.TIPO_OPERACAO = 'D' THEN
            CME.MONTANTE * -1
           ELSE CME.MONTANTE END)) > 0 THEN 'C' ELSE 'D' END) TP_MOV_GRUPO,      
      MAX(CME.TIPO_REG_GRUPO) TIPO_REG_GRUPO,
      MAX(CME.NUM_CONTA) NUM_CONTA,
      MIN(CME.DT_EXTRACTO) DT_EXTRACTO,
	  MIN(CME.DT_MOVIMENTO) DT_MOVIMENTO,
	  MAX(ID_MOV_BANCO) ID_MOV_BANCO_GRUPO,
	  MAX(AGRUPADOR) AGRUPADOR_ACTUAL, --so servirao para casos em que o NUM_MOVIMENTOS = 1
	  MAX(NUM_MOVIMENTOS) NUM_MOVIMENTOS_AGRUP --so servirao para casos em que o NUM_MOVIMENTOS = 1
    INTO  
      V_MONTANTE_BANCO,
      V_EXT_NUM_MOVIMENTOS,
      V_EXT_DESCRICAO_MOVIMENTO,
      V_EXT_COD_DIVISAO,
      V_EXT_NM_DIVISAO,
      V_EXT_ID_TIPO_REG,
      V_EXT_TIPO_MOV,
      V_EXT_TIPO_REG,
      V_EXT_NUM_CONTA,
      V_EXT_DATA,
	  V_EXT_DATA_MOV,
	  V_EXT_ID_MOV_BANCO,
	  V_EXT_AGRUPADOR,
	  V_ANTIGO_NUM_MOVIMENTOS
    FROM 
      CONC_MOVIMENTO_EXTRACTO CME
    WHERE CME.ID_MOV_BANCO IN (SELECT DISTINCT ID_MOV_EXTRACTO FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR);

	--verifica se e necessario novo agrupador
	--se apenas tiver sido seleccionado um movimento e se o agrupador desse movimento so estiver associado um movimento - NAO E PRECISO GERAR NOVO AGRUPADOR	
	IF (V_ANTIGO_NUM_MOVIMENTOS <> 1 or V_EXT_NUM_MOVIMENTOS <> 1) THEN
		--verifica quais os agrupadores antigos envolvidos nos movimentos de extracto seleccionados
    	OPEN c_agrupadores;
		
		--senao, verifica se todos os movimentos de extracto seleccionados tem o mesmo agrupador e se o numero de movimentos desse agrupador e igual ao ao numero de movimentos seleccionados	
		--senao for igual e necessario gerar um novo agrupador
		IF (c_agrupadores%ROWCOUNT <> 1 OR V_ANTIGO_NUM_MOVIMENTOS <> V_EXT_NUM_MOVIMENTOS) THEN
			V_GERADO_NOVO_AGRUPADOR := 1;

			-- obter novo agrupador para o grupo do extracto - deve ser criado um novo grupo de extracto que simboliza esta associacao
	        select sq_id_movimento_associado.NEXTVAL INTO V_EXT_AGRUPADOR FROM DUAL; 			
		END IF;
			
	END IF;
                                           
    --caso o tipo de registo seja MPSIBS                                                
    --obtem soma dos valores relativos aos movimentos do MPSIBS.
    IF (I_TP_DETALHE = 4) THEN
	    SELECT 
	      SUM(CMM.MONTANTE)    
	    INTO 
	      V_VALOR_DETALHE
	    FROM 
	      CONC_MOVIMENTO_MPSIBS CMM
	    WHERE	      
	      CMM.ID_MOV_MPSIBS IN (SELECT CADI.ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE CADI 
                                    WHERE CADI.AGRUPADOR = I_AGRUPADOR
                                    AND CADI.ID_UTILIZADOR = I_ID_UTILIZADOR
                                    AND CADI.TP_MOV_DETALHE = 4);
	
		COD_ERRO := 0;

    ELSIF I_TP_DETALHE = 3 THEN
    	--caso o tipo de registo seja TPA
        --obter soma dos valores relativos aos movimentos de TPA.
        SELECT 
          SUM(CASE WHEN CMTD.TIPO_OPERACAO = 'D' THEN
            CMTD.MONTANTE * -1
           ELSE CMTD.MONTANTE END)    
        INTO 
          V_VALOR_DETALHE
        FROM 
          CONC_MOVIMENTO_TPA_DETALHE CMTD
        WHERE
          CMTD.ID_MOV_TPA IN (SELECT CADI.ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE CADI 
                                    WHERE CADI.AGRUPADOR = I_AGRUPADOR
                                    AND CADI.ID_UTILIZADOR = I_ID_UTILIZADOR
                                    AND CADI.TP_MOV_DETALHE = 3);

		COD_ERRO := 0;
	ELSE
        COD_ERRO := 2; -- I_TP_DETALHE nao e valido
		
    END IF;
   
   	-- verifica se o total e igual em ambas as partes. 
   	IF (ABS(V_VALOR_DETALHE - V_MONTANTE_BANCO) > 0) THEN
    	COD_ERRO := 1; -- valores diferentes
   	ELSE
      
        --ACTUALIZAR AS ENTRADAS DE DETALHE
        --REF MB
        IF I_TP_DETALHE = 4 THEN

			--actualiza o agrupador do banco que se associou aos movimentos MPSIBS
			--se so estiver associado um movimento de extracto ao grupo de detalhe coloca o id_mov_banco correspondente
			--se o movimento MPSIBS ja estava conciliado parcialmente agora ficou completamente conciliado -> actualiza estado
          	UPDATE 
		      CONC_MOVIMENTO_MPSIBS CMM
		    SET
					CMM.ID_ESTADO = (CASE CMM.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMM.ID_ESTADO END),
		            CMM.AGRUPADOR_MOV_BANCO = V_EXT_AGRUPADOR,
		            CMM.ID_MOV_BANCO = (CASE V_EXT_NUM_MOVIMENTOS WHEN 1 THEN V_EXT_ID_MOV_BANCO ELSE NULL END),
					CMM.NM_UTILIZADOR_ASSOC = v_nm_user,
					CMM.DATA_ASSOCIACAO = CURRENT_TIMESTAMP,
					CMM.DH_UPDT = CURRENT_TIMESTAMP,
		 			CMM.dsc_util_updt = v_nm_user
		          WHERE
		            CMM.ID_MOV_MPSIBS IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=4);
        	
			--se o movimento SCCT correspondente ao movimento MPSIBS ja estava conciliado parcialmente agora ficou completamente conciliado -> actualiza estado do movimento SCCT
			UPDATE 
		            CONC_MOVIMENTO_SCCT CMS
		          SET
					CMS.ID_ESTADO = (CASE CMS.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMS.ID_ESTADO END),
					CMS.DH_UPDT = CURRENT_TIMESTAMP,
		  			CMS.dsc_util_updt = v_nm_user
		          WHERE
		            CMS.ID_MOV_SCCT IN (SELECT CMC2.ID_MOV_SCCT FROM CONC_MOVIMENTO_CONCILIADO CMC1, CONC_MOVIMENTO_CONCILIADO CMC2 WHERE 
							CMC1.ID_MOV_MPSIBS IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=4)
							 AND CMC1.AGRUPADOR = CMC2.AGRUPADOR AND CMC2.ID_MOV_SCCT IS NOT NULL);

			--se existem movimentos do SCCT ja associados aos movimentos MPSIBS e necessario alterar tambem o estado na tabela de conciliados
			--se ja estava conciliado parcialmente agora ficou completamente conciliado
			UPDATE 
		            CONC_MOVIMENTO_CONCILIADO CMC
		          SET
					CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
					CMC.DH_UPDT = CURRENT_TIMESTAMP,
		  			CMC.dsc_util_updt = v_nm_user
		          WHERE
		            CMC.ID_MOV_MPSIBS IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=4);
			
			--verifica quantas linhas dos movimentos conciliados foram actualizadas
			V_COUNT_MOV_UPDATE_CONC := SQL%ROWCOUNT;

			--verifica se todos os movimentos MPSIBS deste grupo ja estao conciliados com SCCT
			SELECT COUNT(1) INTO V_COUNT_MOV_POR_CONCILIAR FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=4
						AND ID_MOV_DETALHE NOT IN (SELECT CMC.ID_MOV_MPSIBS FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_MPSIBS = ID_MOV_DETALHE);

        -- TPA
        ELSE 
        
        	--actualiza o agrupador do banco que se associou aos movimentos TPA
			--se so estiver associado um movimento de extracto ao grupo de detalhe coloca o id_mov_banco correspondente
			--e se o movimento TPA ja estava conciliado parcialmente agora ficou completamente conciliado -> actualiza estado
        	
			UPDATE 
		    	CONC_MOVIMENTO_TPA_DETALHE CMTD
			SET
					CMTD.ID_ESTADO = (CASE CMTD.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMTD.ID_ESTADO END),
					CMTD.AGRUPADOR_MOV_BANCO = V_EXT_AGRUPADOR,
		            CMTD.ID_MOV_BANCO = (CASE V_EXT_NUM_MOVIMENTOS WHEN 1 THEN V_EXT_ID_MOV_BANCO ELSE NULL END),
					CMTD.NM_UTILIZADOR_ASSOC = v_nm_user,
					CMTD.DATA_ASSOCIACAO = CURRENT_TIMESTAMP,
					CMTD.DH_UPDT = CURRENT_TIMESTAMP,
		 			CMTD.dsc_util_updt = v_nm_user
		          WHERE
		            CMTD.ID_MOV_TPA IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=3);
		    

			--se o movimento SCCT correspondente ao movimento TPA ja estava conciliado parcialmente agora ficou completamente conciliado -> actualiza estado do movimento SCCT
			 UPDATE 
		            CONC_MOVIMENTO_SCCT CMS
		          SET
					CMS.ID_ESTADO = (CASE CMS.ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMS.ID_ESTADO END),
					CMS.DH_UPDT = CURRENT_TIMESTAMP,
		  			CMS.dsc_util_updt = v_nm_user
		          WHERE
		            CMS.ID_MOV_SCCT IN (SELECT CMC2.ID_MOV_SCCT FROM CONC_MOVIMENTO_CONCILIADO CMC1, CONC_MOVIMENTO_CONCILIADO CMC2 WHERE 
							CMC1.ID_MOV_TPA IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=3)
							 AND CMC1.AGRUPADOR = CMC2.AGRUPADOR AND CMC2.ID_MOV_SCCT IS NOT NULL);

			--se existem movimentos do SCCT ja associados aos movimentos TPA e necessario alterar tambem o estado na tabela de conciliados
			--se ja estava conciliado parcialmente agora ficou completamente conciliado
			UPDATE 
		            CONC_MOVIMENTO_CONCILIADO CMC
		          SET
					CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
					CMC.DH_UPDT = CURRENT_TIMESTAMP,
		  			CMC.dsc_util_updt = v_nm_user
		          WHERE
		            CMC.ID_MOV_TPA IN (SELECT ID_MOV_DETALHE FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=3);

			
			--verifica quantas linhas dos movimentos conciliados foram actualizadas
			V_COUNT_MOV_UPDATE_CONC := SQL%ROWCOUNT;

			--verifica se todos os movimentos TPA deste grupo ja estao conciliados com SCCT
			SELECT COUNT(1) INTO V_COUNT_MOV_POR_CONCILIAR FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR AND TP_MOV_DETALHE=3
						AND ID_MOV_DETALHE NOT IN (SELECT CMC.ID_MOV_TPA FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_TPA = ID_MOV_DETALHE);

        END IF;

		 -- actualizar as entradas do extracto
		 --se todos os movimentos de detalhe associados a este extracto ficaram conciliados, tambem este extracto ficou conciliado
		 --se alguns dos movimentos de detalhe deste extracto ja estao conciliados entao este extracto esta parcialmente conciliado
		 --se nao existirem movimentos de detalhe ja conciliados entao fica no estado que estava -> por conciliar
        UPDATE 
          CONC_MOVIMENTO_EXTRACTO CME
        SET
		  CME.ID_ESTADO = CASE WHEN V_COUNT_MOV_POR_CONCILIAR > 0 THEN (CASE WHEN V_COUNT_MOV_UPDATE_CONC > 0 THEN 6 ELSE CME.ID_ESTADO END) ELSE 4 END, 
          CME.DESCRICAO_GRUPO = V_EXT_DESCRICAO_MOVIMENTO,
          CME.DATA_GRUPO = V_EXT_DATA_MOV,
		  CME.DATA_EXTRACTO_GRUPO = V_EXT_DATA,
          CME.VALOR_GRUPO = V_MONTANTE_BANCO,
          CME.COD_DIVISAO_GRUPO = V_EXT_COD_DIVISAO,
          CME.NM_DIVISAO_GRUPO = V_EXT_NM_DIVISAO,
          CME.TP_MOV_GRUPO = V_EXT_TIPO_MOV,
          CME.ID_TIPO_REG_GRUPO =  V_EXT_ID_TIPO_REG,
          CME.TIPO_REG_GRUPO = V_EXT_TIPO_REG,
          CME.NUM_CONTA_GRUPO =  V_EXT_NUM_CONTA,
          CME.NUM_MOVIMENTOS = V_EXT_NUM_MOVIMENTOS,
          CME.AGRUPADOR = V_EXT_AGRUPADOR,
          CME.FL_COM_DETALHE = 1,
		  CME.DH_UPDT = CURRENT_TIMESTAMP,
		  CME.dsc_util_updt = v_nm_user
		WHERE CME.ID_MOV_BANCO IN (SELECT DISTINCT ID_MOV_EXTRACTO FROM CONC_ASSOC_DETALHE_INTERFACE WHERE AGRUPADOR = I_AGRUPADOR AND ID_UTILIZADOR = I_ID_UTILIZADOR);

		--se houve criacao de um novo agrupador e necessario actualizar TODOS os agrupadores antigos
		IF (V_GERADO_NOVO_AGRUPADOR = 1) THEN
			-- ciclo no qual e feita a actualizacao dos agrupadores antigamente utilizados
			LOOP
				FETCH c_agrupadores INTO V_ANTIGO_AGRUPADOR;
				EXIT WHEN c_agrupadores%NOTFOUND;
	
				-- Actualizar os valores agrupados para o agrupador antigo.
			  	-- Apenas é necessário actualizar o número de movimentos e montante
				FOR C_MOVS IN (SELECT
								 SUM(
                    CASE WHEN ID_ESTADO = 2 THEN
                      CASE WHEN TIPO_OPERACAO = 'D' THEN MONTANTE * -1
                        ELSE MONTANTE END
                    ELSE 0 END
                  ) soma,
                  count(1) qtd,
                  max(descricao_movimento) descricao_movimento,
				  min(dt_movimento) dt_movimento,
                  min(dt_extracto) dt_extracto,
                  CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN NULL
                    ELSE MIN(COD_DIVISAO) END COD_DIVISAO,
                  CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN 'Diversas'
                    ELSE MAX(nm_divisao_grupo) END nm_divisao_grupo,
                  MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                  max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                  max(num_conta) num_conta
								FROM
								  CONC_MOVIMENTO_EXTRACTO MOV_IN
								WHERE MOV_IN.AGRUPADOR = V_ANTIGO_AGRUPADOR)
			
				LOOP
		          UPDATE conc_movimento_extracto cme
		            SET cme.valor_grupo = abs(C_MOVS.soma),
		                cme.num_movimentos = C_MOVS.qtd,
		                CME.DESCRICAO_GRUPO = C_MOVS.descricao_movimento,
		                CME.DATA_GRUPO = C_MOVS.dt_movimento,
						CME.DATA_EXTRACTO_GRUPO = C_MOVS.dt_extracto,
		                CME.COD_DIVISAO_GRUPO = C_MOVS.cod_divisao,
		                CME.NM_DIVISAO_GRUPO = C_MOVS.nm_divisao_grupo,
		                CME.ID_TIPO_REG_GRUPO = C_MOVS.id_tipo_reg_grupo,
		                CME.TP_MOV_GRUPO = (CASE WHEN C_MOVS.soma > 0 THEN 'C' ELSE 'D' END),
		                CME.TIPO_REG_GRUPO = C_MOVS.tipo_reg_grupo,
		                CME.NUM_CONTA_GRUPO = C_MOVS.num_conta
		                ,DH_UPDT = CURRENT_TIMESTAMP
		                ,DSC_UTIL_UPDT = v_nm_user
		          WHERE CME.AGRUPADOR = V_ANTIGO_AGRUPADOR;
			
				END LOOP;
			END LOOP;
		END IF;
		
		IF (c_agrupadores%ISOPEN) THEN
	    	CLOSE c_agrupadores;
		END IF;

        -- Apagar os dados presentes na tabela de interface relativos a associacao processada.
        DELETE FROM CONC_ASSOC_DETALHE_INTERFACE CADI WHERE CADI.ID_UTILIZADOR = I_ID_UTILIZADOR AND CADI.AGRUPADOR = I_AGRUPADOR; 
      
   END IF;          
    
   END SP_CONC_GRAVA_ASSOC_DETALHE;
--
 /**
    * Actualiza os valores agrupados para o identificador de grupo fornecido
    * sobre a tabela de codigo correspondente a lista apresentada em baixo.
    * 1 - CONC_MOVIMENTO_SCCT
    * 2 - CONC_MOVIMENTO_EXTRACTO
    * 3 - CONC_MOVIMENTO_MPSIBS
    * 4 - CONC_MOVIMENTO_TPA_DETALHE
    * 5 - CONC_MOVIMENTO_CONCILIADO
    * 6 - CONC_MOV_MPSIBS_CONCILIADO
    * 7 - CONC_MOV_TPA_CONCILIADO
    * 8 - CONC_MOV_PRECONCILIADO
    * 9 - CONC_MOV_MPSIBS_PRECONCILIADO
    * 10 - CONC_MOV_TPA_PRECONCILIADO
    * EXCEPTIONS:
    * ARG_NULL - Argumentos Obrigatorios.
    * INVALID_TABLE_CODE - Tipo de Tabela a Actualizar invalido.
    */
   PROCEDURE SP_UPDT_AGRUPADORES_POS_CONC(
      I_TP_TABELA_AGRUPADOS   IN    NUMBER,
      I_AGRUPADOR    IN    NUMBER,
      V_NM_UTILIZADOR  IN DGV.DGV_USER.NM_USER%TYPE
   )
   IS
    ARG_NULL EXCEPTION;
    INVALID_TABLE_CODE EXCEPTION;
    contador NUMBER;
   BEGIN

    --actulizar campos NUM_TIPO_REG_SCCT e NUM_TIPO_REG_EXTRACTO

      update conc_movimento_conciliado set NUM_TIPO_REG_EXTRACTO = (
          SELECT COUNT(DISTINCT ID_TIPO_REG_GRUPO_EXTRACTO) NUM_TIPO_REG_EXTRACTO FROM CONC_MOVIMENTO_CONCILIADO WHERE AGRUPADOR = I_AGRUPADOR)
          ,DH_UPDT = CURRENT_TIMESTAMP
          ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
      where agrupador = i_agrupador;

        update conc_movimento_conciliado set NUM_TIPO_REG_SCCT = (
          SELECT COUNT(DISTINCT ID_TIPO_REG_GRUPO_SCCT) NUM_TIPO_REG_SCCT FROM CONC_MOVIMENTO_CONCILIADO WHERE AGRUPADOR = I_AGRUPADOR)
          ,DH_UPDT = CURRENT_TIMESTAMP
          ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
      where agrupador = i_agrupador;


      IF  I_TP_TABELA_AGRUPADOS IS NULL OR I_AGRUPADOR IS NULL THEN
        RAISE ARG_NULL;
      -- CONC_MOVIMENTO_SCCT
      ELSIF I_TP_TABELA_AGRUPADOS = 1 THEN


         FOR CURSOR1 IN (SELECT
                            DISTINCT MOV_SCCT.AGRUPADOR
                         FROM
                            CONC_MOVIMENTO_CONCILIADO MOV_CONC,
                            CONC_MOVIMENTO_SCCT MOV_SCCT
                         WHERE
                            MOV_CONC.AGRUPADOR = I_AGRUPADOR
                            AND MOV_SCCT.ID_MOV_SCCT = MOV_CONC.ID_MOV_SCCT)
            LOOP
               FOR c_scct IN (SELECT count(1) qtd, agrupador,
                                     SUM(CASE
                                          WHEN TIPO_OPERACAO = 'D' THEN
                                          VALOR * -1
                                        ELSE VALOR END
                                     ) soma,
                                     max(descricao_grupo) descricao_grupo,
                                     min(dt_movimento) dt_movimento,
                                     MIN(cod_divisao)cod_divisao,
                                     MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                     MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                                     max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                                     max(num_conta)num_conta
                                FROM CONC_MOVIMENTO_SCCT
                               WHERE id_estado IN (2,5)
                                 AND agrupador = cursor1.agrupador
                              GROUP BY agrupador)

               LOOP
                  UPDATE conc_movimento_scct cms
                     SET cms.num_movimentos = c_scct.qtd,
                         cms.valor_grupo = ABS(c_scct.soma),
                         cms.DESCRICAO_GRUPO = c_scct.descricao_grupo,
                         cms.DATA_GRUPO = c_scct.dt_movimento,
                         cms.COD_DIVISAO_GRUPO = c_scct.cod_divisao,
                         cms.NM_DIVISAO_GRUPO = c_scct.nm_divisao_grupo,
                         cms.ID_TIPO_REG_GRUPO = c_scct.id_tipo_reg_grupo,
                         cms.TP_MOV_GRUPO = (CASE WHEN c_scct.soma > 0 THEN 'C' ELSE 'D' END),
                         cms.TIPO_REG_GRUPO = c_scct.tipo_reg_grupo,
                         CMS.NUM_CONTA_GRUPO = C_SCCT.NUM_CONTA
                         ,CMS.DH_UPDT = CURRENT_TIMESTAMP
                         ,cms.DSC_UTIL_UPDT = V_NM_UTILIZADOR
                   WHERE cms.agrupador = cursor1.agrupador;
               END LOOP;

            END LOOP;

      -- CONC_MOVIMENTO_EXTRACTO
      ELSIF I_TP_TABELA_AGRUPADOS = 2 THEN

        FOR CURSOR1 IN (SELECT
                          DISTINCT MOV_BANCO.AGRUPADOR
                        FROM
                          CONC_MOVIMENTO_CONCILIADO MOV_CONC,
                          CONC_MOVIMENTO_EXTRACTO MOV_BANCO
                        WHERE
                          MOV_CONC.AGRUPADOR = I_AGRUPADOR
                          AND MOV_BANCO.ID_MOV_BANCO = MOV_CONC.ID_MOV_BANCO)
           LOOP

              FOR c_banco IN (SELECT
                                     SUM(CASE
                                          WHEN TIPO_OPERACAO = 'D' THEN
                                          MONTANTE * -1
                                        ELSE MONTANTE END
                                     ) soma,
                                     agrupador, count(1) qtd,
                                     max(descricao_movimento) descricao_movimento,
									 min(dt_movimento) dt_movimento,
                                     min(dt_extracto) dt_extracto,
                                     CASE
                                        WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
                                          NULL
                                        ELSE MIN(COD_DIVISAO) END COD_DIVISAO,
                                      CASE
                                        WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
                                          'Diversas'
                                        ELSE MAX(nm_divisao_grupo) END nm_divisao_grupo,
                                     MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                                     max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                                     max(num_conta)num_conta
                                FROM CONC_MOVIMENTO_EXTRACTO
                               WHERE id_estado IN (2,5)
                                 AND AGRUPADOR = CURSOR1.AGRUPADOR
                               GROUP BY agrupador)

              LOOP
                 UPDATE conc_movimento_extracto cme
                    SET cme.valor_grupo = abs(c_banco.soma),
                        cme.num_movimentos = c_banco.qtd,
                        CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
                        CME.DATA_GRUPO = c_banco.dt_movimento,
                        CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
                        CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
                        CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
                        CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
                        CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
                        CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
                        CME.NUM_CONTA_GRUPO = c_banco.num_conta
                        ,DH_UPDT = CURRENT_TIMESTAMP
                        ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
                  WHERE cme.agrupador = c_banco.agrupador;
              END LOOP;

           END LOOP;

      -- CONC_MOVIMENTO_MPSIBS
      ELSIF I_TP_TABELA_AGRUPADOS = 3 THEN

         FOR GRUPO_MPSIBS IN (SELECT
                                DISTINCT MPSIBS.AGRUPADOR AGRUPADOR
                              FROM
                                CONC_MOVIMENTO_CONCILIADO CONC,
                                CONC_MOVIMENTO_MPSIBS MPSIBS
                              WHERE
                                CONC.AGRUPADOR = I_AGRUPADOR AND
                                MPSIBS.ID_MOV_MPSIBS = CONC.ID_MOV_MPSIBS)
            LOOP
               FOR c_mpsibs IN (SELECT count(1) qtd, agrupador,
                                     SUM(MONTANTE) soma,
                                     min(DATA_NOTIFICACAO_SCCT) dt_notificacao,
									 min(DATA_MOVIMENTO) dt_movimento,
                                     MIN(COD_DIVISAO_GRUPO)cod_divisao,
                                     MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                     max(TP_MOV_GRUPO)TP_MOV_GRUPO,
                                     MAX(NUM_CONTA_GRUPO) NUM_CONTA
                                FROM CONC_MOVIMENTO_MPSIBS
                               WHERE id_estado IN (2,5)
                                 AND agrupador = grupo_mpsibs.agrupador
                              GROUP BY agrupador)

               LOOP
                  UPDATE CONC_MOVIMENTO_MPSIBS mov_msibs
                     SET mov_msibs.num_movimentos = c_mpsibs.qtd,
                         mov_msibs.valor_grupo = c_mpsibs.soma,
                         mov_msibs.DATA_GRUPO = c_mpsibs.dt_notificacao,
						 mov_msibs.DATA_MOV_GRUPO = c_mpsibs.dt_movimento,
                         mov_msibs.COD_DIVISAO_GRUPO = c_mpsibs.cod_divisao,
                         mov_msibs.NM_DIVISAO_GRUPO = c_mpsibs.nm_divisao_grupo
                         ,DH_UPDT = CURRENT_TIMESTAMP
                         ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
                   WHERE mov_msibs.agrupador = grupo_mpsibs.agrupador;
               END LOOP;

            END LOOP;

      -- CONC_MOVIMENTO_TPA_DETALHE
      ELSIF I_TP_TABELA_AGRUPADOS = 4 THEN

         FOR GRUPO_TPA IN (SELECT
                                DISTINCT TPA.AGRUPADOR AGRUPADOR
                              FROM
                                CONC_MOVIMENTO_CONCILIADO CONC,
                                CONC_MOVIMENTO_TPA_DETALHE TPA
                              WHERE
                                CONC.AGRUPADOR = I_AGRUPADOR
                                AND TPA.ID_MOV_TPA = CONC.ID_MOV_TPA)
            LOOP
               FOR C_TPA IN (SELECT COUNT(1) QTD, AGRUPADOR,
                                     SUM(CASE
                                          WHEN TIPO_OPERACAO = 'D' THEN
                                          MONTANTE * -1
                                        ELSE MONTANTE END
                                     ) soma,
                                     min(DT_VALOR) dt_valor,
									 min(DT_MOVIMENTO) dt_movimento,
                                     MIN(COD_DIVISAO_GRUPO)cod_divisao,
                                     MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                     MAX(NUM_CONTA_GRUPO) NUM_CONTA
                                FROM CONC_MOVIMENTO_TPA_DETALHE
                               WHERE id_estado IN (2,5)
                                 AND agrupador = GRUPO_TPA.agrupador
                              GROUP BY agrupador)

               LOOP
                  UPDATE CONC_MOVIMENTO_TPA_DETALHE mov_tpa
                     SET mov_tpa.num_movimentos = c_tpa.qtd,
                         mov_tpa.valor_grupo = abs(c_tpa.soma),
						 mov_tpa.tp_mov_grupo = (CASE WHEN c_tpa.soma > 0 THEN 'C' ELSE 'D' END),
                         mov_tpa.DATA_GRUPO = c_tpa.dt_valor,
						 mov_tpa.DATA_MOV_GRUPO = c_tpa.dt_movimento,
                         mov_tpa.COD_DIVISAO_GRUPO = c_tpa.cod_divisao,
                         mov_tpa.NM_DIVISAO_GRUPO = c_tpa.nm_divisao_grupo
                         ,DH_UPDT = CURRENT_TIMESTAMP
                         ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
                   WHERE mov_tpa.agrupador = GRUPO_TPA.agrupador;
               END LOOP;

            END LOOP;

      -- CONC_MOVIMENTO_CONCILIADO
      ELSIF I_TP_TABELA_AGRUPADOS = 5 THEN

		select count(1) into contador  from  conc_movimento_conciliado where  agrupador = i_agrupador  and id_mov_tpa is null and id_mov_mpsibs is null and id_mov_banco is not null;
		  IF contador > 0 THEN
			select distinct num_tipo_reg_extracto  into contador from conc_movimento_conciliado where agrupador = i_agrupador  and id_mov_tpa is null and id_mov_mpsibs is null and id_mov_banco is not null;
			END IF;
	-- se apenas existirem movimentos de extracto
	IF(contador = 1) THEN

		FOR GRUPO_EXTRACTO IN (
                SELECT SUM(
                            CASE
                              WHEN CME.TIPO_OPERACAO = 'D' THEN
                              CME.MONTANTE * -1
                            ELSE cme.montante END
                        ) montante,
                              max(cme.descricao_movimento) descricao_movimento,
                              min(cme.dt_extracto) dt_extracto,
                              CASE
                                WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                                  NULL
                                ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_GRUPO_EXTRACTO,
                              CASE
                                WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                                  'Diversas'
                                ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_extracto,
                              MAX(CME.ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                              max(CME.TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                              MAX(CME.NUM_CONTA)NUM_CONTA,
                              COUNT(1) NUM_MOVIMENTOS
                   FROM conc_movimento_extracto cme
                  WHERE cme.id_mov_banco IN (SELECT id_mov_banco
                                             FROM conc_movimento_conciliado cmc
                                            WHERE cmc.agrupador = i_agrupador and id_mov_banco is not null)
                --  and cme.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto
                )
		LOOP
			UPDATE conc_movimento_conciliado
              SET
				valor_grupo_extracto = abs(GRUPO_EXTRACTO.montante),
				descricao_grupo_extracto = GRUPO_EXTRACTO.descricao_movimento,
				data_grupo_extracto = GRUPO_EXTRACTO.dt_extracto,
				cod_divisao_grupo_extracto = GRUPO_EXTRACTO.COD_DIVISAO_GRUPO_EXTRACTO,
				nm_divisao_grupo_extracto = GRUPO_EXTRACTO.nm_divisao_grupo_extracto,
				id_tipo_reg_grupo_extracto = GRUPO_EXTRACTO.id_tipo_reg_grupo,
				tp_mov_grupo_extracto = (CASE WHEN GRUPO_EXTRACTO.montante > 0 THEN 'C' ELSE 'D' END),
				TIPO_REG_GRUPO_EXTRACTO = GRUPO_EXTRACTO.TIPO_REG_GRUPO,
				NUM_CONTA_GRUPO_EXTRACTO = GRUPO_EXTRACTO.NUM_CONTA,
				num_mov_grupo_extracto = GRUPO_EXTRACTO.NUM_MOVIMENTOS,
				dh_updt = CURRENT_TIMESTAMP,
				dsc_util_updt = V_NM_UTILIZADOR
              WHERE agrupador = i_agrupador;
             -- and id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto;

		END LOOP;


	ELSE
      for registos in (select distinct id_tipo_reg_grupo_extracto from conc_movimento_conciliado
                        where agrupador = i_agrupador  and id_mov_tpa is null and id_mov_mpsibs is null and id_mov_banco is not null)

      LOOP

		FOR GRUPO_EXTRACTO IN  (SELECT sum(
                      CASE
                        WHEN CME.TIPO_OPERACAO = 'D' THEN
                        CME.MONTANTE * -1
                      ELSE cme.montante END
                    ) montante,
                          max(cme.descricao_movimento) descricao_movimento,
                          min(cme.dt_extracto) dt_extracto,
                          CASE
                              WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                                NULL
                              ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_GRUPO_EXTRACTO,
                          CASE
                            WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                              'Diversas'
                            ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_EXTRACTO,
                          MAX(CME.ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                          max(CME.TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                          max(cme.num_conta)num_conta,
                          count(1) num_movimentos
               FROM conc_movimento_extracto cme
              WHERE cme.id_mov_banco IN (SELECT id_mov_banco
                                         FROM conc_movimento_conciliado cmc
                                        WHERE cmc.agrupador = i_agrupador and id_mov_banco is not null
                                        and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto) )
		LOOP

			UPDATE conc_movimento_conciliado
			  SET valor_grupo_extracto = abs(GRUPO_EXTRACTO.montante),
				descricao_grupo_extracto = GRUPO_EXTRACTO.descricao_movimento,
				data_grupo_extracto = GRUPO_EXTRACTO.dt_extracto,
				cod_divisao_grupo_extracto = GRUPO_EXTRACTO.COD_DIVISAO_GRUPO_EXTRACTO,
				nm_divisao_grupo_extracto = GRUPO_EXTRACTO.nm_divisao_grupo_EXTRACTO,
				id_tipo_reg_grupo_extracto = GRUPO_EXTRACTO.id_tipo_reg_grupo,
				tp_mov_grupo_extracto = (CASE WHEN GRUPO_EXTRACTO.montante > 0 THEN 'C' ELSE 'D' END),
				TIPO_REG_GRUPO_EXTRACTO = GRUPO_EXTRACTO.TIPO_REG_GRUPO,
				NUM_CONTA_GRUPO_EXTRACTO = GRUPO_EXTRACTO.num_conta,
				num_mov_grupo_extracto = GRUPO_EXTRACTO.num_movimentos,
				dh_updt = CURRENT_TIMESTAMP,
				dsc_util_updt = V_NM_UTILIZADOR

			  WHERE id_mov_banco IN (SELECT id_mov_banco
							  FROM conc_movimento_conciliado cmc
							 WHERE cmc.agrupador = i_agrupador and id_mov_banco is not null
							 and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto);

		END LOOP;

      END LOOP;



	END IF;


	--actualiza movimentos TPA

	--verifica se existem apenas movimentos de TPA  ou nao
    select count(1) into contador  from  conc_movimento_conciliado where agrupador = i_agrupador and id_mov_banco is null and id_mov_mpsibs is null and id_mov_tpa is not null;
    IF contador > 0 THEN
    	select distinct num_tipo_reg_extracto into contador from conc_movimento_conciliado where agrupador = i_agrupador and id_mov_banco is null and id_mov_mpsibs is null and id_mov_tpa is not null;
    END IF;


	-- se apenas existirem movimentos de extracto
	IF(contador = 1) THEN

		FOR GRUPO_TPA IN  (SELECT SUM (
							CASE
							  WHEN CME.TIPO_OPERACAO = 'D' THEN
							  CME.MONTANTE * -1
							ELSE cme.montante END
						) valor_grupo_extracto ,
					   'Multibanco' descricao_grupo_extracto,
						MIN (CME.DT_MOVIMENTO) DATA_GRUPO_EXTRACTO,
						CASE
							WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
							  NULL
							ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_grupo_extracto,
						CASE
						  WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
							'Diversas'
						  ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_extracto,
						3 id_tipo_reg_grupo_extracto,
						'TPA' tipo_reg_grupo_extracto,
						MAX (cme.num_conta_grupo) num_conta_grupo_extracto,
						COUNT (1) NUM_MOV_GRUPO_EXTRACTO,
						CURRENT_TIMESTAMP DH_UPDT,
						V_NM_UTILIZADOR DSC_UTIL_UPDT
				   FROM conc_movimento_tpa_detalhe cme
				  WHERE cme.id_mov_tpa IN (SELECT id_mov_tpa
											 FROM conc_movimento_conciliado cmc
											WHERE cmc.agrupador = i_agrupador and id_mov_tpa is not null))
		LOOP
		  UPDATE conc_movimento_conciliado
			SET valor_grupo_extracto = abs(GRUPO_TPA.valor_grupo_extracto),
				descricao_grupo_extracto = GRUPO_TPA.descricao_grupo_extracto,
				data_grupo_extracto = GRUPO_TPA.DATA_GRUPO_EXTRACTO,
				cod_divisao_grupo_extracto = GRUPO_TPA.COD_DIVISAO_GRUPO_EXTRACTO,
				nm_divisao_grupo_extracto = GRUPO_TPA.nm_divisao_grupo_EXTRACTO,
				id_tipo_reg_grupo_extracto = GRUPO_TPA.id_tipo_reg_grupo_extracto,
				tp_mov_grupo_extracto = (CASE WHEN GRUPO_TPA.valor_grupo_extracto > 0 THEN 'C' ELSE 'D' END),
				TIPO_REG_GRUPO_EXTRACTO = GRUPO_TPA.tipo_reg_grupo_extracto,
				NUM_CONTA_GRUPO_EXTRACTO = GRUPO_TPA.num_conta_grupo_extracto,
				num_mov_grupo_extracto = GRUPO_TPA.NUM_MOV_GRUPO_EXTRACTO,
				dh_updt = CURRENT_TIMESTAMP,
				dsc_util_updt = V_NM_UTILIZADOR
			  WHERE agrupador = i_agrupador;

		END LOOP;
	ELSE

      for registos in (select distinct id_tipo_reg_grupo_extracto from conc_movimento_conciliado
                        where agrupador = i_agrupador and id_mov_banco is null and id_mov_mpsibs is null and id_mov_tpa is not null)

      LOOP

		FOR GRUPO_TPA IN  (SELECT SUM (
							  CASE
								WHEN CME.TIPO_OPERACAO = 'D' THEN
								CME.MONTANTE * -1
							  ELSE cme.montante END
							) valor_grupo_extracto ,
						   'Multibanco' descricao_grupo_extracto,
							MIN (CME.DT_MOVIMENTO) DATA_GRUPO_EXTRACTO,
							CASE
								WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
								  NULL
								ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_GRUPO_EXTRACTO,
							CASE
							  WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
								'Diversas'
							  ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_extracto,
							3 id_tipo_reg_grupo_extracto,
							'TPA' tipo_reg_grupo_extracto,
							MAX (cme.num_conta_grupo) num_conta_grupo_extracto,
							COUNT (1) num_mov_grupo_extracto
					   FROM conc_movimento_tpa_detalhe cme
					  WHERE cme.id_mov_tpa IN (SELECT id_mov_tpa
												 FROM conc_movimento_conciliado cmc
												WHERE cmc.agrupador = i_agrupador and id_mov_tpa is not null
												 and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto))

			LOOP
			  UPDATE conc_movimento_conciliado

				SET valor_grupo_extracto = abs(GRUPO_TPA.valor_grupo_extracto),
				descricao_grupo_extracto = GRUPO_TPA.descricao_grupo_extracto,
				data_grupo_extracto = GRUPO_TPA.DATA_GRUPO_EXTRACTO,
				cod_divisao_grupo_extracto = GRUPO_TPA.COD_DIVISAO_GRUPO_EXTRACTO,
				nm_divisao_grupo_extracto = GRUPO_TPA.nm_divisao_grupo_EXTRACTO,
				id_tipo_reg_grupo_extracto = GRUPO_TPA.id_tipo_reg_grupo_extracto,
				tp_mov_grupo_extracto = (CASE WHEN GRUPO_TPA.valor_grupo_extracto > 0 THEN 'C' ELSE 'D' END),
				TIPO_REG_GRUPO_EXTRACTO = GRUPO_TPA.tipo_reg_grupo_extracto,
				NUM_CONTA_GRUPO_EXTRACTO = GRUPO_TPA.num_conta_grupo_extracto,
				num_mov_grupo_extracto = GRUPO_TPA.NUM_MOV_GRUPO_EXTRACTO,
				dh_updt = CURRENT_TIMESTAMP,
				dsc_util_updt = V_NM_UTILIZADOR

				WHERE id_mov_tpa IN (SELECT id_mov_tpa
								  FROM conc_movimento_conciliado cmc
								 WHERE cmc.agrupador = i_agrupador and id_mov_tpa is not null
								  and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto);

			END LOOP;
       END LOOP;

	END IF;

	--actualiza movimentos MPSIBS
      --verifica se existem apenas movimentos de MPSIBS ou n?o
    select count(1) into contador  from  conc_movimento_conciliado where agrupador = i_agrupador and id_mov_banco  is null and id_mov_tpa is null and id_mov_mpsibs is not null;
    IF contador > 0 THEN
	    select distinct num_tipo_reg_extracto into contador from conc_movimento_conciliado where agrupador = i_agrupador and id_mov_banco  is null and id_mov_tpa is null and id_mov_mpsibs is not null;
    END IF;

	-- se apenas existirem movimentos de extracto
	IF(contador = 1) THEN
	 UPDATE conc_movimento_conciliado
       SET (valor_grupo_extracto, descricao_grupo_extracto, data_grupo_extracto,
          cod_divisao_grupo_extracto, nm_divisao_grupo_extracto,
          id_tipo_reg_grupo_extracto, tp_mov_grupo_extracto,
          TIPO_REG_GRUPO_EXTRACTO, NUM_CONTA_GRUPO_EXTRACTO,
          num_mov_grupo_extracto,DH_UPDT,DSC_UTIL_UPDT) =
            (SELECT SUM (cme.montante) valor_grupo_extracto ,
                   'Ref. MB' descricao_grupo_extracto,
                    MIN (CME.DATA_MOVIMENTO) DATA_GRUPO_EXTRACTO,
                    CASE
                        WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                          NULL
                        ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_GRUPO_EXTRACTO,
                    CASE
                      WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                        'Diversas'
                      ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_EXTRACTO,
                    4 id_tipo_reg_grupo_extracto,
                    MAX (cme.tp_mov_grupo) tp_mov_grupo_extracto,
                    'Ref. MB' tipo_reg_grupo_extracto,
                    MAX (cme.num_conta_grupo) num_conta_grupo_extracto,
                    COUNT (1) num_mov_grupo_extracto,
                    CURRENT_TIMESTAMP DH_UPDT,
                    V_NM_UTILIZADOR DSC_UTIL_UPDT
               FROM CONC_MOVIMENTO_MPSIBS cme
              WHERE cme.id_mov_mpsibs IN (SELECT id_mov_mpsibs
                                         FROM conc_movimento_conciliado cmc
                                        WHERE cmc.agrupador = i_agrupador and id_mov_mpsibs is not null))
          WHERE agrupador = i_agrupador ;

	ELSE
      for registos in (select distinct id_tipo_reg_grupo_extracto from conc_movimento_conciliado
                        where agrupador = i_agrupador and id_mov_banco  is null and id_mov_tpa is null and id_mov_mpsibs is not null)

      LOOP
        UPDATE conc_movimento_conciliado
       SET (valor_grupo_extracto, descricao_grupo_extracto, data_grupo_extracto,
          cod_divisao_grupo_extracto, nm_divisao_grupo_extracto,
          id_tipo_reg_grupo_extracto, tp_mov_grupo_extracto,
          TIPO_REG_GRUPO_EXTRACTO, NUM_CONTA_GRUPO_EXTRACTO,
          num_mov_grupo_extracto,DH_UPDT,DSC_UTIL_UPDT) =
            (SELECT SUM (cme.montante) valor_grupo_extracto ,
                   'Ref. MB' descricao_grupo_extracto,
                    MIN (CME.DATA_MOVIMENTO) DATA_GRUPO_EXTRACTO,
                    CASE
                        WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                          NULL
                        ELSE MIN(CME.COD_DIVISAO) END COD_DIVISAO_GRUPO_EXTRACTO,
                    CASE
                      WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                        'Diversas'
                      ELSE MAX(cme.nm_divisao_grupo) END nm_divisao_grupo_extracto,
                    4 id_tipo_reg_grupo_extracto,
                    MAX (cme.tp_mov_grupo) tp_mov_grupo_extracto,
                    'Ref. MB' tipo_reg_grupo_extracto,
                    MAX (cme.num_conta_grupo) num_conta_grupo_extracto,
                    COUNT (1) num_mov_grupo_extracto,
                    CURRENT_TIMESTAMP DH_UPDT,
                    V_NM_UTILIZADOR DSC_UTIL_UPDT
               FROM CONC_MOVIMENTO_MPSIBS cme
              WHERE cme.id_mov_mpsibs IN (SELECT id_mov_mpsibs
                                         FROM conc_movimento_conciliado cmc
                                        WHERE cmc.agrupador = i_agrupador and id_mov_mpsibs is not null
                                         and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto))
          WHERE id_mov_mpsibs IN (SELECT id_mov_mpsibs
                          FROM conc_movimento_conciliado cmc
                         WHERE cmc.agrupador = i_agrupador and id_mov_mpsibs is not null
                          and cmc.id_tipo_reg_grupo_extracto = registos.id_tipo_reg_grupo_extracto);


      END LOOP;

	END IF;
        
        -- actualiza o conjunto de agrupadores correspondente ao scct.
        -- verifica se e o tipo de movimento e unico -- codigo possivel optimizar
        select count(distinct  cmscct.id_tipo_reg_grupo ) into contador from conc_movimento_scct cmscct ,  conc_movimento_conciliado cmc
                     where cmc.agrupador = i_agrupador
                       and cmc.id_mov_scct = cmscct.id_mov_scct;


         for c1 in (select sum(
                            CASE
                              WHEN CMSCCT.TIPO_OPERACAO = 'D' THEN
                              CMSCCT.VALOR * -1
                            ELSE CMSCCT.VALOR END
                          ) montante,
                          max(CMSCCT.DESCRICAO_grupo) descricao_movimento,
                          min(cmscct.dt_movimento) dt_movimento,
                          CASE
                              WHEN COUNT(DISTINCT CMSCCT.COD_DIVISAO) > 1 THEN
                                NULL
                              ELSE MIN(CMSCCT.COD_DIVISAO) END COD_DIVISAO,
                          CASE
                            WHEN COUNT(DISTINCT CMSCCT.COD_DIVISAO) > 1 THEN
                              'Diversas'
                            ELSE MAX(cmscct.nm_divisao_grupo) END nm_divisao_grupo,
                          id_tipo_reg_grupo,
                          max(cmscct.TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                          max(cmscct.num_conta)num_conta,
                          count(1) num_movimentos
                     from conc_movimento_scct cmscct,
                          conc_movimento_conciliado cmc
                     where cmc.agrupador = i_agrupador
                       and cmc.id_mov_scct = cmscct.id_mov_scct
					   GROUP BY id_tipo_reg_grupo )
        LOOP
           IF contador > 1 THEN
             UPDATE conc_movimento_conciliado
                set valor_grupo_scct = abs(c1.montante),
                    DESCRICAO_GRUPO_scct = C1.DESCRICAO_MOVIMENTO,
                    DATA_GRUPO_scct = C1.DT_MOVIMENTO,
                    COD_DIVISAO_GRUPO_scct = C1.COD_DIVISAO,
                    NM_DIVISAO_GRUPO_scct = C1.NM_DIVISAO_GRUPO,
                    TP_MOV_GRUPO_scct = (CASE WHEN c1.montante > 0 THEN 'C' ELSE 'D' END),
                    ID_TIPO_REG_GRUPO_scct = C1.id_TIPO_rEG_GRUPO,
                    TIPO_REG_GRUPO_scct = c1.tipo_reg_grupo,
                    NUM_CONTA_GRUPO_scct = C1.NUM_CONTA,
                    NUM_MOV_GRUPO_SCCT = c1.num_movimentos
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE AGRUPADOR = I_AGRUPADOR
              AND ID_TIPO_REG_GRUPO_SCCT = c1.id_tipo_reg_grupo;
          ELSE
            UPDATE conc_movimento_conciliado
                set valor_grupo_scct = abs(c1.montante),
                    DESCRICAO_GRUPO_scct = C1.DESCRICAO_MOVIMENTO,
                    DATA_GRUPO_scct = C1.DT_MOVIMENTO,
                    COD_DIVISAO_GRUPO_scct = C1.COD_DIVISAO,
                    NM_DIVISAO_GRUPO_scct = C1.NM_DIVISAO_GRUPO,
                    TP_MOV_GRUPO_scct = (CASE WHEN c1.montante > 0 THEN 'C' ELSE 'D' END),
                    ID_TIPO_REG_GRUPO_scct = C1.id_TIPO_rEG_GRUPO,
                    TIPO_REG_GRUPO_scct = c1.tipo_reg_grupo,
                    NUM_CONTA_GRUPO_scct = C1.NUM_CONTA,
                    NUM_MOV_GRUPO_SCCT = c1.num_movimentos
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE AGRUPADOR = I_AGRUPADOR;
          END IF;
        END LOOP;


    --actualizar campos NUM_TIPO_REG_SCCT e NUM_TIPO_REG_EXTRACTO

      update conc_movimento_conciliado set NUM_TIPO_REG_EXTRACTO = (
          SELECT COUNT(DISTINCT ID_TIPO_REG_GRUPO_EXTRACTO) NUM_TIPO_REG_EXTRACTO FROM CONC_MOVIMENTO_CONCILIADO WHERE AGRUPADOR = I_AGRUPADOR)
          ,DH_UPDT = CURRENT_TIMESTAMP
          ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
      where agrupador = i_agrupador;

        update conc_movimento_conciliado set NUM_TIPO_REG_SCCT = (
          SELECT COUNT(DISTINCT ID_TIPO_REG_GRUPO_SCCT) NUM_TIPO_REG_SCCT FROM CONC_MOVIMENTO_CONCILIADO WHERE AGRUPADOR = I_AGRUPADOR)
          ,DH_UPDT = CURRENT_TIMESTAMP
          ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
      where agrupador = i_agrupador;
  
      -- CONC_MOV_PRECONCILIADO
      ELSIF I_TP_TABELA_AGRUPADOS = 8 THEN

        -- a tabela de preconciliados nao necessita da actualizacao de agrupadores
        -- mas sim que sejam quebradas todas as preconciliacoes que contenham registos
        -- para qualquer um dos movimentos conciliados.

        -- apaga todos os grupos com movimentos envolvidos na conciliacao realizada.
        FOR C1 IN (SELECT
                      DISTINCT CMP.AGRUPADOR AGRUPADOR
                   FROM
                      CONC_MOVIMENTO_CONCILIADO CMC,
                      CONC_MOV_PRECONCILIADO CMP
                   WHERE
                      CMC.AGRUPADOR = I_AGRUPADOR
                      AND (CMP.ID_MOV_BANCO = CMC.ID_MOV_BANCO
                           OR CMP.ID_MOV_SCCT = CMC.ID_MOV_SCCT))
        LOOP
           DELETE FROM CONC_MOV_PRECONCILIADO WHERE AGRUPADOR = C1.AGRUPADOR;
        END LOOP;


      -- CONC_MOV_MPSIBS_PRECONCILIADO
      ELSIF I_TP_TABELA_AGRUPADOS = 9 THEN

        -- apaga todos os movimentos envolvidos na conciliacao realizada.
          FOR C1 IN (SELECT
                        DISTINCT CMMC.ID_MOV_MPSIBS
                     FROM
                        CONC_MOVIMENTO_CONCILIADO CMMC
                     WHERE
                        CMMC.AGRUPADOR = I_AGRUPADOR
                    )
          LOOP
             DELETE FROM CONC_MOV_MPSIBS_PRECONCILIADO WHERE ID_MOV_MPSIBS = C1.ID_MOV_MPSIBS;
          END LOOP;

      -- CONC_MOV_TPA_PRECONCILIADO
      ELSIF I_TP_TABELA_AGRUPADOS = 10 THEN

         -- a tabela de preconciliados nao necessita da actualizacao de agrupadores
          -- mas sim que sejam quebradas todas as preconciliacoes que contenham registos
          -- para qualquer um dos movimentos conciliados.

          -- apaga todos os movimentos envolvidos na conciliacao realizada.
          FOR C1 IN (SELECT
                        DISTINCT CMTC.ID_MOV_SCCT
                     FROM
                        CONC_MOVIMENTO_CONCILIADO CMTC
                     WHERE
                        CMTC.AGRUPADOR = I_AGRUPADOR
                    )
          LOOP
             DELETE FROM CONC_MOV_TPA_PRECONCILIADO WHERE ID_MOV_SCCT = C1.ID_MOV_SCCT;
          END LOOP;


      -- TIPO DE TABELA DESCONHECIDO
      ELSE
       RAISE INVALID_TABLE_CODE;
      END IF;


   END SP_UPDT_AGRUPADORES_POS_CONC;
--

   /**
    * PROCEDURE que grava na tabela de movimentos conciliados, os movimentos envolvidos
    * numa conciliacao.
    */

--
	PROCEDURE sp_conc_grava_conciliacao(

      i_agrupador          IN    NUMBER,
      i_id_utilizador      IN    NUMBER,
      i_val_intervalo      IN    NUMBER,
      cod_erro             OUT   NUMBER,
      O_MSG_RETORNO        OUT VARCHAR2
   )
   IS
      v_cod_divisao       CONC_MOVIMENTO_EXTRACTO.COD_DIVISAO%TYPE;
      V_ID_MOV_SCCT       NUMBER;
      V_ID_MOV_MPSIBS       NUMBER;
      v_montante_banco    CONC_MOVIMENTO_EXTRACTO.MONTANTE%TYPE;
      v_valor_scct        CONC_MOVIMENTO_SCCT.VALOR%TYPE;
      v_valor             NUMBER;
      v_val_intervalo     NUMBER;
      v_nm_user           DGV.DGV_USER.NM_USER%TYPE;
      v_reg_banco         CONC_MOVIMENTO_EXTRACTO%ROWTYPE;
      V_REG_SCCT          CONC_MOVIMENTO_SCCT%ROWTYPE;
      V_REG_MPSIBS        CONC_MOVIMENTO_MPSIBS%ROWTYPE;
      V_REG_TPA           CONC_MOVIMENTO_TPA_DETALHE%ROWTYPE;
      V_DATA_CONCILIACAO  DATE;
      V_ID_NOVO_ESTADO    NUMBER;
      V_REGULARIZACAO     BOOLEAN := FALSE;
	  V_ID_NOVO_ESTADO_TPA    	 NUMBER;
	  V_ID_NOVO_ESTADO_MPSIBS    NUMBER;
	  V_COUNT_MOV				 NUMBER;
	  V_COM_TRIANGULACAO		 NUMBER;
	  V_EXT_AGRUPADOR			 NUMBER;

   BEGIN

      -- obter o nome do utilizador que realizou a conciliacao.
      SELECT nm_user
        INTO v_nm_user
        FROM dgv.dgv_user
       WHERE id_user = i_id_utilizador;

     v_data_conciliacao := current_timestamp;

     IF(i_val_intervalo IS NULL)THEN
      v_val_intervalo := 0;
     ELSE
      v_val_intervalo := i_val_intervalo;
     END IF;

      -- obter o valor do conjunto de movimentos do lado do banco.
      SELECT
        SUM(VALOR) INTO v_montante_banco
      FROM (
        SELECT
           SUM(CASE
              WHEN CME.TIPO_OPERACAO = 'D' THEN
              CME.MONTANTE * -1
            ELSE cme.montante END) VALOR
        FROM
          CONC_MOVIMENTO_INTERFACE CMI,
          CONC_MOVIMENTO_EXTRACTO CME
        WHERE
          CMI.AGRUPADOR = I_AGRUPADOR AND
          CMI.ID_UTILIZADOR = I_ID_UTILIZADOR AND
          CMI.TP_MOV = 2 AND
          CME.ID_MOV_BANCO = CMI.ID_MOV
        UNION ALL
        SELECT
          sum(MPSIBS.MONTANTE) VALOR
        FROM
          CONC_MOVIMENTO_INTERFACE CMI,
          CONC_MOVIMENTO_MPSIBS MPSIBS
        WHERE
          CMI.AGRUPADOR = I_AGRUPADOR AND
          CMI.ID_UTILIZADOR = I_ID_UTILIZADOR AND
          CMI.TP_MOV = 4  AND
          MPSIBS.ID_MOV_MPSIBS = CMI.ID_MOV
        UNION ALL
        SELECT
           SUM(CASE
              WHEN TPA.TIPO_OPERACAO = 'D' THEN
              TPA.MONTANTE * -1
            ELSE TPA.montante END) VALOR
        FROM
          CONC_MOVIMENTO_INTERFACE CMI,
          CONC_MOVIMENTO_TPA_DETALHE TPA
        WHERE
          CMI.AGRUPADOR = I_AGRUPADOR AND
          CMI.ID_UTILIZADOR = I_ID_UTILIZADOR AND
          CMI.TP_MOV = 3 AND
          TPA.ID_MOV_TPA = CMI.ID_MOV
        );


      --obter soma dos valores relativos aos movimentos do scct
      SELECT sum(
              CASE
                WHEN CMS.TIPO_OPERACAO = 'D' THEN
                  CMS.VALOR * -1
              ELSE CMS.VALOR END
              ) INTO v_valor_scct
        FROM CONC_MOVIMENTO_SCCT cms
       WHERE cms.id_mov_scct IN (SELECT CMI.ID_MOV
                                   FROM CONC_MOVIMENTO_INTERFACE cmi
                                  WHERE CMI.AGRUPADOR = i_agrupador
                                    AND CMI.ID_UTILIZADOR = i_id_utilizador
                                    AND CMI.TP_MOV=1);

      -- tratar os valores a null de forma a que seja possivel conciliar movimentos de apenas
      -- um dos lados.
      V_VALOR_SCCT := NVL(V_VALOR_SCCT,0);
      V_MONTANTE_BANCO := NVL(V_MONTANTE_BANCO,0);

      v_valor := abs((v_montante_banco * 0.01) - (v_valor_scct * 0.01));

      IF(V_VALOR = V_VAL_INTERVALO)THEN
        V_REGULARIZACAO := FALSE;
        V_ID_NOVO_ESTADO := 4;
        COD_ERRO := 0;
      ELSIF( (V_VALOR >= 0) AND (V_VALOR <= V_VAL_INTERVALO) ) THEN
        V_REGULARIZACAO := TRUE;
        V_ID_NOVO_ESTADO := 5;
        COD_ERRO := 0;
      ELSE
        COD_ERRO := 1;
        O_MSG_RETORNO := 'O valor a conciliar tem uma diferenca de: banco: '||v_montante_banco||' scct: '||V_VALOR_SCCT || ' ----> agrupador: ' ||I_AGRUPADOR;
      END IF;


      IF COD_ERRO = 0 THEN

          BEGIN
            --obter a divisao a atribuir a registos do lado do banco que nao tenham o mesmo preenchido.
            SELECT COD_DIVISAO INTO V_COD_DIVISAO
            FROM CONC_MOVIMENTO_SCCT
            WHERE ID_MOV_SCCT = (SELECT MIN(CMI.ID_MOV)
                                 FROM CONC_MOVIMENTO_INTERFACE CMI
                                 WHERE CMI.TP_MOV = 1 AND CMI.AGRUPADOR = I_AGRUPADOR AND CMI.ID_UTILIZADOR = I_ID_UTILIZADOR);

          EXCEPTION
            -- se n encontrou a divisao marca a divisao como null.
            WHEN NO_DATA_FOUND THEN
              V_COD_DIVISAO := NULL;

          END;

          FOR cursor1 IN (SELECT *
                            FROM CONC_MOVIMENTO_INTERFACE cmi
                           WHERE cmi.agrupador = i_agrupador
                             AND CMI.ID_UTILIZADOR = I_ID_UTILIZADOR)

          LOOP

			 V_COM_TRIANGULACAO := 0;

             IF(CURSOR1.TP_MOV=2)THEN--extracto

				--quando existe conciliacao de movimentos de extracto podemos estar perante um conciliacao automatica com TRIANGULACAO
				--teremos que ter tratamentos especiais para esses casos
                  SELECT * INTO v_reg_banco
                   FROM conc_movimento_extracto
                  WHERE id_mov_banco = cursor1.id_mov;

				--nao considerar triangulacao nos TPAs, nao e possivel - nao faz sentido agrupar todos os movimentos num so grupo de conciliacao para os TPAs
				/*
                  --verifica se a conciliacao de extracto esta associada a movimentos TPA ( caso de Conciliação automática de TPA's) - TRIANGULACAO     
                  SELECT COUNT(1) INTO V_COUNT_MOV FROM conc_mov_tpa_preconciliado where id_mov_banco = cursor1.id_mov and id_utilizador = I_ID_UTILIZADOR;
					
				  --se existem movimentos na conc_mov_tpa_preconciliado esta a ser feita a triangulacao para TPA - e necessario actualizar os dados de detalhe TPA e extracto de forma especial
				  IF (V_COUNT_MOV > 0) THEN
					V_COM_TRIANGULACAO := 1;
					
					--se o grupo do banco tiver mais do que um movimento parte o grupo criando um novo agrupador
					--se o grupo do banco so tiver um movimento actualiza os dados do CONC_MOVIMENTO_TPA_DETALHE
					IF (v_reg_banco.NUM_MOVIMENTOS = 1) THEN
						
						--associacao do detalhe com o movimento de extracto em causa e respectivo agrupador
						--actualiza o estado do movimento de detalhe
		                UPDATE
		                    CONC_MOVIMENTO_TPA_DETALHE
		                SET
		                    ID_ESTADO = V_ID_NOVO_ESTADO 
							,ID_MOV_BANCO = v_reg_banco.id_mov_banco
							,AGRUPADOR_MOV_BANCO = v_reg_banco.agrupador
							,NM_UTILIZADOR_ASSOC = V_NM_USER
						  	,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
		                    ,DH_UPDT = CURRENT_TIMESTAMP
		                    ,DSC_UTIL_UPDT = V_NM_USER
		                WHERE
		                    ID_MOV_TPA IN (select distinct id_mov_tpa from conc_mov_tpa_preconciliado where id_mov_banco = cursor1.id_mov and id_utilizador = I_ID_UTILIZADOR);
					ELSE

						--como existe mais do que um movimento de extracto associado ao agrupador e necessario criar um novo agrupador para usar para o movimento de extracto
		   				select sq_id_movimento_associado.NEXTVAL INTO V_EXT_AGRUPADOR FROM DUAL;

						--associacao do detalhe com movimento de extracto em causa e novo agrupador
						UPDATE
		                    CONC_MOVIMENTO_TPA_DETALHE
		                  SET
		                    ID_ESTADO = V_ID_NOVO_ESTADO 
							,ID_MOV_BANCO = v_reg_banco.id_mov_banco
							,AGRUPADOR_MOV_BANCO = V_EXT_AGRUPADOR
							,NM_UTILIZADOR_ASSOC = V_NM_USER
						  	,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
		                    ,DH_UPDT = CURRENT_TIMESTAMP
		                    ,DSC_UTIL_UPDT = V_NM_USER
		                  WHERE
		                    ID_MOV_TPA IN (select distinct id_mov_tpa from conc_mov_tpa_preconciliado where id_mov_banco = cursor1.id_mov and id_utilizador = I_ID_UTILIZADOR);

						--e necessario actualizar os dados na tabela de movimentos de extracto para este id_mov_banco com o novo agrupador e os valores de grupo
						UPDATE CONC_MOVIMENTO_EXTRACTO MOV
						SET
							MOV.AGRUPADOR = V_EXT_AGRUPADOR,
							MOV.NUM_MOVIMENTOS = 1,
							MOV.valor_grupo = MOV.MONTANTE,
							MOV.TP_MOV_GRUPO = MOV.TIPO_OPERACAO,
							MOV.DESCRICAO_GRUPO = MOV.DESCRICAO_MOVIMENTO,
							MOV.DATA_GRUPO = MOV.DT_MOVIMENTO,
							MOV.DATA_EXTRACTO_GRUPO = MOV.DT_EXTRACTO,
							MOV.COD_DIVISAO_GRUPO = MOV.COD_DIVISAO,
							MOV.NM_DIVISAO_GRUPO = NULL,
							MOV.ID_TIPO_REG_GRUPO = 3,
							MOV.TIPO_REG_GRUPO = 'TPA',
							MOV.NUM_CONTA_GRUPO = NUM_CONTA,
							MOV.DSC_UTIL_UPDT = V_NM_USER,
							MOV.DH_UPDT = CURRENT_TIMESTAMP
						WHERE MOV.id_mov_banco = v_reg_banco.id_mov_banco;
	
						--e necessario actualizar o agrupador antigo que era usado pelo movimento de extracto
						FOR c_banco IN (SELECT
                                SUM(
                                   CASE WHEN ID_ESTADO = 2 THEN
                                   		CASE WHEN TIPO_OPERACAO = 'D' THEN
                                          MONTANTE * -1
                                        ELSE MONTANTE END
                                   ELSE 0 END
                                ) soma,
                                agrupador, 
								count(1) qtd,
                                max(descricao_movimento) descricao_movimento,
								min(dt_movimento) dt_movimento,
                                min(dt_extracto) dt_extracto,
                                CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
                                	NULL
                                ELSE MIN(COD_DIVISAO) END COD_DIVISAO,
                                CASE WHEN COUNT(DISTINCT COD_DIVISAO) > 1 THEN
                                    'Diversas'
                                ELSE MAX(nm_divisao_grupo) END nm_divisao_grupo,
                                MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                                max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                                max(num_conta)num_conta
                             FROM CONC_MOVIMENTO_EXTRACTO
                             WHERE id_estado IN (2,4)
                             AND AGRUPADOR = v_reg_banco.agrupador
                             GROUP BY agrupador)

			              LOOP
			                 UPDATE conc_movimento_extracto cme
			                    SET cme.valor_grupo = abs(c_banco.soma),
			                        cme.num_movimentos = c_banco.qtd,
			                        CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
			                        CME.DATA_GRUPO = c_banco.dt_movimento,
									CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
			                        CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
			                        CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
			                        CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
			                        CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
			                        CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
			                        CME.NUM_CONTA_GRUPO = c_banco.num_conta
			                        ,DH_UPDT = CURRENT_TIMESTAMP
			                        ,DSC_UTIL_UPDT = V_NM_USER
			                  WHERE cme.agrupador = v_reg_banco.agrupador;
			              END LOOP;
						
						--actualiza os dados da variavel que contem o movimento de extracto
						SELECT * INTO v_reg_banco
		                   FROM conc_movimento_extracto
		                  WHERE id_mov_banco = cursor1.id_mov;
					  END IF;
				  END IF;
					*/

					--a conciliacao de extracto pode estar associada a movimentos MPSIBS (caso de Conciliação automática de MPSIBS's) - TRIANGULACAO
          			--por isso tambem e actualizado o estado na detalhe MPSIBS
          			SELECT COUNT(1) INTO V_COUNT_MOV from conc_mov_mpsibs_preconciliado where agrupador_banco = v_reg_banco.agrupador and id_utilizador = I_ID_UTILIZADOR;
					
				  	--se existem movimentos na conc_mov_mpsibs_preconciliado esta a ser feita a triangulacao para MPSIBS
				  	IF (V_COUNT_MOV > 0) THEN
					  	V_COM_TRIANGULACAO := 1;
            
						-- actualizar agrupador do banco
	                  	UPDATE
	                    	CONC_MOVIMENTO_MPSIBS
	                  	SET
	                    	ID_ESTADO = V_ID_NOVO_ESTADO
							,NM_UTILIZADOR_ASSOC = V_NM_USER
							,DATA_ASSOCIACAO = CURRENT_TIMESTAMP
	                    	,DH_UPDT = CURRENT_TIMESTAMP
	                    	,DSC_UTIL_UPDT = V_NM_USER
	                  	WHERE
	                    	ID_MOV_MPSIBS IN (select distinct id_mov_mpsibs from conc_mov_mpsibs_preconciliado where agrupador_banco = v_reg_banco.agrupador and id_utilizador = I_ID_UTILIZADOR);
				  
            	END IF;

				 --alterar estado do movimento da conc_movimento_extracto e da FLAG detalhe se estiver a ser feita triangulacao (pela conciliacao automatica)
                UPDATE CONC_MOVIMENTO_EXTRACTO
                   SET ID_ESTADO = V_ID_NOVO_ESTADO
                      ,FL_COM_DETALHE = (CASE WHEN V_COM_TRIANGULACAO = 1 THEN 1 ELSE 0 END)
                      ,DH_UPDT = CURRENT_TIMESTAMP
                      ,DSC_UTIL_UPDT = V_NM_USER
                 WHERE id_mov_banco= cursor1.id_mov;
				  

                  INSERT INTO CONC_MOVIMENTO_CONCILIADO(id_mov_banco,
                                                            id_mov_scct,
                                                            agrupador,
                                                            id_tipo_estado_movimento,
                                                            dh_ins,
                                                            id_utilizador,
                                                            dt_conciliacao,
                                                            dsc_util_ins,
                                                            DESCRICAO_GRUPO_EXTRACTO,
                                                            DATA_GRUPO_EXTRACTO,
                                                            COD_DIVISAO_GRUPO_EXTRACTO,
                                                            NM_DIVISAO_GRUPO_EXTRACTO,
                                                            TP_MOV_GRUPO_EXTRACTO,
                                                            ID_TIPO_REG_GRUPO_EXTRACTO,
                                                            TIPO_REG_GRUPO_EXTRACTO,
                                                            NUM_CONTA_GRUPO_EXTRACTO,
                                                            VALOR_GRUPO_EXTRACTO,
                                                            NUM_MOV_GRUPO_EXTRACTO,
                                                            COD_DIVISAO_GRUPO_SCCT,
                                                            NM_USER,
                                                            DH_UPDT,
                                                            DSC_UTIL_UPDT
                                                            )
                 VALUES (cursor1.id_mov,
                         NULL,
                         cursor1.agrupador,
                          V_ID_NOVO_ESTADO,
                         sysdate,
                         i_id_utilizador,
                         v_data_conciliacao,
                         v_nm_user,
                         v_reg_banco.descricao_grupo,
                         v_reg_banco.data_extracto_grupo,
                         v_reg_banco.cod_divisao_grupo,
                         v_reg_banco.nm_divisao_grupo,
                         v_reg_banco.tp_mov_grupo,
                         v_reg_banco.id_tipo_reg_grupo,
                         v_reg_banco.tipo_reg_grupo,
                         v_reg_banco.num_conta_grupo,
                         v_reg_banco.valor_grupo,
                         V_REG_BANCO.NUM_MOVIMENTOS,
						 CASE WHEN v_reg_banco.cod_divisao_grupo is not null then v_reg_banco.cod_divisao_grupo else 0 end,
                         V_NM_USER,
                         SYSDATE,
                         V_NM_USER
                         );


                  --preencher o campo cod divisao da conc_movimento_extracto
                  UPDATE conc_movimento_extracto
                  SET COD_DIVISAO = V_COD_DIVISAO
                      ,DH_UPDT = CURRENT_TIMESTAMP
                      ,DSC_UTIL_UPDT = V_NM_USER
                  WHERE id_mov_banco = cursor1.id_mov AND (COD_DIVISAO IS NULL OR COD_DIVISAO = -1);

             ELSIF(cursor1.tp_mov=1) THEN--scct

                SELECT * INTO v_reg_scct
                   FROM conc_movimento_scct
                  WHERE id_mov_scct = cursor1.id_mov;


                INSERT INTO CONC_MOVIMENTO_CONCILIADO(id_mov_banco,
                                                           id_mov_scct,
                                                           agrupador,
                                                           id_tipo_estado_movimento,
                                                           dh_ins,
                                                           id_utilizador,
                                                           dt_conciliacao,
                                                           dsc_util_ins,
                                                           DESCRICAO_GRUPO_SCCT,
                                                           DATA_GRUPO_SCCT,
                                                           COD_DIVISAO_GRUPO_SCCT,
                                                           NM_DIVISAO_GRUPO_SCCT,
                                                           TP_MOV_GRUPO_SCCT,
                                                           ID_TIPO_REG_GRUPO_SCCT,
                                                           TIPO_REG_GRUPO_SCCT,
                                                           NUM_CONTA_GRUPO_SCCT,
                                                           VALOR_GRUPO_SCCT,
                                                           NUM_MOV_GRUPO_SCCT,
                                                           NM_USER,
                                                           DH_UPDT,
                                                           dsc_util_updt)
                VALUES (NULL,
                        cursor1.id_mov,
                        cursor1.agrupador,
                        V_ID_NOVO_ESTADO,
                        sysdate,
                        i_id_utilizador,
                        v_data_conciliacao,
                        v_nm_user,
                        v_reg_scct.descricao_grupo,
                        v_reg_scct.data_grupo,
                        v_reg_scct.cod_divisao_grupo,
                        v_reg_scct.nm_divisao_grupo,
                        v_reg_scct.tp_mov_grupo,
                        v_reg_scct.id_tipo_reg_grupo,
                        v_reg_scct.tipo_reg_grupo,
                        v_reg_scct.num_conta_grupo,
                        v_reg_scct.valor_grupo,
                        v_reg_scct.num_movimentos,
                        V_NM_USER,
                        SYSDATE,
                        v_nm_user);


                UPDATE CONC_MOVIMENTO_SCCT
                   SET ID_ESTADO = V_ID_NOVO_ESTADO
                       ,DH_UPDT = CURRENT_TIMESTAMP
                       ,DSC_UTIL_UPDT = V_NM_USER
                 WHERE id_mov_scct = cursor1.id_mov;


             --TPA
             ELSIF(cursor1.tp_mov=3) THEN

                SELECT * INTO V_REG_TPA
                FROM CONC_MOVIMENTO_TPA_DETALHE
                WHERE ID_MOV_TPA = cursor1.id_mov;

				-- se ja existir movimento do banco o estado sera movimento conciliado, senao sera parcialmente conciliado
				V_ID_NOVO_ESTADO_TPA := CASE WHEN V_REG_TPA.AGRUPADOR_MOV_BANCO is not null THEN V_ID_NOVO_ESTADO ELSE (CASE V_ID_NOVO_ESTADO WHEN 5 THEN 7 ELSE 6 END) END;

                INSERT INTO CONC_MOVIMENTO_CONCILIADO( id_mov_tpa,
                                                            id_mov_scct,
                                                            agrupador,
                                                            id_tipo_estado_movimento,
                                                            dh_ins,
                                                            id_utilizador,
                                                            dt_conciliacao,
                                                            dsc_util_ins,
                                                            DESCRICAO_GRUPO_EXTRACTO,
                                                            DATA_GRUPO_EXTRACTO,
                                                            COD_DIVISAO_GRUPO_EXTRACTO,
                                                            NM_DIVISAO_GRUPO_EXTRACTO,
                                                            TP_MOV_GRUPO_EXTRACTO,
                                                            ID_TIPO_REG_GRUPO_EXTRACTO,
                                                            TIPO_REG_GRUPO_EXTRACTO,
                                                            NUM_CONTA_GRUPO_EXTRACTO,
                                                            VALOR_GRUPO_EXTRACTO,
                                                            NUM_MOV_GRUPO_EXTRACTO,
                                                            NM_USER,
                                                            DH_UPDT,
                                                            dsc_util_updt
                                                              )
                VALUES (cursor1.id_mov,
                        NULL,
                        cursor1.agrupador,
                        V_ID_NOVO_ESTADO_TPA,
                        sysdate,
                        i_id_utilizador,
                        v_data_conciliacao,
                        V_NM_USER,
                        NULL,
                        V_REG_TPA.data_mov_grupo,
                        V_REG_TPA.cod_divisao_grupo,
                        V_REG_TPA.nm_divisao_grupo,
                        V_REG_TPA.tp_mov_grupo,
                        3,
                        'TPA',
                        V_REG_TPA.num_conta_grupo,
                        V_REG_TPA.valor_grupo,
                        V_REG_TPA.num_movimentos,
                        V_NM_USER,
                        SYSDATE,
                        v_nm_user);

                UPDATE CONC_MOVIMENTO_TPA_DETALHE
                   SET ID_ESTADO = V_ID_NOVO_ESTADO_TPA
						,COD_DIVISAO = (CASE WHEN (COD_DIVISAO IS NULL OR COD_DIVISAO = -1) THEN V_COD_DIVISAO ELSE COD_DIVISAO END)
                       ,DH_UPDT = CURRENT_TIMESTAMP
                       ,DSC_UTIL_UPDT = V_NM_USER
                 WHERE ID_MOV_TPA = CURSOR1.ID_MOV;

				
				--se o estado for 4 ou 5 e necessario validar se o movimento de extracto ja esta completamente conciliado
				--para isso e necessario que todos os movimentos com este id_mov_banco estejam no estado 4 ou 5
				IF (V_ID_NOVO_ESTADO_TPA = V_ID_NOVO_ESTADO) THEN 
						SELECT COUNT(1) INTO V_COUNT_MOV FROM CONC_MOVIMENTO_TPA_DETALHE WHERE AGRUPADOR_MOV_BANCO = V_REG_TPA.AGRUPADOR_MOV_BANCO AND ID_ESTADO <> 4 and ID_ESTADO <> 5;

						--actualiza o movimento de extracto
						--caso todos os movimentos de detalhe para este movimento do banco tenham ficado conciliados entao passa o estado do extracto para conciliado
						--senao devera estar parcialmente conciliado
						UPDATE CONC_MOVIMENTO_EXTRACTO
              			SET ID_ESTADO = CASE WHEN (V_COUNT_MOV = 0) THEN 4 ELSE 6 END
								   ,DH_UPDT = CURRENT_TIMESTAMP
			                       ,DSC_UTIL_UPDT = V_NM_USER
			            WHERE AGRUPADOR = V_REG_TPA.AGRUPADOR_MOV_BANCO;

				END IF;

             -- REF MB
             ELSIF(cursor1.tp_mov=4) THEN

                SELECT * INTO V_REG_MPSIBS
                FROM CONC_MOVIMENTO_MPSIBS
                WHERE ID_MOV_MPSIBS = cursor1.id_mov;

				-- se ja existir agrupador do banco o estado sera movimento conciliado, senao sera parcialmente conciliado
				V_ID_NOVO_ESTADO_MPSIBS := CASE WHEN V_REG_MPSIBS.agrupador_mov_banco is not null THEN V_ID_NOVO_ESTADO ELSE (CASE V_ID_NOVO_ESTADO WHEN 5 THEN 7 ELSE 6 END) END;

                INSERT INTO CONC_MOVIMENTO_CONCILIADO( id_mov_mpsibs,
                                                            id_mov_scct,
                                                            agrupador,
                                                            id_tipo_estado_movimento,
                                                            dh_ins,
                                                            id_utilizador,
                                                            dt_conciliacao,
                                                            dsc_util_ins,
                                                            DESCRICAO_GRUPO_EXTRACTO,
                                                            DATA_GRUPO_EXTRACTO,
                                                            COD_DIVISAO_GRUPO_EXTRACTO,
                                                            NM_DIVISAO_GRUPO_EXTRACTO,
                                                            TP_MOV_GRUPO_EXTRACTO,
                                                            ID_TIPO_REG_GRUPO_EXTRACTO,
                                                            TIPO_REG_GRUPO_EXTRACTO,
                                                            NUM_CONTA_GRUPO_EXTRACTO,
                                                            VALOR_GRUPO_EXTRACTO,
                                                            NUM_MOV_GRUPO_EXTRACTO,
                                                            NM_USER,
                                                            DH_UPDT,
                                                            dsc_util_updt
                                                            )
                    VALUES (cursor1.id_mov,
                        NULL,
                        cursor1.agrupador,
                        V_ID_NOVO_ESTADO_MPSIBS,
                        sysdate,
                        i_id_utilizador,
                        v_data_conciliacao,
                        V_NM_USER,
                        NULL,
                        V_REG_MPSIBS.data_mov_grupo, --vai introduzir o min data_movimento
                        V_REG_MPSIBS.cod_divisao_grupo,
                        V_REG_MPSIBS.nm_divisao_grupo,
                        V_REG_MPSIBS.tp_mov_grupo,
                        4,
                        'Ref. MB',
                        V_REG_MPSIBS.num_conta_grupo,
                        V_REG_MPSIBS.valor_grupo,
                        V_REG_MPSIBS.num_movimentos,
                        V_NM_USER,
                        SYSDATE,
                        v_nm_user);

                UPDATE CONC_MOVIMENTO_MPSIBS
                   SET ID_ESTADO = V_ID_NOVO_ESTADO_MPSIBS
						,COD_DIVISAO = (CASE WHEN (COD_DIVISAO IS NULL OR COD_DIVISAO = -1) THEN V_COD_DIVISAO ELSE COD_DIVISAO END)
                       ,DH_UPDT = CURRENT_TIMESTAMP
                       ,DSC_UTIL_UPDT = V_NM_USER
                 WHERE ID_MOV_MPSIBS = CURSOR1.ID_MOV;

				--se o estado for 4 ou 5 e necessario validar se o agrupador de movimento de extracto ja esta completamente conciliado
				--para isso e necessario que todos os movimentos com este agrupador estejam no estado 4 ou 5
				IF (V_ID_NOVO_ESTADO_MPSIBS = V_ID_NOVO_ESTADO) THEN

						SELECT COUNT(1) INTO V_COUNT_MOV FROM CONC_MOVIMENTO_MPSIBS WHERE agrupador_mov_banco = V_REG_MPSIBS.agrupador_mov_banco AND ID_ESTADO <> 4 and ID_ESTADO <> 5;

						--actualiza o movimento de extracto
						--caso todos os movimentos de detalhe para este agrupador do banco tenham ficado conciliados entao passa o estado do extracto para conciliado
						--senao devera estar parcialmente conciliado
						UPDATE CONC_MOVIMENTO_EXTRACTO
			                   SET ID_ESTADO = CASE WHEN (V_COUNT_MOV = 0) THEN 4 ELSE 6 END
									,DH_UPDT = CURRENT_TIMESTAMP
			                       ,DSC_UTIL_UPDT = V_NM_USER
			            WHERE agrupador = V_REG_MPSIBS.agrupador_mov_banco;
						
				END IF;

             END IF;

          END LOOP;

      END IF;

      -- limpar a tabela de interface.
      DELETE FROM CONC_MOVIMENTO_INTERFACE cmi
            WHERE CMI.ID_UTILIZADOR = i_id_utilizador
              AND CMI.AGRUPADOR = i_agrupador;

      -- actualiza os agrupadores do scct.
      SP_UPDT_AGRUPADORES_POS_CONC(1,I_AGRUPADOR,v_nm_user);
      -- actualiza os agrupadores do extracto.
      SP_UPDT_AGRUPADORES_POS_CONC(2,I_AGRUPADOR,v_nm_user);
      -- actualiza os agrupadores de conciliacao.
      SP_UPDT_AGRUPADORES_POS_CONC(5,I_AGRUPADOR,v_nm_user);
      -- actualiza a tabela de preconciliados.
      SP_UPDT_AGRUPADORES_POS_CONC(8,I_AGRUPADOR,v_nm_user);

      -- actualiza os agrupadores do mpsibs.
      SP_UPDT_AGRUPADORES_POS_CONC(3,I_AGRUPADOR,v_nm_user);
      -- Actualiza os agrupadores de conciliados do mpsibs.
    --  SP_UPDT_AGRUPADORES_POS_CONC(6,I_AGRUPADOR);
      -- Actualiza os agrupadores de pre conciliados do mpsibs.
      SP_UPDT_AGRUPADORES_POS_CONC(9,I_AGRUPADOR,v_nm_user);

      -- actualiza os agrupadores dos tpas
      SP_UPDT_AGRUPADORES_POS_CONC(4,I_AGRUPADOR,v_nm_user);
      -- actualiza os agrupadores de tpas conciliados.
   --   SP_UPDT_AGRUPADORES_POS_CONC(7,I_AGRUPADOR);
      -- Actualiza os agrupadores de tpas pre conciliados.
      SP_UPDT_AGRUPADORES_POS_CONC(10,I_AGRUPADOR,v_nm_user);

    EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            COD_ERRO := 2;
            O_MSG_RETORNO := 'Erro a executar o procedimento. Pelo um dos movimentos envolvidos já foi conciliado. '|| SQLERRM ;
         WHEN OTHERS THEN
            COD_ERRO := 10;
            O_MSG_RETORNO := 'Erro a executar o procedimento. '||SQLERRM ;

   END sp_conc_grava_conciliacao;
  --
/**
 *
 *
 */
   PROCEDURE sp_anula_conc_mov(
      I_AGRUPADOR    IN    NUMBER,
      I_ID_UTILIZADOR IN NUMBER,
      o_cod_erro     OUT   NUMBER--sucesso = 0
   )
   IS
      v_num_linhas         NUMBER;
	  v_por_conciliar	   NUMBER;
	  v_conciliados		   NUMBER;
      V_DESCRICAO_GRUPO    CONC_MOVIMENTO_SCCT.DESCRICAO_GRUPO%TYPE;
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      SELECT count(agrupador) INTO v_num_linhas
      FROM CONC_MOVIMENTO_CONCILIADO
      WHERE agrupador = i_agrupador;


      FOR c_movs IN (SELECT CMC.ID_MOV_BANCO,
                            CMC.ID_MOV_SCCT,
                            cmc.id_mov_tpa,
                            cmc.id_mov_mpsibs
                       FROM CONC_MOVIMENTO_CONCILIADO cmc
                      WHERE CMC.AGRUPADOR = i_agrupador)
      LOOP

        IF(c_movs.id_mov_banco IS NOT NULL)THEN

            UPDATE CONC_MOVIMENTO_EXTRACTO cme
               SET CME.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CME.ID_MOV_BANCO = c_movs.id_mov_banco;

            --este extracto pode ter detalhe tpa associado (conc. Automática) e por isso temos que actualizar o estado na conc_movimento_tpa_detalhe
             UPDATE conc_movimento_tpa_detalhe cme
               SET CME.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CME.ID_MOV_BANCO = c_movs.id_mov_banco;

			--este extracto pode ter detalhe mpsibs associado (conc. Automática) e por isso temos que actualizar o estado na CONC_MOVIMENTO_MPSIBS
			UPDATE CONC_MOVIMENTO_MPSIBS cms
               SET CMS.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CMS.AGRUPADOR_MOV_BANCO in (SELECT agrupador
                                                      FROM conc_movimento_extracto
                                                     WHERE ID_MOV_BANCO = c_movs.id_mov_banco);

        ELSIF(c_movs.id_mov_scct IS NOT NULL)THEN

            UPDATE CONC_MOVIMENTO_SCCT cms
               SET CMS.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CMS.ID_MOV_SCCT = c_movs.id_mov_scct;

        ELSIF(c_movs.id_mov_tpa IS NOT NULL)THEN

            UPDATE conc_movimento_tpa_detalhe cms
               SET CMS.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CMS.ID_MOV_tpa = c_movs.id_mov_tpa;

        ELSIF(c_movs.id_mov_mpsibs IS NOT NULL)THEN

            UPDATE CONC_MOVIMENTO_MPSIBS cms
               SET CMS.ID_ESTADO = 2
               ,DH_UPDT = CURRENT_TIMESTAMP
               ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
             WHERE CMS.ID_MOV_mpsibs = c_movs.id_mov_mpsibs;

        END IF;
      END LOOP;

      --actualizar agrupadores do extracto
      FOR c_agrup_banco IN (SELECT DISTINCT agrupador
                              FROM conc_movimento_extracto
                             WHERE id_mov_banco IN (SELECT distinct id_mov_banco
                                                      FROM conc_movimento_conciliado
                                                     WHERE agrupador = i_agrupador
                                                       AND id_mov_banco IS NOT NULL))
       LOOP

          FOR C_BANCO IN (SELECT
                                SUM(
                                    CASE WHEN ID_ESTADO = 2 THEN
                                      CASE
                                        WHEN TIPO_OPERACAO = 'D' THEN
                                        MONTANTE * -1
                                      ELSE MONTANTE END
                                    ELSE 0 END
                                 ) soma,
                                 agrupador, count(1) qtd,
                                 max(descricao_movimento) descricao_movimento,
                                 min(dt_movimento) dt_movimento,
								 min(dt_extracto) dt_extracto,
                                 MIN(cod_divisao)cod_divisao,
                                 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                                 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                                 max(num_conta)num_conta
                            FROM conc_movimento_extracto
                           WHERE AGRUPADOR = C_AGRUP_BANCO.AGRUPADOR
                                 AND ID_ESTADO IN (2,5)
                          GROUP BY agrupador)

          LOOP
             UPDATE conc_movimento_extracto cme
                SET cme.valor_grupo = ABS(c_banco.soma),
                    cme.num_movimentos = c_banco.qtd,
                    CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
                    CME.DATA_GRUPO = c_banco.dt_movimento,
					CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
                    CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
                    CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
                    CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
                    CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
                    CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
                    CME.NUM_CONTA_GRUPO = c_banco.num_conta
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE cme.agrupador = c_banco.agrupador;
          END LOOP;

       END LOOP;


      --actualizar agrupadores tpa_detalhe - valores do grupo, numero movimentos, codigo divisao do grupo, etc
      FOR c_agrup_tpa_det IN (SELECT DISTINCT agrupador
                              FROM conc_movimento_tpa_detalhe
                             WHERE id_mov_tpa IN (SELECT distinct id_mov_tpa
                                                      FROM conc_movimento_conciliado
                                                     WHERE agrupador = i_agrupador
                                                       AND id_mov_tpa IS NOT NULL))
       LOOP

          FOR C_TPA IN (SELECT  SUM(
                                  CASE WHEN ID_ESTADO = 2 THEN
                                    CASE
                                      WHEN TIPO_OPERACAO = 'D' THEN
                                      MONTANTE * -1
                                    ELSE MONTANTE END
                                  ELSE 0 END
                                 ) soma,
                                 agrupador, count(1) qtd,
                                 min(dt_valor) dt_valor,
								 min(dt_movimento) dt_movimento,
                                 MIN(cod_divisao)cod_divisao,
                                 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                 max(num_conta_GRUPO)num_conta
                            FROM conc_movimento_tpa_detalhe
                           WHERE AGRUPADOR = C_AGRUP_TPA_DET.AGRUPADOR
                                AND ID_ESTADO IN (2,5)
                          GROUP BY agrupador)

          LOOP
             UPDATE conc_movimento_tpa_detalhe cme
                SET cme.valor_grupo = ABS(c_tpa.soma),
                    cme.num_movimentos = c_tpa.qtd,
                    CME.DATA_GRUPO = c_tpa.dt_valor,
					CME.DATA_MOV_GRUPO = c_tpa.dt_movimento,
                    CME.COD_DIVISAO_GRUPO = c_tpa.cod_divisao,
                    CME.NM_DIVISAO_GRUPO = c_tpa.nm_divisao_grupo,
                    CME.TP_MOV_GRUPO = (CASE WHEN c_tpa.soma > 0 THEN 'C' ELSE 'D' END),
                    CME.NUM_CONTA_GRUPO = c_tpa.num_conta
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE cme.agrupador = c_tpa.agrupador;
          END LOOP;
       END LOOP;

		--verifica se os movimentos de TPA (Detalhe) envolvidos estavam associados a algum movimento de extracto - actualizar o estado do movimento de extracto
		FOR C_EXTRACTO IN (SELECT DISTINCT AGRUPADOR_MOV_BANCO FROM CONC_MOVIMENTO_TPA_DETALHE WHERE ID_MOV_TPA IN (SELECT distinct id_mov_tpa
                                                      FROM conc_movimento_conciliado
                                                     WHERE agrupador = i_agrupador
                                                       AND id_mov_tpa IS NOT NULL))
		LOOP

			select count(1) into v_conciliados from CONC_MOVIMENTO_TPA_DETALHE where agrupador_mov_banco = C_EXTRACTO.AGRUPADOR_MOV_BANCO and id_estado in (4,5);
			select count(1) into v_por_conciliar from CONC_MOVIMENTO_TPA_DETALHE where agrupador_mov_banco = C_EXTRACTO.AGRUPADOR_MOV_BANCO and id_estado not in (4,5);
			
			UPDATE 
	          CONC_MOVIMENTO_EXTRACTO CME
	        SET
			  CME.ID_ESTADO = (CASE WHEN v_conciliados > 0 THEN (CASE WHEN v_por_conciliar > 0 THEN 6 ELSE CME.ID_ESTADO END) ELSE 2 END), 
			  CME.DH_UPDT = CURRENT_TIMESTAMP,
			  CME.dsc_util_updt = V_NM_UTILIZADOR
			WHERE CME.AGRUPADOR = C_EXTRACTO.AGRUPADOR_MOV_BANCO;
		END LOOP;

      --actualizar agrupadores detalhe_mpsibs - valores do grupo, numero movimentos, codigo divisao do grupo, etc
      FOR C_AGRUP_MPSIBS IN (SELECT
                                DISTINCT MOV_MPSIBS.AGRUPADOR
                              FROM
                                CONC_MOVIMENTO_CONCILIADO MOV_CONC,
                                CONC_MOVIMENTO_MPSIBS MOV_MPSIBS
                             WHERE
                                MOV_CONC.AGRUPADOR = I_AGRUPADOR
                                AND MOV_MPSIBS.ID_MOV_MPSIBS = MOV_CONC.ID_MOV_MPSIBS)
       LOOP

          FOR C_MPSIBS IN (SELECT
                                 SUM(
                                    CASE WHEN ID_ESTADO = 2 THEN
                                      MONTANTE
                                    ELSE 0 END
                                 ) soma,
                                 AGRUPADOR, COUNT(1) QTD,
                                 min(DATA_NOTIFICACAO_SCCT) dt_notificacao,
								 min(DATA_MOVIMENTO) dt_movimento,
                                 MIN(cod_divisao)cod_divisao,
                                 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                 min(TP_MOV_GRUPO)TP_MOV_GRUPO,
                                 MAX(NUM_CONTA_GRUPO)NUM_CONTA
                            FROM conc_movimento_mpsibs
                           WHERE AGRUPADOR = C_AGRUP_MPSIBS.AGRUPADOR
                            AND ID_ESTADO IN (2,5)
                          GROUP BY AGRUPADOR)

          LOOP
             UPDATE CONC_MOVIMENTO_MPSIBS cme
                SET cme.valor_grupo = C_MPSIBS.soma,
                    cme.num_movimentos = C_MPSIBS.qtd,
                    CME.DATA_GRUPO = C_MPSIBS.dt_notificacao,
					CME.DATA_MOV_GRUPO = C_MPSIBS.dt_movimento,
                    CME.COD_DIVISAO_GRUPO = C_MPSIBS.cod_divisao,
                    CME.NM_DIVISAO_GRUPO = C_MPSIBS.nm_divisao_grupo,
                    CME.TP_MOV_GRUPO = C_MPSIBS.tp_mov_grupo,
                    CME.NUM_CONTA_GRUPO = C_MPSIBS.num_conta
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE cme.agrupador = C_MPSIBS.agrupador;
          END LOOP;

       END LOOP;

		--verifica se os movimentos de MPSIBS (detalhe) envolvidos estavam associados a algum movimento de extracto - actualizar o estado do movimento de extracto
		FOR C_EXTRACTO IN (SELECT DISTINCT AGRUPADOR_MOV_BANCO FROM CONC_MOVIMENTO_MPSIBS WHERE ID_MOV_MPSIBS IN (SELECT distinct ID_MOV_MPSIBS
                                                      FROM conc_movimento_conciliado
                                                     WHERE agrupador = i_agrupador
                                                       AND ID_MOV_MPSIBS IS NOT NULL))
		LOOP

			select count(1) into v_conciliados from CONC_MOVIMENTO_MPSIBS where agrupador_mov_banco = C_EXTRACTO.AGRUPADOR_MOV_BANCO and id_estado in (4,5);
			select count(1) into v_por_conciliar from CONC_MOVIMENTO_MPSIBS where agrupador_mov_banco = C_EXTRACTO.AGRUPADOR_MOV_BANCO and id_estado not in (4,5);
			
			UPDATE 
	          CONC_MOVIMENTO_EXTRACTO CME
	        SET
			  CME.ID_ESTADO = (CASE WHEN v_conciliados > 0 THEN (CASE WHEN v_por_conciliar > 0 THEN 6 ELSE CME.ID_ESTADO END) ELSE 2 END), 
			  CME.DH_UPDT = CURRENT_TIMESTAMP,
			  CME.dsc_util_updt = V_NM_UTILIZADOR
			WHERE CME.AGRUPADOR = C_EXTRACTO.AGRUPADOR_MOV_BANCO;
		END LOOP;


       --actualizar agrupadores do scct
      FOR c_agrup_scct IN (SELECT DISTINCT agrupador
                              FROM conc_movimento_scct
                             WHERE id_mov_scct IN (SELECT distinct id_mov_scct
                                                      FROM conc_movimento_conciliado
                                                     WHERE agrupador = i_agrupador
                                                       AND id_mov_scct IS NOT NULL))
       LOOP

          FOR c_scct IN (SELECT  SUM(
                                    CASE WHEN ID_ESTADO = 2 THEN
                                      CASE
                                        WHEN TIPO_OPERACAO = 'D' THEN
                                        VALOR * -1
                                      ELSE VALOR END
                                    ELSE 0 END
                                 ) soma,
                                 agrupador, count(1) qtd,
                                 max(descricao) descricao_movimento,
                                 min(dt_movimento) dt_movimento,
                                 MIN(cod_divisao)cod_divisao,
                                 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
                                 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
                                 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
                                 max(num_conta)num_conta
                            FROM conc_movimento_scct
                           WHERE AGRUPADOR = C_AGRUP_SCCT.AGRUPADOR
                            AND ID_ESTADO IN (2,5)
                          GROUP BY agrupador)


          LOOP

             v_descricao_grupo := sp_obtem_descricao_grupo(c_scct.id_tipo_reg_grupo,c_scct.agrupador);

             UPDATE conc_movimento_scct cms
                SET cms.valor_grupo = ABS(c_scct.soma),
                    cms.num_movimentos = c_scct.qtd,
                    cms.descricao_grupo = v_descricao_grupo,
                    cms.DATA_GRUPO = c_scct.dt_movimento,
                    cms.COD_DIVISAO_GRUPO = c_scct.cod_divisao,
                    cms.NM_DIVISAO_GRUPO = c_scct.nm_divisao_grupo,
                    cms.ID_TIPO_REG_GRUPO = c_scct.id_tipo_reg_grupo,
                    cms.TP_MOV_GRUPO = (CASE WHEN c_scct.soma > 0 THEN 'C' ELSE 'D' END),
                    cms.TIPO_REG_GRUPO = c_scct.tipo_reg_grupo,
                    cms.NUM_CONTA_GRUPO = c_scct.num_conta
                    ,DH_UPDT = CURRENT_TIMESTAMP
                    ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
              WHERE cms.agrupador = c_scct.agrupador;
          END LOOP;

       END LOOP;


      DELETE FROM CONC_MOVIMENTO_CONCILIADO cmc
       WHERE CMC.AGRUPADOR = i_agrupador;

       IF(SQL%ROWCOUNT != v_num_linhas)THEN
         o_cod_erro := 1;
       ELSE
         o_cod_erro := 0;
        END IF;

   END sp_anula_conc_mov;

---

   /**
    * i_tipo_registo:
    * 1 - normal
    * 2 - sigi (altera coluna de descricao grupo no scct)
    */
   PROCEDURE sp_actualiza_val_agrupadores(
      i_id_utilizador    NUMBER,
      i_tipo_registo     NUMBER
   )
   IS
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;


      FOR c1 in( SELECT DISTINCT agrupador
                   FROM conc_mov_preconciliado
                  WHERE id_utilizador = i_id_utilizador)

      LOOP


         FOR c_banco IN (SELECT SUM(CASE
                                        WHEN cme.TIPO_OPERACAO = 'D' THEN
                                        cme.montante * -1
                                      ELSE cme.montante END) montante,
                                MAX(cme.descricao_movimento) descricao_movimento,
                                MIN(CME.DT_EXTRACTO) DT_MOVIMENTO,
                                CASE
                                  WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 AND i_tipo_registo IS NOT NULL THEN
                                    NULL
                                 ELSE DECODE(i_tipo_registo, NULL, NULL, i_tipo_registo, MIN(cme.cod_divisao)) END COD_DIVISAO,
                                 CASE
                                  WHEN COUNT(DISTINCT CME.COD_DIVISAO) > 1 THEN
                                    'Diversas'
                                  ELSE MAX(CME.NM_DIVISAO_GRUPO) END NM_DIVISAO_GRUPO,
                                MAX(cme.id_tipo_reg_grupo) id_tipo_reg_grupo,
                                MAX(cme.tipo_reg_grupo) tipo_reg_grupo,
                                MAX(cme.num_conta) num_conta,
                                count(cme.id_mov_banco) num_movimentos,
                                max(cme.id_mov_banco)
                           FROM CONC_MOVIMENTO_EXTRACTO CME
                          WHERE cme.id_mov_banco in (select distinct id_mov_banco from conc_mov_preconciliado cmp where cmp.agrupador = c1.agrupador AND cmp.id_utilizador = i_id_utilizador))


         LOOP

            UPDATE conc_mov_preconciliado
            SET valor_grupo_extracto = abs(c_banco.montante),
                DESCRICAO_GRUPO_EXTRACTO = c_banco.DESCRICAO_MOVIMENTO,
                DATA_GRUPO_EXTRACTO = c_banco.DT_MOVIMENTO,
                COD_DIVISAO_GRUPO_EXTRACTO = c_banco.COD_DIVISAO,
                NM_DIVISAO_GRUPO_EXTRACTO = c_banco.NM_DIVISAO_GRUPO,
                TP_MOV_GRUPO_EXTRACTO = (CASE WHEN c_banco.montante > 0 THEN 'C' ELSE 'D' END),
                ID_TIPO_REG_GRUPO_EXTRACTO = c_banco.id_TIPO_rEG_GRUPO,
                TIPO_REG_GRUPO_EXTRACTO = c_banco.tipo_reg_grupo,
                NUM_CONTA_GRUPO_EXTRACTO = c_banco.NUM_CONTA,
                NUM_MOV_GRUPO_EXTRACTO = C_BANCO.NUM_MOVIMENTOS
                ,DH_UPDT = CURRENT_TIMESTAMP
                ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE agrupador = c1.agrupador AND id_utilizador = i_id_utilizador;


         END LOOP;


         FOR C_SCCT IN (SELECT SUM(CASE
                                        WHEN CMS.TIPO_OPERACAO = 'D' THEN
                                        CMS.VALOR * -1
                                      ELSE CMS.VALOR END) MONTANTE,
                              CASE WHEN I_TIPO_REGISTO = 2 THEN
                                MAX(CMS.REFERENCIA_DIVIDA)
                              ELSE
                               MAX(CMS.DESCRICAO_GRUPO) END DESCRICAO_GRUPO,
                               MIN(cms.dt_movimento) dt_movimento,
                               CASE
                                WHEN COUNT(DISTINCT CMS.COD_DIVISAO) > 1 THEN
                                  NULL
                               ELSE MIN(CMS.COD_DIVISAO) END COD_DIVISAO,
                               CASE
                                WHEN COUNT(DISTINCT CMS.COD_DIVISAO) > 1 THEN
                                  'Diversas'
                                ELSE MAX(cms.nm_divisao_grupo) END nm_divisao_grupo,
                               MAX(cms.id_tipo_reg_grupo) id_tipo_reg_grupo,
                               MAX(cms.tipo_reg_grupo) tipo_reg_grupo,
                               MAX(cms.num_conta) num_conta,
                               count(distinct cmp.id_mov_scct) num_movimentos
                          FROM CONC_MOVIMENTO_SCCT CMS,
                               (select distinct id_mov_scct from conc_mov_preconciliado t where t.agrupador = c1.agrupador  AND t.id_utilizador = i_id_utilizador) cmp
                         WHERE
                            cmp.id_mov_scct = cms.id_mov_scct)
         LOOP

            UPDATE conc_mov_preconciliado
            SET valor_grupo_SCCT = abs(c_scct.montante),
                DESCRICAO_GRUPO_SCCT = c_scct.DESCRICAO_grupo,
                DATA_GRUPO_SCCT = c_scct.DT_MOVIMENTO,
                COD_DIVISAO_GRUPO_SCCT = c_scct.COD_DIVISAO,
                NM_DIVISAO_GRUPO_SCCT = c_scct.NM_DIVISAO_GRUPO,
                TP_MOV_GRUPO_SCCT = (CASE WHEN c_scct.montante > 0 THEN 'C' ELSE 'D' END),
                ID_TIPO_REG_GRUPO_SCCT = c_scct.id_TIPO_rEG_GRUPO,
                TIPO_REG_GRUPO_SCCT = c_scct.tipo_reg_grupo,
                NUM_CONTA_GRUPO_SCCT = c_scct.NUM_CONTA,
                NUM_MOV_GRUPO_SCCT = C_SCCT.NUM_MOVIMENTOS
                ,DH_UPDT = CURRENT_TIMESTAMP
                ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE agrupador = c1.agrupador AND id_utilizador = i_id_utilizador;


         END LOOP;


       END LOOP;

   END  sp_actualiza_val_agrupadores;

--

   /**
    *Calcula os agrupadores e numero de movimentos dos registos de REF MB do extracto e actualiza os registos com esses valores.
    */
   PROCEDURE sp_trata_agrup_refmb_extracto(I_ID_UTILIZADOR IN NUMBER)

   IS
      V_AGRUPADOR    NUMBER;
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      SELECT sq_id_movimento_associado.NEXTVAL INTO v_agrupador
        FROM dual;

      FOR c_regs IN(SELECT id_mov_banco,
                           SUM(montante) over (partition by dt_movimento) montante,
                           dt_movimento,
                           to_number(v_agrupador||to_char(dt_movimento, 'yyyymmdd')) agrupador
                      FROM conc_movimento_extracto
                     WHERE tipo_registo = 4
                       AND origem_ficheiro = 'CGD'
                       AND agrupador IS NULL
                    ORDER BY dt_movimento ASC)
      LOOP

         UPDATE conc_movimento_extracto
            SET agrupador = c_regs.agrupador
            ,DH_UPDT = CURRENT_TIMESTAMP
            ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE id_mov_banco = c_regs.id_mov_banco;

      END LOOP;


	-- executa o count do n.º de registos e a soma do total destes
      FOR c_regs IN (SELECT SUM(
                              CASE
                                  WHEN TIPO_OPERACAO = 'D' THEN
                                  MONTANTE * -1
                                ELSE MONTANTE END
                             ) SOMA,
							count(agrupador) qtd,
							agrupador
                       FROM conc_movimento_extracto
                      WHERE tipo_registo = 4
                     GROUP BY agrupador)
      LOOP

         UPDATE conc_movimento_extracto
            SET
			 VALOR_GRUPO = ABS(C_REGS.SOMA),
			 NUM_MOVIMENTOS  = C_REGS.QTD,
			 TP_MOV_GRUPO = (CASE WHEN C_REGS.soma > 0 THEN 'C' ELSE 'D' END)
			,DH_UPDT = CURRENT_TIMESTAMP
            ,DSC_UTIL_UPDT = V_NM_UTILIZADOR
          WHERE agrupador = c_regs.agrupador;

      END LOOP;
   END sp_trata_agrup_refmb_extracto;

--
	/**
	 * Procedure auxiliar para actualizar um movimento de MPSIBS detalhe com a associacao com o agrupador de extracto seleccionado
	 */
	PROCEDURE sp_actualiza_mpsibs_assoc(I_ID_MOV_MPSIBS NUMBER,
		I_AGRUPADOR_BANCO NUMBER,
		I_NUM_CONTA_EXTRACTO NUMBER,
		I_NM_UTILIZADOR VARCHAR)

	IS
		V_COUNT_MOV_POR_CONCILIAR	NUMBER;
		V_COUNT_MOV_CONCILIADO		NUMBER;
	BEGIN
		
		UPDATE conc_movimento_mpsibs
               SET agrupador_mov_banco = I_AGRUPADOR_BANCO,
                   agrupador = I_AGRUPADOR_BANCO,
                   ID_ESTADO = (CASE ID_ESTADO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE ID_ESTADO END),
                   NM_UTILIZADOR_ASSOC = I_NM_UTILIZADOR,
                   DATA_ASSOCIACAO = CURRENT_TIMESTAMP,
                   num_conta_grupo = I_NUM_CONTA_EXTRACTO
                   ,DH_UPDT = CURRENT_TIMESTAMP
                   ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
             WHERE id_mov_mpsibs = I_ID_MOV_MPSIBS
               AND agrupador_mov_banco IS NULL;

		--se existem movimentos do SCCT ja associados ao movimento TPA e necessario alterar tambem o estado na tabela de conciliados
		--se ja estava conciliado parcialmente agora ficou completamente conciliado
		UPDATE 
			CONC_MOVIMENTO_CONCILIADO CMC
		SET
			CMC.ID_TIPO_ESTADO_MOVIMENTO = (CASE CMC.ID_TIPO_ESTADO_MOVIMENTO WHEN 6 THEN 4 WHEN 7 THEN 5 ELSE CMC.ID_TIPO_ESTADO_MOVIMENTO END),
			CMC.DH_UPDT = CURRENT_TIMESTAMP,
		  	CMC.dsc_util_updt = I_NM_UTILIZADOR
		WHERE
			CMC.ID_MOV_MPSIBS = I_ID_MOV_MPSIBS;

	END sp_actualiza_mpsibs_assoc;

--
	/**
	 * Procedure auxiliar para actualizar os movimentos de extracto MPSIBSque foram associados a detalhes
	 */
	PROCEDURE sp_actualiza_ext_mpsibs_assoc(
		I_AGRUPADOR_BANCO NUMBER,
		I_NM_UTILIZADOR VARCHAR)

	IS
		V_COUNT_MOV_POR_CONCILIAR	NUMBER;
		V_COUNT_MOV_CONCILIADO		NUMBER;
	BEGIN
		
		--verifica se todos os movimentos referencia MB deste grupo ja estao conciliados com SCCT
		SELECT COUNT(1) INTO V_COUNT_MOV_POR_CONCILIAR FROM conc_movimento_mpsibs WHERE AGRUPADOR_MOV_BANCO = I_AGRUPADOR_BANCO
						AND ID_MOV_MPSIBS NOT IN (SELECT CMC.ID_MOV_MPSIBS FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_MPSIBS = ID_MOV_MPSIBS);

		--verifica se algum dos movimentos ja esta conciliado
		SELECT COUNT(1) INTO V_COUNT_MOV_CONCILIADO FROM conc_movimento_mpsibs WHERE AGRUPADOR_MOV_BANCO = I_AGRUPADOR_BANCO
						AND ID_MOV_MPSIBS IN (SELECT CMC.ID_MOV_MPSIBS FROM CONC_MOVIMENTO_CONCILIADO CMC WHERE CMC.ID_MOV_MPSIBS = ID_MOV_MPSIBS);
			
		--update do extracto - passa a ter detalhe associado -> FL_COM_DETALHE, num novo agrupador e a revisao dos dados do grupo
		UPDATE CONC_MOVIMENTO_EXTRACTO MOV
		SET
				MOV.ID_ESTADO = CASE WHEN V_COUNT_MOV_POR_CONCILIAR > 0 THEN (CASE WHEN V_COUNT_MOV_CONCILIADO > 0 THEN 6 ELSE MOV.ID_ESTADO END) ELSE 4 END,
		        MOV.FL_COM_DETALHE = 1,
		        MOV.DSC_UTIL_UPDT = I_NM_UTILIZADOR,
		        MOV.DH_UPDT = CURRENT_TIMESTAMP
		WHERE MOV.agrupador = I_AGRUPADOR_BANCO;

	END sp_actualiza_ext_mpsibs_assoc;

--
     /**
    *Atribui aos movimentos da tabela conc_movimento_mpsibs o registo do extracto respectivo
    */
   PROCEDURE sp_trata_mpsibs_detalhe(I_ID_UTILIZADOR IN NUMBER)

   IS
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
	  agrupadores_actualizar	TP_SYNC_TAB_UPDT_GROUP := TP_SYNC_TAB_UPDT_GROUP();
   BEGIN

       SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;


       ---classificacao inicial
	   --data do movimento e calculada com base na data indicada no ficheiro - em principio, representa a data em que o pagamento entrou na conta
       UPDATE conc_movimento_mpsibs
          SET agrupador = id_mov_mpsibs,
			  descricao_grupo = entidade,
              data_grupo = data_notificacao_scct,
              valor_grupo = montante,
              num_movimentos = 1,
              id_estado = 2,
              tp_mov_grupo = 'C',
			  data_movimento = TO_DATE(   SUBSTR(filename, 7, 2)|| '-'|| SUBSTR(filename, 5, 2)|| '-'|| SUBSTR(filename, 0, 4),'DD-MM-YYYY'),
			  data_mov_grupo = TO_DATE(   SUBSTR(filename, 7, 2)|| '-'|| SUBSTR(filename, 5, 2)|| '-'|| SUBSTR(filename, 0, 4),'DD-MM-YYYY'),
              DH_UPDT = CURRENT_TIMESTAMP,
              DSC_UTIL_UPDT = V_NM_UTILIZADOR
        WHERE id_estado = 1;

      --tratar entidade 20975 (CGD)
      --tenta encontrar os agrupadores de extracto correspondentes aos grupos de MPSIBS
      FOR c_regs IN(SELECT extracto.agrupador,
                           extracto.num_conta,
                           mpsibs.id_mov_mpsibs
                      FROM (SELECT SUM(CASE
                                        WHEN TIPO_OPERACAO = 'D' THEN
                                        montante * -1
                                      ELSE montante END) soma,
                                   dt_movimento,
                                   agrupador,
                                   num_conta
                              FROM conc_movimento_extracto
                             WHERE tipo_registo = 4 AND origem_ficheiro = 'CGD'
                               AND num_conta = '0081095579230'
                               AND FL_COM_DETALHE = 0
                          GROUP BY dt_movimento,agrupador,num_conta) extracto,
                             (SELECT id_mov_mpsibs,
                                     SUM(montante) OVER(PARTITION BY data_movimento) soma,
                                     data_movimento
                                FROM (SELECT montante,
                                              data_movimento,
                                             id_mov_mpsibs
                                        FROM conc_movimento_mpsibs
                                       WHERE entidade = 20975
                                         and agrupador_mov_banco is null)
                            ORDER BY 3) mpsibs
                     WHERE extracto.dt_movimento = mpsibs.data_movimento AND extracto.soma = mpsibs.soma)
       LOOP

          sp_actualiza_mpsibs_assoc(c_regs.id_mov_mpsibs, c_regs.AGRUPADOR, c_regs.NUM_CONTA, V_NM_UTILIZADOR);

		  --guarda o agrupador antigo para actualizar o estado da associacao
		  SELECT (AGRUPADORES_ACTUALIZAR MULTISET UNION (CAST(MULTISET(SELECT TP_SYNC_UPDT_GROUP(c_regs.agrupador, null) FROM DUAL) AS TP_SYNC_TAB_UPDT_GROUP))) INTO AGRUPADORES_ACTUALIZAR  FROM DUAL;

       END LOOP;


       --tratar entidade 11181(IGCP)
       FOR i IN 1..4 LOOP

         FOR c_regs IN (SELECT extracto.agrupador,
                               extracto.num_conta,
                               mpsibs.id_mov_mpsibs
                          FROM (SELECT   montante soma,
                                         dt_movimento,
                                         agrupador,
                                         num_conta
                                    FROM conc_movimento_extracto
                                   WHERE tipo_registo = 4
                                     AND origem_ficheiro = 'IGCP'
                                     AND num_conta = '01120013221'
                                     AND FL_COM_DETALHE = 0) extracto,
                               (SELECT   id_mov_mpsibs,
                                         SUM(montante) OVER(PARTITION BY data_movimento) soma,
                                         data_movimento
                                    FROM (SELECT montante,
                                                 data_movimento,
                                                 id_mov_mpsibs
                                            FROM conc_movimento_mpsibs
                                           WHERE entidade = 11181 AND agrupador_mov_banco IS NULL)
                                ORDER BY 3) mpsibs
                         WHERE extracto.dt_movimento - mpsibs.data_movimento = i
                           AND extracto.soma = mpsibs.soma)

          LOOP

             sp_actualiza_mpsibs_assoc(c_regs.id_mov_mpsibs, c_regs.AGRUPADOR, c_regs.NUM_CONTA, V_NM_UTILIZADOR);

		  	--guarda o agrupador antigo para actualizar o estado da associacao
		  	SELECT (AGRUPADORES_ACTUALIZAR MULTISET UNION (CAST(MULTISET(SELECT TP_SYNC_UPDT_GROUP(c_regs.agrupador, null) FROM DUAL) AS TP_SYNC_TAB_UPDT_GROUP))) INTO AGRUPADORES_ACTUALIZAR  FROM DUAL;


          END LOOP;

       END LOOP;


	--actualiza os grupos dos movimentos que acabaram de ser associados do lado do MPSIBS e do lado do extracto
	FOR GRUPO IN (SELECT DISTINCT AGRUPADOR FROM TABLE(AGRUPADORES_ACTUALIZAR))
      LOOP

		--actualiza os dados de extracto - passam a ter detalhe associado
		sp_actualiza_ext_mpsibs_assoc(grupo.agrupador, V_NM_UTILIZADOR);

		--actualiza os grupos de referencias MB, passam a ser de acordo com o grupo de extracto associado
		UPDATE conc_movimento_mpsibs 
			set (data_grupo, data_mov_grupo, valor_grupo, num_movimentos, DH_UPDT, DSC_UTIL_UPDT)=
			(SELECT MIN(data_notificacao_scct) data_motificacao,
					MIN(data_movimento) data_mov,
                    SUM(montante) soma,
                    COUNT(1) num_movs,
					CURRENT_TIMESTAMP,
					V_NM_UTILIZADOR
             FROM conc_movimento_mpsibs
			 WHERE agrupador_mov_banco = GRUPO.AGRUPADOR
             GROUP BY agrupador_mov_banco)
		WHERE agrupador_mov_banco = grupo.agrupador;

	END LOOP;
   END sp_trata_mpsibs_detalhe;

--


   /**
    *
    */
   FUNCTION sp_obtem_descricao_grupo(

      i_tipo_registo    IN    CONC_TIPO_REGISTO.ID_TIPO_REGISTO%TYPE,
      i_agrupador       IN    NUMBER
   )
   RETURN CONC_MOVIMENTO_SCCT.DESCRICAO_GRUPO%TYPE
   IS

      v_descricao_grupo    CONC_MOVIMENTO_SCCT.DESCRICAO_GRUPO%TYPE;

   BEGIN

      IF(i_tipo_registo = 1)THEN

         SELECT DISTINCT to_char(n_talao_deposito) INTO v_descricao_grupo
           FROM conc_movimento_scct
          WHERE agrupador = i_agrupador;

      ELSIF(i_tipo_registo = 2)THEN

         SELECT DISTINCT to_char(n_talao_deposito_pac) INTO v_descricao_grupo
           FROM conc_movimento_scct
          WHERE agrupador = i_agrupador;

      ELSIF(i_tipo_registo = 3)THEN

         v_descricao_grupo := 'Multibanco';

      ELSIF(i_tipo_registo = 4)THEN
	
		 SELECT DISTINCT to_char(entidade) INTO v_descricao_grupo
           FROM conc_movimento_scct
          WHERE agrupador = i_agrupador;

      ELSIF(i_tipo_registo = 5)THEN

        SELECT descricao_grupo INTO v_descricao_grupo
           FROM CONC_MOVIMENTO_SCCT
          WHERE agrupador = i_agrupador AND ROWNUM = 1;

      END IF;

      RETURN v_descricao_grupo;

   END sp_obtem_descricao_grupo;

--
 /**
  * Actualiza os valores agrupados após a inserção/rectificação de um pedido d
	* e conciliação para regularização para o identificador de grupo fornecido.
    * sobre a tabela de codigo correspondente a lista apresentada em baixo.
	* RETURN CODES:
	* 1 - ARGS NULL
	* 2 - Movimentos alterados durante o processamento.
  */
   PROCEDURE SP_TRATA_CONC_REGULARIZACAO(
      I_AGRUPADOR    IN    NUMBER,
      I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
      I_FL_INICIAL IN NUMBER,
      O_COD_ERRO OUT NUMBER,
      O_MSG_ERRO OUT VARCHAR
   )
   IS
    ARG_NULL EXCEPTION;
    STATUS_CHANGED EXCEPTION;
    CONTADOR NUMBER;
    I_NM_UTILIZADOR DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      IF  I_ID_UTILIZADOR IS NULL OR I_AGRUPADOR IS NULL OR I_FL_INICIAL IS NULL THEN
        RAISE ARG_NULL;
	  END IF;


    SELECT NM_USER INTO I_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

    -- QUANDO NAO SE TRATA DE UM PEDIDO INICIAL, É NECESSÀRIO TRATAR AS REPETICOES E
    -- REMOÇÕES DE MOVIMENTOS.
    IF I_FL_INICIAL = 0 THEN


      -- ADICIONAR MOVIMENTOS NOVOS AO PROCESSO (SCCT)
      INSERT INTO REGISTO_WORKFLOW_MOVIMENTO (ID_REG_WF_MOV,NUM_REGISTOS,ID_MOV_SCCT,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT,FL_INICIAL)
      SELECT
        SQ_REG_WF_MOVIMENTO.NEXTVAL,
        I_AGRUPADOR,
        ID_MOV,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        0 FL_INICIAL
      FROM
        CONC_WF_REG_INTERFACE CWFI
      WHERE
       CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
       AND CWFI.TP_MOV = 1
       AND NOT EXISTS (SELECT
                      1
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM
                    WHERE
                      RWM.ID_MOV_SCCT = CWFI.ID_MOV
                      AND RWM.FL_INICIAL = 0
                      AND RWM.NUM_REGISTOS = I_AGRUPADOR);

       -- ADICIONAR MOVIMENTOS NOVOS AO PROCESSO (EXTRACTO)
      INSERT INTO REGISTO_WORKFLOW_MOVIMENTO (ID_REG_WF_MOV,NUM_REGISTOS,ID_MOV_EXTRACTO,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT,FL_INICIAL)
      SELECT
        SQ_REG_WF_MOVIMENTO.NEXTVAL,
        I_AGRUPADOR,
        ID_MOV,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        0 FL_INICIAL
      FROM
        CONC_WF_REG_INTERFACE CWFI
      WHERE
       CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
       AND CWFI.TP_MOV = 2
      AND NOT EXISTS (SELECT
                      1
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM
                    WHERE
                      RWM.ID_MOV_EXTRACTO = CWFI.ID_MOV
                      AND RWM.FL_INICIAL = 0
                      AND RWM.NUM_REGISTOS = I_AGRUPADOR);


       -- ADICIONAR MOVIMENTOS NOVOS AO PROCESSO (TPA)
      INSERT INTO REGISTO_WORKFLOW_MOVIMENTO (ID_REG_WF_MOV,NUM_REGISTOS,ID_MOV_TPA,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT,FL_INICIAL)
      SELECT
        SQ_REG_WF_MOVIMENTO.NEXTVAL,
        I_AGRUPADOR,
        ID_MOV,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        0 FL_INICIAL
      FROM
        CONC_WF_REG_INTERFACE CWFI
      WHERE
       CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
       AND CWFI.TP_MOV = 3
      AND NOT EXISTS (SELECT
                      1
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM
                    WHERE
                      RWM.ID_MOV_TPA = CWFI.ID_MOV
                      AND RWM.FL_INICIAL = 0
                      AND RWM.NUM_REGISTOS = I_AGRUPADOR);

       -- ADICIONAR MOVIMENTOS NOVOS AO PROCESSO (MPSIBS)
      INSERT INTO REGISTO_WORKFLOW_MOVIMENTO (ID_REG_WF_MOV,NUM_REGISTOS,ID_MOV_MPSIBS,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT,FL_INICIAL)
      SELECT
        SQ_REG_WF_MOVIMENTO.NEXTVAL,
        I_AGRUPADOR,
        ID_MOV,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        CURRENT_TIMESTAMP,
        I_NM_UTILIZADOR,
        0 FL_INICIAL
      FROM
        CONC_WF_REG_INTERFACE CWFI
      WHERE
       CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
       AND CWFI.TP_MOV = 4
       AND NOT EXISTS (SELECT
                      1
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM
                    WHERE
                      RWM.ID_MOV_MPSIBS = CWFI.ID_MOV
                      AND RWM.FL_INICIAL = 0
                      AND RWM.NUM_REGISTOS = I_AGRUPADOR);

    END IF;


    -- Actualizar o estado dos movimentos do scct.
    FOR CURSOR1 IN (SELECT
                      MOV_SCCT.ID_MOV_SCCT,
                      MOV_SCCT.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_SCCT MOV_SCCT
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.FL_INICIAL = I_FL_INICIAL
                      AND RWM.ID_MOV_SCCT = MOV_SCCT.ID_MOV_SCCT
                   FOR UPDATE OF MOV_SCCT.ID_ESTADO



                   )
		LOOP

      -- foi adicionado agora
      IF CURSOR1.ID_ESTADO = 2 THEN
        UPDATE CONC_MOVIMENTO_SCCT SET ID_ESTADO = 5 WHERE ID_MOV_SCCT = CURSOR1.ID_MOV_SCCT;
      -- deve ter sido removido agora, é necessário validar se está marcado para tal.
      ELSIF CURSOR1.ID_ESTADO = 5 THEN
        DECLARE
          LOCAL_COUNT NUMBER;
        BEGIN

          SELECT COUNT(1) INTO LOCAL_COUNT FROM CONC_WF_REG_INTERFACE WHERE ID_MOV = CURSOR1.ID_MOV_SCCT AND TP_MOV = 1 AND ID_UTILIZADOR = I_ID_UTILIZADOR;

          IF LOCAL_COUNT = 0 THEN
            UPDATE CONC_MOVIMENTO_SCCT SET ID_ESTADO = 2 WHERE ID_MOV_SCCT = CURSOR1.ID_MOV_SCCT;
          END IF;

        END;
      ELSE
        RAISE STATUS_CHANGED;

      END IF;

    END LOOP;


    -- Actualizar o estado dos movimentos do extracto.
    FOR CURSOR1 IN (SELECT
                      MOV_EXTRACTO.ID_MOV_BANCO,
                      MOV_EXTRACTO.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_EXTRACTO MOV_EXTRACTO
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.FL_INICIAL = I_FL_INICIAL
                      AND RWM.ID_MOV_EXTRACTO = MOV_EXTRACTO.ID_MOV_BANCO
                   FOR UPDATE OF MOV_EXTRACTO.ID_ESTADO)
		LOOP

      -- foi adicionado agora
      IF CURSOR1.ID_ESTADO = 2 THEN
         UPDATE CONC_MOVIMENTO_EXTRACTO SET ID_ESTADO = 5 WHERE ID_MOV_BANCO = CURSOR1.ID_MOV_BANCO;
      -- deve ter sido removido agora, é necessário validar se está marcado para tal.
      ELSIF CURSOR1.ID_ESTADO = 5 THEN
        DECLARE
          LOCAL_COUNT NUMBER;
        BEGIN

          SELECT COUNT(1) INTO LOCAL_COUNT FROM CONC_WF_REG_INTERFACE WHERE ID_MOV = CURSOR1.ID_MOV_BANCO AND TP_MOV = 2 AND ID_UTILIZADOR = I_ID_UTILIZADOR;

          IF LOCAL_COUNT = 0 THEN
            UPDATE CONC_MOVIMENTO_EXTRACTO SET ID_ESTADO = 2 WHERE ID_MOV_BANCO = CURSOR1.ID_MOV_BANCO;
          END IF;

        END;
      ELSE
        RAISE STATUS_CHANGED;

      END IF;

    END LOOP;

     -- Actualizar o estado dos movimentos de tpa.
    FOR CURSOR1 IN (SELECT
                      MOV_TPA.ID_MOV_TPA,
                      MOV_TPA.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_TPA_DETALHE MOV_TPA
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.FL_INICIAL = I_FL_INICIAL
                      AND RWM.ID_MOV_TPA = MOV_TPA.ID_MOV_TPA
                   FOR UPDATE OF MOV_TPA.ID_ESTADO)
		LOOP

      -- foi adicionado agora
      IF CURSOR1.ID_ESTADO = 2 THEN
          UPDATE CONC_MOVIMENTO_TPA_DETALHE SET ID_ESTADO = 5 WHERE ID_MOV_TPA = CURSOR1.ID_MOV_TPA;
      -- deve ter sido removido agora, é necessário validar se está marcado para tal.
      ELSIF CURSOR1.ID_ESTADO = 5 THEN
        DECLARE
          LOCAL_COUNT NUMBER;
        BEGIN

          SELECT COUNT(1) INTO LOCAL_COUNT FROM CONC_WF_REG_INTERFACE WHERE ID_MOV = CURSOR1.ID_MOV_TPA AND TP_MOV = 3 AND ID_UTILIZADOR = I_ID_UTILIZADOR;

          IF LOCAL_COUNT = 0 THEN
            UPDATE CONC_MOVIMENTO_TPA_DETALHE SET ID_ESTADO = 2 WHERE ID_MOV_TPA = CURSOR1.ID_MOV_TPA;
          END IF;

        END;
      ELSE
        RAISE STATUS_CHANGED;

      END IF;

    END LOOP;

    -- Actualizar o estado dos movimentos do mpsibs.
    FOR CURSOR1 IN (SELECT
                      MOV_MPSIBS.ID_MOV_MPSIBS,
                      MOV_MPSIBS.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_MPSIBS MOV_MPSIBS
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.FL_INICIAL = I_FL_INICIAL
                      AND RWM.ID_MOV_MPSIBS = MOV_MPSIBS.ID_MOV_MPSIBS
                   FOR UPDATE OF MOV_MPSIBS.ID_ESTADO)
		LOOP

       -- foi adicionado agora
      IF CURSOR1.ID_ESTADO = 2 THEN
         UPDATE CONC_MOVIMENTO_MPSIBS SET ID_ESTADO = 5 WHERE ID_MOV_MPSIBS = CURSOR1.ID_MOV_MPSIBS;
      -- deve ter sido removido agora, é necessário validar se está marcado para tal.
      ELSIF CURSOR1.ID_ESTADO = 5 THEN
        DECLARE
          LOCAL_COUNT NUMBER;
        BEGIN

          SELECT COUNT(1) INTO LOCAL_COUNT FROM CONC_WF_REG_INTERFACE WHERE ID_MOV = CURSOR1.ID_MOV_MPSIBS AND TP_MOV = 3 AND ID_UTILIZADOR = I_ID_UTILIZADOR;

          IF LOCAL_COUNT = 0 THEN
            UPDATE CONC_MOVIMENTO_MPSIBS SET ID_ESTADO = 2 WHERE ID_MOV_MPSIBS = CURSOR1.ID_MOV_MPSIBS;
          END IF;

        END;
      ELSE
        RAISE STATUS_CHANGED;

      END IF;

    END LOOP;


   -- Actualizar: CONC_MOVIMENTO_SCCT
	 FOR CURSOR1 IN (SELECT
						DISTINCT MOV_SCCT.AGRUPADOR
					 FROM
						REGISTO_WORKFLOW_MOVIMENTO RWM,
						CONC_MOVIMENTO_SCCT MOV_SCCT
					 WHERE
						RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
						AND RWM.ID_MOV_SCCT = MOV_SCCT.ID_MOV_SCCT)
		LOOP
		   FOR c_scct IN (SELECT count(1) qtd, agrupador,
								SUM(
                  CASE WHEN ID_ESTADO = 2 THEN
                    CASE
                      WHEN TIPO_OPERACAO = 'D' THEN
                      VALOR * -1
                    ELSE VALOR END
                  ELSE 0 END
								 ) soma,
								 max(descricao_grupo) descricao_grupo,
								 min(dt_movimento) dt_movimento,
								 MIN(cod_divisao)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
								 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
								 max(num_conta)num_conta
							FROM CONC_MOVIMENTO_SCCT
						   WHERE id_estado IN (2,5)
							 AND agrupador = cursor1.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE conc_movimento_scct cms
				 SET cms.num_movimentos = c_scct.qtd,
					 cms.valor_grupo = abs(c_scct.soma),
					 cms.DESCRICAO_GRUPO = c_scct.descricao_grupo,
					 cms.DATA_GRUPO = c_scct.dt_movimento,
					 cms.COD_DIVISAO_GRUPO = c_scct.cod_divisao,
					 cms.NM_DIVISAO_GRUPO = c_scct.nm_divisao_grupo,
					 cms.ID_TIPO_REG_GRUPO = c_scct.id_tipo_reg_grupo,
					 cms.TP_MOV_GRUPO = (CASE WHEN c_scct.soma > 0 THEN 'C' ELSE 'D' END),
					 cms.TIPO_REG_GRUPO = c_scct.tipo_reg_grupo,
					 CMS.NUM_CONTA_GRUPO = C_SCCT.NUM_CONTA
					 ,CMS.DH_UPDT = CURRENT_TIMESTAMP
					 ,cms.DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE cms.agrupador = cursor1.agrupador;
		   END LOOP;

		END LOOP;

    -- Actualizar: CONC_MOVIMENTO_EXTRACTO
	FOR CURSOR1 IN (SELECT
					  DISTINCT MOV_BANCO.AGRUPADOR
					FROM
					  REGISTO_WORKFLOW_MOVIMENTO RWM,
					  CONC_MOVIMENTO_EXTRACTO MOV_BANCO
					WHERE
					  RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
					  AND MOV_BANCO.ID_MOV_BANCO = RWM.ID_MOV_EXTRACTO)
	   LOOP

		  FOR c_banco IN (SELECT
								SUM(
								  CASE WHEN ID_ESTADO = 2 THEN
									CASE
									  WHEN TIPO_OPERACAO = 'D' THEN
									  MONTANTE * -1
									ELSE MONTANTE END
								  ELSE 0 END) soma,
								 agrupador, count(1) qtd,
								 MAX(DESCRICAO_MOVIMENTO) DESCRICAO_MOVIMENTO,
								 min(dt_movimento) dt_movimento,
								 min(dt_extracto) dt_extracto,
								 MIN(cod_divisao)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
								 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
								 max(num_conta)num_conta
							FROM CONC_MOVIMENTO_EXTRACTO
						   WHERE id_estado IN (2,5)
							 AND AGRUPADOR = CURSOR1.AGRUPADOR
						   GROUP BY agrupador)

		  LOOP
			 UPDATE conc_movimento_extracto cme
				SET cme.valor_grupo = abs(c_banco.soma),
					cme.num_movimentos = c_banco.qtd,
					CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
					CME.DATA_GRUPO = c_banco.dt_movimento,
					CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
					CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
					CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
					CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
					CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
					CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
					CME.NUM_CONTA_GRUPO = c_banco.num_conta
					,DH_UPDT = CURRENT_TIMESTAMP
					,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			  WHERE cme.agrupador = c_banco.agrupador;
		  END LOOP;

	   END LOOP;

	-- Actualizar: CONC_MOV_PRECONCILIADO
	-- a tabela de preconciliados nao necessita da actualizacao de agrupadores
	-- mas sim que sejam quebradas todas as preconciliacoes que contenham registos
	-- para qualquer um dos movimentos conciliados.
	-- apaga todos os grupos com movimentos envolvidos na conciliacao realizada.
	FOR C1 IN (SELECT
				  DISTINCT CMP.AGRUPADOR AGRUPADOR
			   FROM
				  REGISTO_WORKFLOW_MOVIMENTO RWM,
				  CONC_MOV_PRECONCILIADO CMP
			   WHERE
				  RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
				  AND (CMP.ID_MOV_BANCO = RWM.ID_MOV_EXTRACTO
					   OR CMP.ID_MOV_SCCT = RWM.ID_MOV_SCCT))
		LOOP
		   DELETE FROM CONC_MOV_PRECONCILIADO WHERE AGRUPADOR = C1.AGRUPADOR;
		END LOOP;

	-- Actualizar: CONC_MOVIMENTO_MPSIBS
	FOR GRUPO_MPSIBS IN (SELECT
						DISTINCT MPSIBS.AGRUPADOR AGRUPADOR
					  FROM
						REGISTO_WORKFLOW_MOVIMENTO RWM,
						CONC_MOVIMENTO_MPSIBS MPSIBS
					  WHERE
						RWM.NUM_REGISTOS = I_AGRUPADOR  AND RWM.FL_INICIAL = I_FL_INICIAL AND
						MPSIBS.ID_MOV_MPSIBS = RWM.ID_MOV_MPSIBS)
		LOOP
		   FOR c_mpsibs IN (SELECT count(1) qtd, agrupador,
								 SUM(
								  CASE
									WHEN ID_ESTADO = 2 THEN
									  MONTANTE
									ELSE 0 END
								 ) soma,
								 min(DATA_NOTIFICACAO_SCCT) dt_notificacao,
								 min(DATA_MOVIMENTO) dt_movimento,
								 MIN(COD_DIVISAO_GRUPO)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 max(TP_MOV_GRUPO)TP_MOV_GRUPO,
								 MAX(NUM_CONTA_GRUPO) NUM_CONTA
							FROM CONC_MOVIMENTO_MPSIBS
						   WHERE id_estado IN (2,5)
							 AND agrupador = grupo_mpsibs.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE CONC_MOVIMENTO_MPSIBS mov_msibs
				 SET mov_msibs.num_movimentos = c_mpsibs.qtd,
					 mov_msibs.valor_grupo = c_mpsibs.soma,
					 mov_msibs.DATA_GRUPO = c_mpsibs.dt_notificacao,
					 mov_msibs.DATA_MOV_GRUPO = c_mpsibs.dt_movimento,
					 mov_msibs.COD_DIVISAO_GRUPO = c_mpsibs.cod_divisao,
					 mov_msibs.NM_DIVISAO_GRUPO = c_mpsibs.nm_divisao_grupo
					 ,DH_UPDT = CURRENT_TIMESTAMP
					 ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE mov_msibs.agrupador = grupo_mpsibs.agrupador;
		   END LOOP;

		END LOOP;

	-- Actualizar: CONC_MOV_MPSIBS_PRECONCILIADO
    -- apaga todos os movimentos envolvidos na conciliacao realizada.
	FOR C1 IN (SELECT
					DISTINCT RWM.ID_MOV_MPSIBS
				 FROM
					REGISTO_WORKFLOW_MOVIMENTO RWM
				 WHERE
					RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
				)
        LOOP
           DELETE FROM CONC_MOV_MPSIBS_PRECONCILIADO WHERE ID_MOV_MPSIBS = C1.ID_MOV_MPSIBS;
        END LOOP;


    -- Actualizar: CONC_MOVIMENTO_TPA_DETALHE
    FOR GRUPO_TPA IN (SELECT
							DISTINCT TPA.AGRUPADOR AGRUPADOR
						  FROM
							REGISTO_WORKFLOW_MOVIMENTO RWM,
							CONC_MOVIMENTO_TPA_DETALHE TPA
						  WHERE
							RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
							AND TPA.ID_MOV_TPA = RWM.ID_MOV_TPA)
		LOOP
		   FOR c_tpa IN (SELECT count(1) qtd, agrupador,
								 SUM(
								  CASE WHEN ID_ESTADO = 2 THEN
									CASE
									  WHEN TIPO_OPERACAO = 'D' THEN
									  MONTANTE * -1
									ELSE MONTANTE END
								  ELSE 0 END
								 ) soma,
								 min(DT_VALOR) dt_valor,
								 min(DT_MOVIMENTO) dt_movimento,
								 MIN(COD_DIVISAO_GRUPO)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(NUM_CONTA_GRUPO) NUM_CONTA
							FROM CONC_MOVIMENTO_TPA_DETALHE
						   WHERE id_estado IN (2,5)
							 AND agrupador = GRUPO_TPA.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE CONC_MOVIMENTO_TPA_DETALHE mov_tpa
				 SET mov_tpa.num_movimentos = c_tpa.qtd,
					 mov_tpa.valor_grupo = abs(c_tpa.soma),
					 mov_tpa.tp_mov_grupo = (CASE WHEN c_tpa.soma > 0 THEN 'C' ELSE 'D' END),
					 mov_tpa.DATA_GRUPO = c_tpa.dt_valor,
					 mov_tpa.DATA_MOV_GRUPO = c_tpa.dt_movimento,
					 mov_tpa.COD_DIVISAO_GRUPO = c_tpa.cod_divisao,
					 mov_tpa.NM_DIVISAO_GRUPO = c_tpa.nm_divisao_grupo
					 ,DH_UPDT = CURRENT_TIMESTAMP
					 ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE mov_tpa.agrupador = GRUPO_TPA.agrupador;
		   END LOOP;

		END LOOP;


    -- Actualizar: CONC_MOV_TPA_PRECONCILIADO
    -- a tabela de preconciliados nao necessita da actualizacao de agrupadores
    -- mas sim que sejam quebradas todas as preconciliacoes que contenham registos
    -- para qualquer um dos movimentos conciliados.
	-- apaga todos os movimentos envolvidos na conciliacao realizada.
	FOR C1 IN (SELECT
				DISTINCT RWM.ID_MOV_SCCT
			 FROM
				REGISTO_WORKFLOW_MOVIMENTO RWM
			 WHERE
				RWM.NUM_REGISTOS = I_AGRUPADOR AND RWM.FL_INICIAL = I_FL_INICIAL
			)
		LOOP
			DELETE FROM CONC_MOV_TPA_PRECONCILIADO WHERE ID_MOV_SCCT = C1.ID_MOV_SCCT;
		END LOOP;




    -- UMA VEZ ACTUALIZADOS/REPOSTOS TODOS OS AGRUPADORES, É NECESSARIO REMOVER OS MOVIMENTOS
    -- MARCADOS PARA O EFEITO.
    IF I_FL_INICIAL = 0 THEN

      -- REMOVER DO PROCESSO OS MOVIMENTOS MARCADOS PARA O EFEITO (SCCT).
      DELETE FROM REGISTO_WORKFLOW_MOVIMENTO RWM
      WHERE
        RWM.NUM_REGISTOS = I_AGRUPADOR
        AND RWM.FL_INICIAL = 0
        AND RWM.ID_MOV_SCCT IS NOT NULL
        AND NOT EXISTS (
          SELECT 1 FROM
            CONC_WF_REG_INTERFACE CWFI
          WHERE
            CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
            AND CWFI.TP_MOV = 1
            AND CWFI.ID_MOV = RWM.ID_MOV_SCCT
        );

      -- REMOVER DO PROCESSO OS MOVIMENTOS MARCADOS PARA O EFEITO (EXTRACTO).
      DELETE FROM REGISTO_WORKFLOW_MOVIMENTO RWM
      WHERE
        RWM.NUM_REGISTOS = I_AGRUPADOR
        AND RWM.FL_INICIAL = 0
        AND RWM.ID_MOV_EXTRACTO IS NOT NULL
        AND NOT EXISTS (
          SELECT 1 FROM
            CONC_WF_REG_INTERFACE CWFI
          WHERE
            CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
            AND CWFI.TP_MOV = 2
            AND CWFI.ID_MOV = RWM.ID_MOV_EXTRACTO
        );

       -- REMOVER DO PROCESSO OS MOVIMENTOS MARCADOS PARA O EFEITO (TPA).
      DELETE FROM REGISTO_WORKFLOW_MOVIMENTO RWM
      WHERE
        RWM.NUM_REGISTOS = I_AGRUPADOR
        AND RWM.FL_INICIAL = 0
        AND RWM.ID_MOV_TPA IS NOT NULL
        AND NOT EXISTS (
          SELECT 1 FROM
            CONC_WF_REG_INTERFACE CWFI
          WHERE
            CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
            AND CWFI.TP_MOV = 3
            AND CWFI.ID_MOV = RWM.ID_MOV_TPA
        );


       -- REMOVER DO PROCESSO OS MOVIMENTOS MARCADOS PARA O EFEITO (MPSIBS).
      DELETE FROM REGISTO_WORKFLOW_MOVIMENTO RWM
      WHERE
        RWM.NUM_REGISTOS = I_AGRUPADOR
        AND RWM.FL_INICIAL = 0
        AND RWM.ID_MOV_MPSIBS IS NOT NULL
        AND NOT EXISTS (
          SELECT 1 FROM
            CONC_WF_REG_INTERFACE CWFI
          WHERE
            CWFI.ID_UTILIZADOR = I_ID_UTILIZADOR
            AND CWFI.TP_MOV = 4
            AND CWFI.ID_MOV = RWM.ID_MOV_MPSIBS
        );


      -- LIMPAR A INTERFACE.
      DELETE FROM CONC_WF_REG_INTERFACE WHERE ID_UTILIZADOR = I_ID_UTILIZADOR;

  END IF;

  O_COD_ERRO := 0;

  EXCEPTION
     WHEN ARG_NULL THEN
      O_COD_ERRO := 1;
      O_MSG_ERRO := 'Todos os argumentos de entrada do procedimento são de preenchimento obrigatório.';
     WHEN STATUS_CHANGED THEN
      O_COD_ERRO := 2;
      O_MSG_ERRO := 'Existem movimentos que viram o seu estado alterado durante a execução do procedimento.';
     WHEN OTHERS THEN
      O_COD_ERRO := 3;
      O_MSG_ERRO := 'Ocorreu um erro ao executar o procedimento: '||SQLERRM;


	END SP_TRATA_CONC_REGULARIZACAO;


  /**
    * Procedimento que insere os movimentos envolvidos num processo de conciliação para regularização
    * numa tabela de interface para que posteriormente possam ser tratados pelo procedimento SP_TRATA_CONC_REGULARIZACAO.
    *
    */

   PROCEDURE SP_CONC_WF_REG_INTERFACE(
      I_ID_MOV    IN     NUMBER,
      I_TP_MOV    IN     VARCHAR2,
      I_ID_UTILIZADOR IN NUMBER,
      O_COD_ERRO    OUT    NUMBER,
      O_MSG_ERRO OUT VARCHAR2
   )

   IS
      ID_NULL EXCEPTION;
      V_NM_UTILIZADOR DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      IF(I_ID_MOV IS NULL) THEN
         RAISE ID_NULL;
      ELSE

        INSERT INTO CONC_WF_REG_INTERFACE(ID_MOV,TP_MOV,ID_UTILIZADOR,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT)
        VALUES (I_ID_MOV,I_TP_MOV,I_ID_UTILIZADOR,CURRENT_TIMESTAMP,V_NM_UTILIZADOR,CURRENT_TIMESTAMP,V_NM_UTILIZADOR);

        --sucesso
        O_COD_ERRO := 0;

      END IF;

      EXCEPTION
         WHEN ID_NULL THEN
         O_COD_ERRO := 1;
         O_MSG_ERRO := 'O identificador de movimento é de preenchimento obrigatório.';


   END SP_CONC_WF_REG_INTERFACE;


 /**
  * Cancela um pedido de conciliação para regularização, colocando os movimentos
  * envolvidos novamente disponíveis para conciliação e recalculando novamente todos
  * os agrupadores envolvidos.
	* RETURN CODES:
	* 1 - ARGS NULL
	* 2 - Movimentos alterados durante o processamento.
  */
   PROCEDURE SP_CANCELA_CONC_REGULARIZACAO(
      I_AGRUPADOR    IN    NUMBER,
      I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
      O_COD_ERRO OUT NUMBER,
      O_MSG_ERRO OUT VARCHAR
   )
   IS
    ARG_NULL EXCEPTION;
    STATUS_CHANGED EXCEPTION;
    CONTADOR NUMBER;
    I_NM_UTILIZADOR DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

    IF  I_ID_UTILIZADOR IS NULL OR I_AGRUPADOR IS NULL THEN
        RAISE ARG_NULL;
	  END IF;


    SELECT NM_USER INTO I_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

    -- Actualizar o estado dos movimentos do scct.
    FOR CURSOR1 IN (SELECT
                      MOV_SCCT.ID_MOV_SCCT,
                      MOV_SCCT.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_SCCT MOV_SCCT
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.ID_MOV_SCCT = MOV_SCCT.ID_MOV_SCCT
                   FOR UPDATE OF MOV_SCCT.ID_ESTADO
                   )
		LOOP
      IF CURSOR1.ID_ESTADO = 5 THEN
        UPDATE CONC_MOVIMENTO_SCCT SET ID_ESTADO = 2 WHERE ID_MOV_SCCT = CURSOR1.ID_MOV_SCCT;
      ELSE
        RAISE STATUS_CHANGED;
      END IF;
    END LOOP;

    -- Actualizar o estado dos movimentos do extracto.
    FOR CURSOR1 IN (SELECT
                      MOV_EXTRACTO.ID_MOV_BANCO,
                      MOV_EXTRACTO.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_EXTRACTO MOV_EXTRACTO
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.ID_MOV_EXTRACTO = MOV_EXTRACTO.ID_MOV_BANCO
                   FOR UPDATE OF MOV_EXTRACTO.ID_ESTADO)
		LOOP
      IF CURSOR1.ID_ESTADO = 5 THEN
         UPDATE CONC_MOVIMENTO_EXTRACTO SET ID_ESTADO = 2 WHERE ID_MOV_BANCO = CURSOR1.ID_MOV_BANCO;
      ELSE
        RAISE STATUS_CHANGED;
      END IF;
    END LOOP;

     -- Actualizar o estado dos movimentos de tpa.
    FOR CURSOR1 IN (SELECT
                      MOV_TPA.ID_MOV_TPA,
                      MOV_TPA.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_TPA_DETALHE MOV_TPA
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.ID_MOV_TPA = MOV_TPA.ID_MOV_TPA
                   FOR UPDATE OF MOV_TPA.ID_ESTADO)
		LOOP
      IF CURSOR1.ID_ESTADO = 5 THEN
          UPDATE CONC_MOVIMENTO_TPA_DETALHE SET ID_ESTADO = 2 WHERE ID_MOV_TPA = CURSOR1.ID_MOV_TPA;
      ELSE
        RAISE STATUS_CHANGED;
      END IF;
    END LOOP;

    -- Actualizar o estado dos movimentos do mpsibs.
    FOR CURSOR1 IN (SELECT
                      MOV_MPSIBS.ID_MOV_MPSIBS,
                      MOV_MPSIBS.ID_ESTADO
                    FROM
                      REGISTO_WORKFLOW_MOVIMENTO RWM,
                      CONC_MOVIMENTO_MPSIBS MOV_MPSIBS
                   WHERE
                      RWM.NUM_REGISTOS = I_AGRUPADOR
                      AND RWM.ID_MOV_MPSIBS = MOV_MPSIBS.ID_MOV_MPSIBS
                   FOR UPDATE OF MOV_MPSIBS.ID_ESTADO)
		LOOP
      IF CURSOR1.ID_ESTADO = 5 THEN
         UPDATE CONC_MOVIMENTO_MPSIBS SET ID_ESTADO = 2 WHERE ID_MOV_MPSIBS = CURSOR1.ID_MOV_MPSIBS;
      ELSE
        RAISE STATUS_CHANGED;
      END IF;
    END LOOP;


   -- Actualizar: CONC_MOVIMENTO_SCCT
	 FOR CURSOR1 IN (SELECT
						DISTINCT MOV_SCCT.AGRUPADOR
					 FROM
						REGISTO_WORKFLOW_MOVIMENTO RWM,
						CONC_MOVIMENTO_SCCT MOV_SCCT
					 WHERE
						RWM.NUM_REGISTOS = I_AGRUPADOR
						AND RWM.ID_MOV_SCCT = MOV_SCCT.ID_MOV_SCCT)
		LOOP
		   FOR c_scct IN (SELECT count(1) qtd, agrupador,
								SUM(
								  CASE WHEN ID_ESTADO = 2 THEN
									CASE
									  WHEN TIPO_OPERACAO = 'D' THEN
									  VALOR * -1
									ELSE VALOR END
								  ELSE 0 END
								 ) soma,
								 max(descricao_grupo) descricao_grupo,
								 min(dt_movimento) dt_movimento,
								 MIN(cod_divisao)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
								 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
								 max(num_conta)num_conta
							FROM CONC_MOVIMENTO_SCCT
						   WHERE id_estado IN (2,5)
							 AND agrupador = cursor1.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE conc_movimento_scct cms
				 SET cms.num_movimentos = c_scct.qtd,
					 cms.valor_grupo = ABS(c_scct.soma),
					 cms.DESCRICAO_GRUPO = c_scct.descricao_grupo,
					 cms.DATA_GRUPO = c_scct.dt_movimento,
					 cms.COD_DIVISAO_GRUPO = c_scct.cod_divisao,
					 cms.NM_DIVISAO_GRUPO = c_scct.nm_divisao_grupo,
					 cms.ID_TIPO_REG_GRUPO = c_scct.id_tipo_reg_grupo,
					 cms.TP_MOV_GRUPO = (CASE WHEN c_scct.soma > 0 THEN 'C' ELSE 'D' END),
					 cms.TIPO_REG_GRUPO = c_scct.tipo_reg_grupo,
					 CMS.NUM_CONTA_GRUPO = C_SCCT.NUM_CONTA
					 ,CMS.DH_UPDT = CURRENT_TIMESTAMP
					 ,cms.DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE cms.agrupador = cursor1.agrupador;
		   END LOOP;

		END LOOP;

    -- Actualizar: CONC_MOVIMENTO_EXTRACTO
	FOR CURSOR1 IN (SELECT
					  DISTINCT MOV_BANCO.AGRUPADOR
					FROM
					  REGISTO_WORKFLOW_MOVIMENTO RWM,
					  CONC_MOVIMENTO_EXTRACTO MOV_BANCO
					WHERE
					  RWM.NUM_REGISTOS = I_AGRUPADOR
					  AND MOV_BANCO.ID_MOV_BANCO = RWM.ID_MOV_EXTRACTO)
	   LOOP

		  FOR c_banco IN (SELECT
								SUM(
								  CASE WHEN ID_ESTADO = 2 THEN
									CASE
									  WHEN TIPO_OPERACAO = 'D' THEN
									  MONTANTE * -1
									ELSE MONTANTE END
								  ELSE 0 END
								 ) soma,
								 agrupador, count(1) qtd,
								 MAX(DESCRICAO_MOVIMENTO) DESCRICAO_MOVIMENTO,
								 min(dt_movimento) dt_movimento,
								 min(dt_extracto) dt_extracto,
								 MIN(cod_divisao)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(ID_TIPO_REG_GRUPO) id_tipo_reg_grupo,
								 max(TIPO_REG_GRUPO)TIPO_REG_GRUPO,
								 max(num_conta)num_conta
							FROM CONC_MOVIMENTO_EXTRACTO
						   WHERE id_estado IN (2,5)
							 AND AGRUPADOR = CURSOR1.AGRUPADOR
						   GROUP BY agrupador)

		  LOOP
			 UPDATE conc_movimento_extracto cme
				SET cme.valor_grupo = ABS(c_banco.soma),
					cme.num_movimentos = c_banco.qtd,
					CME.DESCRICAO_GRUPO = c_banco.descricao_movimento,
					CME.DATA_GRUPO = c_banco.dt_movimento,
					CME.DATA_EXTRACTO_GRUPO = c_banco.dt_extracto,
					CME.COD_DIVISAO_GRUPO = c_banco.cod_divisao,
					CME.NM_DIVISAO_GRUPO = c_banco.nm_divisao_grupo,
					CME.ID_TIPO_REG_GRUPO = c_banco.id_tipo_reg_grupo,
					CME.TP_MOV_GRUPO = (CASE WHEN c_banco.soma > 0 THEN 'C' ELSE 'D' END),
					CME.TIPO_REG_GRUPO = c_banco.tipo_reg_grupo,
					CME.NUM_CONTA_GRUPO = c_banco.num_conta
					,DH_UPDT = CURRENT_TIMESTAMP
					,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			  WHERE cme.agrupador = c_banco.agrupador;
		  END LOOP;

	   END LOOP;

	-- Actualizar: CONC_MOVIMENTO_MPSIBS
	FOR GRUPO_MPSIBS IN (SELECT
						DISTINCT MPSIBS.AGRUPADOR AGRUPADOR
					  FROM
						REGISTO_WORKFLOW_MOVIMENTO RWM,
						CONC_MOVIMENTO_MPSIBS MPSIBS
					  WHERE
						RWM.NUM_REGISTOS = I_AGRUPADOR  AND
						MPSIBS.ID_MOV_MPSIBS = RWM.ID_MOV_MPSIBS)
		LOOP
		   FOR c_mpsibs IN (SELECT count(1) qtd, agrupador,
								 SUM(
					                  CASE
					                    WHEN ID_ESTADO = 2 THEN
					                      MONTANTE
					                    ELSE 0 END
					                 ) soma,
								 min(DATA_NOTIFICACAO_SCCT) dt_notificacao,
								 min(DATA_MOVIMENTO) dt_movimento,
								 MIN(COD_DIVISAO_GRUPO)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 min(TP_MOV_GRUPO)TP_MOV_GRUPO,
								 MAX(NUM_CONTA_GRUPO) NUM_CONTA
							FROM CONC_MOVIMENTO_MPSIBS
						   WHERE id_estado IN (2,5)
							 AND agrupador = grupo_mpsibs.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE CONC_MOVIMENTO_MPSIBS mov_msibs
				 SET mov_msibs.num_movimentos = c_mpsibs.qtd,
					 mov_msibs.valor_grupo = c_mpsibs.soma,
					 mov_msibs.DATA_GRUPO = c_mpsibs.dt_notificacao,
					 mov_msibs.DATA_MOV_GRUPO = c_mpsibs.dt_movimento,
					 mov_msibs.COD_DIVISAO_GRUPO = c_mpsibs.cod_divisao,
					 mov_msibs.NM_DIVISAO_GRUPO = c_mpsibs.nm_divisao_grupo
					 ,DH_UPDT = CURRENT_TIMESTAMP
					 ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE mov_msibs.agrupador = grupo_mpsibs.agrupador;
		   END LOOP;

		END LOOP;

    -- Actualizar: CONC_MOVIMENTO_TPA_DETALHE
    FOR GRUPO_TPA IN (SELECT
							DISTINCT TPA.AGRUPADOR AGRUPADOR
						  FROM
							REGISTO_WORKFLOW_MOVIMENTO RWM,
							CONC_MOVIMENTO_TPA_DETALHE TPA
						  WHERE
							RWM.NUM_REGISTOS = I_AGRUPADOR
							AND TPA.ID_MOV_TPA = RWM.ID_MOV_TPA)
		LOOP
		   FOR c_tpa IN (SELECT count(1) qtd, agrupador,
								 SUM(
								  CASE WHEN ID_ESTADO = 2 THEN
									CASE
									  WHEN TIPO_OPERACAO = 'D' THEN
									  MONTANTE * -1
									ELSE MONTANTE END
								  ELSE 0 END
								 ) soma,
								 min(DT_VALOR) dt_valor,
								 min(DT_MOVIMENTO) dt_movimento,
								 MIN(COD_DIVISAO_GRUPO)cod_divisao,
								 MIN(NM_DIVISAO_GRUPO)NM_DIVISAO_GRUPO,
								 MAX(NUM_CONTA_GRUPO) NUM_CONTA
							FROM CONC_MOVIMENTO_TPA_DETALHE
						   WHERE id_estado IN (2,5)
							 AND agrupador = GRUPO_TPA.agrupador
						  GROUP BY agrupador)

		   LOOP
			  UPDATE CONC_MOVIMENTO_TPA_DETALHE mov_tpa
				 SET mov_tpa.num_movimentos = c_tpa.qtd,
					 mov_tpa.valor_grupo = ABS(c_tpa.soma),
					 mov_tpa.DATA_GRUPO = c_tpa.dt_valor,
					 mov_tpa.DATA_MOV_GRUPO = c_tpa.dt_movimento,
					 mov_tpa.COD_DIVISAO_GRUPO = c_tpa.cod_divisao,
					 mov_tpa.NM_DIVISAO_GRUPO = c_tpa.nm_divisao_grupo,
					 mov_tpa.TP_MOV_GRUPO = (CASE WHEN c_tpa.soma > 0 THEN 'C' ELSE 'D' END)
					 ,DH_UPDT = CURRENT_TIMESTAMP
					 ,DSC_UTIL_UPDT = I_NM_UTILIZADOR
			   WHERE mov_tpa.agrupador = GRUPO_TPA.agrupador;
		   END LOOP;

		END LOOP;

  O_COD_ERRO := 0;

  EXCEPTION
     WHEN ARG_NULL THEN
      O_COD_ERRO := 1;
      O_MSG_ERRO := 'Todos os argumentos de entrada do procedimento são de preenchimento obrigatório.';
     WHEN STATUS_CHANGED THEN
      O_COD_ERRO := 2;
      O_MSG_ERRO := 'Existem movimentos que viram o seu estado alterado durante a execução do procedimento.';
     WHEN OTHERS THEN
      O_COD_ERRO := 3;
      O_MSG_ERRO := 'Ocorreu um erro ao executar o procedimento: '||SQLERRM;


	END SP_CANCELA_CONC_REGULARIZACAO;


   /**
   * Procedimento responsavel por actualizar os valores agrupados de um conjunto
   * assim como obter uma nova descrição para o grupo.
   */
   PROCEDURE SP_UPDT_VALORES_AGRUPADOS(
      I_ID_AGRUPADOR    IN  NUMBER,
      I_ID_TIPO_REGISTO IN  NUMBER,
      I_NM_UTILIZADOR   IN  VARCHAR2
   )
   IS
      IN_DESCRICAO_GRUPO  CONC_MOVIMENTO_EXTRACTO.DESCRICAO_GRUPO%TYPE;
   BEGIN

      -- Obtém a nova descrição para o grupo.
      --IN_DESCRICAO_GRUPO := SP_OBTEM_DESCRICAO_GRUPO(I_ID_TIPO_REGISTO,I_ID_AGRUPADOR);

      -- Actualizar os valores agrupados.
      FOR C_BANCO IN (SELECT
                             SUM(
                              CASE WHEN MOV.ID_ESTADO = 2 THEN
                                CASE
                                  WHEN MOV.TIPO_OPERACAO = 'D' THEN
                                  MOV.MONTANTE * -1
                                ELSE MOV.MONTANTE END
                              ELSE 0 END
                             ) SOMA,
                             MOV.AGRUPADOR,
                             COUNT(1) QTD,
                             MIN(MOV.DT_MOVIMENTO) DT_MOVIMENTO,
							 MIN(MOV.DT_EXTRACTO) DT_EXTRACTO,
                             MAX(MOV.DESCRICAO_MOVIMENTO) DESCRICAO_GRUPO,
                            CASE
                              WHEN COUNT(DISTINCT MOV.COD_DIVISAO) > 1 THEN
                                NULL
                              ELSE MIN(MOV.COD_DIVISAO) END COD_DIVISAO,
                            CASE
                              WHEN COUNT(DISTINCT MOV.COD_DIVISAO) > 1 THEN
                                'Diversas'
                              WHEN COUNT(DISTINCT MOV.COD_DIVISAO) = 0 THEN
                                NULL
                              ELSE MAX(D.NM_DIVISAO) END NM_DIVISAO_GRUPO,
                             MAX(TIPO_REGISTO) ID_TIPO_REG_GRUPO,
                             MAX(NUM_CONTA)NUM_CONTA
                        FROM
                          CONC_MOVIMENTO_EXTRACTO MOV
                          LEFT JOIN DGV.DGV_DIVISAO D ON MOV.COD_DIVISAO = D.COD_DIVISAO
                       WHERE ID_ESTADO IN (2,4)
                         AND AGRUPADOR = I_ID_AGRUPADOR
                       GROUP BY AGRUPADOR)

      LOOP

         UPDATE CONC_MOVIMENTO_EXTRACTO CME
            SET CME.VALOR_GRUPO = ABS(C_BANCO.SOMA),
                CME.NUM_MOVIMENTOS = C_BANCO.QTD,
                CME.DATA_GRUPO = C_BANCO.DT_MOVIMENTO,
				CME.DATA_EXTRACTO_GRUPO = C_BANCO.DT_EXTRACTO,
                CME.COD_DIVISAO_GRUPO = C_BANCO.COD_DIVISAO,
                CME.NM_DIVISAO_GRUPO = C_BANCO.NM_DIVISAO_GRUPO,
                CME.ID_TIPO_REG_GRUPO = C_BANCO.ID_TIPO_REG_GRUPO,
                CME.TP_MOV_GRUPO = (CASE WHEN C_BANCO.soma > 0 THEN 'C' ELSE 'D' END),
                CME.TIPO_REG_GRUPO = (SELECT VALOR FROM CONC_TIPO_REGISTO WHERE ID_TIPO_REGISTO = C_BANCO.ID_TIPO_REG_GRUPO),
                CME.DESCRICAO_GRUPO = C_BANCO.DESCRICAO_GRUPO,
                CME.NUM_CONTA_GRUPO = C_BANCO.NUM_CONTA,
                DH_UPDT = CURRENT_TIMESTAMP,
                DSC_UTIL_UPDT = I_NM_UTILIZADOR
          WHERE CME.AGRUPADOR = C_BANCO.AGRUPADOR;
      END LOOP;


  EXCEPTION
    -- se nao encontrou dados para calcular, quer dizer que já
    -- nao existem mais movimentos com este agrupador.
    WHEN NO_DATA_FOUND THEN
      NULL;
    WHEN OTHERS THEN
      RAISE;


   END SP_UPDT_VALORES_AGRUPADOS;


  /**
   * Procedimento responsavel por realizar as alterações necessárias em termos de reclassificação
   * de movimentos e por actualizar toda a informação subjacente a esta alteração.
   * CODIGOS DE ERRO:
   * ------------------
   * 1 - Campo obrigatório por preencher.
   * 2 - Não existe um utilizador com o identificador fornecido.
   * 3 - Não existem movimentos com o identificador fornecido.
   * 4 - O novo tipo de registo não e válido.
   * 5 - O indicador de origem do movimento é inválido. Apenas os valores D e E são autorizados.
   */
   PROCEDURE SP_UPDT_POS_RECLASSIFICACAO(
      I_ID_MOVIMENTO            IN  NUMBER,
      I_ORIGEM_MOVIMENTO        IN  CHAR, /** E - Extracto / D - Detalhe **/
      I_ID_ANTIGO_TIPO_REGISTO  IN  NUMBER,
      I_ID_NOVO_TIPO_REGISTO    IN  NUMBER,
      I_COD_NOVA_DIVISAO        IN  NUMBER,
      I_ID_UTILIZADOR           IN  NUMBER,
      O_COD_ERRO                OUT NUMBER,
      O_MSG_ERRO                OUT VARCHAR
   )
   IS
    IN_NM_UTILIZADOR DGV.DGV_USER.NM_USER%TYPE;
    IN_NM_DIVISAO_GENERICA DGV.DGV_DIVISAO.NM_DIVISAO%TYPE := 'Diversas';
    -- excepcoes personalizadas.
    IN_INVALID_USER EXCEPTION;
    IN_REQUIRED_ARGS EXCEPTION;
    IN_INVALID_MOV EXCEPTION;
    IN_INVALID_NEW_TP_REG EXCEPTION;
    IN_INVALID_SOURCE EXCEPTION;
   BEGIN

    -- por omissão não ocorre qualquer tipo de erro.
    O_COD_ERRO := 0;

    -- valida se todos os argumentos vêm preenchidos.
    IF
      I_ID_MOVIMENTO IS NULL
      OR I_ID_ANTIGO_TIPO_REGISTO IS NULL
      OR I_ID_NOVO_TIPO_REGISTO IS NULL
      --OR I_COD_NOVA_DIVISAO IS NULL
      OR I_ID_UTILIZADOR IS NULL
      OR I_ORIGEM_MOVIMENTO IS NULL
    THEN
      RAISE IN_REQUIRED_ARGS;
    ELSIF  
      I_ORIGEM_MOVIMENTO NOT IN ('D','E') THEN
      RAISE IN_INVALID_SOURCE;
    -- caso contrário valida so existe um utilizador com o identificador fornecido.
    ELSE
      BEGIN

        SELECT NM_USER INTO IN_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE IN_INVALID_USER;
      END;
    END IF;

    -- TPA <-> TPA - Caso que se esta a tratar da actualização de divisões nos movimentos de detalhe de tpa.
    IF I_ID_ANTIGO_TIPO_REGISTO = 3 AND I_ORIGEM_MOVIMENTO = 'D' THEN

       IF I_ID_NOVO_TIPO_REGISTO <> 3 THEN
        RAISE IN_INVALID_NEW_TP_REG;
       ELSIF I_COD_NOVA_DIVISAO IS NULL THEN
        RAISE IN_REQUIRED_ARGS;
       END IF;

       DECLARE
        IN_MOV_TPA CONC_MOVIMENTO_TPA_DETALHE%ROWTYPE;
        IN_NOVO_AGRUPADOR CONC_MOVIMENTO_TPA_DETALHE.AGRUPADOR%TYPE;
        IN_ANTIGO_AGRUPADOR CONC_MOVIMENTO_TPA_DETALHE.AGRUPADOR%TYPE;
       BEGIN

          -- obter o movimento do extracto com o identificador fornecido.
          SELECT * INTO IN_MOV_TPA FROM CONC_MOVIMENTO_TPA_DETALHE WHERE ID_MOV_TPA = I_ID_MOVIMENTO;

          -- Apenas e necessário proceder a actualizações caso o código de divisão seja diferente ou não estivesse preenchido.
          IF IN_MOV_TPA.COD_DIVISAO IS NULL OR IN_MOV_TPA.COD_DIVISAO <> I_COD_NOVA_DIVISAO THEN

            -- Guardar o agrupador antigo.
            IN_ANTIGO_AGRUPADOR := IN_MOV_TPA.AGRUPADOR;
            -- Gerar o novo agrupador.
            IN_NOVO_AGRUPADOR :=  '10'||I_COD_NOVA_DIVISAO||TO_CHAR(IN_MOV_TPA.DT_VALOR,'ddmmyyy');

            -- actualizar a divisao, agrupador e campos de auditoria.
            UPDATE CONC_MOVIMENTO_TPA_DETALHE
            SET COD_DIVISAO = I_COD_NOVA_DIVISAO,AGRUPADOR = IN_NOVO_AGRUPADOR,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
            WHERE ID_MOV_TPA = I_ID_MOVIMENTO;

            -- actualizar os valores agrupados para o novo grupo.
            -- Apenas é necessário actualizar o número de movimentos e montante uma
            -- vez que o agrupador já é baseado na data e divisão, fazendo com que todos eles tenham
            -- a mesma divisão e data.
            FOR C_MOVS IN (SELECT
                  SUM(
                  CASE
                    WHEN MOV_IN.TIPO_OPERACAO = 'D' THEN
                      MOV_IN.MONTANTE * -1
                    ELSE MOV_IN.MONTANTE END
                  ) VALOR_GRUPO,
                  COUNT(1) NUM_MOVIMENTOS,
                  MAX(MOV_IN.COD_DIVISAO) COD_DIVISAO_GRUPO,
                  MAX(D.NM_DIVISAO) NM_DIVISAO_GRUPO
                FROM
                  CONC_MOVIMENTO_TPA_DETALHE MOV_IN
                  LEFT JOIN
                  DGV.DGV_DIVISAO D ON MOV_IN.COD_DIVISAO = D.COD_DIVISAO
                WHERE MOV_IN.AGRUPADOR = IN_NOVO_AGRUPADOR GROUP BY MOV_IN.AGRUPADOR)
              LOOP
                UPDATE CONC_MOVIMENTO_TPA_DETALHE MOV
                SET MOV.VALOR_GRUPO = ABS(C_MOVS.VALOR_GRUPO),
                  MOV.TP_MOV_GRUPO = (CASE WHEN C_MOVS.VALOR_GRUPO > 0 THEN 'C' ELSE 'D' END),
                  MOV.NUM_MOVIMENTOS = C_MOVS.NUM_MOVIMENTOS,
                  MOV.DSC_UTIL_UPDT = IN_NM_UTILIZADOR,
                  MOV.DH_UPDT = CURRENT_TIMESTAMP,
                  MOV.COD_DIVISAO_GRUPO = C_MOVS.COD_DIVISAO_GRUPO,
                  MOV.NM_DIVISAO_GRUPO = C_MOVS.NM_DIVISAO_GRUPO
                  WHERE MOV.AGRUPADOR = IN_NOVO_AGRUPADOR;
              END LOOP;


            -- Actualizar os valores agrupados para o grupo antigo.
            -- Apenas é necessário actualizar o número de movimentos e montante uma
            -- vez que o agrupador já é baseado na data e divisão, fazendo com que todos eles tenham
            -- a mesma divisão e data.
			FOR C_MOVS IN (SELECT
							  SUM(
								CASE WHEN MOV_IN.TIPO_OPERACAO = 'D' THEN MOV_IN.MONTANTE * -1
								ELSE MOV_IN.MONTANTE END) VALOR_GRUPO,
							  COUNT(1) NUM_MOVIMENTOS
							FROM
							  CONC_MOVIMENTO_TPA_DETALHE MOV_IN
							WHERE MOV_IN.AGRUPADOR = IN_ANTIGO_AGRUPADOR)

			LOOP
				UPDATE CONC_MOVIMENTO_TPA_DETALHE MOV
				SET
				MOV.VALOR_GRUPO = ABS(C_MOVS.VALOR_GRUPO),
				MOV.TP_MOV_GRUPO = (CASE WHEN C_MOVS.VALOR_GRUPO > 0 THEN 'C' ELSE 'D' END),
				MOV.NUM_MOVIMENTOS = C_MOVS.NUM_MOVIMENTOS,
				MOV.DSC_UTIL_UPDT = IN_NM_UTILIZADOR,
				MOV.DH_UPDT = CURRENT_TIMESTAMP
				WHERE MOV.AGRUPADOR = IN_ANTIGO_AGRUPADOR;

			END LOOP;



          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE IN_INVALID_MOV;

        END;
    -- RefMB <-> RefMB - Caso em que se pretende actualizar as divisões nos movimentos de detalhe de referencia multibanco.
    ELSIF I_ID_ANTIGO_TIPO_REGISTO = 4 AND I_ORIGEM_MOVIMENTO = 'D' THEN

       IF I_ID_NOVO_TIPO_REGISTO <> 4 THEN
        RAISE IN_INVALID_NEW_TP_REG;
       END IF;

       DECLARE
        IN_MOV_MPSIBS CONC_MOVIMENTO_MPSIBS%ROWTYPE;
        IN_NUM_DIVISOES_DIFERENTES NUMBER;
        IN_NM_DIVISAO_GRUPO DGV.DGV_DIVISAO.NM_DIVISAO%TYPE;
       BEGIN

          -- obter o movimento do extracto com o identificador fornecido.
          SELECT * INTO IN_MOV_MPSIBS FROM CONC_MOVIMENTO_MPSIBS WHERE ID_MOV_MPSIBS = I_ID_MOVIMENTO;

          -- Apenas e necessário proceder a actualizações caso o código de divisão seja diferente ou não estivesse preenchido.
          IF (I_COD_NOVA_DIVISAO IS NULL AND IN_MOV_MPSIBS.COD_DIVISAO IS NOT NULL) OR IN_MOV_MPSIBS.COD_DIVISAO IS NULL OR IN_MOV_MPSIBS.COD_DIVISAO <> I_COD_NOVA_DIVISAO THEN

            -- actualizar a divisao e campos de auditoria.
            UPDATE CONC_MOVIMENTO_MPSIBS
            SET COD_DIVISAO = I_COD_NOVA_DIVISAO,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
            WHERE ID_MOV_MPSIBS = I_ID_MOVIMENTO;

            -- ver quantas divisoes distintas existem neste conjunto.
            SELECT COUNT(DISTINCT COD_DIVISAO) INTO IN_NUM_DIVISOES_DIFERENTES FROM CONC_MOVIMENTO_MPSIBS WHERE AGRUPADOR = IN_MOV_MPSIBS.AGRUPADOR;

            -- se apenas existir uma divisão distinta, estabelece a mesma como o valor para o grupo
            IF IN_NUM_DIVISOES_DIFERENTES = 1 AND I_COD_NOVA_DIVISAO IS NOT NULL THEN
                -- obter o nome da divisão.
                SELECT NM_DIVISAO INTO IN_NM_DIVISAO_GRUPO FROM DGV.DGV_DIVISAO WHERE COD_DIVISAO = I_COD_NOVA_DIVISAO;

                -- colocar o nome da divisão seleccionada como sendo a divisao do grupo.
                UPDATE CONC_MOVIMENTO_MPSIBS
                SET COD_DIVISAO_GRUPO = I_COD_NOVA_DIVISAO,NM_DIVISAO_GRUPO = IN_NM_DIVISAO_GRUPO,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
                WHERE AGRUPADOR = IN_MOV_MPSIBS.AGRUPADOR;

            -- caso constrário exista mais do que uma, coloca a divisão a null e a descrição genérica.
            ELSIF IN_NUM_DIVISOES_DIFERENTES > 1 THEN
                UPDATE CONC_MOVIMENTO_MPSIBS
                SET COD_DIVISAO_GRUPO = NULL,NM_DIVISAO_GRUPO = IN_NM_DIVISAO_GENERICA,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
                WHERE AGRUPADOR = IN_MOV_MPSIBS.AGRUPADOR;
            -- caso contrario quer dizer que nenhum movimento tem divisão associada, e como tal limpa os dados sobre a mesma.
            ELSE
                UPDATE CONC_MOVIMENTO_MPSIBS
                SET COD_DIVISAO_GRUPO = NULL,NM_DIVISAO_GRUPO = NULL,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
                WHERE AGRUPADOR = IN_MOV_MPSIBS.AGRUPADOR;
            END IF;

          END IF;

          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE IN_INVALID_MOV;

        END;
    -- a alteraçao incide sobre a tabela de extracto.
    ELSE
      DECLARE
        IN_MOV_EXTRACTO CONC_MOVIMENTO_EXTRACTO%ROWTYPE;
        IN_MOV_EXTRACTO_CHEQUE CONC_MOVIMENTO_EXTRACTO%ROWTYPE;
        IN_AGRUPADOR_INICIAL CONC_MOVIMENTO_EXTRACTO.AGRUPADOR%TYPE;
        IN_AGRUPADOR_FINAL  CONC_MOVIMENTO_EXTRACTO.AGRUPADOR%TYPE;
        IN_EXISTE_MOV_CHEQUE BOOLEAN := TRUE;
      BEGIN

        -- obter o movimento do extracto com o identificador fornecido.
        SELECT * INTO IN_MOV_EXTRACTO FROM CONC_MOVIMENTO_EXTRACTO WHERE ID_MOV_BANCO = I_ID_MOVIMENTO;

        IN_AGRUPADOR_INICIAL := IN_MOV_EXTRACTO.AGRUPADOR;

          -- * -> CheqIrr - Caso em que se pretende passar um movimento de extracto para um cheque irregular.
        IF I_ID_ANTIGO_TIPO_REGISTO IN (1,2,6,7) AND  I_ID_NOVO_TIPO_REGISTO = 5 THEN


          -- Antes de proceder a actualização, analisa se existe a possíbilidade de recuperar algum agrupamento.
          -- A recuperação apenas e possível caso o movimento que esta a ser reclassificado tenha o número de cheque ou número
          -- de cheque tx preenchido e seja diferente de 0.

          -- Primeiro caso: existe número de cheque e é diferente de 0.
          IF IN_MOV_EXTRACTO.NUM_CHEQUE IS NOT NULL AND IN_MOV_EXTRACTO.NUM_CHEQUE <> 0 THEN
            -- tenta validar se existe um movimento de encargos para este cheque.
            BEGIN
              SELECT * INTO IN_MOV_EXTRACTO_CHEQUE FROM CONC_MOVIMENTO_EXTRACTO WHERE NUM_CHEQUE_TX = IN_MOV_EXTRACTO.NUM_CHEQUE;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                IN_EXISTE_MOV_CHEQUE := FALSE;
            END;
          -- Segundo caso: existe número de cheque tx e e diferente de 0.
          ELSIF IN_MOV_EXTRACTO.NUM_CHEQUE_TX IS NOT NULL AND IN_MOV_EXTRACTO.NUM_CHEQUE_TX <> 0 THEN
            -- tenta validar se existe um movimento de devolução para este cheque.
            BEGIN
              SELECT * INTO IN_MOV_EXTRACTO_CHEQUE FROM CONC_MOVIMENTO_EXTRACTO WHERE NUM_CHEQUE = IN_MOV_EXTRACTO.NUM_CHEQUE_TX;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                IN_EXISTE_MOV_CHEQUE := FALSE;
            END;
		  ELSE
	          IN_EXISTE_MOV_CHEQUE := FALSE;
          END IF;

          -- Se encontrou outro movimento, utiliza o mesmo agrupador.
          IF IN_EXISTE_MOV_CHEQUE THEN

            IN_AGRUPADOR_FINAL := IN_MOV_EXTRACTO_CHEQUE.AGRUPADOR;

          -- Se não encontrou nenhum movimento passível de ser relacionado, coloca o movimento num novo grupo.
          ELSE
            -- obter um novo agrupador.
            SELECT SQ_ID_MOVIMENTO_ASSOCIADO.NEXTVAL INTO IN_AGRUPADOR_FINAL FROM DUAL;

          END IF;

          -- actualizar os dados do registo e colocar um novo agrupador de forma a garantir que fica separado de qualquer outro movimento com o qual
          -- esteja agrupado.
          UPDATE
            CONC_MOVIMENTO_EXTRACTO
          SET TIPO_REGISTO = I_ID_NOVO_TIPO_REGISTO,COD_DIVISAO = I_COD_NOVA_DIVISAO,AGRUPADOR = IN_AGRUPADOR_FINAL,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
          WHERE ID_MOV_BANCO = I_ID_MOVIMENTO;

          -- actualiza valores agrupados (grupo antigo).
          SP_UPDT_VALORES_AGRUPADOS(IN_AGRUPADOR_INICIAL,I_ID_ANTIGO_TIPO_REGISTO,IN_NM_UTILIZADOR);

          -- actualiza valores agrupados (grupo novo).
          SP_UPDT_VALORES_AGRUPADOS(IN_AGRUPADOR_FINAL,I_ID_NOVO_TIPO_REGISTO,IN_NM_UTILIZADOR);



        -- CheqIrr -> * - Caso em que se pretende passar um movimentos de cheque irregular para outros de tratamento genérico.
        ELSIF I_ID_ANTIGO_TIPO_REGISTO = 5 AND I_ID_NOVO_TIPO_REGISTO IN (1,2,6,7) THEN

          -- obter um novo agrupador.
          SELECT SQ_ID_MOVIMENTO_ASSOCIADO.NEXTVAL INTO IN_AGRUPADOR_FINAL FROM DUAL;

          -- actualizar os dados do registo e colocar um novo agrupador de forma a garantir que fica separado de qualquer outro movimento com o qual
          -- esteja agrupado.
          UPDATE
            CONC_MOVIMENTO_EXTRACTO
          SET TIPO_REGISTO = I_ID_NOVO_TIPO_REGISTO,COD_DIVISAO = I_COD_NOVA_DIVISAO,AGRUPADOR = IN_AGRUPADOR_FINAL,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
          WHERE ID_MOV_BANCO = I_ID_MOVIMENTO;

          -- actualiza valores agrupados (grupo antigo).
          SP_UPDT_VALORES_AGRUPADOS(IN_AGRUPADOR_INICIAL,I_ID_ANTIGO_TIPO_REGISTO,IN_NM_UTILIZADOR);

          -- actualiza valores agrupados (grupo novo).
          SP_UPDT_VALORES_AGRUPADOS(IN_AGRUPADOR_FINAL,I_ID_NOVO_TIPO_REGISTO,IN_NM_UTILIZADOR);

        -- * <-> * - Caso que se pretende passar de um movimento de extracto de tratamento generico para outro com o mesmo tipo de tratamento.
        ELSE

          -- caso se esteja o tipo de registo actual seja ref. mb ou tpa, então este tinha já de ser o tipo do movimento antes desta operação.
          IF I_ID_NOVO_TIPO_REGISTO IN (3,4) AND  I_ID_ANTIGO_TIPO_REGISTO NOT IN (3,4) THEN
            RAISE IN_INVALID_NEW_TP_REG;
          END IF;


          UPDATE
            CONC_MOVIMENTO_EXTRACTO
          SET TIPO_REGISTO = I_ID_NOVO_TIPO_REGISTO,COD_DIVISAO = I_COD_NOVA_DIVISAO,DSC_UTIL_UPDT = IN_NM_UTILIZADOR,DH_UPDT = CURRENT_TIMESTAMP
          WHERE ID_MOV_BANCO = I_ID_MOVIMENTO;

          -- actualiza valores agrupados (o grupo mantém-se).
          SP_UPDT_VALORES_AGRUPADOS(IN_MOV_EXTRACTO.AGRUPADOR,I_ID_NOVO_TIPO_REGISTO,IN_NM_UTILIZADOR);

        END IF;


        EXCEPTION
          WHEN NO_DATA_FOUND THEN
           RAISE IN_INVALID_MOV;

      END;
    END IF;

    -- tratamento de erros.
    EXCEPTION
     WHEN IN_INVALID_USER THEN
        O_COD_ERRO := 2;
        O_MSG_ERRO := 'Não existe um utilizador com o identificador fornecido.';
     WHEN IN_REQUIRED_ARGS THEN
        O_COD_ERRO := 1;
        O_MSG_ERRO := 'Todos os argumentos de entrada são de preenchimento ';
     WHEN IN_INVALID_MOV THEN
        O_COD_ERRO := 3;
        O_MSG_ERRO := 'Não foi possível encontrar o movimento com o identificador fornecido.';
     WHEN IN_INVALID_NEW_TP_REG THEN
        O_COD_ERRO := 4;
        O_MSG_ERRO := 'O novo tipo de registo não é permitido.';
     WHEN IN_INVALID_SOURCE THEN
        O_COD_ERRO := 5;
        O_MSG_ERRO := 'O indicador de origem do movimento é inválido. Apenas os valores D e E são autorizados.';
     WHEN OTHERS THEN
        O_COD_ERRO := 10;
        O_MSG_ERRO := 'Ocorreu um erro ao tentar processar a reclassificação.'|| SQLERRM ||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE();

   END SP_UPDT_POS_RECLASSIFICACAO;

	/**
	  * Executa a conciliação automática de movimentos equivalentes, débito/crédito, para os movimentos do ficheiro importado
	  *  I_ID_FICHEIRO_IMPORTADO - id do ficheiro importado para o qual se procura
	  *  I_ID_UTILIZADOR - id do utilizador a executar a operacao
	  *
	  * RETURN CODES:
	  * 20 - Erro na execução do PC_CONC.SP_CONC_INTERFACE
	  * 21 - Erro na execução do PC_CONC.SP_CONC_GRAVA_CONCILIACAO
	  */
	   PROCEDURE SP_CONC_DEB_CRED_EXTRACTO(
	      I_ID_FICHEIRO_IMPORTADO    IN    NUMBER,
	      I_ID_UTILIZADOR  IN DGV.DGV_USER.ID_USER%TYPE,
	      O_COD_ERRO OUT NUMBER,
	      O_MSG_ERRO OUT VARCHAR
	   )
	   IS
		agrupador VARCHAR2(100);
		count_for_update number;
		tipo_movimento_banco varchar2(1) := 2; --movimento de extracto
		cod_erro number;
		msg_erro VARCHAR2(200);

	    BEGIN

			FOR cursor1 IN (SELECT ID_MOV_BANCO_1,ID_MOV_BANCO_2
                      FROM (SELECT cme.id_mov_banco ID_MOV_BANCO_1, cme2.id_mov_banco ID_MOV_BANCO_2,
									row_number() over (partition by least(cme.id_mov_banco,cme2.id_mov_banco),
																		   greatest(cme.id_mov_banco,cme2.id_mov_banco) order by cme.id_mov_banco) as rn
									FROM conc_movimento_extracto cme, conc_movimento_extracto cme2
									WHERE cme.tipo_registo = 1 AND cme.id_estado = 2 AND cme.ID_FICHEIRO_IMPORTADO = I_ID_FICHEIRO_IMPORTADO
											AND cme2.ID_ESTADO = 2
											AND cme.num_conta = cme2.num_conta
											AND CME.COD_DIVISAO = cme2.COD_DIVISAO
											AND cme.descricao_movimento = cme2.descricao_movimento
											AND cme.montante = cme2.MONTANTE
											AND cme.tipo_operacao <> cme2.tipo_operacao
											AND ABS(CME.DT_MOVIMENTO - cme2.DT_MOVIMENTO) BETWEEN 0 AND 1
									)
							where rn = 1)
      			LOOP
					--verifica se os id_movimentos continuam por conciliar
					SELECT COUNT(1) INTO count_for_update from conc_movimento_extracto where (id_mov_banco = cursor1.ID_MOV_BANCO_1 and id_estado = 2) or (id_mov_banco = cursor1.ID_MOV_BANCO_2 and id_estado = 2);

					IF count_for_update = 2 THEN

						agrupador := null;

						--dbms_output.put_line('A conciliar os movimentos: id_mov_banco 1: ' || cursor1.ID_MOV_BANCO_1 || '; id_mov_banco 2: ' || cursor1.ID_MOV_BANCO_2);

						--guarda a conciliacao na interface - movimento 1
						SP_CONC_INTERFACE(cursor1.ID_MOV_BANCO_1, tipo_movimento_banco, agrupador, I_ID_UTILIZADOR, cod_erro);

						IF cod_erro = 0 THEN

							--guarda a conciliacao na interface - movimento 2
							SP_CONC_INTERFACE(cursor1.ID_MOV_BANCO_2, tipo_movimento_banco, agrupador, I_ID_UTILIZADOR, cod_erro);

							IF cod_erro =  0 THEN

								--dbms_output.put_line('A gravar conciliação de movimentos: id_mov_banco 1: ' || cursor1.ID_MOV_BANCO_1 || '; id_mov_banco 2: ' || cursor1.ID_MOV_BANCO_2);
								--grava conciliacao com agrupador
								SP_CONC_GRAVA_CONCILIACAO(agrupador, I_ID_UTILIZADOR, null, cod_erro, msg_erro);

								IF cod_erro <> 0 THEN
									O_COD_ERRO := 21;
									O_MSG_ERRO := 'Nem todos os movimentos encontrados foram tratados por ter sido recebido erro na execução do PC_CONC.SP_CONC_GRAVA_CONCILIACAO - codErro: ' || cod_erro || ' -> ' || msg_erro;
								END IF;
							ELSE
								O_COD_ERRO := 20;
								O_MSG_ERRO := 'Nem todos os movimentos encontrados foram tratados por ter sido recebido erro na execução do PC_CONC.SP_CONC_INTERFACE - codErro: ' || cod_erro;
							END IF;
						ELSE
								O_COD_ERRO := 20;
								O_MSG_ERRO := 'Nem todos os movimentos encontrados foram tratados por ter sido recebido erro na execução do PC_CONC.SP_CONC_INTERFACE - codErro: ' || cod_erro;
						END IF;

					END IF;
		       END LOOP;
	END SP_CONC_DEB_CRED_EXTRACTO;

	/*
	 * Permite remover movimentos do scct para abrir uma caixa e executar a criacao de um novo talao de deposito
	 */
	PROCEDURE sp_remove_mov_scct_by_caixa(
      I_ID_CAIXA    IN    NUMBER,
      I_ID_UTILIZADOR IN NUMBER
   )
   IS
      GRUPOS_UPDT TP_SYNC_TAB_UPDT_GROUP := TP_SYNC_TAB_UPDT_GROUP();
      V_NM_UTILIZADOR           DGV.DGV_USER.NM_USER%TYPE;
   BEGIN

      SELECT NM_USER INTO V_NM_UTILIZADOR FROM DGV.DGV_USER WHERE ID_USER = I_ID_UTILIZADOR;

	 --obtem os agrupadores a actualizar - que correspondem aos movimentos que serao eliminados
	 SELECT (CAST(MULTISET(SELECT TP_SYNC_UPDT_GROUP(cmc.AGRUPADOR,cmc.NUM_CHEQUE) FROM CONC_MOVIMENTO_SCCT cmc
       WHERE CMC.ID_TRANSACCAO IN (SELECT ID_TRANSACCAO FROM TRANSACCAO WHERE ID_CAIXA = I_ID_CAIXA)) AS TP_SYNC_TAB_UPDT_GROUP)) INTO GRUPOS_UPDT  FROM DUAL;

	  --elimina os movimentos associados a caixa recebida
      DELETE FROM CONC_MOVIMENTO_SCCT cmc
       WHERE CMC.ID_TRANSACCAO IN (SELECT ID_TRANSACCAO FROM TRANSACCAO WHERE ID_CAIXA = I_ID_CAIXA);

	  FOR GRUPO IN (SELECT DISTINCT AGRUPADOR FROM TABLE(GRUPOS_UPDT))

        LOOP

          UPDATE
           CONC_MOVIMENTO_SCCT MOVS
          SET (MOVS.VALOR_GRUPO,MOVS.NUM_MOVIMENTOS, MOVS.DH_UPDT, MOVS.dsc_util_updt) = (SELECT
							SUM(
					            CASE
					              WHEN MOVS_IN.TIPO_OPERACAO = 'D' THEN
					                MOVS_IN.VALOR*(-1)
					              ELSE MOVS_IN.VALOR END) VALOR_GRUPO,
                              COUNT(1) NUM_MOVIMENTOS, sysdate, 'SCTTAPP'

                             FROM
                             CONC_MOVIMENTO_SCCT MOVS_IN
                             WHERE
                              MOVS_IN.AGRUPADOR = GRUPO.AGRUPADOR
                              -- apenas os que nao estao conciliados.
                              AND MOVS_IN.ID_ESTADO <> 4)
          WHERE MOVS.AGRUPADOR = GRUPO.AGRUPADOR;
        END LOOP;

   END sp_remove_mov_scct_by_caixa;

 	/**
    * Procedure que limpa os dados das tabelas de preconciliados para o utilizador enviado
    */
   PROCEDURE sp_conc_limpa_preconciliado(i_id_utilizador		IN	NUMBER) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
	
	BEGIN

		DELETE FROM CONC_MOV_MPSIBS_PRECONCILIADO cmp
		      WHERE  CMP.ID_UTILIZADOR = i_id_utilizador;
		DELETE FROM CONC_MOV_PRECONCILIADO cmp
		      WHERE  CMP.ID_UTILIZADOR = i_id_utilizador;
		DELETE FROM conc_mov_tpa_preconciliado cmp
		      WHERE  CMP.ID_UTILIZADOR = i_id_utilizador;
		
		COMMIT;

	END sp_conc_limpa_preconciliado;

   /**
    * Procedure que auxiliar na conciliação automática de um agrupador preconciliado
    */
   PROCEDURE sp_conc_auto_preconciliado(i_id_utilizador		IN	NUMBER,
										i_agrupador 		IN VARCHAR2,
        								o_cod_erro 			OUT	NUMBER,
        								o_msg_erro			OUT  VARCHAR2) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
	
	agrupador_conc VARCHAR2(100);
	AGRUPADOR_NULL EXCEPTION;

	BEGIN

		agrupador_conc := null;
		o_cod_erro := 0;
		
		--para cada um dos movimentos pre-conciliados para o agrupador guarda-o na tabela de interface
		--Movimentos do SCCT
		FOR C_PRE_CONC IN (SELECT distinct id_mov_scct FROM conc_mov_preconciliado cmp
			    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		LOOP
			        
			IF(o_cod_erro = 0) THEN
			          
				SP_CONC_INTERFACE(
								C_PRE_CONC.ID_MOV_SCCT,
								1,
								agrupador_conc,
								i_id_utilizador,
								o_cod_erro);
			END IF;
		END LOOP; -- movimentos SCCT por agrupador
					
		IF(o_cod_erro = 0) THEN
			--Movimentos de EXTRACTO
			FOR C_PRE_CONC IN (SELECT distinct id_mov_banco FROM conc_mov_preconciliado cmp
				    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		    LOOP
		        
				IF(o_cod_erro = 0) THEN
		          
					SP_CONC_INTERFACE(
										C_PRE_CONC.ID_MOV_BANCO,
										2,
										agrupador_conc,
										i_id_utilizador,
										o_cod_erro);
								
				END IF;
				
			END LOOP; -- movimentos EXTRACTO por agrupador
		END IF;
			
		IF(o_cod_erro = 0) THEN
	
			--verifica se foi correctamente gerado o agrupador de conciliacao
			IF(agrupador_conc is not null) THEN
				--executa a gravacao da conciliacao
				SP_CONC_GRAVA_CONCILIACAO(agrupador_conc, i_id_utilizador, 0, o_cod_erro, o_msg_erro);
			ELSE
				o_cod_erro := -111;
				o_msg_erro := 'Erro no registo dos dados nas tabelas CONC_INTERFACE - agrupador veio a NULL';

				--guarda a informacao dos movimentos a conciliar
				FOR C_PRE_CONC IN (SELECT distinct id_mov_scct FROM conc_mov_preconciliado cmp
			    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
					LOOP
						o_msg_erro := o_msg_erro || '; ID_MOV_SCCT -> ' || C_PRE_CONC.id_mov_scct;
					
					END LOOP;

				FOR C_PRE_CONC IN (SELECT distinct id_mov_banco FROM conc_mov_preconciliado cmp
				    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		    		LOOP
						o_msg_erro := o_msg_erro || '; ID_MOV_BANCO -> ' || C_PRE_CONC.ID_MOV_BANCO;
					END LOOP;
		        
			END IF;
		END IF;


		IF (O_COD_ERRO <> 0) THEN 
			ROLLBACK;		
		ELSE
			COMMIT;
		END IF;
	
	EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;

   END sp_conc_auto_preconciliado;

	/**
    * Procedure que auxiliar na conciliação automática de um agrupador preconciliado
    */
   PROCEDURE sp_conc_auto_preconc_tpa(i_id_utilizador		IN	NUMBER,
										i_agrupador 		IN VARCHAR2,
        								o_cod_erro 			OUT	NUMBER,
        								o_msg_erro			OUT  VARCHAR2) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
	
	agrupador_conc VARCHAR2(100);
	AGRUPADOR_NULL EXCEPTION;

	BEGIN

		agrupador_conc := null;
		o_cod_erro := 0;
		
		--para cada um dos movimentos pre-conciliados para o agrupador guarda-o na tabela de interface
		--Movimentos do SCCT
		FOR C_PRE_CONC IN (SELECT distinct id_mov_scct FROM conc_mov_preconciliado cmp
			    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		LOOP
			        
			IF(o_cod_erro = 0) THEN
			          
				SP_CONC_INTERFACE(
								C_PRE_CONC.ID_MOV_SCCT,
								1,
								agrupador_conc,
								i_id_utilizador,
								o_cod_erro);
			END IF;
		END LOOP; -- movimentos SCCT por agrupador
					
		IF(o_cod_erro = 0) THEN
			--Movimentos de TPA
			FOR C_PRE_CONC IN (SELECT distinct id_mov_banco FROM conc_mov_preconciliado cmp
				    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		    LOOP
		        
				IF(o_cod_erro = 0) THEN
		          
					SP_CONC_INTERFACE(
										C_PRE_CONC.ID_MOV_BANCO,
										3,
										agrupador_conc,
										i_id_utilizador,
										o_cod_erro);
								
				END IF;
				
			END LOOP; -- movimentos EXTRACTO por agrupador
		END IF;
			
		IF(o_cod_erro = 0) THEN
	
			--verifica se foi correctamente gerado o agrupador de conciliacao
			IF(agrupador_conc is not null) THEN
				--executa a gravacao da conciliacao
				SP_CONC_GRAVA_CONCILIACAO(agrupador_conc, i_id_utilizador, 0, o_cod_erro, o_msg_erro);
			ELSE
				o_cod_erro := -111;
				o_msg_erro := 'Erro no registo dos dados nas tabelas CONC_INTERFACE - agrupador veio a NULL';

				--guarda a informacao dos movimentos a conciliar
				FOR C_PRE_CONC IN (SELECT distinct id_mov_scct FROM conc_mov_preconciliado cmp
			    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
					LOOP
						o_msg_erro := o_msg_erro || '; ID_MOV_SCCT -> ' || C_PRE_CONC.id_mov_scct;
					
					END LOOP;

				FOR C_PRE_CONC IN (SELECT distinct id_mov_banco FROM conc_mov_preconciliado cmp
				    							WHERE  cmp.AGRUPADOR = i_agrupador and cmp.id_utilizador = i_id_utilizador)
		    		LOOP
						o_msg_erro := o_msg_erro || '; ID_MOV_TPA -> ' || C_PRE_CONC.ID_MOV_BANCO;
					END LOOP;
		        
			END IF;
		END IF;


		IF (O_COD_ERRO <> 0) THEN 
			ROLLBACK;		
		ELSE
			COMMIT;
		END IF;
	
	EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;

		  o_cod_erro := -10;
		  o_msg_erro := 'Erro no procedimento sp_conc_auto_preconc_tpa: ' || SQLERRM;

   END sp_conc_auto_preconc_tpa;

   /**
    * Procedure que executa a conciliação automática, por triangulação, das referências MB por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_ref_mb_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
	BEGIN
		
		sp_conc_limpa_preconciliado(i_id_utilizador);

		--pre concilia os movimentos de referencia MB de acordo com os parametros definidos para a conciliacao automatica
		sp_pre_concilia_auto(i_id_utilizador,
                        i_num_conta,
                        1,
                        4,
                        i_data_inicio,
                        i_data_fim,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        o_cod_erro,
                        1);
	
		-- se a pre conciliacao correu com sucesso executa a conciliacao automatica
		IF(o_cod_erro = 0) THEN
			-- para cada agrupador criado pela pre conciliacao executa a conciliacao entre scct e extracto
			FOR C_AGRUPADOR IN (SELECT DISTINCT AGRUPADOR FROM conc_mov_preconciliado cmp
		    							WHERE  cmp.id_utilizador = i_id_utilizador)		
		     LOOP
				
				sp_conc_auto_preconciliado(i_id_utilizador, c_agrupador.agrupador, o_cod_erro, o_msg_erro);		
		
				exit when o_cod_erro <> 0;
			 END LOOP; --agrupador
	
	     END IF;
	END sp_conc_ref_mb_automatica;

---

	/**
    * Procedure que executa a conciliação parcial (DETALHE MPSIBS - SCCT) automática das referências MB por conciliar 
    * com movimentos do banco já associados ao movimento de detalhe!!
    */
   PROCEDURE sp_conc_parc_ref_mb_auto(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
		agrupador_conc 		VARCHAR2(100);
		v_data_flag			NUMBER;
		v_id_dimensao		NUMBER;
		v_data_intervalo	NUMBER;
    CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 4;
	BEGIN
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 4 AND id_dimensao = 3;

		 ELSE
			--valor por defeito 60
			v_data_intervalo := 60;
         END IF;
		
		pc_conc_aux.SP_PARC_CONC_MB_AUX(v_data_intervalo, TO_DATE('2010-01-01','YYYY-MM-DD'),
                        CURRENT_DATE, i_id_utilizador, i_num_conta);

		EXCEPTION
	     WHEN OTHERS THEN
	        O_COD_ERRO := 10;
	        O_MSG_ERRO := 'Ocorreu um erro ao executar a conciliacao parcial de referencias MB.' || SQLERRM ;

	END sp_conc_parc_ref_mb_auto;

--

   /**
    * Procedure que executa a conciliação automática dos talões de depósito por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_taloes_dep_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
	BEGIN
		
		sp_conc_limpa_preconciliado(i_id_utilizador);

		--pre concilia os movimentos de talões de depósito de acordo com os parametros definidos para a conciliacao automatica
		sp_pre_concilia_auto(i_id_utilizador,
                        i_num_conta,
                        1,
                        1,
                        i_data_inicio,
                        i_data_fim,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        o_cod_erro,
                        1);
	
		-- se a pre conciliacao correu com sucesso executa a conciliacao automatica
		IF(o_cod_erro = 0) THEN
			-- para cada agrupador criado pela pre conciliacao executa a conciliacao entre scct e extracto
			FOR C_AGRUPADOR IN (SELECT DISTINCT AGRUPADOR FROM conc_mov_preconciliado cmp
		    							WHERE  cmp.id_utilizador = i_id_utilizador)		
		     LOOP
				
				sp_conc_auto_preconciliado(i_id_utilizador, c_agrupador.agrupador, o_cod_erro, o_msg_erro);	

				exit when o_cod_erro <> 0;
				
			 END LOOP; --agrupador
	
	     END IF;
	END sp_conc_taloes_dep_automatica;

---

	/**
    * Procedure que executa a conciliação automática dos talões PAC por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_taloes_pac_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
	BEGIN
		
		sp_conc_limpa_preconciliado(i_id_utilizador);

		--pre concilia os movimentos de talões PAC de acordo com os parametros definidos para a conciliacao automatica
		sp_pre_concilia_auto(i_id_utilizador,
                        i_num_conta,
                        1,
                        2,
                        i_data_inicio,
                        i_data_fim,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        o_cod_erro,
                        1);

		-- se a pre conciliacao correu com sucesso executa a conciliacao automatica
		IF(o_cod_erro = 0) THEN
			-- para cada agrupador criado pela pre conciliacao executa a conciliacao entre scct e extracto
			FOR C_AGRUPADOR IN (SELECT DISTINCT AGRUPADOR FROM conc_mov_preconciliado cmp
		    							WHERE  cmp.id_utilizador = i_id_utilizador)		
		     LOOP
				
				sp_conc_auto_preconciliado(i_id_utilizador, c_agrupador.agrupador, o_cod_erro, o_msg_erro);		

				exit when o_cod_erro <> 0;
				
			 END LOOP; --agrupador
	
	     END IF;
	END sp_conc_taloes_pac_automatica;

---

   /**
    * Procedure que executa a conciliação parcial automática de TPA 
    */
   PROCEDURE sp_conc_parc_tpa_auto(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
		agrupador_conc 		VARCHAR2(100);
		v_data_flag			NUMBER;
		v_id_dimensao		NUMBER;
		v_data_intervalo	NUMBER;
    CURSOR c_dimensao
      IS
         SELECT id_dimensao
           FROM conc_parametrizacao
          WHERE tipo_registo = 3;
	BEGIN
         v_data_flag := 0;

         OPEN c_dimensao;

         LOOP
            FETCH c_dimensao
             INTO v_id_dimensao;

            EXIT WHEN c_dimensao%NOTFOUND;

            IF v_id_dimensao = 3 THEN
               v_data_flag := 1;
            END IF;
         END LOOP;

         CLOSE c_dimensao;

         IF v_data_flag = 1 THEN
            SELECT intervalo
              INTO v_data_intervalo
              FROM conc_parametrizacao
             WHERE tipo_registo = 3 AND id_dimensao = 3;

		 ELSE
			--valor por defeito 
			v_data_intervalo := 3;
         END IF;
		
		pc_conc_aux.SP_PARC_CONC_TPA_AUX(v_data_intervalo, TO_DATE('2010-01-01','YYYY-MM-DD'),
                        CURRENT_DATE, i_id_utilizador, i_num_conta);

		EXCEPTION
	     WHEN OTHERS THEN
	        O_COD_ERRO := 10;
	        O_MSG_ERRO := 'Ocorreu um erro ao executar a conciliacao parcial de referencias MB.' || SQLERRM ;

	END sp_conc_parc_tpa_auto;

---

	

	/**
    * Procedure que executa a conciliação automática de TPAs por conciliar
    * para uma determinada conta
    */
   PROCEDURE sp_conc_tpa_automatica(
        i_id_utilizador		IN	NUMBER,
      	i_num_conta			IN  VARCHAR2,
		i_data_inicio		IN DATE,
		i_data_fim			IN DATE,
        o_cod_erro 			OUT	NUMBER,
        o_msg_erro			OUT  VARCHAR2)

	IS
	BEGIN

		sp_conc_limpa_preconciliado(i_id_utilizador);

		--pre concilia os movimentos de TPAs de acordo com os parametros definidos para a conciliacao automatica
		sp_pre_concilia_auto(i_id_utilizador,
                        i_num_conta,
                        1,
                        3,
                        i_data_inicio,
                        i_data_fim,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        o_cod_erro,
                        1);
	
		-- se a pre conciliacao correu com sucesso executa a conciliacao automatica
		IF(o_cod_erro = 0) THEN
			-- para cada agrupador criado pela pre conciliacao executa a conciliacao entre scct e extracto
			FOR C_AGRUPADOR IN (SELECT DISTINCT AGRUPADOR FROM conc_mov_preconciliado cmp
		    							WHERE  cmp.id_utilizador = i_id_utilizador)		
		     LOOP
				
				sp_conc_auto_preconc_tpa(i_id_utilizador, c_agrupador.agrupador, o_cod_erro, o_msg_erro);	

				exit when o_cod_erro <> 0;
				
			 END LOOP; --agrupador
	
	     END IF;
	END sp_conc_tpa_automatica;


   /**
    * Importação manual de dados de uma referencia MB para conciliação
    */
  PROCEDURE SP_PROCESSA_MOVIMENTO_REF_MB(I_ID_REF_MB IN REFERENCIA_MULTIBANCO.ID_REFERENCIA_MULTIBANCO%TYPE, I_OBSERVACOES IN VARCHAR2, I_NM_USER IN DGV.DGV_USER.NM_USER%TYPE)
  IS
    IN_COUNT_ROWS_INSRT NUMBER :=0;
	IN_SOMA_GRUPO NUMBER;
    IN_NUM_MOVIMENTOS NUMBER;
  BEGIN

	--insere o movimento, correspondente ao id da ref mb recebida, na tabela CONC_MOVIMENTO_SCCT
    FOR MOV IN (SELECT
         TO_NUMBER(T.ID_TRANSACCAO||TP.ID_PAGAMENTO) ID_MOV_SCCT,
         T.ID_TRANSACCAO ID_TRANSACCAO,
         TP.ID_PAGAMENTO,
         NULL ID_MOVIMENTACAO_BANCARIA,
         T.DT_TRANSACCAO DT_MOVIMENTO,
         P.VALOR_PAGO VALOR,
         P.ID_MEIO_PAGAMENTO MEIO_PAGAMENTO,
         NULL NUM_CHEQUE,
         NULL REFERENCIA_DIVIDA,
         NULL N_VALE_POSTAL,
         RMB.ENTIDADE ENTIDADE,
         RMB.REFERENCIA REFERENCIA_MB,
         CASE
            WHEN CD.ID_TIPO_DOCUMENTO = 1 THEN 'FACTURA/RECIBO'
            WHEN CD.ID_TIPO_DOCUMENTO = 3 THEN 'RECIBO'
            ELSE '-1'
         END NUM_DOC,
         CD.NUM_NIF NIF_REQUERENTE,
         NULL N_TALAO_DEPOSITO,
         NULL MONTANTE_TALAO_DEPOSITO,
         NULL N_TALAO_DEPOSITO_PAC,
         NULL MONTANTE_TALAO_DEPOSITO_PAC,
         CB.NUM_CONTA NUM_CONTA,
         CB.NOME_BANCO BANCO,
         CB.AGENCIA AGENCIA,
         C.ID_DGV_USER ID_DGV_USER,
         C.ID_DGV_LOCAL COD_DIVISAO,
         TO_NUMBER('3'||RMB.ENTIDADE || C.ID_DGV_LOCAL||TO_CHAR(T.DT_TRANSACCAO, 'yyyymmdd')) AGRUPADOR,
         4 TIPO_REGISTO,
         'C' TIPO_OPERACAO,
         MP.DESCRICAO DESCRICAO,
         RMB.REFERENCIA||' | '||RMB.ENTIDADE DETALHE_DESCRICAO,
         T.DT_TRANSACCAO DATA_GRUPO,
         RMB.ENTIDADE DESCRICAO_GRUPO,
         C.ID_DGV_LOCAL COD_DIVISAO_GRUPO,
         DDD.NM_DIVISAO NM_DIVISAO_GRUPO,
         'C' TP_MOV_GRUPO,
         4 ID_TIPO_REG_GRUPO,
         'Referencia MB' TIPO_REG_GRUPO,
         CB.NUM_CONTA NUM_CONTA_GRUPO,
         P.VALOR_PAGO VALOR_GRUPO,
         NULL NUM_MOVIMENTOS,
         DDU.NM_USER NM_USER,
         CD.NUM_DOCUMENTO,
         CD.NUM_DOCUMENTO_ENTIDADE
      FROM
         TRANSACCAO T,
         TRANSACCAO_PAGAMENTO TP,
         PAGAMENTO P,
         CABECALHO_DOCUMENTO CD,
         REFERENCIA_MULTIBANCO RMB,
         AREA_NEGOCIO AN,
         CONTA_BANCARIA CB,
         CAIXA C,
         MEIO_PAGAMENTO MP,
         DGV.DGV_DIVISAO DDD,
         DGV.DGV_USER DDU
      WHERE
         T.ID_TIPO_TRANSACCAO = 1
		 AND T.ID_TRANSACCAO = TP.ID_TRANSACCAO
         AND TP.ID_PAGAMENTO = P.ID_PAGAMENTO
         AND P.ID_REFERENCIA_MULTIBANCO = RMB.ID_REFERENCIA_MULTIBANCO
         AND P.ID_MEIO_PAGAMENTO = 8
         AND P.VALOR_PAGO <> 0
         AND T.ID_CABECALHO_DOCUMENTO = CD.ID_CABECALHO_DOCUMENTO
         AND CD.ID_AREA_NEGOCIO = AN.ID_VALOR_PARAM_GERAL
         AND AN.ID_CONTA_BANCARIA = CB.ID_VALOR_PARAM_GERAL
		 -- apenas dados de caixas fechadas ou bloqueadas
         AND C.ID_ESTADO_CAIXA IN (3,5)
         AND T.ID_CAIXA = C.ID_CAIXA
         AND P.ID_MEIO_PAGAMENTO = MP.ID_MEIO_PAGAMENTO
         AND C.ID_DGV_LOCAL = DDD.COD_DIVISAO (+)
         AND C.ID_DGV_USER = DDU.ID_USER (+)
         AND RMB.ID_REFERENCIA_MULTIBANCO = I_ID_REF_MB
         AND NOT EXISTS(SELECT 1 FROM CONC_MOVIMENTO_SCCT MOV_OLD WHERE MOV_OLD.ID_MOV_SCCT =  TO_NUMBER(T.ID_TRANSACCAO||TP.ID_PAGAMENTO)))
    LOOP

      -- inserir o registo na tabela de movimentos
      INSERT INTO CONC_MOVIMENTO_SCCT (ID_MOV_SCCT,ID_TRANSACCAO,ID_PAGAMENTO,
          ID_MOVIMENTACAO_BANCARIA,DT_MOVIMENTO,VALOR,MEIO_PAGAMENTO,NUM_CHEQUE,REFERENCIA_DIVIDA,
          N_VALE_POSTAL,ENTIDADE,REFERENCIA_MB,NUM_DOC,NIF_REQUERENTE,N_TALAO_DEPOSITO,
          MONTANTE_TALAO_DEPOSITO,N_TALAO_DEPOSITO_PAC,MONTANTE_TALAO_DEPOSITO_PAC,NUM_CONTA,
          BANCO,AGENCIA,ID_DGV_USER,COD_DIVISAO,AGRUPADOR,TIPO_REGISTO,TIPO_OPERACAO,DESCRICAO,
          DETALHE_DESCRICAO,DATA_GRUPO,DESCRICAO_GRUPO,COD_DIVISAO_GRUPO,NM_DIVISAO_GRUPO,TP_MOV_GRUPO,
          ID_TIPO_REG_GRUPO,TIPO_REG_GRUPO,NUM_CONTA_GRUPO,VALOR_GRUPO,NUM_MOVIMENTOS,NM_USER,
          NUM_DOCUMENTO,NUM_DOCUMENTO_ENTIDADE,DH_INS,DSC_UTIL_INS,DH_UPDT,DSC_UTIL_UPDT,ID_ESTADO, OBSERVACOES)
      VALUES(MOV.ID_MOV_SCCT,MOV.ID_TRANSACCAO,MOV.ID_PAGAMENTO,
          MOV.ID_MOVIMENTACAO_BANCARIA,MOV.DT_MOVIMENTO,MOV.VALOR,MOV.MEIO_PAGAMENTO,MOV.NUM_CHEQUE,MOV.REFERENCIA_DIVIDA,
          MOV.N_VALE_POSTAL,MOV.ENTIDADE,MOV.REFERENCIA_MB,MOV.NUM_DOC,MOV.NIF_REQUERENTE,MOV.N_TALAO_DEPOSITO,
          MOV.MONTANTE_TALAO_DEPOSITO,MOV.N_TALAO_DEPOSITO_PAC,MOV.MONTANTE_TALAO_DEPOSITO_PAC,MOV.NUM_CONTA,
          MOV.BANCO,MOV.AGENCIA,MOV.ID_DGV_USER,MOV.COD_DIVISAO,MOV.AGRUPADOR,MOV.TIPO_REGISTO,MOV.TIPO_OPERACAO,MOV.DESCRICAO,
          MOV.DETALHE_DESCRICAO,MOV.DATA_GRUPO,MOV.DESCRICAO_GRUPO,MOV.COD_DIVISAO_GRUPO,MOV.NM_DIVISAO_GRUPO,MOV.TP_MOV_GRUPO,
          MOV.ID_TIPO_REG_GRUPO,MOV.TIPO_REG_GRUPO,MOV.NUM_CONTA_GRUPO,MOV.VALOR_GRUPO,MOV.NUM_MOVIMENTOS,MOV.NM_USER,
          MOV.NUM_DOCUMENTO,MOV.NUM_DOCUMENTO_ENTIDADE,CURRENT_TIMESTAMP,I_NM_USER,CURRENT_TIMESTAMP,I_NM_USER,2, I_OBSERVACOES);

      IN_COUNT_ROWS_INSRT := IN_COUNT_ROWS_INSRT + SQL%ROWCOUNT;

		-- Obtem os valores agrupados para o agrupador do movimento inserido
	    SELECT
	            SUM(
	              CASE WHEN MOVS_IN.TIPO_OPERACAO = 'C' THEN
	                MOVS_IN.VALOR
	              ELSE MOVS_IN.VALOR*-1 END
	            ) VALOR_GRUPO,
	            COUNT(1) NUM_MOVIMENTOS
	    INTO
	            IN_SOMA_GRUPO,
	            IN_NUM_MOVIMENTOS
	    FROM
	            CONC_MOVIMENTO_SCCT MOVS_IN
	    WHERE
	            MOVS_IN.AGRUPADOR = MOV.AGRUPADOR
	            -- apenas os que nao estao conciliados.
	            AND MOVS_IN.ID_ESTADO not in (4,6);
	
	    -- Actualiza os valores dos movimentos agrupados para o movimento inserido
	    UPDATE
			CONC_MOVIMENTO_SCCT MOVS
	    SET
	        MOVS.VALOR_GRUPO = ABS(IN_SOMA_GRUPO),
	        MOVS.NUM_MOVIMENTOS = IN_NUM_MOVIMENTOS,
	        MOVS.TP_MOV_GRUPO = DECODE(IN_SOMA_GRUPO,ABS(IN_SOMA_GRUPO),'C','D'),
			MOVS.DH_UPDT = sysdate,
			MOVS.dsc_util_updt = I_NM_USER
	    WHERE
	        MOVS.AGRUPADOR = MOV.AGRUPADOR;
    END LOOP;

     -- inserir no log a indicacao que o processo terminou com sucesso.
    IF (IN_COUNT_ROWS_INSRT <> 1) THEN
		RAISE_APPLICATION_ERROR(-20002, 'Erro a importar a referência multibanco para conciliação: ID_REFERENCIA_MULTIBANCO = ' || I_ID_REF_MB || ', n.º de linhas afectadas: ' || IN_COUNT_ROWS_INSRT);
	END IF;
	
	

  END SP_PROCESSA_MOVIMENTO_REF_MB;

END pc_conc;
