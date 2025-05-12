package com.porto.sinistro.regulacaosinistroauto.service;

import java.awt.image.RenderedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.rmi.RemoteException;
import java.sql.Time;
import java.util.*;

import javax.ejb.CreateException;
import javax.media.jai.JAI;
import javax.naming.NamingException;

import com.google.gson.Gson;
import com.google.gson.JsonParseException;
import com.porto.sinistro.automovel.api.fotos.type.FotosRequest;
import com.porto.sinistro.regulacaosinistroauto.common.*;
import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.comparators.NullComparator;
import org.apache.commons.collections.map.LinkedMap;

import com.porto.infra.util.ConfigProperties;
import com.porto.infra.util.LogManager;
import com.porto.infra.util.ServiceLocator;
import com.porto.infra.util.UserMessageError;
import com.porto.regulacaosinistroauto.common.ArquivoNaoEncontradoException;
import com.porto.regulacaosinistroauto.common.ArquivoProcessoOrigemVO;
import com.porto.regulacaosinistroauto.common.ArquivoProcessoRegulacaoVO;
import com.porto.regulacaosinistroauto.common.DocumentoRegulacaoVO;
import com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO;
import com.porto.regulacaosinistroauto.common.GerenciaArqProcRegulacaoAutoModelException;
import com.porto.regulacaosinistroauto.model.GerenciaArqProcRegulacaoAutoModel;
import com.porto.regulacaosinistroauto.model.GerenciaArqProcRegulacaoAutoModelHome;
import com.porto.regulacaosinistroauto.model.GerenciaDocProcRegulacaoAutoModel;
import com.porto.regulacaosinistroauto.model.GerenciaDocProcRegulacaoAutoModelHome;
import com.porto.segmentacao.common.TarefaModelException;
import com.porto.segmentacao.model.TarefaModel;
import com.porto.segmentacao.model.TarefaModelHome;
import com.porto.sinistro.common.ConsultasAvisoSinistroVO;
import com.porto.sinistro.common.DadosSinistroVO;
import com.porto.sinistro.common.GerenciaArqProcRegulacaoModelException;
import com.porto.sinistro.model.AvisoSinistroModel;
import com.porto.sinistro.model.AvisoSinistroModelHome;
import com.porto.sinistro.model.SinistroModel;
import com.porto.sinistro.model.SinistroModelHome;
import com.porto.sinistro.regulacaosinistroauto.cache.Cache;
import com.porto.sinistro.regulacaosinistroauto.cache.CacheUsuario;
import com.porto.sinistro.regulacaosinistroauto.helper.LookupHelper;
import com.porto.sinistro.regulacaosinistroauto.model.GerenciaArqProcRegulacaoModel;
import com.porto.sinistro.regulacaosinistroauto.model.GerenciaArqProcRegulacaoModelHome;
import com.porto.sinistro.regulacaosinistroauto.utils.ComunicacoesUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.CriptografiaUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.DocumentosSinistroUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.PopulateUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.RegulacaoSinistroAutoConstantes;
import com.porto.sinistro.regulacaosinistroauto.utils.RegulacaoSinistroUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.SafeRetrieverUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.StringUtils;
import com.porto.sinistro.regulacaosinistroauto.utils.ValidacaoUtils;
import com.porto.sinistro.regulacaosinistroauto.webservice.client.FileSystemClientUtil;
import com.porto.sinistro.regulacaosinistroauto.webservice.util.RespostaFSRecuperarArquivo;
import com.porto.vistprevauto.common.FotosVistoriaPreviaVO;
import com.porto.vistprevauto.model.LaudoVistoriaPreviaModel;
import com.sun.media.jai.codec.ByteArraySeekableStream;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.SeekableStream;


/**
 * Bean implementation class for Enterprise Bean: GerirArqProcRegulacaoAutoService
 */
public class GerirArqProcRegulacaoAutoServiceBean implements javax.ejb.SessionBean {

	private static final LogManager LOG = LogManager.getLog(GerirArqProcRegulacaoAutoServiceBean.class);
	private static final String ORIGEM_UTILIZACAO_GCDE = "gcde";
	private javax.ejb.SessionContext mySessionCtx;

	private static final ConfigProperties NAME_BUCKET_URL = new ConfigProperties(RegulacaoSinistroAutoConstantes.BASESREGULACAO_PROPERTIES);

	/**
	 * getSessionContext
	 */
	public javax.ejb.SessionContext getSessionContext() {
		return mySessionCtx;
	}
	/**
	 * setSessionContext
	 */
	public void setSessionContext(javax.ejb.SessionContext ctx) {
		mySessionCtx = ctx;
	}
	/**
	 * ejbCreate
	 */
	public void ejbCreate() throws javax.ejb.CreateException {
	}
	/**
	 * ejbActivate
	 */
	public void ejbActivate() {
	}
	/**
	 * ejbPassivate
	 */
	public void ejbPassivate() {
	}
	/**
	 * ejbRemove
	 */
	public void ejbRemove() {
	}

	/**
	 *
	 * @param codigoRamo
	 * @param numeroSinistro
	 * @param anoSisnistro
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 * @throws RemoteException
	 */
	public List buscarArquivosProcessoRegulacao(RegulacaoSinistroAutoVO regulacaoSinistroAutoVO) throws GerirArqProcRegulacaoAutoServiceException {
		LOG.info("Buscar Arquivos Regulacao Processo " + regulacaoSinistroAutoVO.toString());
		List listaArquivos = new ArrayList();
		if (regulacaoSinistroAutoVO == null) {
			return listaArquivos;
		}

		/* Dados Sinistro */
		Short ramoSinistro = regulacaoSinistroAutoVO != null ? regulacaoSinistroAutoVO.getRamoSinistro() : null;
		Integer numeroSinistro = regulacaoSinistroAutoVO != null ? regulacaoSinistroAutoVO.getNumeroSinistro() : null;
		Short anoSinistro = regulacaoSinistroAutoVO != null ? regulacaoSinistroAutoVO.getAnoSinistro() : null;
		Short sequenciaItemSinistro = regulacaoSinistroAutoVO != null ? regulacaoSinistroAutoVO.getSequenciaItemSinistro() : null;
		ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = montarArquivoProcessoRegulacao(ramoSinistro, numeroSinistro, anoSinistro, sequenciaItemSinistro);

		try {
			GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoAutoModel = getGerenciaArqProcRegulacaoAutoModel();
			listaArquivos = gerenciaArqProcRegulacaoAutoModel.buscarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);
		} catch (GerenciaArqProcRegulacaoAutoModelException e) {
			UserMessageError userMessageError = new UserMessageError();
			userMessageError.addMessage("error.regulacao.problemabuscaarquivos" );
			throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}

