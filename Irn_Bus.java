// ----------------------------------------------------------------------
// Project: "BMar_Interface".
// Client: "DGRM".
//
// Class Irn_Bus
// Created for Module 'irn'
// ----------------------------------------------------------------------
package dgrm.bmar.iface.business;

import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.stream.Collectors;

import dgrm.bmar.common.business.serial.jackson.JacksonSerializer;
import dgrm.bmar.common.shared.constants.ConstantsCommon;
import dgrm.bmar.common.shared.enums.EnumsCommon.CodBandeira;
import dgrm.bmar.common.shared.enums.EnumsCommon.CodFuncaoMotor;
import dgrm.bmar.common.shared.enums.EnumsCommon.CodTpAtividade;
import dgrm.bmar.common.wserv.JWSToolbox;
import dgrm.bmar.iface.business.base.AbstractIrn_Bus;
import dgrm.bmar.iface.shared.EnumsIface.CodAreaRegistoIrn;
import dgrm.bmar.iface.shared.EnumsIface.CodEstadoMsg;
import dgrm.bmar.iface.shared.EnumsIface.CodEstadoMsgEnv;
import dgrm.bmar.iface.shared.EnumsIface.CodEstadoMsgRec;
import dgrm.bmar.iface.shared.EnumsIface.CodTpAtividadeIrn;
import dgrm.bmar.iface.shared.beans.extemba.EmbaCComOutBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaCaraComumBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaCaraPescBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaCaraRecBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaConstrucaoBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaIdentificacaoBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbaMotorizacaoBean;
import dgrm.bmar.iface.shared.beans.extemba.EmbarcacaoBean;
import dgrm.bmar.iface.shared.beans.irn.IrnAtualizaSirnavemBean;
import dgrm.bmar.iface.shared.beans.irn.IrnConsFactosJurBean;
import dgrm.bmar.iface.wserv.irn.dto.DadosChamadorDTO;
import local.bai.basis.context.PortableContext;
import local.bai.basis.exceptions.ServiceException;
import local.bai.basis.utils.Checks;
import local.bai.servhibern.context.DataContext;

/**
 * Service class for module 'irn'.<br>
 * This class provides all the functionalities in class {@ AbstractIrn_Bus}, but allows the project team to add more specific
 * services.<br>
 */