		return listaArquivos;
	}

	private ArquivoProcessoRegulacaoVO montarArquivoProcessoRegulacao(Short ramoSinistro, Integer numeroSinistro, Short anoSinistro, Short sequenciaItemSinistro) {

		ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
		if (ramoSinistro != null && numeroSinistro != null && anoSinistro != null && sequenciaItemSinistro != null ) {
			arquivoProcessoRegulacaoVO.setCodigoRamo(ramoSinistro);
			arquivoProcessoRegulacaoVO.setNumeroSinistro(numeroSinistro);
			arquivoProcessoRegulacaoVO.setAnoSinistro(anoSinistro);
			arquivoProcessoRegulacaoVO.setSequenciaItemSinistro(sequenciaItemSinistro);
		}
		return arquivoProcessoRegulacaoVO;

	}

	/**
	 * Incluir arquivo via fax.
	 *
	 * @param regulacaoSinistroAutoVO the regulacao sinistro auto vo
	 * @throws GerirArqProcRegulacaoAutoServiceException the gerir arq proc regulacao auto service exception
	 */
	public void incluirArquivoViaFax(
			final RegulacaoSinistroAutoVO regulacaoSinistroAutoVO) throws GerirArqProcRegulacaoAutoServiceException {
		LOG.info("Incluir Arquivo via Fax " + regulacaoSinistroAutoVO.toString());
		if (regulacaoSinistroAutoVO != null) {
			ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
			try {
				long inicTotal = (new Date()).getTime();

				/* Obtendo Dados da Vistoria do Sinistro */

				if (ValidacaoUtils.isEmpty(regulacaoSinistroAutoVO.getNumeroVistoriaSinistro())
						|| ValidacaoUtils.isEmpty(regulacaoSinistroAutoVO.getAnoVistoriaSinistro())) {
					buscarDadosVistoriaSinistro(regulacaoSinistroAutoVO);
				}

				BeanUtils.copyProperties(arquivoProcessoRegulacaoVO, regulacaoSinistroAutoVO);
				arquivoProcessoRegulacaoVO.setCodigoRamo(regulacaoSinistroAutoVO.getRamoSinistro());
				arquivoProcessoRegulacaoVO.setTipoUsuarioInclusao(regulacaoSinistroAutoVO.getTipoUsuario());
				arquivoProcessoRegulacaoVO.setFlagCancelamento(RegulacaoSinistroAutoConstantes.N);

				if (regulacaoSinistroAutoVO.getIdentificaoArquivoOrigem() != null){
					ArquivoProcessoOrigemVO origemVO = new ArquivoProcessoOrigemVO();
					origemVO.setIdentificaoArquivoOrigem(regulacaoSinistroAutoVO.getIdentificaoArquivoOrigem());
					arquivoProcessoRegulacaoVO.setArquivoProcessoOrigem(origemVO);
				}

				//Retirada chamada da tabela ssdmrcbfax (INFORMIX) - F0122886 - DAYANE  MOREIRA
				GerenciaArqProcRegulacaoModel obtemFaxModel = getGerenciaArqProcRegulacaoModel();
				//LOG.info("[incluirArquivoViaFax] Buscando arquivos na base do legado: "+arquivoProcessoRegulacaoVO.getNumeroVistoriaSinistro()+ " "+arquivoProcessoRegulacaoVO.getAnoVistoriaSinistro());
				List listaFax = obtemFaxModel.buscarFaxRecebidosPorVistoria(arquivoProcessoRegulacaoVO.getNumeroVistoriaSinistro() ,arquivoProcessoRegulacaoVO.getAnoVistoriaSinistro());

				if (RegulacaoSinistroUtils.collectionIsEmpty(listaFax)){
					LOG.info("[incluirArquivoViaFax] Nenhum arquivo localizado na base do legado: "+arquivoProcessoRegulacaoVO.getNumeroVistoriaSinistro()+ " "+arquivoProcessoRegulacaoVO.getAnoVistoriaSinistro());
				}else{
					LOG.info("[incluirArquivoViaFax] Arquivos localizados na base do legado: "+listaFax.size());
				}

				List listaFaxRegulacao = converteFaxSinistroToFaxRegulacao(listaFax);

				if (!RegulacaoSinistroUtils.collectionIsEmpty(listaFaxRegulacao)){
					LOG.info("[incluirArquivoViaFax] Copiando arquivos da base do legado para o novo: "+listaFaxRegulacao.size());
				}

				GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoModel = getGerenciaArqProcRegulacaoAutoModel();
				gerenciaArqProcRegulacaoModel.incluirArquivoViaFax(arquivoProcessoRegulacaoVO, listaFaxRegulacao);

				long fin = (new Date()).getTime();
				LOG.debug("[incluirArquivoViaFax] TEMPO INCLUSAO ARQUIVO PASTA DIGITAL = " + (fin - inicTotal));
			} catch (GerenciaArqProcRegulacaoAutoModelException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.problemaincluirarquivofax");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (GerenciaArqProcRegulacaoModelException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.problemaincluirarquivofax");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (Exception e) {
				throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
			}

		}

	}

	/**
	 * Incluir arquivos.
	 *
	 * @param regulacaoSinistroAutoVO the regulacao sinistro auto vo
	 * @param arquivos the arquivos
	 * @throws GerirArqProcRegulacaoAutoServiceException the gerir arq proc regulacao auto service exception
	 */
	public void incluirArquivos(
			final RegulacaoSinistroAutoVO regulacaoSinistroAutoVO, final List<UploadArquivoConvertidoVO> arquivos)
			throws GerirArqProcRegulacaoAutoServiceException {
		LOG.info("Incluir Arquivo via Fax " + regulacaoSinistroAutoVO.toString());
		if (regulacaoSinistroAutoVO != null) {
			ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
			try {
				long inicTotal = (new Date()).getTime();

				/* Obtendo Dados da Vistoria do Sinistro */

				if (ValidacaoUtils.isEmpty(regulacaoSinistroAutoVO.getNumeroVistoriaSinistro())
						|| ValidacaoUtils.isEmpty(regulacaoSinistroAutoVO.getAnoVistoriaSinistro())) {
					buscarDadosVistoriaSinistro(regulacaoSinistroAutoVO);
				}

				BeanUtils.copyProperties(arquivoProcessoRegulacaoVO, regulacaoSinistroAutoVO);
				arquivoProcessoRegulacaoVO.setCodigoRamo(regulacaoSinistroAutoVO.getRamoSinistro());
				arquivoProcessoRegulacaoVO.setTipoUsuarioInclusao(regulacaoSinistroAutoVO.getTipoUsuario());
				arquivoProcessoRegulacaoVO.setFlagCancelamento(RegulacaoSinistroAutoConstantes.N);

				if (regulacaoSinistroAutoVO.getIdentificaoArquivoOrigem() != null){
					ArquivoProcessoOrigemVO origemVO = new ArquivoProcessoOrigemVO();
					origemVO.setIdentificaoArquivoOrigem(regulacaoSinistroAutoVO.getIdentificaoArquivoOrigem());
					arquivoProcessoRegulacaoVO.setArquivoProcessoOrigem(origemVO);
				}

				List<com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO> listaFaxRegulacao
						= converteArquivosUploadArquivosRegulacaoToFaxRegulacao(
						arquivos,
						regulacaoSinistroAutoVO.getNumeroVistoriaSinistro(),
						regulacaoSinistroAutoVO.getAnoVistoriaSinistro(),
						regulacaoSinistroAutoVO.getSequenciaItemSinistro());

				GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoModel = getGerenciaArqProcRegulacaoAutoModel();
				gerenciaArqProcRegulacaoModel.incluirArquivoViaFax(arquivoProcessoRegulacaoVO, listaFaxRegulacao);

				long fin = (new Date()).getTime();
				LOG.debug("[incluirArquivoViaFax] TEMPO INCLUSAO ARQUIVO PASTA DIGITAL = " + (fin - inicTotal));
			} catch (GerenciaArqProcRegulacaoAutoModelException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.problemaincluirarquivofax");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (GerenciaArqProcRegulacaoModelException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.problemaincluirarquivofax");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (Exception e) {
				throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
			}

		}

	}

	/**
	 * Converte fax sinistro to fax regulacao.
	 *
	 * @param arquivos the arquivos
	 * @param short2
	 * @param short1
	 * @param integer
	 * @return the list
	 */
	private List<FaxRecebidosPeloSistemaUraVO> converteArquivosUploadArquivosRegulacaoToFaxRegulacao(
			final List<UploadArquivoConvertidoVO> arquivos,
			final Integer numeroVistoria, final Short anoVistoria, final Short sequenciaItemSinistro) {
		List<FaxRecebidosPeloSistemaUraVO> retorno = new ArrayList<FaxRecebidosPeloSistemaUraVO>();
		for (UploadArquivoConvertidoVO arquivo : arquivos) {
			FaxRecebidosPeloSistemaUraVO faxRecebidoVO = new FaxRecebidosPeloSistemaUraVO();
//			String descricaoArquivo = faxRecebidosPeloSistemaUraVO.getCodigoIdentificacaoFaxNaPasta().trim();
//			Date dataRecepcao = faxRecebidosPeloSistemaUraVO.getDataRecebimentoFax();
//			Time horaRecepcao = faxRecebidosPeloSistemaUraVO.getHoraRecebimentoFaxPastaDigi();
//			Short sequenciaArquivo =  faxRecebidosPeloSistemaUraVO.getSequenciaDocumentoNaPastaDigital();

			faxRecebidoVO.setCodigoIdentificacaoFaxNaPasta(arquivo.getCodigoIdentificacaoFaxNaPasta());
			faxRecebidoVO.setDataRecebimentoFax(new Date());
//			faxRecebidoVO.setDescricaoParaSubdivisaoDiretorios(string);
			faxRecebidoVO.setDescricaoTipoArquivo(arquivo.getExtensao());
			faxRecebidoVO.setHoraRecebimentoFaxPastaDigi(new Time(new Date().getTime()));
//			faxRecebidoVO.setNumeroIdentificacaoDvdImagens(string);
//			faxRecebidoVO.setNumeroIdentificacaoHdEDiscoOptico(short1);
			faxRecebidoVO.setSequenciaDocumentoNaPastaDigital(Short.valueOf(arquivo.getSequenciaArquivo()));

			retorno.add(faxRecebidoVO);
		}
		return retorno;
	}
	/**
	 * Converte
	 * @param listaFaxSinistro com.porto.sinistro.common.FaxRecebidosPeloSistemaUraVO em com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO
	 * para enviar ao regulacaosinistroauto_model
	 * @return
	 */
	private List<com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO> converteFaxSinistroToFaxRegulacao(List listaFaxSinistro) {

		List listaFaxRegulacao = new ArrayList();
		for(Iterator it = listaFaxSinistro.iterator(); it.hasNext();) {
			com.porto.sinistro.common.FaxRecebidosPeloSistemaUraVO faxSinistroVO = (com.porto.sinistro.common.FaxRecebidosPeloSistemaUraVO) it.next();
			com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO faxRegulacaoVO = new com.porto.regulacaosinistroauto.common.FaxRecebidosPeloSistemaUraVO();
			PopulateUtils.copyVO(faxRegulacaoVO, faxSinistroVO);

			listaFaxRegulacao.add(faxRegulacaoVO);
		}

		return listaFaxRegulacao;
	}

	/**
	 *
	 * @param regulacaoSinistroAutoVO
	 * @return
	 * @throws Exception
	 */
	private void buscarDadosVistoriaSinistro(RegulacaoSinistroAutoVO regulacaoSinistroAutoVO) throws Exception {

		SinistroModel sinistroModel  = getSinistroModel();
		DadosSinistroVO dadosSinistroVO = sinistroModel.obterSinistro(regulacaoSinistroAutoVO.getRamoSinistro(), regulacaoSinistroAutoVO.getAnoSinistro(), regulacaoSinistroAutoVO.getNumeroSinistro());
		if (dadosSinistroVO == null) {
			LOG.warn("Impossível Localizar Dados da Vistoria para o Sinistro " + regulacaoSinistroAutoVO.getRamoSinistro() + " " + regulacaoSinistroAutoVO.getAnoSinistro() + " " + regulacaoSinistroAutoVO.getNumeroSinistro());
		} else {
			regulacaoSinistroAutoVO.setAnoVistoriaSinistro(dadosSinistroVO.getAnoPedidoVistoriaSinistro());
			regulacaoSinistroAutoVO.setNumeroVistoriaSinistro(dadosSinistroVO.getNumeroPedidoVistoriaSinistro());
		}

		//return regulacaoSinistroAutoVO;

	}

	/**
	 *
	 * @param inicioAbaDocumentosRegulacaoVO
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	public void cancelarArquivoProcessoRegulacao(InicioAbaDocumentosRegulacaoVO inicioAbaDocumentosRegulacaoVO) throws GerirArqProcRegulacaoAutoServiceException {

		RegulacaoSinistroAutoVO regulacaoSinistroAutoVO = RegulacaoSinistroUtils.convertAbaDocumentoToRegulacaoSinistroAutoVO(inicioAbaDocumentosRegulacaoVO);
		Integer identificacaoArquivo = regulacaoSinistroAutoVO != null ? regulacaoSinistroAutoVO.getIdentificadorArquivoProcesso() : null;
		LOG.info("Cancelar Arquivo Processo " + identificacaoArquivo);
		if (identificacaoArquivo != null) {
			ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
			try {
				arquivoProcessoRegulacaoVO.setIdentificacaoArquivoProcessoRegulacao(identificacaoArquivo);
				arquivoProcessoRegulacaoVO.setEmpresaUsuarioCancelamento(regulacaoSinistroAutoVO.getCodigoEmpresa());
				arquivoProcessoRegulacaoVO.setTipoUsuarioCancelamento(regulacaoSinistroAutoVO.getTipoUsuario());
				arquivoProcessoRegulacaoVO.setMatriculaUsuarioCancelamento(regulacaoSinistroAutoVO.getMatriculaFuncionario());

				GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoAutoModel = getGerenciaArqProcRegulacaoAutoModel();
				gerenciaArqProcRegulacaoAutoModel.cancelarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);

				/* Realiza a verificação dos arquivos pendendes para o encerramento da Tarefa 253 no Análise Eletrônica */
				encerrarTarefaAnaliseEletronica(regulacaoSinistroAutoVO);
			} catch (EncerrarTarefaAnaliseEletronicaException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.encerrartarefaanalise", e.getMessage());
				/* Cancela Inclusão */
				mySessionCtx.setRollbackOnly();
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (ArquivoNaoEncontradoException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.impossivellocalizararquivo");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (GerenciaArqProcRegulacaoAutoModelException e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.regulacao.problemacancelararquivo");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			} catch (Exception e) {
				UserMessageError userMessageError = new UserMessageError();
				userMessageError.addMessage("error.default");
				throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
			}

		}

	}

	/**
	 *
	 * @return
	 * @throws
	 */
	private GerenciaArqProcRegulacaoAutoModel getGerenciaArqProcRegulacaoAutoModel() throws Exception {

		try {
			GerenciaArqProcRegulacaoAutoModelHome gerenciaArqProcRegulacaoAutoModelHome = (GerenciaArqProcRegulacaoAutoModelHome) ServiceLocator.getGlobalInstance().lookup(GerenciaArqProcRegulacaoAutoModelHome.JNDI_NAME, GerenciaArqProcRegulacaoAutoModelHome.class);
			return gerenciaArqProcRegulacaoAutoModelHome.create();
		} catch(Exception e) {
			throw e;
		}

	}

	private GerenciaDocProcRegulacaoAutoModel getGerenciaDocProcRegulacaoModel() throws NamingException, RemoteException, CreateException {

		GerenciaDocProcRegulacaoAutoModelHome gerenciaDocProcRegulacaoModelHome = (GerenciaDocProcRegulacaoAutoModelHome) ServiceLocator.getGlobalInstance().lookup(GerenciaDocProcRegulacaoAutoModelHome.JNDI_NAME, GerenciaDocProcRegulacaoAutoModelHome.class);
		return gerenciaDocProcRegulacaoModelHome.create();

	}

	/**
	 *
	 * @return
	 * @throws
	 */
	private GerenciaDocProcRegulacaoAutoModel getGerenciaDocProcRegulacaoAutoModel() throws Exception {

		try {
			GerenciaDocProcRegulacaoAutoModelHome gerenciaDocProcRegulacaoAutoModel = (GerenciaDocProcRegulacaoAutoModelHome) ServiceLocator.getGlobalInstance().lookup(GerenciaDocProcRegulacaoAutoModelHome.JNDI_NAME, GerenciaDocProcRegulacaoAutoModelHome.class);
			return gerenciaDocProcRegulacaoAutoModel.create();
		} catch(Exception e) {
			throw e;
		}

	}

	/**
	 *
	 * @return
	 * @throws
	 */
	private GerenciaArqProcRegulacaoModel getGerenciaArqProcRegulacaoModel() throws Exception {

		try {
			GerenciaArqProcRegulacaoModelHome gerenciaArqProcRegulacaoModelHome = (GerenciaArqProcRegulacaoModelHome) ServiceLocator.getGlobalInstance().lookup(GerenciaArqProcRegulacaoModelHome.JNDI_NAME, GerenciaArqProcRegulacaoModelHome.class);
			return gerenciaArqProcRegulacaoModelHome.create();
		} catch(Exception e) {
			throw e;
		}

	}

	/**
	 *
	 * @return
	 * @throws
	 */
	private TarefaModel getTarefaModel() throws Exception {

		try {
			TarefaModelHome tarefaModelHome = (TarefaModelHome) ServiceLocator.getGlobalInstance().lookup(TarefaModelHome.JNDI_NAME, TarefaModelHome.class);
			return tarefaModelHome.create();
		} catch(Exception e) {
			throw e;
		}

	}

	public ArquivoRecebidoVO exibirArquivoRegulacao (ArquivoRecebidoVO arquivoRecebidoVO) throws GerirArqProcRegulacaoAutoServiceException {

		LOG.info("Exibir Arquivo Regulacao " + arquivoRecebidoVO.getIdentificadorAquivoProcesso());
		if (org.apache.commons.lang.StringUtils.isEmpty(arquivoRecebidoVO.getCodigoUsuario())) {
			arquivoRecebidoVO.setCodigoUsuario("F0107680");
		}

		LOG.info("Codigo Usuário: " + arquivoRecebidoVO.getCodigoUsuario());

		CacheUsuario cacheUsuario = Cache.getCacheUsuario(arquivoRecebidoVO.getCodigoUsuario());
		byte[] conteudo = null;
		try  {
			GerenciaArqProcRegulacaoAutoModel gerenciarArquivosModel = getGerenciaArqProcRegulacaoAutoModel();
			if (arquivoRecebidoVO.getIdentificadorAquivoProcesso() != null && arquivoRecebidoVO.getIdentificadorAquivoProcesso().intValue() != 0) {
				Integer identificadorArquivo = arquivoRecebidoVO.getIdentificadorAquivoProcesso();
				ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = gerenciarArquivosModel.buscarArquivoProcessoRegulacaoPorId(identificadorArquivo);

				ConfigProperties configProperties = new ConfigProperties(RegulacaoSinistroAutoConstantes.BASESREGULACAO_PROPERTIES);
				String path =  configProperties.readString(RegulacaoSinistroAutoConstantes.CAMINHO_PASTADIGITAL);
				LOG.info("Caminho da pasta: " + path);

				Date dataRecebimentoArquivo = arquivoProcessoRegulacaoVO.getDataRecepcao();
				LOG.info("Data Recepcao do Arquivo " + StringUtils.getStringFromDate(dataRecebimentoArquivo));

				Calendar calendar = new GregorianCalendar(new Locale("pt", "BR"));
				calendar.setTime(dataRecebimentoArquivo);

				int diaRecebimento = calendar.get(Calendar.DAY_OF_MONTH);
				int mesRecebimento = calendar.get(Calendar.MONTH);
				/* Mes do ano começa em 0 */
				mesRecebimento++;
				int anoRecebimento = calendar.get(Calendar.YEAR);

				Short sequenciaArquivo = arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital() != null ? arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital() : new Short("0");
				String sequencia = StringUtils.fillStringLeft(sequenciaArquivo.toString(), '0', 3);

				String caminhoArquivo = StringUtils.fillStringLeft(String.valueOf(anoRecebimento), '0',4) + "/" +  StringUtils.fillStringLeft(String.valueOf(mesRecebimento), '0', 2) + "/" +  StringUtils.fillStringLeft(String.valueOf(diaRecebimento), '0', 2) + "/" +  StringUtils.fillStringLeft(sequenciaArquivo.toString(), '0', 2) + "/";
				LOG.info("Local do Arquivo " + caminhoArquivo);

				String nomeCompletoArquivo = arquivoProcessoRegulacaoVO.getNomeArquivo() +  sequencia + ".tif";

				arquivoRecebidoVO.setCaminhoArquivo(path + caminhoArquivo);
				arquivoRecebidoVO.setNomeArquivoFisico(nomeCompletoArquivo);

				List listaArquivos = new ArrayList();
				listaArquivos.add(path + caminhoArquivo + nomeCompletoArquivo);
//				listaArquivos.add("//nt112/imagem/sinistro/regulacaosinistroauto/imagem/DU151389200901003.tif");
				LOG.info("Local e nome do arquivo: " + path + caminhoArquivo + nomeCompletoArquivo);

				LinkedMap lmFotos = ComunicacoesUtils.buscarArquivosRegulacao(listaArquivos);

				if (lmFotos != null) {
					LOG.info("FOTO ENCONTRADA");
					LOG.info("CHAVE FOTO = [" + lmFotos.firstKey() + "]");

					conteudo = (byte[]) lmFotos.get(lmFotos.firstKey());
				}
				arquivoRecebidoVO.setArquivo(conteudo);

				//Pega o identificador dos arquivos anteriores e proximos
				List arquivos = gerenciarArquivosModel.buscarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);
				Collections.sort(arquivos, new ComparadorSequenciaArquivo());

				// Verifica se existe mais do que ele próprio
				if (arquivos != null && arquivos.size() > 1){
					LOG.info("Tamanho da lista de arquivos: " + arquivos.size());

					// pega a sequencia do arquivo que está selecionado para comparação
					int seqArquivoSelecionado = arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital().intValue();
					LOG.info("Identificador do arquivo selecionado: " + seqArquivoSelecionado);

					boolean result = false;
					for (Iterator iter = arquivos.iterator(); iter.hasNext();) {
						ArquivoProcessoRegulacaoVO element = (ArquivoProcessoRegulacaoVO) iter.next();

						if (element.getSequenciaDocumentoNaPastaDigital().intValue() < seqArquivoSelecionado && element.getDataAssociacao() == null){
							arquivoRecebidoVO.setIdentificadorArquivoAnterior(element.getIdentificacaoArquivoProcessoRegulacao());
						} else if(element.getSequenciaDocumentoNaPastaDigital().intValue() > seqArquivoSelecionado && element.getDataAssociacao() == null && !result){
							arquivoRecebidoVO.setIdentificadorProximoArquivo(element.getIdentificacaoArquivoProcessoRegulacao());
							result = true;
						}
					}
				}
				LOG.info("Código de identificação do arquivo anterior: " + arquivoRecebidoVO.getIdentificadorArquivoAnterior());
				LOG.info("Código de identificação do arquivo sucessor: " + arquivoRecebidoVO.getIdentificadorProximoArquivo());


				if (conteudo != null){
					SeekableStream seekableStream = new ByteArraySeekableStream(conteudo);
					ImageDecoder decoder = ImageCodec.createImageDecoder("tiff", seekableStream, null);
					if (decoder != null){
						int	numPages = decoder.getNumPages();
						RenderedImage image[] = new RenderedImage[numPages];
						int count = 0;

						for (int i=0;i<decoder.getNumPages();i++) {
							image[i] = decoder.decodeAsRenderedImage(i);
							ByteArrayOutputStream baos = new ByteArrayOutputStream();
							JAI.create("encode", image[i], baos, "png");
							cacheUsuario.put("imagens" + i, baos.toByteArray());
							baos.close();
						}
						arquivoRecebidoVO.setNumPages(new Integer(numPages));
					} else {
						arquivoRecebidoVO.setNumPages(new Integer(0));
					}
				}

				return arquivoRecebidoVO;
			}
		} catch(GerenciaArqProcRegulacaoAutoModelException e) {
			LOG.error("Erro no decoder da imagem");
			if (conteudo != null){
				arquivoRecebidoVO.setNumPages(new Integer("0"));
				cacheUsuario.put("imagens0", conteudo);
			}
		} catch(Exception e) {
			LOG.error("Erro no decoder da imagem");
			if (conteudo != null){
				arquivoRecebidoVO.setNumPages(new Integer("0"));
				cacheUsuario.put("imagens0", conteudo);
			}
		}
		return arquivoRecebidoVO;
	}


	/**
	 *
	 * @param identificadorArquivoProcesso
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 * @throws RemoteException
	 */
	public ArquivoRecebidoVO exibirArquivoRegulacaoEspecifico(String identificadorArquivoProcesso) throws GerirArqProcRegulacaoAutoServiceException {
		LOG.info("Exibir Arquivo Regulacao " + identificadorArquivoProcesso);
		ArquivoRecebidoVO arquivoRecebidoVO = new ArquivoRecebidoVO();

		try  {
			GerenciaArqProcRegulacaoAutoModel gerenciarArquivosModel = getGerenciaArqProcRegulacaoAutoModel();
			if (!StringUtils.isEmpty(identificadorArquivoProcesso)) {
				Integer identificadorArquivo = new Integer(identificadorArquivoProcesso);
				ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = gerenciarArquivosModel.buscarArquivoProcessoRegulacaoPorId(identificadorArquivo);

				ConfigProperties configProperties = new ConfigProperties(RegulacaoSinistroAutoConstantes.BASESREGULACAO_PROPERTIES);

				String path =  configProperties.readString(RegulacaoSinistroAutoConstantes.CAMINHO_PASTADIGITAL);
				LOG.info("Caminho da pasta: " + path);

				Date dataRecebimentoArquivo = arquivoProcessoRegulacaoVO.getDataRecepcao();
				LOG.info("Data Recepcao do Arquivo " + StringUtils.getStringFromDate(dataRecebimentoArquivo));

				Calendar calendar = new GregorianCalendar(new Locale("pt", "BR"));
				calendar.setTime(dataRecebimentoArquivo);

				int diaRecebimento = calendar.get(Calendar.DAY_OF_MONTH);
				int mesRecebimento = calendar.get(Calendar.MONTH);
				/* Mes do ano começa em 0 */
				mesRecebimento++;
				int anoRecebimento = calendar.get(Calendar.YEAR);

				Short sequenciaArquivo = arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital() != null ? arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital() : new Short("0");
				String sequencia = StringUtils.fillStringLeft(sequenciaArquivo.toString(), '0', 3);

				String caminhoArquivo = StringUtils.fillStringLeft(String.valueOf(anoRecebimento), '0',4) + "/" +  StringUtils.fillStringLeft(String.valueOf(mesRecebimento), '0', 2) + "/" +  StringUtils.fillStringLeft(String.valueOf(diaRecebimento), '0', 2) + "/" +  StringUtils.fillStringLeft(sequenciaArquivo.toString(), '0', 2) + "/";
				LOG.info("Local do Arquivo " + caminhoArquivo);

				String nomeCompletoArquivo = arquivoProcessoRegulacaoVO.getNomeArquivo() +  sequencia + ".tif";

				arquivoRecebidoVO.setCaminhoArquivo(path + caminhoArquivo);
				arquivoRecebidoVO.setNomeArquivoFisico(nomeCompletoArquivo);


				List listaArquivos = new ArrayList();
				listaArquivos.add(path + caminhoArquivo + nomeCompletoArquivo);
				LOG.info("Local e nome do arquivo: " + path + caminhoArquivo + nomeCompletoArquivo);

				LinkedMap lmFotos = ComunicacoesUtils.buscarArquivosRegulacao(listaArquivos);

				byte[] conteudo = null;
				if (lmFotos != null) {
					LOG.info("FOTO ENCONTRADA");
					LOG.info("CHAVE FOTO = [" + lmFotos.firstKey() + "]");

					conteudo = (byte[]) lmFotos.get(lmFotos.firstKey());
				}
				arquivoRecebidoVO.setArquivo(conteudo);

				//Pega o identificador dos arquivos anteriores e proximos
				List arquivos = gerenciarArquivosModel.buscarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);
				Collections.sort(arquivos, new ComparadorSequenciaArquivo());

				// Verifica se existe mais do que ele próprio
				if (arquivos != null && arquivos.size() > 1){
					LOG.info("Tamanho da lista de arquivos: " + arquivos.size());

					// pega a sequencia do arquivo que está selecionado para comparação
					int seqArquivoSelecionado = arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital().intValue();
					LOG.info("Identificador do arquivo selecionado: " + seqArquivoSelecionado);

					boolean result = false;
					for (Iterator iter = arquivos.iterator(); iter.hasNext();) {
						ArquivoProcessoRegulacaoVO element = (ArquivoProcessoRegulacaoVO) iter.next();

						if (element.getSequenciaDocumentoNaPastaDigital().intValue() < seqArquivoSelecionado && element.getDataAssociacao() == null){
							arquivoRecebidoVO.setIdentificadorArquivoAnterior(element.getIdentificacaoArquivoProcessoRegulacao());
						} else if(element.getSequenciaDocumentoNaPastaDigital().intValue() > seqArquivoSelecionado && element.getDataAssociacao() == null && !result){
							arquivoRecebidoVO.setIdentificadorProximoArquivo(element.getIdentificacaoArquivoProcessoRegulacao());
							result = true;
						}
					}
				}

				LOG.info("Código de identificação do arquivo anterior: " + arquivoRecebidoVO.getIdentificadorArquivoAnterior());
				LOG.info("Código de identificação do arquivo sucessor: " + arquivoRecebidoVO.getIdentificadorProximoArquivo());
				return arquivoRecebidoVO;
			}
		} catch(GerenciaArqProcRegulacaoAutoModelException e) {
			UserMessageError userMessageError = new UserMessageError();
			userMessageError.addMessage("error.regulacao.problemaexibirarquivo");
			throw new GerirArqProcRegulacaoAutoServiceException(userMessageError, e, LOG);
		} catch(Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}
		return arquivoRecebidoVO;
	}


	/***
	 *
	 * @return
	 * @throws NamingException
	 * @throws RemoteException
	 * @throws CreateException
	 */
	private SinistroModel getSinistroModel() throws NamingException, RemoteException, CreateException {

		SinistroModelHome sinistroModelHome = (SinistroModelHome) ServiceLocator.getGlobalInstance().lookup(SinistroModelHome.JNDI_NAME, SinistroModelHome.class);
		return sinistroModelHome.create();

	}

	/***
	 *
	 * @return
	 * @throws NamingException
	 * @throws RemoteException
	 * @throws CreateException
	 */
	private AvisoSinistroModel getAvisoSinistroModel() throws NamingException, RemoteException, CreateException {

		AvisoSinistroModelHome avisoSinistroModelHome = (AvisoSinistroModelHome) ServiceLocator.getGlobalInstance().lookup(AvisoSinistroModelHome.JNDI_NAME, AvisoSinistroModelHome.class);
		return avisoSinistroModelHome.create();

	}



	/***
	 *
	 * @return
	 * @throws NamingException
	 * @throws RemoteException
	 * @throws CreateException
	 */
	private GerirArqProcRegulacaoAutoService getThis()
			throws NamingException, RemoteException, CreateException {

		GerirArqProcRegulacaoAutoServiceHome thisHome =
				(GerirArqProcRegulacaoAutoServiceHome) ServiceLocator.getGlobalInstance().lookup(
						GerirArqProcRegulacaoAutoServiceHome.JNDI_NAME,
						GerirArqProcRegulacaoAutoServiceHome.class);
		return thisHome.create();

	}



	/**
	 *
	 * @param regulacaoSinistroAutoVO
	 * @throws RelacionarArqDocProcRegulacaoAutoServiceException
	 */
	private void encerrarTarefaAnaliseEletronica(RegulacaoSinistroAutoVO regulacaoSinistroAutoVO) throws EncerrarTarefaAnaliseEletronicaException {

		try {

			if (!existeArquivosPendentes(regulacaoSinistroAutoVO)) {
				Short codigoRamo = regulacaoSinistroAutoVO.getRamoSinistro();
				Short anoSinistro = regulacaoSinistroAutoVO.getAnoSinistro();
				Integer numeroSinistro = regulacaoSinistroAutoVO.getNumeroSinistro();
				Short sequenciaSinistro = regulacaoSinistroAutoVO.getSequenciaItemSinistro();
				Short tipoPerda = regulacaoSinistroAutoVO.getTipoPerda();
				Integer matriculaFuncionario =  regulacaoSinistroAutoVO.getMatriculaFuncionario();

				StringBuffer sb =  new StringBuffer();
				sb.append("\n #################################################################################")
						.append("\n CHAMA METODO Encerrar Tarefa 253 Analise Eletronica")
						.append("\n Parametros do metodo: ")
						.append("\n Numero Sinistro: ")
						.append(numeroSinistro)
						.append("\n Ramo Sinistro: ")
						.append(codigoRamo)
						.append("\n Ano Sinistro: ")
						.append(anoSinistro)
						.append("\n Ordem Sinistro: ")
						.append(sequenciaSinistro)
						.append("\n Tipo Perda: ")
						.append(tipoPerda)
						.append("\n Matricula Solicitante: ")
						.append(matriculaFuncionario)
						.append("\n #################################################################################");

				LOG.info(sb.toString());

				String saida = ComunicacoesUtils.integrarAnaliseEletronica(codigoRamo, anoSinistro, numeroSinistro, sequenciaSinistro, tipoPerda, matriculaFuncionario);
				if (!"0".equals(saida)) {
					throw new EncerrarTarefaAnaliseEletronicaException(saida, LOG);
				}
			}

		} catch(Exception e) {
			throw new EncerrarTarefaAnaliseEletronicaException(e, LOG);
		}

	}


	/**
	 * Verificar se existe Arquivos pendentes de associção
	 * @param regulacaoSinistroAutoVO
	 * @return
	 * @throws RelacionarArqDocProcRegulacaoAutoServiceException
	 */
	private boolean existeArquivosPendentes(RegulacaoSinistroAutoVO regulacaoSinistroAutoVO) throws GerirArqProcRegulacaoAutoServiceException {

		boolean existeArquivoPendente = false;
		try {

			List listaArquivos = buscarArquivosProcessoRegulacao(regulacaoSinistroAutoVO);
			Iterator itArquivos = listaArquivos != null ? listaArquivos.iterator() : new ArrayList().iterator();
			for (;itArquivos.hasNext();) {
				ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = (ArquivoProcessoRegulacaoVO)itArquivos.next();
				Short statusArquivo = definirStatusArquivo(arquivoProcessoRegulacaoVO.getFlagCancelamento(), arquivoProcessoRegulacaoVO.getMatriculaUsuarioAssociacao(), arquivoProcessoRegulacaoVO.getDataAssociacao());
				if (RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_DISPONIVEL.shortValue() == statusArquivo.shortValue()) {
					existeArquivoPendente = true;
					return existeArquivoPendente;
				}
			}
		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}

		return existeArquivoPendente;
	}


	/**
	 *
	 * @param flagCancelado
	 * @param matriculaUsuarioAssociacao
	 * @return
	 */
	private Short definirStatusArquivo(String flagCancelado, Integer matriculaUsuarioAssociacao, Date dataAssociacao) {

		if (RegulacaoSinistroAutoConstantes.S.equalsIgnoreCase(flagCancelado)) {
			return RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_CANCELADO;
		} else if (RegulacaoSinistroAutoConstantes.N.equalsIgnoreCase(flagCancelado) && (dataAssociacao != null ||matriculaUsuarioAssociacao != null && matriculaUsuarioAssociacao.intValue() > 0)) {
			return RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_ASSOCIADO;
		} else {
			return RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_DISPONIVEL;
		}
	}



	/**
	 *
	 * @param consultaTarefaRegulacaoVO
	 * @return
	 * @throws SolicitarDocProcRegulacaoAutoServiceException
	 */
	public List consultarDocumentosPendentesDeAssociacao(InicioAbaDocumentosRegulacaoVO inicioAbaDocumentosRegulacaoVO) throws GerirArqProcRegulacaoAutoServiceException {

		LOG.info("consultarDocumentosPendentesDeAssociacao - INICIO");

		List retorno = new ArrayList();
		Hashtable sinistrosComArquivosPendentes = null;
		ArrayList processosResp = new ArrayList();


		try {


			TarefaModel tarefaModel = getTarefaModel();
			AvisoSinistroModel avisoSinistroModel = getAvisoSinistroModel();

			ConfigProperties securityProperties = new ConfigProperties(RegulacaoSinistroAutoConstantes.SECURITY_PROPERTIES);
			String portal = securityProperties.readString("portal");

			if(portal != null && !portal.equals("0")){
				//Buscar todos os sinistros que são de responsabilidade do analista
				processosResp.addAll(tarefaModel.obterProcessosPorMatricula( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(inicioAbaDocumentosRegulacaoVO.getCodigoUsuario()), new Short("1"), "F"));
				//Buscar todos os sinistros sem responsável e que sejam da equipe do analista
				processosResp.addAll(tarefaModel.obterProcessosPorEquipeColaborador( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(inicioAbaDocumentosRegulacaoVO.getCodigoUsuario()), new Short("1"), "F"));
				//Buscar todos os sinistros que o analista solicitou documentos
				processosResp.addAll(getGerenciaDocProcRegulacaoAutoModel().obterProcessosPorSolicitanteDocumento( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(inicioAbaDocumentosRegulacaoVO.getCodigoUsuario()), new Short("1"), "F"));
			}else{
				//Buscar todos os sinistros que são de responsabilidade do analista
				processosResp.addAll(tarefaModel.obterProcessosPorMatricula( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(RegulacaoSinistroUtils.retornaMatriculaFixa()), new Short("1"), "F"));
				//Buscar todos os sinistros sem responsável e que sejam da equipe do analista
				processosResp.addAll(tarefaModel.obterProcessosPorEquipeColaborador( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(RegulacaoSinistroUtils.retornaMatriculaFixa()), new Short("1"), "F"));
				//Buscar todos os sinistros que o analista solicitou documentos
				processosResp.addAll(getGerenciaDocProcRegulacaoAutoModel().obterProcessosPorSolicitanteDocumento( RegulacaoSinistroUtils.getMatriculaByUserIdLDAP(RegulacaoSinistroUtils.retornaMatriculaFixa()), new Short("1"), "F"));
			}

			LOG.info("Tamanho da lista de processos: " + processosResp.size());

			/*
			 * criando instancia do mesmo EJB para iniciar o contexto de Transacao
			 * apenas para inclusãoDeArquivoViaFax
			 */
			GerirArqProcRegulacaoAutoService arqProcRegulacaoAutoService = getThis();

			//Atualizar arquivos pendentes
			for (Iterator iter = processosResp.iterator(); iter.hasNext();) {
				Object[] element = (Object[]) iter.next();
				RegulacaoSinistroAutoVO regulacaoSinistroAutoVO = new RegulacaoSinistroAutoVO();
				regulacaoSinistroAutoVO.setRamoSinistro((Short)element[0]);
				regulacaoSinistroAutoVO.setAnoSinistro((Short)element[1]);
				regulacaoSinistroAutoVO.setNumeroSinistro((Integer)element[2]);
				regulacaoSinistroAutoVO.setSequenciaItemSinistro((Short)element[3]);

				//iniciando contexto transacional
				arqProcRegulacaoAutoService.incluirArquivoViaFax(regulacaoSinistroAutoVO);

			}


			//Montar hash com todos os arquivos não associados
			GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoAutoModel = getGerenciaArqProcRegulacaoAutoModel();
			sinistrosComArquivosPendentes = gerenciaArqProcRegulacaoAutoModel.getArquivosProcessoRegulacaoNaoAssociados();

			ListaProcessosVO listaProcessosVO = null;

			for (Iterator iter = processosResp.iterator(); iter.hasNext();) {
				Object[] element = (Object[]) iter.next();

				String id = String.valueOf(element[0]) + String.valueOf(element[1]) + String.valueOf(element[2]) + String.valueOf(element[3]);

				if(sinistrosComArquivosPendentes!=null && sinistrosComArquivosPendentes.get(id)!=null){
					//Remove da Hash para evitar duplicidade
					sinistrosComArquivosPendentes.remove(id);

					ConsultasAvisoSinistroVO consultasAvisoSinistroVO = avisoSinistroModel.getAvisoPorNumeroSinistro((Short)element[0] , (Short)element[1], (Integer)element[2] , (Short)element[3]);

					if(consultasAvisoSinistroVO!=null){
						listaProcessosVO = new ListaProcessosVO();
						listaProcessosVO.setRamoSinistro(String.valueOf(element[0]));
						listaProcessosVO.setAnoSinistro(String.valueOf(element[1]));
						listaProcessosVO.setNumeroSinistro(String.valueOf(element[2]));
						listaProcessosVO.setSequenciaSinistro(String.valueOf(element[3]));

						listaProcessosVO.setNumeroAviso( consultasAvisoSinistroVO.getNumeroAvisoSinistro().toString() );

						listaProcessosVO.setApolice(consultasAvisoSinistroVO.getCodigoSucursal() + "-" +
								consultasAvisoSinistroVO.getDigitoENumeroApolice() + "-" +
								consultasAvisoSinistroVO.getDigitoENumeroItem());

						listaProcessosVO.setNomeCliente(consultasAvisoSinistroVO.getNomeSegurado());

						retorno.add(listaProcessosVO);
					}
				}
			}

		} catch (TarefaModelException e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		} catch (NumberFormatException e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		} catch (RemoteException e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}

		LOG.info("Tamanho do Retorno: " + retorno.size());

		LOG.info("consultarDocumentosPendentesDeAssociacao - FIM");

		return retorno;
	}


	/**
	 *
	 * Este método disponibiliza a action abertamente, através de token
	 * para não permitir consulta em qualquer processo de sinistro
	 *
	 * @author F0105027 - Marcelo Mathias
	 * @param ramoSinistro
	 * @param anoSinistro
	 * @param numeroSinistro
	 * @param sequenciaItemSinistro
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	public VisualizacaoDocumentoVO listaDocumentosProcessoVisualizacaoComToken (VisualizacaoDocumentoVO visualizacaoDocumentoVO) throws GerirArqProcRegulacaoAutoServiceException{


		if ( StringUtils.isEmpty(visualizacaoDocumentoVO.getToken()) ) {
			throw new GerirArqProcRegulacaoAutoServiceException("Utilização inválida.", LOG);
		}

		String consulta = (String)Cache.get("tokenDocumento"+visualizacaoDocumentoVO.getToken());
		if (consulta==null) {
			throw new GerirArqProcRegulacaoAutoServiceException("Acesso negado. Código de consulta expirado.", LOG);
		}

		try {
			StringTokenizer st = new StringTokenizer(consulta, "|");

			visualizacaoDocumentoVO.setRamoSinistro( new Short(st.nextToken()) );
			visualizacaoDocumentoVO.setAnoSinistro( new Short(st.nextToken()) );
			visualizacaoDocumentoVO.setNumeroSinistro( new Integer(st.nextToken()) );
			visualizacaoDocumentoVO.setSequenciaSinistro( new Short(st.nextToken()) );

		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException("Erro no parse de informações do Token.", LOG);
		}


		return listaDocumentosProcessoVisualizacaoU10(visualizacaoDocumentoVO);

	}


	/**
	 *
	 * @author F0104178 - Maina Godoy
	 * @param ramoSinistro
	 * @param anoSinistro
	 * @param numeroSinistro
	 * @param sequenciaItemSinistro
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	public VisualizacaoDocumentoVO listaDocumentosProcessoVisualizacao (VisualizacaoDocumentoVO visualizacaoDocumentoVO) throws GerirArqProcRegulacaoAutoServiceException{

		LOG.info("[listaDocumentosProcessoVisualizacao] Inicio: "+ visualizacaoDocumentoVO);

		LOG.info("VisualizacaoDocumentoVO RamoSinistro: " + visualizacaoDocumentoVO.getRamoSinistro() );

		LOG.info("VisualizacaoDocumentoVO AnoSinistro: " + visualizacaoDocumentoVO.getAnoSinistro());

		LOG.info("VisualizacaoDocumentoVO NumeroSinistro: " + visualizacaoDocumentoVO.getNumeroSinistro());

		LOG.info("VisualizacaoDocumentoVO SequenciaSinistro: " + visualizacaoDocumentoVO.getSequenciaSinistro());

		LOG.info("VisualizacaoDocumentoVO IdentificacaoArquivoProcessoRegulacao: " + visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao());

		VisualizacaoDocumentoVO voDownload = null;

		List listaTodosArquivosRecebidos = new ArrayList();
		ArquivoRecebidoVO arquivoRecebidoLastVO = null;
		String idFiltroArquivo = null;
		try {
			visualizacaoDocumentoVO.setTipoArquivos(RegulacaoSinistroAutoConstantes.TIPO_ARQUIVO_DOCUMENTOS);
			ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
			arquivoProcessoRegulacaoVO.setCodigoRamo(visualizacaoDocumentoVO.getRamoSinistro());
			arquivoProcessoRegulacaoVO.setAnoSinistro(visualizacaoDocumentoVO.getAnoSinistro());
			arquivoProcessoRegulacaoVO.setNumeroSinistro(visualizacaoDocumentoVO.getNumeroSinistro());
			arquivoProcessoRegulacaoVO.setSequenciaItemSinistro(visualizacaoDocumentoVO.getSequenciaSinistro());

			/* Busca todos documentos enviados para esse sinistro, independente da associação*/
			GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoAutoModel = getGerenciaArqProcRegulacaoAutoModel();
			List listaArquivos = gerenciaArqProcRegulacaoAutoModel.buscarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);


			if (RegulacaoSinistroUtils.collectionIsEmpty(listaArquivos)){
				LOG.info("[listaDocumentosProcessoVisualizacao] Nenhum documento localizado para o processo "+ visualizacaoDocumentoVO);
				visualizacaoDocumentoVO.setListaArquivosRecebido(listaArquivos);
				return visualizacaoDocumentoVO;
			}
			LOG.info("[listaDocumentosProcessoVisualizacao] Documentos localizados para o processo "+ visualizacaoDocumentoVO+ " : "+ listaArquivos.size());

			for (Iterator iter = listaArquivos.iterator(); iter.hasNext();) {
				arquivoProcessoRegulacaoVO = (ArquivoProcessoRegulacaoVO) iter.next();

				// Log detalhado dos campos do ArquivoProcessoRegulacaoVO
				LOG.info("[listaDocumentosProcessoVisualizacao] - Processando ArquivoProcessoRegulacaoVO: {"
						+ "NomeArquivo = " + arquivoProcessoRegulacaoVO.getNomeArquivo()
						+ ", CodigoIdentificacaoFaxNaPastaDigital = " + arquivoProcessoRegulacaoVO.getCodigoIdentificacaoFaxNaPastaDigital()
						+ ", SequenciaDocumentoNaPastaDigital = " + arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital()
						+ ", DescricaoTipoArquivo = " + arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo()
						+ ", IdentificacaoArquivoProcessoRegulacao = " + arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao()
						+ ", DataRecepcao = " + (arquivoProcessoRegulacaoVO.getDataRecepcao() != null ? arquivoProcessoRegulacaoVO.getDataRecepcao().toString() : "null")
						+ ", DataAssociacao = " + (arquivoProcessoRegulacaoVO.getDataAssociacao() != null ? arquivoProcessoRegulacaoVO.getDataAssociacao().toString() : "null")
						+ ", MatriculaUsuarioAssociacao = " + arquivoProcessoRegulacaoVO.getMatriculaUsuarioAssociacao()
						+ ", IdentificacaoDocumentoRegulacao = " + arquivoProcessoRegulacaoVO.getIdentificacaoDocumentoRegulacao()
						+ ", DescricaoDocumentoRegulacao = " + arquivoProcessoRegulacaoVO.getDescricaoDocumentoRegulacao()
						+ ", FlagCancelamento = " + arquivoProcessoRegulacaoVO.getFlagCancelamento()
						+ ", CodigoRamo = " + arquivoProcessoRegulacaoVO.getCodigoRamo()
						+ ", AnoSinistro = " + arquivoProcessoRegulacaoVO.getAnoSinistro()
						+ ", NumeroSinistro = " + arquivoProcessoRegulacaoVO.getNumeroSinistro()
						+ ", SequenciaItemSinistro = " + arquivoProcessoRegulacaoVO.getSequenciaItemSinistro()
						+ "}");

				// Filtra o arquivo se o identificador corresponder
				if (visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao() != null &&
						visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao().intValue() ==
								arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao().intValue()) {

					// Formata SequenciaDocumentoNaPastaDigital com zero à esquerda
					String sequenciaFormatada = String.format("%02d", arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital());

					// Concatena os valores para idFiltroArquivo
					idFiltroArquivo = arquivoProcessoRegulacaoVO.getCodigoIdentificacaoFaxNaPastaDigital()
							+ sequenciaFormatada
							+ arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo();

					LOG.info("[listaDocumentosProcessoVisualizacao] - Arquivo filtrado encontrado: idFiltroArquivo = " + idFiltroArquivo);
				}


				Short statusArquivo = definirStatusArquivo(
						arquivoProcessoRegulacaoVO.getFlagCancelamento(),
						arquivoProcessoRegulacaoVO.getMatriculaUsuarioAssociacao(),
						arquivoProcessoRegulacaoVO.getDataAssociacao()
				);

				// Log para verificar o status do arquivo
				LOG.info("[listaDocumentosProcessoVisualizacao] - Status do arquivo processado: "
						+ statusArquivo + ", ID: " + arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());

				// Só adiciona os arquivos que não estão cancelados
				if (statusArquivo != null &&
						statusArquivo.intValue() != RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_CANCELADO.intValue()) {

					LOG.info("[listaDocumentosProcessoVisualizacao] Adicionando arquivo : "
							+ arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());

					ArquivoRecebidoVO arquivoRecebidoVO = new ArquivoRecebidoVO();
					arquivoRecebidoVO.setTipoArquivo(org.apache.commons.lang.StringUtils.trimToEmpty(
							arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo()));

					String seqArquivo = StringUtils.fillStringLeft(
							arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital().toString(),
							'0',
							3
					);
					String nomeArquivo = arquivoProcessoRegulacaoVO.getNomeArquivo() + seqArquivo;

					arquivoRecebidoVO.setDescricaoArquivo(nomeArquivo + arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo());
					arquivoRecebidoVO.setNomeArquivo(nomeArquivo);
					arquivoRecebidoVO.setSequenciaDocumentoNaPastaDigital(new Short(seqArquivo));
					arquivoRecebidoVO.setCodigoDocumento(arquivoProcessoRegulacaoVO.getIdentificacaoDocumentoRegulacao());
					arquivoRecebidoVO.setIdentificadorAquivoProcesso(arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());

					if (arquivoProcessoRegulacaoVO.getDataRecepcao() != null) {
						String dataRecepcao = StringUtils.getStringFromDateCompleta(arquivoProcessoRegulacaoVO.getDataRecepcao());
						arquivoRecebidoVO.setDataRecepcao(dataRecepcao);
					}
					arquivoRecebidoVO.setDescricaoDocumentoRegulacao(arquivoProcessoRegulacaoVO.getDescricaoDocumentoRegulacao());

					String filePath = "";

					if (RegulacaoSinistroUtils.isObjectInArray(
							RegulacaoSinistroAutoConstantes.FORMATOS_ARQUIVOS_ARRAY_BYTES,
							arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo()
					)) {
						LOG.info("[listaDocumentosProcessoVisualizacao] 1.opcao");
						filePath = DocumentosSinistroUtils.getFilePath(
								DocumentosSinistroUtils.getNomeArquivoLink(nomeArquivo),
								DocumentosSinistroUtils.getSequenciaArquivoLink(nomeArquivo),
								arquivoRecebidoVO.getDataRecepcao()
						) + arquivoRecebidoVO.getDescricaoArquivo();

					} else {
						LOG.info("[listaDocumentosProcessoVisualizacao] 2.opcao");
						filePath = DocumentosSinistroUtils.getFilePath(
								DocumentosSinistroUtils.getNomeArquivoLink(nomeArquivo),
								DocumentosSinistroUtils.getSequenciaArquivoLink(nomeArquivo),
								arquivoRecebidoVO.getDataRecepcao()
						) + arquivoRecebidoVO.getDescricaoArquivo();
						filePath = SafeRetrieverUtils.criptografar(filePath);
					}

					arquivoRecebidoVO.setCaminhoArquivo(filePath);
					LOG.info("[listaDocumentosProcessoVisualizacao] Path do arquivo: " + filePath);

					if (arquivoRecebidoVO.getCodigoDocumento() != null) {
						DocumentoRegulacaoVO documentoRegulacaoVO = getGerenciaDocProcRegulacaoModel()
								.obterTipoDocumentoRegulacaoVO(arquivoRecebidoVO.getCodigoDocumento());
						if (documentoRegulacaoVO != null) {
							arquivoRecebidoVO.setNomeDocumento(documentoRegulacaoVO.getNomeDocumentoRegulacao());
						}
					} else {
						arquivoRecebidoVO.setNomeDocumento("Documento sem associação");
					}

					//fazer a consulta na gcp e colocar no parse para apresentar para o usuario final
					try {
						// Tenta obter a URL do GCP através do método abrirPopupDownloadGcp
						voDownload = abrirPopupDownloadGcp(idFiltroArquivo);
					} catch (UploadDocumentoServiceException e) {
						LOG.error("Erro ao tentar obter a URL assinada do GCP: ", e);
						throw new RuntimeException("Erro ao tentar obter a URL assinada do GCP", e);
					}

					LOG.info("Backend Imagem GCP URL: " + voDownload.getImagemGcp());
//					visualizacaoDocumentoVO.setImagemGcp(voDownload.getImagemGcp());
					arquivoRecebidoVO.setImagemGcp(voDownload.getImagemGcp());

					LOG.info("Backend Imagem Status Code GCP: " + voDownload.getStatusCode());
//					visualizacaoDocumentoVO.setStatusCode(voDownload.getStatusCode());
					arquivoRecebidoVO.setStatusCode(voDownload.getStatusCode());

					// Se algum arquivo veio selecionado, vamos precisar deixá-lo carregado
					if (visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao() != null &&
							visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao().intValue() ==
									arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao().intValue()) {
						arquivoRecebidoLastVO = arquivoRecebidoVO;
					} else {
						listaTodosArquivosRecebidos.add(arquivoRecebidoVO);
					}

				} else {
					LOG.info("[listaDocumentosProcessoVisualizacao] Arquivo cancelado, não será adicionado: "
							+ arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());
				}

			}

			// Se for diferente de NULL colocar arquivo selecionado no fim da lista
			// para vir "selecionado"
			if (arquivoRecebidoLastVO!=null) {
				listaTodosArquivosRecebidos.add(arquivoRecebidoLastVO);
			}
			visualizacaoDocumentoVO.setListaArquivosRecebido(listaTodosArquivosRecebidos);

			/* ordena a lista de forma decrescente, o objeto com o arquivo diferente de null vem primeiro (comportamento definido pelo parametro "false")*/
			Comparator comparator =	new NullComparator(new BeanComparator("arquivo",new NullComparator()),false);
			Collections.sort(listaTodosArquivosRecebidos, comparator);

		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}

		return visualizacaoDocumentoVO;
	}

	private VisualizacaoDocumentoVO abrirPopupDownloadGcp(String nomeArquivo) throws UploadDocumentoServiceException {


		VisualizacaoDocumentoVO vo = new VisualizacaoDocumentoVO();
		LOG.info("Início do método abrirPopupDownloadGcp");
		LOG.info("Nome do Arquivo Recebido: " + nomeArquivo);

        // Criação do objeto FotosRequest
		FotosRequest docRequest = new FotosRequest();
		ConfigProperties configProperties = new ConfigProperties(RegulacaoSinistroAutoConstantes.BASESREGULACAO_PROPERTIES);

		String bucket = configProperties.readString(RegulacaoSinistroAutoConstantes.BUCKET);
		docRequest.setBucket(bucket);
//		docRequest.setBucket("SOMA"); // Nome do bucket

		String urlProxy = configProperties.readString(RegulacaoSinistroAutoConstantes.URL_PROXY);
		docRequest.setUrlProxy(urlProxy);
//		docRequest.setUrlProxy("http://was8hmlsoma/cloudproxyapiWS/api/v1"); // Endpoint base da API

		LOG.info("Bucket: "+docRequest.getBucket());
		LOG.info("UrlProxy: "+docRequest.getUrlProxy());
		LOG.info("Nome do Arquivo Recebido: " + nomeArquivo);

		String urlAssinada = null;
		try {
			// Constrói a URL assinada chamando o método getSignedURL
			urlAssinada = getSignedURL(vo, docRequest, nomeArquivo, LOG, 1800L);
			vo.setImagemGcp(urlAssinada);

			LOG.info("URL retornada da GCP: " + urlAssinada);
		} catch (Exception e) {
			LOG.error("Erro ao gerar URL assinada para download: ", e);
			throw new UploadDocumentoServiceException("Erro ao gerar URL assinada para download.", LOG);
		}

		return vo;
	}

	private String getSignedURL(VisualizacaoDocumentoVO vo, FotosRequest request, String objectId, LogManager log, Long tempoAteExpirar) throws UploadDocumentoServiceException {
		log.debug("[FotosUtil.getSignedURL] INÍCIO");

		String url = null;

		try {
			// Constrói a URL para a API
			StringBuilder strUrl = new StringBuilder();
			strUrl.append(request.getUrlProxy());
			strUrl.append("/cloudlink?bucket=").append(request.getBucket());
			strUrl.append("&objectId=").append(objectId);
			strUrl.append("&duration=").append(tempoAteExpirar != null ? tempoAteExpirar : 1800);

			log.debug("[FotosUtil.getSignedURL] URL para requisição: " + strUrl);

			// Configura a conexão HTTP
			URL obj = new URL(strUrl.toString());
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			con.setRequestMethod("GET");

			// Verifica o código de resposta da API
			int responseCode = con.getResponseCode();
			log.debug("[FotosUtil.getSignedURL] Código de resposta HTTP: " + responseCode);

			// Set the response code in the VisualizacaoDocumentoVO object
			vo.setStatusCode(responseCode);  // Set the statusCode here
			log.debug("[FotosUtil.getSignedURL] Status Code: " + vo.getStatusCode());

			if (responseCode == 200) {
				// Lê o conteúdo da resposta
				String retorno = inputStreamToString(con.getInputStream(), log);
				log.debug("[FotosUtil.getSignedURL] Resposta recebida: " + retorno);

				// Extrai a URL do JSON de retorno
				url = extrairURLDoJson(retorno, log);
				if (url == null || url.length() == 0) {
					throw new IOException("URL assinada não encontrada na resposta.");
				}
			} else {
				throw new IOException("Erro ao tentar obter URL assinada. Código HTTP: " + responseCode);
			}

			con.disconnect();
			log.debug("[FotosUtil.getSignedURL] Conexão HTTP fechada.");
		} catch (Exception e) {
			log.error("[FotosUtil.getSignedURL] Ocorreu um erro: ", e);
		}

		log.debug("[FotosUtil.getSignedURL] FIM");
		return url;
	}

	private String inputStreamToString(InputStream inputStream, LogManager log) {
		log.info("[FotosUtil.inputStreamToString] INICIO ");
		ByteArrayOutputStream buf = new ByteArrayOutputStream();

		try {
			BufferedInputStream bis = new BufferedInputStream(inputStream);

			for(int result = bis.read(); result != -1; result = bis.read()) {
				buf.write((byte)result);
			}
		} catch (Exception var5) {
			Exception e = var5;
			log.error("[FotosUtil.inputStreamToString] Ocorreu um erro inesperado ", e);
			return null;
		}

		log.info("[FotosUtil.inputStreamToString] FIM ");
		return buf.toString();
	}

	private String extrairURLDoJson(String json, LogManager log) throws Exception {
		log.info("[FotosUtil.extrairURLDoJson] INICIO");
		String url = new String();
		if (json != null && json.length() > 0) {
			log.info("[FotosUtil.extrairURLDoJson] Realizando a extraÃ§Ã£o da url");
			Gson gson = new Gson();
			new HashMap();

			try {
				Map parsedMap = (Map)gson.fromJson(json, Map.class);
				url = (String)parsedMap.get("signedURL");
			} catch (JsonParseException var6) {
				JsonParseException e = var6;
				log.error("[FotosUtil.extrairURLDoJson] Ocorreu um erro ao realizar o parse do JSON para Url Google Cloud", e);
				throw new Exception(e);
			} catch (Exception var7) {
				Exception e = var7;
				log.error("[FotosUtil.extrairURLDoJson] Ocorreu um erro ao obter a Url Google Cloud do JSON", e);
				throw new Exception(e);
			}
		}

		log.info("[FotosUtil.extrairURLDoJson] FIM");
		return url;
	}

	/**
	 *
	 * @author F0104178 - Maina Godoy
	 * @param ramoSinistro
	 * @param anoSinistro
	 * @param numeroSinistro
	 * @param sequenciaItemSinistro
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	private VisualizacaoDocumentoVO listaDocumentosProcessoVisualizacaoU10 (VisualizacaoDocumentoVO visualizacaoDocumentoVO) throws GerirArqProcRegulacaoAutoServiceException{

		LOG.info("[listaDocumentosProcessoVisualizacaoU10] Inicio: "+ visualizacaoDocumentoVO);

		List listaTodosArquivosRecebidos = new ArrayList();
		ArquivoRecebidoVO arquivoRecebidoLastVO = null;
		try {
			visualizacaoDocumentoVO.setTipoArquivos(RegulacaoSinistroAutoConstantes.TIPO_ARQUIVO_DOCUMENTOS);
			ArquivoProcessoRegulacaoVO arquivoProcessoRegulacaoVO = new ArquivoProcessoRegulacaoVO();
			arquivoProcessoRegulacaoVO.setCodigoRamo(visualizacaoDocumentoVO.getRamoSinistro());
			arquivoProcessoRegulacaoVO.setAnoSinistro(visualizacaoDocumentoVO.getAnoSinistro());
			arquivoProcessoRegulacaoVO.setNumeroSinistro(visualizacaoDocumentoVO.getNumeroSinistro());
			arquivoProcessoRegulacaoVO.setSequenciaItemSinistro(visualizacaoDocumentoVO.getSequenciaSinistro());

			/* Busca todos documentos enviados para esse sinistro, independente da associação*/
			GerenciaArqProcRegulacaoAutoModel gerenciaArqProcRegulacaoAutoModel = getGerenciaArqProcRegulacaoAutoModel();
			List listaArquivos = gerenciaArqProcRegulacaoAutoModel.buscarArquivosProcessoRegulacaoPorSinistro(arquivoProcessoRegulacaoVO);

			GerenciaDocProcRegulacaoAutoModel docModel = getGerenciaDocProcRegulacaoModel();

			if (RegulacaoSinistroUtils.collectionIsEmpty(listaArquivos)){
				LOG.info("[listaDocumentosProcessoVisualizacaoU10] Nenhum documento localizado para o processo "+ visualizacaoDocumentoVO);
				return visualizacaoDocumentoVO;
			}

			LOG.info("[listaDocumentosProcessoVisualizacaoU10] Documentos localizados para o processo "+ visualizacaoDocumentoVO+ " : "+ listaArquivos.size());
			for (Iterator iter = listaArquivos.iterator(); iter.hasNext();) {
				arquivoProcessoRegulacaoVO = (ArquivoProcessoRegulacaoVO) iter.next();

				DocumentoRegulacaoVO doc = docModel.obterTipoDocumentoRegulacaoVO(arquivoProcessoRegulacaoVO.getIdentificacaoDocumentoRegulacao());

				if (doc != null && "N".equalsIgnoreCase(doc.getFlagDocumentoUsoInterno())){
					Short statusArquivo = definirStatusArquivo(arquivoProcessoRegulacaoVO.getFlagCancelamento(), arquivoProcessoRegulacaoVO.getMatriculaUsuarioAssociacao(), arquivoProcessoRegulacaoVO.getDataAssociacao());

					//só adiciona os arquivos que não estão cancelados
					if (statusArquivo !=null &&
							statusArquivo.intValue() != RegulacaoSinistroAutoConstantes.STATUS_ARQUIVO_CANCELADO.intValue()){

						LOG.info("[listaDocumentosProcessoVisualizacaoU10] Adicionando arquivo : "+ arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());

						ArquivoRecebidoVO arquivoRecebidoVO = new ArquivoRecebidoVO();
						arquivoRecebidoVO.setTipoArquivo(org.apache.commons.lang.StringUtils.trimToEmpty(arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo()));

						String seqArquivo = StringUtils.fillStringLeft(arquivoProcessoRegulacaoVO.getSequenciaDocumentoNaPastaDigital().toString(), '0', 3);
						String nomeArquivo = arquivoProcessoRegulacaoVO.getNomeArquivo() +seqArquivo;

						arquivoRecebidoVO.setDescricaoArquivo(nomeArquivo + arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo());
						arquivoRecebidoVO.setNomeArquivo( nomeArquivo );
						arquivoRecebidoVO.setSequenciaDocumentoNaPastaDigital(new Short(seqArquivo));
						arquivoRecebidoVO.setCodigoDocumento(arquivoProcessoRegulacaoVO.getIdentificacaoDocumentoRegulacao());
						arquivoRecebidoVO.setIdentificadorAquivoProcesso(arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());
						if (arquivoProcessoRegulacaoVO.getDataRecepcao() != null) {
							String dataRecepcao = StringUtils.getStringFromDateCompleta(arquivoProcessoRegulacaoVO.getDataRecepcao());
							arquivoRecebidoVO.setDataRecepcao(dataRecepcao);
						}
						arquivoRecebidoVO.setDescricaoDocumentoRegulacao(arquivoProcessoRegulacaoVO.getDescricaoDocumentoRegulacao());

						String filePath ="";

						if (RegulacaoSinistroUtils.isObjectInArray(RegulacaoSinistroAutoConstantes.FORMATOS_ARQUIVOS_ARRAY_BYTES,arquivoProcessoRegulacaoVO.getDescricaoTipoArquivo())){
							filePath = DocumentosSinistroUtils.getFilePath(DocumentosSinistroUtils.getNomeArquivoLink(nomeArquivo),
									DocumentosSinistroUtils.getSequenciaArquivoLink(nomeArquivo),
									arquivoRecebidoVO.getDataRecepcao())
									+arquivoRecebidoVO.getDescricaoArquivo();

						}else{
							filePath = DocumentosSinistroUtils.getFilePath(DocumentosSinistroUtils.getNomeArquivoLink(nomeArquivo),
									DocumentosSinistroUtils.getSequenciaArquivoLink(nomeArquivo),
									arquivoRecebidoVO.getDataRecepcao())
									+arquivoRecebidoVO.getDescricaoArquivo();
							filePath = SafeRetrieverUtils.criptografar(filePath);
						}

						arquivoRecebidoVO.setCaminhoArquivo(filePath);
						LOG.info("[listaDocumentosProcessoVisualizacaoU10] Path do arquivo: "+ filePath);

						if (arquivoRecebidoVO.getCodigoDocumento() != null){

							DocumentoRegulacaoVO documentoRegulacaoVO = getGerenciaDocProcRegulacaoModel().obterTipoDocumentoRegulacaoVO(arquivoRecebidoVO.getCodigoDocumento());
							if (documentoRegulacaoVO != null){
								arquivoRecebidoVO.setNomeDocumento(documentoRegulacaoVO.getNomeDocumentoRegulacao());
							}
						}else{
							arquivoRecebidoVO.setNomeDocumento("Documento sem associação");
						}


						//se algum arquivo veio selecionado, vamos precisar deixá-lo carregado
						if (visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao() != null && visualizacaoDocumentoVO.getIdentificacaoArquivoProcessoRegulacao().intValue() == arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao().intValue()){
							arquivoRecebidoLastVO = arquivoRecebidoVO;
						} else {
							listaTodosArquivosRecebidos.add(arquivoRecebidoVO);
						}

					}else{
						LOG.info("[listaDocumentosProcessoVisualizacaoU10] Arquivo cancelado, não será adicionado: "+ arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());
					}
				} else {
					LOG.info("[listaDocumentosProcessoVisualizacaoU10] Documento de uso Interno, não será adicionado: "+ arquivoProcessoRegulacaoVO.getIdentificacaoArquivoProcessoRegulacao());
				}

			}
			// Se for diferente de NULL colocar arquivo selecionado no fim da lista
			// para vir "selecionado"
			if (arquivoRecebidoLastVO!=null) {
				listaTodosArquivosRecebidos.add(arquivoRecebidoLastVO);
			}
			visualizacaoDocumentoVO.setListaArquivosRecebido(listaTodosArquivosRecebidos);

			/* ordena a lista de forma decrescente, o objeto com o arquivo diferente de null vem primeiro (comportamento definido pelo parametro "false")*/
			Comparator comparator =	new NullComparator(new BeanComparator("arquivo",new NullComparator()),false);
			Collections.sort(listaTodosArquivosRecebidos, comparator);

		} catch (Exception e) {
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}

		return visualizacaoDocumentoVO;
	}


	/**
	 * Carregar um arquivo a partir do seu path criptografado
	 * @author F0104178 - Maina Godoy
	 * @param cryptFilePath
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	public ArquivoRecebidoVO carregarArquivoVisualizacao(String cryptFilePath) throws GerirArqProcRegulacaoAutoServiceException{

		ArquivoRecebidoVO arquivoRecebidoVO = null;
		try {

			arquivoRecebidoVO = new ArquivoRecebidoVO();

			String filePath= cryptFilePath;
			LOG.info("[filePath]  " + filePath);
			if (cryptFilePath.indexOf("/")==-1 && cryptFilePath.indexOf("\\")==-1) {
				// Não é uma URL válida. Tentar decriptografar.
				try {
					filePath= new String((CriptografiaUtils.toHex(cryptFilePath)));
				} catch (Exception e) { }
			}

			//Carrega Imagem da VP
			if (filePath != null && filePath.startsWith("VP|")) {
				RespostaFSRecuperarArquivo resposta = null;

				try {
					//Carrega o parametro do filepath: VP|%idArquivo%|%token%
					final String[] params = filePath.split("\\|");
					final String idArquivo = params[1].trim();
					final String token = params[2].trim();

					resposta = FileSystemClientUtil.downloadArquivo(idArquivo, token);

				} catch (Exception e) {
					LOG.info("[carregarArquivoVisualizacao] ERRO ao ler arquivo: ", e);
				}

				if(resposta != null) {
					arquivoRecebidoVO.setTipoArquivo("JPG");
					arquivoRecebidoVO.setArquivo(resposta.getConteudo());
					arquivoRecebidoVO.setNomeArquivo(resposta.getNomeArquivo());
				}

			} else {

				LOG.info("PATH-Obtido " + filePath);

				ConfigProperties configProperties = new ConfigProperties(RegulacaoSinistroAutoConstantes.BASESREGULACAO_PROPERTIES);
				String pathNAS =  configProperties.readString(RegulacaoSinistroAutoConstantes.CAMINHO_PASTADIGITAL_NAS);

				//se o caminho utilizado é o do NAS
				if (filePath.indexOf(pathNAS) == 0 ){
					String pathNT =  configProperties.readString(RegulacaoSinistroAutoConstantes.CAMINHO_PASTADIGITAL);

					filePath= StringUtils.substituirString(filePath,pathNAS,pathNT);
				}

				byte[] arquivo  = RegulacaoSinistroUtils.getArquivo(filePath);

				if (arquivo != null) {
					//LOG.info("[carregarArquivoVisualizacao] Arquivo encontrado. Chave = [" + lmArquivos.firstKey() + "]");
					arquivoRecebidoVO.setArquivo(arquivo);
					arquivoRecebidoVO.setCaminhoArquivo(cryptFilePath);
				}else{
					LOG.warn("[carregarArquivoVisualizacao] Arquivo não encontrado: "+ filePath);
				}
			}

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			throw new GerirArqProcRegulacaoAutoServiceException("[carregarArquivoVisualizacao] Erro ao carregar arquivo: "+ e, LOG);
		}
		return arquivoRecebidoVO;

	}


	/**
	 * Recupera as fotos de vistoria previa para exibir no visualizador
	 * @param visualizacaoDocumentoVO
	 * @return
	 * @throws GerirArqProcRegulacaoAutoServiceException
	 */
	public VisualizacaoDocumentoVO getFotosVistoriaPreviaVisualizacao (VisualizacaoDocumentoVO visualizacaoDocumentoVO) throws GerirArqProcRegulacaoAutoServiceException{

		LOG.info("[getFotosVistoriaPreviaVisualizacao] Inicio: "+ visualizacaoDocumentoVO.getNumeroVistoriaPrevia());

		List<ArquivoRecebidoVO> listaTodosArquivosRecebidos = new ArrayList<ArquivoRecebidoVO>();

		try {
			visualizacaoDocumentoVO.setTipoArquivos(RegulacaoSinistroAutoConstantes.TIPO_ARQUIVO_FOTOS_VP);
			visualizacaoDocumentoVO.setSistemaOrigem("U10");//com esse sistema não mostra o campo "Visualizar fotos de outro processo"

			List<Integer> listaVistorias = new ArrayList<Integer>();
			listaVistorias.add(visualizacaoDocumentoVO.getNumeroVistoriaPrevia());

			LaudoVistoriaPreviaModel laudoVistoriaPreviaModel = LookupHelper.lookupLaudoVistoriaPreviaModel();
			List<FotosVistoriaPreviaVO> listaFotos = laudoVistoriaPreviaModel.consultarFotosVistorias(listaVistorias);

			if (RegulacaoSinistroUtils.collectionIsEmpty(listaFotos)){
				LOG.info("[getFotosVistoriaPreviaVisualizacao] Nenhuma foto localizada para a vistoria "+ visualizacaoDocumentoVO.getNumeroVistoriaPrevia());
				return visualizacaoDocumentoVO;
			}

			LOG.info("[getFotosVistoriaPreviaVisualizacao] Fotos localizadas para a vistoria "+ visualizacaoDocumentoVO.getNumeroVistoriaPrevia()+ " : "+ listaFotos.size());
			FotosVistoriaPreviaVO fotosVistoriaPreviaVO;

			final String tipoUtilizacao = getTipoUtilizacao();
			final String origemUtilizacao = ORIGEM_UTILIZACAO_GCDE;

			final String token = FileSystemClientUtil.gerarToken(tipoUtilizacao, origemUtilizacao);

			for (Iterator<FotosVistoriaPreviaVO> iter = listaFotos.iterator(); iter.hasNext();) {

				fotosVistoriaPreviaVO = iter.next();
				LOG.info("[getFotosVistoriaPreviaVisualizacao] Adicionando foto : "+ fotosVistoriaPreviaVO.getNomeArquivoFotoNoSerivodrNt());
				LOG.info("[getFotosVistoriaPreviaVisualizacao] File - ID imagem : "+ fotosVistoriaPreviaVO.getCodigoFotoGcde());

				ArquivoRecebidoVO arquivoRecebidoVO = new ArquivoRecebidoVO();
				arquivoRecebidoVO.setTipoArquivo("JPG");
				arquivoRecebidoVO.setIdArquivoVp(fotosVistoriaPreviaVO.getCodigoFotoGcde());
				arquivoRecebidoVO.setToken(token);
				arquivoRecebidoVO.setSequenciaDocumentoNaPastaDigital(fotosVistoriaPreviaVO.getSequenciaDasFotosVistoriaPrevia());
				arquivoRecebidoVO.setIdentificadorAquivoProcesso(fotosVistoriaPreviaVO.getSequenciaDasFotosVistoriaPrevia().intValue());
				arquivoRecebidoVO.setNomeDocumento(fotosVistoriaPreviaVO.getNomeArquivoFotoNoSerivodrNt());

				listaTodosArquivosRecebidos.add(arquivoRecebidoVO);
			}
			visualizacaoDocumentoVO.setListaArquivosRecebido(listaTodosArquivosRecebidos);
		} catch (Exception e) {
			LOG.warn("[getFotosVistoriaPreviaVisualizacao] ERRO ao tentar carregar lista de arquivos.");
			throw new GerirArqProcRegulacaoAutoServiceException(e, LOG);
		}
		LOG.info("[getFotosVistoriaPreviaVisualizacao] FIM");
		return visualizacaoDocumentoVO;
	}

	private String getTipoUtilizacao() {
		final String tipoUtilizacao = RegulacaoSinistroUtils.BASE_PROPERTIES_CONF.readString("regulacaosinistroauto.tokenservice.tipo.utilizacao");

		return tipoUtilizacao;
	}


}