public final class Irn_Bus
    extends
    AbstractIrn_Bus {

    private static final String IRN_SYSTEMID = "BMAR_SNEM";

    /**
     * Constructor for class <tt>Irn_Bus</tt><br>
     * 
     * @param sharedDataCntx
     *            The data context to be used inside the new instance.
     * @param sameTransaction
     *            Specifies whether this new instance's calls will be performed inside the same connection and transaction,
     *            specified in the given data context.
     */
    public Irn_Bus(DataContext sharedDataCntx, boolean sameTransaction) {

        super(sharedDataCntx, sameTransaction);
        super.assignTranslator(dgrm.bmar.common.business.translate.TranslatorFactory.FACTORY);
    }

    /**
     * Constructor for class <tt>Irn_Bus</tt><br>
     * 
     * @param callerCntx
     *            A portable context, that shall be used for creating an internal data context object..
     */
    public Irn_Bus(PortableContext callerCntx) {

        super(callerCntx);
        super.assignTranslator(dgrm.bmar.common.business.translate.TranslatorFactory.FACTORY);
    }

    /**
     * This method is used to call a webservice from IRN to check for any new Factos Juridicos related to a given vessel.<br>
     * 
     * @param embaBean
     *            the vessel bean with all required information
     * @return the bean with the result of the call
     * @throws IllegalArgumentException
     * @throws ServiceException
     */
    public IrnConsFactosJurBean checkFactosJuridicos(EmbarcacaoBean embaBean)
        throws IllegalArgumentException, ServiceException {

        IrnConsFactosJurBean consultaBean = new IrnConsFactosJurBean();

        try {
            // extract current child beans from emba
            Date currDateTime = getContext().getTimeSource().getCurrentDateTime();
            EmbaIdentificacaoBean embaIdentBean = embaBean.getLstEmbaIdentificacao()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaIdentificacaoBean());

            // prepare the information for the call
            consultaBean.setDatMsgConsulta(currDateTime);
            consultaBean.setCodAreaRegisto(
                    Checks.areEqual(embaBean.getCodBandeira(), CodBandeira.MAR.code()) ? CodAreaRegistoIrn.TR_ZFM.code()
                                                                                       : CodAreaRegistoIrn.TR_CONV.code());
            consultaBean.setParentCapitania(embaIdentBean.getParentXfkCapitania());
            consultaBean.setNumRegSnem(embaBean.getNumRegEmba());
            consultaBean.setTxtIndChamada(embaBean.getTxtIndChamada());
            consultaBean.setNumImo(embaBean.getNumImoBase());
            consultaBean.setTxtConjuntoIdent(embaBean.getTxtConjIdent());
            consultaBean.setTxtConjIdentAnt(embaIdentBean.getTxtConjIdentAnt());
            consultaBean.setNomEmba(embaBean.getNomEmbaBase());
            consultaBean.setCodTpAtividade(convertTpAtividadeIrn(embaBean.getCodTpAtivBase()));
            consultaBean.setCodEstadoMsg(CodEstadoMsg.MSG_POR_ENVIAR.code());
            consultaBean.setDatEstadoMsg(currDateTime);

            // save this first version of the bean to database
            insertOrUpdateIrnConsFactosJur(consultaBean);

            // call WS from IRN to obtain a token
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            String obtainedToken = "dummy";

            // prepare the message to send
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            DadosChamadorDTO chamadorDTO = new DadosChamadorDTO();
            chamadorDTO.setIdMensagem(consultaBean.getIdMsgConsulta().toString());
            chamadorDTO.setCodSistema(IRN_SYSTEMID);
            chamadorDTO.setCodUtilizador(getContext().getUserData().getIdUser());
            chamadorDTO.setTxtToken(obtainedToken);
            // DadosEmbaDTO embaDTO = new DadosEmbaDTO();
            // embaDTO.setCodAreaRegisto(consultaBean.getCodAreaRegisto());
            // embaDTO.setCodCapitania(consultaBean.getCodCapitania());
            // embaDTO.setNumRegSnem(consultaBean.getNumRegSnem());
            // embaDTO.setTxtIndChamada(consultaBean.getTxtIndChamada());
            // embaDTO.setNumImo(consultaBean.getNumImo());
            // embaDTO.setTxtConjuntoIdent(consultaBean.getTxtConjuntoIdent());
            // embaDTO.setTxtConjIdentAnt(consultaBean.getTxtConjIdentAnt());
            // embaDTO.setNomEmba(consultaBean.getNomEmba());
            // embaDTO.setCodTpAtividade(consultaBean.getCodTpAtividade());

            // updates the bean one last time before calling the WS
            consultaBean.setCodEstadoMsg(CodEstadoMsg.MSG_ENVIADA.code());
            consultaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
            // consultaBean.setTxtMsgEnviada(????????); //TODO - TO IMPLEMENT #####################
            insertOrUpdateIrnConsFactosJur(consultaBean);

            // call WS from IRN to send the message
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            String responseMsg = "";
            // check for error in response

            // updates the bean with the result of the call
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            consultaBean.setCodEstadoMsg(CodEstadoMsg.RSP_POR_TRATAR.code());
            consultaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
            consultaBean.setTxtMsgRecebida(new JacksonSerializer().serialize(responseMsg));
            // list of factos juridicos
            // if (null != responseMsg.getLstDadosFacto()) {
            // for (DadosFactoDTO dadosFactoDTO : responseMsg.getLstDadosFacto()) {
            // IrnFactoJurBean factoJurBean = new IrnFactoJurBean();
            // factoJurBean.setCodIdFactoOrig(dadosFactoDTO.getIdFacto());
            // factoJurBean.setCodTpFacto(EnumType.codeElementOf(dadosFactoDTO.getCodTpFacto(),
            // CodTpFactoJuridicoIrn.values()) ? dadosFactoDTO.getCodTpFacto()
            // : CodTpFactoJuridicoIrn.ERR.code());
            // factoJurBean.setDatRegisto(IRNWSToolbox.toDate(dadosFactoDTO.getDatRegisto()));
            // factoJurBean.setCodEstado(EnumType.codeElementOf(dadosFactoDTO.getCodEstado(),
            // CodEstadoFactoIrn.values()) ? dadosFactoDTO.getCodEstado() : CodEstadoFactoIrn.ERR.code());
            // factoJurBean.setDatEstado(IRNWSToolbox.toDate(dadosFactoDTO.getDatEstado()));
            // factoJurBean.setNomConservatoria(dadosFactoDTO.getNomConservatoria());
            // factoJurBean.setTxtDescricao(dadosFactoDTO.getTxtDescricao());
            //
            // // list of intervenientes for each facto juridico
            // if (null != dadosFactoDTO.getLstDadosInterveniente()) {
            // for (DadosIntervenienteDTO dadosIntervDTO : dadosFactoDTO.getLstDadosInterveniente()) {
            // IrnFactoJurInterBean factoJurInterBean = new IrnFactoJurInterBean();
            // factoJurInterBean
            // .setCodTpInterveniente(EnumType.codeElementOf(dadosIntervDTO.getCodTpInterveniente(),
            // CodTpIntervenienteIrn.values()) ? dadosIntervDTO.getCodTpInterveniente()
            // : CodTpIntervenienteIrn.ERR.code());
            // factoJurInterBean.setCodTpPessoa(EnumType.codeElementOf(dadosIntervDTO.getCodTpPessoa(),
            // CodTpPessoaIrn.values()) ? dadosIntervDTO.getCodTpPessoa() : CodTpPessoaIrn.ERR.code());
            // factoJurInterBean.setNomInterveniente(dadosIntervDTO.getNomInterveniente());
            // factoJurInterBean.setCodOrigemNif(EnumType.codeElementOf(dadosIntervDTO.getCodOrigemNif(),
            // CodOrigemNifIrn.values()) ? dadosIntervDTO.getCodOrigemNif()
            // : CodOrigemNifIrn.ERR.code());
            // factoJurInterBean.setNumNif(dadosIntervDTO.getNumNif());
            // factoJurInterBean.setCodTpDocIdent(EnumType.codeElementOf(dadosIntervDTO.getCodTpDocIdent(),
            // CodTpDocIdentIrn.values()) ? dadosIntervDTO.getCodTpDocIdent()
            // : CodTpDocIdentIrn.ERR.code());
            // factoJurInterBean.setNumDocIdent(dadosIntervDTO.getNumDocIdent());
            // factoJurInterBean.setTxtEmail(dadosIntervDTO.getTxtEmail());
            // factoJurInterBean.setNumTelefone(dadosIntervDTO.getNumTelefone());
            // factoJurInterBean.setTxtMorada(dadosIntervDTO.getTxtMorada());
            //
            // factoJurInterBean.setParentIrnFactoJur(factoJurBean);
            // factoJurBean.getLstIrnFactoJurInter().add(factoJurInterBean);
            // }
            // }
            //
            // factoJurBean.setParentIrnAtualizaSnem(null);
            // factoJurBean.setParentIrnConsFactosJur(consultaBean);
            // consultaBean.getLstIrnFactoJur().add(factoJurBean);
            // }
            // }
            // saves the data
            insertOrUpdateIrnConsFactosJur(consultaBean);

            // finally calls BMar_Emba to save this information associated to the vessel
            new Extemba_Bus(getContext().portable()).updateLstFactosJuridicosEmba(embaBean, consultaBean.getFlgExistemFactos(),
                    consultaBean.getLstIrnFactoJur());

            // updates status in database
            consultaBean.setCodEstadoMsg(CodEstadoMsgRec.TRATADA.code());
            consultaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
            insertOrUpdateIrnConsFactosJur(consultaBean);

        }
        catch (Exception ex) {
            log.error("EXCEPTION > Irn_Bus.checkFactosJuridicos() >>> Id Emba: " + embaBean.getIdEmba() + " :: Num SNEM: "
                    + embaBean.getNumRegEmba() + " :: Cod Origem Marsys: " + embaBean.getCodOrigemMarsys(), ex);
            try {
                consultaBean.setCodEstadoMsg(CodEstadoMsgRec.ERRO.code());
                consultaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
                consultaBean.setTxtObservacoes(ex.getMessage() + ex.getStackTrace());

                insertOrUpdateIrnConsFactosJur(consultaBean);
            }
            catch (Exception e) {
                // ignore
            }
            JWSToolbox.processWSCallException(ex, true);
        }

        return consultaBean;
    }

    /**
     * This method is used to call a webservice from IRN to send updated data of a vessel.<br>
     * 
     * @param embaBean
     *            the vessel bean with all required information
     * @return the bean with the result of the call
     * @throws IllegalArgumentException
     * @throws ServiceException
     */
    public IrnAtualizaSirnavemBean sendUpdatedEmbaToIrn(EmbarcacaoBean embaBean)
        throws IllegalArgumentException, ServiceException {

        IrnAtualizaSirnavemBean atualizaBean = new IrnAtualizaSirnavemBean();

        try {
            // extract current child beans from emba
            Date currDateTime = getContext().getTimeSource().getCurrentDateTime();
            EmbaConstrucaoBean embaConstrBean = embaBean.getLstEmbaConstrucao()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaConstrucaoBean());
            EmbaCaraComumBean embaCaraComumBean = embaBean.getLstEmbaCaraComum()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaCaraComumBean());
            EmbaCaraPescBean embaCaraPescaBean = embaBean.getLstEmbaCaraPesc()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaCaraPescBean());
            EmbaCaraRecBean embaCaraRecreioBean = embaBean.getLstEmbaCaraRec()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaCaraRecBean());
            EmbaCComOutBean embaCaraComercioBean = embaBean.getLstEmbaCComOut()
                    .stream()
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .findFirst()
                    .orElse(new EmbaCComOutBean());
            Collection<EmbaMotorizacaoBean> lstEmbaMotorBean = embaBean.getLstEmbaMotorizacao()
                    .stream()
                    .filter(motor -> motor.getCodFuncMotor().equals(CodFuncaoMotor.PROP_PRIN.code()))
                    .filter(rf -> (rf.getDatInicio() == null || !currDateTime.before(rf.getDatInicio()))
                            && (rf.getDatFim() == null || !currDateTime.after(rf.getDatFim())))
                    .collect(Collectors.toList());

            // prepare the information for the call
            atualizaBean.setDatMsgAtualiza(currDateTime);
            atualizaBean.setNumRegSnem(embaBean.getNumRegEmba());
            atualizaBean.setNomEmba(embaBean.getNomEmbaBase());
            atualizaBean.setTxtConjuntoIdent(embaBean.getTxtConjIdent());
            atualizaBean.setCodTpAtividade(convertTpAtividadeIrn(embaBean.getCodTpAtivBase()));
            atualizaBean.setTxtIndChamada(embaBean.getTxtIndChamada());
            atualizaBean.setNumImo(embaBean.getNumImoBase());
            atualizaBean.setValCompForaFora(embaCaraComumBean.getValCompFF());
            atualizaBean.setValCompPerpend(
                    Checks.areEqual(embaBean.getCodTpAtivBase(), CodTpAtividade.PESCA.code()) ? embaCaraPescaBean
                            .getValCompPerpend() : embaCaraComercioBean.getValCompPerpend());
            atualizaBean.setValCompTotal(Checks.elementOf(embaBean.getCodTpAtivBase(), CodTpAtividade.PESCA.code(),
                    CodTpAtividade.RECREIO.code()) ? atualizaBean.getValCompForaFora() : atualizaBean.getValCompPerpend());
            atualizaBean.setValBoca(embaCaraComumBean.getValBoca());
            atualizaBean
                    .setValPontal(Checks.areEqual(embaBean.getCodTpAtivBase(), CodTpAtividade.PESCA.code()) ? embaCaraPescaBean
                            .getValPontalConstr() : embaCaraComercioBean.getValPontalConstr());
            atualizaBean.setValArqBruta(embaCaraComumBean.getValArqBrutaGt());
            atualizaBean.setValArqLiq(Checks.areEqual(embaBean.getCodTpAtivBase(),
                    CodTpAtividade.PESCA.code()) ? embaCaraPescaBean.getValArqLiqNt() : embaCaraComercioBean.getValArqLiqNt());
            atualizaBean.setTxtLocConstrucao(embaConstrBean.getTxtLocConstrucao());
            atualizaBean.setDatConstrucao(embaConstrBean.getDatConstrucao());
            String nomEstaleiro = !Checks.nullempty(embaConstrBean.getParentEstaleiro())
                    && !Checks.nullempty(embaConstrBean.getParentEstaleiro().getNomEntidade())
                                                                                               ? embaConstrBean
                                                                                                       .getParentEstaleiro()
                                                                                                       .getNomEntidade()
                                                                                               : null;
            String txtMarcaModelo = !Checks.nullempty(embaBean.getParentMarca()) ? embaBean.getParentMarca().getTxtMarca() + " "
                    + embaBean.getTxtModelo() : null;
            atualizaBean.setTxtConstrutor(!Checks.nullempty(nomEstaleiro) ? nomEstaleiro : txtMarcaModelo);
            atualizaBean.setCodTpMatCasco(embaCaraComumBean.getCodTpMatCasco());
            atualizaBean.setNumConstrCasco(
                    Checks.areEqual(embaBean.getCodTpAtivBase(), CodTpAtividade.PESCA.code()) ? embaCaraPescaBean
                            .getNumConstrCasco() : embaCaraRecreioBean.getNumConstrCasco());
            StringBuilder txtSistemaPropulsao = new StringBuilder(
                    "Tipo Propulsão: " + embaCaraComumBean.getCodTpPropulsao() + "; ");
            StringBuilder txtFabricanteMotor = new StringBuilder("");
            if (!Checks.nullempty(lstEmbaMotorBean)) {
                int cont = 0;
                Set<String> lstMarcas = new LinkedHashSet<String>();
                for (EmbaMotorizacaoBean motorBean : lstEmbaMotorBean) {
                    String txtMarca = !Checks.nullempty(motorBean.getParentMarca()) ? motorBean.getParentMarca().getTxtMarca()
                                                                                    : "";
                    lstMarcas.add(txtMarca);
                    txtSistemaPropulsao.append(ConstantsCommon.LINE_BREAK)
                            .append("Motor " + ++cont + " - ")
                            .append("Localização: " + motorBean.getCodLocalMotor() + "; ")
                            .append("Marca: " + txtMarca + "; ")
                            .append("Modelo: " + motorBean.getTxtModeloMotor() + "; ")
                            .append("N.º Série: " + motorBean.getNumSerieMotor() + "; ")
                            .append("Tipo Combustível: " + motorBean.getCodTpCombustivel() + "; ");
                }
                for (String marca : lstMarcas) {
                    txtFabricanteMotor.append(marca).append("; ");
                }
            }
            atualizaBean.setTxtSistPropulsao(txtSistemaPropulsao.toString());
            atualizaBean.setTxtFabricanteMotor(txtFabricanteMotor.toString());

            atualizaBean.setCodEstadoMsg(CodEstadoMsgEnv.POR_ENVIAR.code());
            atualizaBean.setDatEstadoMsg(currDateTime);

            // save this first version of the bean to database
            insertOrUpdateIrnAtualizaSirnavem(atualizaBean);

            // call WS from IRN to obtain a token
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            String obtainedToken = "dummy";

            // prepare the message to send
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            DadosChamadorDTO chamadorDTO = new DadosChamadorDTO();
            chamadorDTO.setIdMensagem(atualizaBean.getIdMsgAtualiza().toString());
            chamadorDTO.setCodSistema(IRN_SYSTEMID);
            chamadorDTO.setCodUtilizador(getContext().getUserData().getIdUser());
            chamadorDTO.setTxtToken(obtainedToken);
            // DadosEmbaDTO embaDTO = new DadosEmbaDTO();
            // embaDTO.setNumRegSnem(atualizaBean.getNumRegSnem());
            // embaDTO.setNomEmba(atualizaBean.getNomEmba());
            // embaDTO.setTxtConjuntoIdent(atualizaBean.getTxtConjuntoIdent());
            // embaDTO.setCodTpAtividade(atualizaBean.getCodTpAtividade());
            // embaDTO.setTxtIndChamada(atualizaBean.getTxtIndChamada());
            // embaDTO.setNumImo(atualizaBean.getNumImo());
            // embaDTO.setValCompTotal(atualizaBean.getValCompTotal());
            // embaDTO.setValCompForaFora(atualizaBean.getValCompForaFora());
            // embaDTO.setValCompPerpend(atualizaBean.getValCompPerpend());
            // embaDTO.setValBoca(atualizaBean.getValBoca());
            // embaDTO.setValPontal(atualizaBean.getValPontal());
            // embaDTO.setValArqBruta(atualizaBean.getValArqBruta());
            // embaDTO.setValArqLiq(atualizaBean.getValArqLiq());
            // embaDTO.setTxtLocConstrucao(atualizaBean.getTxtLocConstrucao());
            // embaDTO.setDatConstrucao(atualizaBean.getDatConstrucao());
            // embaDTO.setTxtConstrutor(atualizaBean.getTxtConstrutor());
            // embaDTO.setCodTpMatCasco(atualizaBean.getCodTpMatCasco());
            // embaDTO.setNumConstrCasco(atualizaBean.getNumConstrCasco());
            // embaDTO.setTxtSistPropulsao(atualizaBean.getTxtSistPropulsao());
            // embaDTO.setTxtFabricanteMotor(atualizaBean.getTxtFabricanteMotor());

            // call WS from IRN to send the message
            // ###################################################################
            // TODO - TO IMPLEMENT
            // ###################################################################
            String responseMsg = "";
            // check for error in response

            // updates the bean with the result of the call
            atualizaBean.setCodEstadoMsg(CodEstadoMsg.MSG_ENVIADA.code());
            atualizaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
            // consultaBean.setTxtMsgEnviada(????????); //TODO - TO IMPLEMENT #####################
            insertOrUpdateIrnAtualizaSirnavem(atualizaBean);

        }
        catch (Exception ex) {
            log.error("EXCEPTION > Irn_Bus.sendUpdatedEmbaToIrn() >>> Id Emba: " + embaBean.getIdEmba() + " :: Num SNEM: "
                    + embaBean.getNumRegEmba() + " :: Cod Origem Marsys: " + embaBean.getCodOrigemMarsys(), ex);
            try {
                atualizaBean.setCodEstadoMsg(CodEstadoMsgRec.ERRO.code());
                atualizaBean.setDatEstadoMsg(getContext().getTimeSource().getCurrentDateTime());
                atualizaBean.setTxtObservacoes(ex.getMessage() + ex.getStackTrace());

                insertOrUpdateIrnAtualizaSirnavem(atualizaBean);
            }
            catch (Exception e) {
                // ignore
            }
            JWSToolbox.processWSCallException(ex, true);
        }

        return atualizaBean;
    }

    /**
     * Method used to convert the SNEM activity type into the IRN's activity type.<br>
     * 
     * @param codTpAtividadeSnem
     *            the SNEM's activity type to convert
     * @return the result of the convertion
     */
    private String convertTpAtividadeIrn(String codTpAtividadeSnem) {

        switch (CodTpAtividade.fromCode(codTpAtividadeSnem)) {
            case PESCA:
                return CodTpAtividadeIrn.NEP.code();
            case COMERCIO:
                return CodTpAtividadeIrn.ECRIA.code();
            case INVESTIG:
                return CodTpAtividadeIrn.NEI.code();
            case AUXILIAR:
                return CodTpAtividadeIrn.NEA.code();
            case RECREIO:
                return CodTpAtividadeIrn.ERBMAR.code();
            case REBOCADOR:
                return CodTpAtividadeIrn.NER.code();
            case OUTRA:
            default:
                return CodTpAtividadeIrn.OUTRA.code();
        }
    }

} // end class
