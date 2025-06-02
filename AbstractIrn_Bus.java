// ================================================================================================
// == DO NOT EDIT MANUALLY !!!!
// == This is automated code, based on the Bean classes that compose the data model.
// == Any modifications to this file *MAY BE LOST*
// ================================================================================================

// ----------------------------------------------------------------------
// Project: "BMar_Interface".
// Client: "DGRM".
//
// Class AbstractIrn_Bus
// Created for Module 'irn'
// ----------------------------------------------------------------------
package dgrm.bmar.iface.business.base;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FlushMode;
import org.hibernate.Transaction;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.Junction;

import dgrm.bmar.common.business.BmarAbstractBusinessService;
import dgrm.bmar.iface.business.valid.BeanValidatorRegistrar;
import dgrm.bmar.iface.shared.beans.extgeral.EntidadeBean;
import dgrm.bmar.iface.shared.beans.irn.IrnAtualizaSirnavemBean;
import dgrm.bmar.iface.shared.beans.irn.IrnAtualizaSirnavemCrit;
import dgrm.bmar.iface.shared.beans.irn.IrnAtualizaSnemBean;
import dgrm.bmar.iface.shared.beans.irn.IrnAtualizaSnemCrit;
import dgrm.bmar.iface.shared.beans.irn.IrnConsFactosJurBean;
import dgrm.bmar.iface.shared.beans.irn.IrnConsFactosJurCrit;
import dgrm.bmar.iface.shared.beans.irn.IrnFactoJurBean;
import dgrm.bmar.iface.shared.beans.irn.IrnFactoJurCrit;
import dgrm.bmar.iface.shared.beans.irn.IrnFactoJurInterBean;
import dgrm.bmar.iface.shared.beans.irn.IrnFactoJurInterCrit;
import local.bai.basis.OperationMode;
import local.bai.basis.context.PortableContext;
import local.bai.basis.databeans.BeanDetailSpec;
import local.bai.basis.exceptions.AgregateBusinessException;
import local.bai.basis.exceptions.BusinessException;
import local.bai.basis.exceptions.ServiceException;
import local.bai.basis.exceptions.ServiceRuntimeException;
import local.bai.basis.services.OrderInfo;
import local.bai.basis.services.ServiceReturn;
import local.bai.basis.validation.ValidationTreewalker;
import local.bai.servhibern.context.DataContext;
import local.bai.servhibern.dataaccess.HibernateDAO;

/**
 * Abstract service class for module 'irn'.<br>
 * This class is not intended to be used nor modified. Please use the non-abstract class instead.<br>
 */
public abstract class AbstractIrn_Bus
    extends
    BmarAbstractBusinessService {

    /*--------------------------------------------------------
     * Note to Developers:
     *--------------------------------------------------------
     * This class is intended to provided methods that implement 
     * CRUD operations.
     *	
     * NOTE:
     * If there is the need to develop specific (non-CRUD) service methods.
     * This is NOT the place to do that!!
     * That should be done on a specific class that extends this one. 
     */

    /**
     * Constructor for class <tt>AbstractIrn_Bus</tt>.<br>
     * 
     * @param sharedDataCntx
     *            The data context to be used inside the new instance.
     * @param sameTransaction
     *            Specifies whether this new instance's calls will be performed inside the same connection and transaction,
     *            specified in the given data context.
     */
    public AbstractIrn_Bus(DataContext sharedDataCntx, boolean sameTransaction) {

        super(sharedDataCntx, sameTransaction);
    }

    /**
     * Constructor for class <tt>AbstractIrn_Bus</tt>.<br>
     * 
     * @param callerCntx
     *            A portable context, that shall be used for creating an internal data context object..
     */
    public AbstractIrn_Bus(PortableContext callerCntx) {

        super(callerCntx);
    }

    // ---------------------------------------------------------------------
    // Standard service methods for table 'IRN_ATUALIZA_SIRNAVEM'
    // ---------------------------------------------------------------------

    /**
     * Obtain a <u>single bean</u> of type {@link IrnAtualizaSirnavemBean} from table <tt>IRN_ATUALIZA_SIRNAVEM</tt> using, as
     * criteria, the field properties <tt>[idMsgAtualiza]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * This method's result will always contain all the child beans, regardless of the contents of the list of included child
     * beans specified on the <tt>keyBean</tt>.<br>
     * 
     * @param keyBean
     *            an instance of <tt>IrnAtualizaSirnavemBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> findSingleIrnAtualizaSirnavem_PK(IrnAtualizaSirnavemBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnAtualizaSirnavemBean ret = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(IrnAtualizaSirnavemBean.class, dc);
            ret = myDao.retrieveSingleByPK(keyBean.getIdMsgAtualiza());

            // Detach lists, including all children, propagate that all children are included
            detachDataBeanListValues(ret, false, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, (ret == null ? 0l : 1l), null);
    }

    /**
     * Obtain a <u>single bean</u> of type {@link IrnAtualizaSirnavemBean} from table <tt>IRN_ATUALIZA_SIRNAVEM</tt> using, as
     * criteria, the field properties <tt>[idMsgAtualiza]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param keyBean
     *            an instance of <tt>IrnAtualizaSirnavemBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> findSingleIrnAtualizaSirnavem_PK(boolean includeChildren,
                                                                                   IrnAtualizaSirnavemBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        ServiceReturn<IrnAtualizaSirnavemBean> ret = null;

        if (includeChildren) {
            // search using default method by primary key (includes all children)
            ret = findSingleIrnAtualizaSirnavem_PK(keyBean);
        }
        else if (keyBean != null && keyBean.getIdMsgAtualiza() != null) {
            // search using list method to avoid unwanted children
            IrnAtualizaSirnavemCrit critBean = new IrnAtualizaSirnavemCrit();
            critBean.setIdMsgAtualiza(keyBean.getIdMsgAtualiza());
            BeanDetailSpec newDetSpec = BeanDetailSpec.includeChildrenNone().importExclusions4Parents(keyBean.getDetailSpec());
            critBean.setDetailSpec(newDetSpec);
            ServiceReturn<Collection<IrnAtualizaSirnavemBean>> lstRet = findListIrnAtualizaSirnavem_Crit(false, critBean);

            Collection<IrnAtualizaSirnavemBean> lstVal = lstRet.getValue();
            ret = new ServiceReturn<IrnAtualizaSirnavemBean>(lstRet.getMessage());
            if (lstVal != null && !lstVal.isEmpty()) {
                // returns the first record found, if any
                ret.setValue(lstVal.iterator().next());
            }
        }

        return ret;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnAtualizaSirnavemBean} from table <tt>IRN_ATUALIZA_SIRNAVEM</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numRegSnem, nomEmba, txtConjuntoIdent, codTpAtividade, codTpAtividadeList, txtIndChamada, numImo, valCompTotal, valCompTotalMinv, valCompTotalMaxv, valCompForaFora, valCompForaForaMinv, valCompForaForaMaxv, valCompPerpend, valCompPerpendMinv, valCompPerpendMaxv, valBoca, valBocaMinv, valBocaMaxv, valPontal, valPontalMinv, valPontalMaxv, valArqBruta, valArqBrutaMinv, valArqBrutaMaxv, valArqLiq, valArqLiqMinv, valArqLiqMaxv, txtLocConstrucao, datConstrucao, datConstrucaoMinv, datConstrucaoMaxv, txtConstrutor, codTpMatCasco, codTpMatCascoList, numConstrCasco, txtSistPropulsao, txtFabricanteMotor, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSirnavemCrit</tt>.
     * @return <tt>ServiceReturn<Collection<IrnAtualizaSirnavemBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnAtualizaSirnavemBean>> findListIrnAtualizaSirnavem_Crit(boolean includeChildren,
                                                                                               IrnAtualizaSirnavemCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnAtualizaSirnavem_Crit(includeChildren, critBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnAtualizaSirnavemBean} from table <tt>IRN_ATUALIZA_SIRNAVEM</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numRegSnem, nomEmba, txtConjuntoIdent, codTpAtividade, codTpAtividadeList, txtIndChamada, numImo, valCompTotal, valCompTotalMinv, valCompTotalMaxv, valCompForaFora, valCompForaForaMinv, valCompForaForaMaxv, valCompPerpend, valCompPerpendMinv, valCompPerpendMaxv, valBoca, valBocaMinv, valBocaMaxv, valPontal, valPontalMinv, valPontalMaxv, valArqBruta, valArqBrutaMinv, valArqBrutaMaxv, valArqLiq, valArqLiqMinv, valArqLiqMaxv, txtLocConstrucao, datConstrucao, datConstrucaoMinv, datConstrucaoMaxv, txtConstrutor, codTpMatCasco, codTpMatCascoList, numConstrCasco, txtSistPropulsao, txtFabricanteMotor, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSirnavemCrit</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnAtualizaSirnavemBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnAtualizaSirnavemBean>> findListIrnAtualizaSirnavem_Crit(boolean includeChildren,
                                                                                               IrnAtualizaSirnavemCrit critBean,
                                                                                               int startRec, int maxRecs,
                                                                                               OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnAtualizaSirnavemBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(IrnAtualizaSirnavemBean.class, dc);
            Criteria crit = myDao.createCriteria();

            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            junct = buildCriteria4IrnAtualizaSirnavem(junct, critBean);

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren, critBean.getDetailSpec());
            crit = applyOrdering4IrnAtualizaSirnavem(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : maxRecs;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, !includeChildren, critBean.getDetailSpec());
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnAtualizaSirnavemBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Builds search restrictions into the given {@link Criteria} object for table <tt>IRN_ATUALIZA_SIRNAVEM</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numRegSnem, nomEmba, txtConjuntoIdent, codTpAtividade, codTpAtividadeList, txtIndChamada, numImo, valCompTotal, valCompTotalMinv, valCompTotalMaxv, valCompForaFora, valCompForaForaMinv, valCompForaForaMaxv, valCompPerpend, valCompPerpendMinv, valCompPerpendMaxv, valBoca, valBocaMinv, valBocaMaxv, valPontal, valPontalMinv, valPontalMaxv, valArqBruta, valArqBrutaMinv, valArqBrutaMaxv, valArqLiq, valArqLiqMinv, valArqLiqMaxv, txtLocConstrucao, datConstrucao, datConstrucaoMinv, datConstrucaoMaxv, txtConstrutor, codTpMatCasco, codTpMatCascoList, numConstrCasco, txtSistPropulsao, txtFabricanteMotor, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * <br>
     * This method returns an instance of Junction, that may, or not, be the received one.<br>
     * 
     * @param objCrit
     *            The Junction to which the restrictions must be added, the object will be modified internally.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSirnavemCrit</tt>.
     * @return <tt>Junction</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Junction buildCriteria4IrnAtualizaSirnavem(Junction objCrit, IrnAtualizaSirnavemCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_ID_MSG_ATUALIZA, critBean.getIdMsgAtualiza());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_DAT_MSG_ATUALIZA, critBean.getDatMsgAtualiza());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_DAT_MSG_ATUALIZA, false, critBean.getDatMsgAtualizaMinv(),
                critBean.getDatMsgAtualizaMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_NUM_REG_SNEM, critBean.getNumRegSnem());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_NOM_EMBA, critBean.getNomEmba());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_CONJUNTO_IDENT, critBean.getTxtConjuntoIdent());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_COD_TP_ATIVIDADE, critBean.getCodTpAtividade());
        addToCriteria(Op.IN, objCrit, IrnAtualizaSirnavemBean.FLD_COD_TP_ATIVIDADE, critBean.getCodTpAtividadeList());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_IND_CHAMADA, critBean.getTxtIndChamada());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_NUM_IMO, critBean.getNumImo());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_TOTAL, critBean.getValCompTotal());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_TOTAL, false, critBean.getValCompTotalMinv(),
                critBean.getValCompTotalMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_FORA_FORA, critBean.getValCompForaFora());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_FORA_FORA, false, critBean.getValCompForaForaMinv(),
                critBean.getValCompForaForaMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_PERPEND, critBean.getValCompPerpend());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_COMP_PERPEND, false, critBean.getValCompPerpendMinv(),
                critBean.getValCompPerpendMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_BOCA, critBean.getValBoca());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_BOCA, false, critBean.getValBocaMinv(),
                critBean.getValBocaMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_PONTAL, critBean.getValPontal());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_PONTAL, false, critBean.getValPontalMinv(),
                critBean.getValPontalMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_ARQ_BRUTA, critBean.getValArqBruta());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_ARQ_BRUTA, false, critBean.getValArqBrutaMinv(),
                critBean.getValArqBrutaMaxv());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_VAL_ARQ_LIQ, critBean.getValArqLiq());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_VAL_ARQ_LIQ, false, critBean.getValArqLiqMinv(),
                critBean.getValArqLiqMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_LOC_CONSTRUCAO, critBean.getTxtLocConstrucao());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_DAT_CONSTRUCAO, critBean.getDatConstrucao());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_DAT_CONSTRUCAO, false, critBean.getDatConstrucaoMinv(),
                critBean.getDatConstrucaoMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_CONSTRUTOR, critBean.getTxtConstrutor());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_COD_TP_MAT_CASCO, critBean.getCodTpMatCasco());
        addToCriteria(Op.IN, objCrit, IrnAtualizaSirnavemBean.FLD_COD_TP_MAT_CASCO, critBean.getCodTpMatCascoList());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_NUM_CONSTR_CASCO, critBean.getNumConstrCasco());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_SIST_PROPULSAO, critBean.getTxtSistPropulsao());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_FABRICANTE_MOTOR, critBean.getTxtFabricanteMotor());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsg());
        addToCriteria(Op.IN, objCrit, IrnAtualizaSirnavemBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsgList());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSirnavemBean.FLD_DAT_ESTADO_MSG, critBean.getDatEstadoMsg());
        addRangeToCriteria(objCrit, IrnAtualizaSirnavemBean.FLD_DAT_ESTADO_MSG, false, critBean.getDatEstadoMsgMinv(),
                critBean.getDatEstadoMsgMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSirnavemBean.FLD_TXT_OBSERVACOES, critBean.getTxtObservacoes());
        return objCrit;
    }

    /**
     * Adapts the {@link Criteria} object for table <tt>IRN_ATUALIZA_SIRNAVEM</tt>, the object will be modified internally using
     * to use the given Ordering Info object.<br>
     * 
     * @param objCrit
     *            The object to which the ordering must be added, the object will be modified internally.
     * @param order
     *            The ordering info to be applied. If null or empty, default ordering will be used.
     * @return <tt>Criteria</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Criteria applyOrdering4IrnAtualizaSirnavem(Criteria objCrit, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Add additional criteria to not fetch child beans
        if (order == null || order.isEmpty()) {
            order = new OrderInfo();
            order.placeEnd(IrnAtualizaSirnavemBean.FLD_ID_MSG_ATUALIZA, OrderInfo.DESC);
        }

        objCrit = applyOrdering(objCrit, order);
        return objCrit;
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> insertIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertIrnAtualizaSirnavem(dataBean, true);
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insert.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> insertIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean,
                                                                            boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSirnavem(OperationMode.CREATE, dataBean);

        IrnAtualizaSirnavemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSirnavemBean.class,
                    dc);
            myDao.insert(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.CREATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, null, null);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> updateIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return updateIrnAtualizaSirnavem(dataBean, true);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the update.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> updateIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean,
                                                                            boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSirnavem(OperationMode.UPDATE, dataBean);

        IrnAtualizaSirnavemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSirnavemBean.class,
                    dc);
            myDao.update(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, null, null);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> insertOrUpdateIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertOrUpdateIrnAtualizaSirnavem(dataBean, true);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insertOrUpdate.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> insertOrUpdateIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean,
                                                                                    boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSirnavem(OperationMode.UPDATE, dataBean);

        IrnAtualizaSirnavemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSirnavemBean.class,
                    dc);
            myDao.insertOrUpdate(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, null, null);
    }

    /**
     * <u>Deletes</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants, from the table
     * <tt>IRN_ATUALIZA_SIRNAVEM</tt>.<br>
     * <br>
     * Obviously this method's result will not contain any child beans.<br>
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavemBean</tt> to be removed from database.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> deleteIrnAtualizaSirnavem(IrnAtualizaSirnavemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSirnavem(OperationMode.DELETE, dataBean);

        IrnAtualizaSirnavemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            HibernateDAO<IrnAtualizaSirnavemBean> myDao = HibernateDAO.instance(IrnAtualizaSirnavemBean.class, dc);
            myDao.delete(dataBean);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.DELETE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, null, null);
    }

    /**
     * <u>Creates</u> a bean of type {@link IrnAtualizaSirnavemBean}, returning the new data.<br>
     * If some defaults are to be assumed, an override method must be created on the subclass.<br>
     * 
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> createIrnAtualizaSirnavem()
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnAtualizaSirnavemBean ret = new IrnAtualizaSirnavemBean().fillWithDefaults();

        return new ServiceReturn<IrnAtualizaSirnavemBean>(ret, null, null);
    }

    /**
     * <u>Validates</u> a bean of type {@link IrnAtualizaSirnavemBean}, and all its descendants.<br>
     * Returns the given data, updated during the performed validations.<br>
     * 
     * @param mode
     *            The operation mode for which the data must validated.
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSirnavem</tt> validated.
     * @return <tt>ServiceReturn<IrnAtualizaSirnavemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSirnavemBean> validateIrnAtualizaSirnavem(OperationMode mode,
                                                                              IrnAtualizaSirnavemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        AgregateBusinessException agrex = new AgregateBusinessException();

        // Validate the data structure by using the recursive mechanism
        List<BusinessException> lstBex = new ArrayList<BusinessException>();
        obtainValidationTW().validateTree(mode, dataBean, lstBex);
        agrex.addExceptions(lstBex);
        if (agrex != null && !agrex.isEmpty()) {
            throw agrex;
        }

        return new ServiceReturn<IrnAtualizaSirnavemBean>(dataBean, null, null);
    }

    // ---------------------------------------------------------------------
    // Standard service methods for table 'IRN_ATUALIZA_SNEM'
    // ---------------------------------------------------------------------

    /**
     * Obtain a <u>single bean</u> of type {@link IrnAtualizaSnemBean} from table <tt>IRN_ATUALIZA_SNEM</tt> using, as criteria,
     * the field properties <tt>[idMsgAtualiza]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * This method's result will always contain all the child beans, regardless of the contents of the list of included child
     * beans specified on the <tt>keyBean</tt>.<br>
     * 
     * @param keyBean
     *            an instance of <tt>IrnAtualizaSnemBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> findSingleIrnAtualizaSnem_PK(IrnAtualizaSnemBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnAtualizaSnemBean ret = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(IrnAtualizaSnemBean.class, dc);
            ret = myDao.retrieveSingleByPK(keyBean.getIdMsgAtualiza());

            // Detach lists, including all children, propagate that all children are included
            detachDataBeanListValues(ret, false, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, (ret == null ? 0l : 1l), null);
    }

    /**
     * Obtain a <u>single bean</u> of type {@link IrnAtualizaSnemBean} from table <tt>IRN_ATUALIZA_SNEM</tt> using, as criteria,
     * the field properties <tt>[idMsgAtualiza]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param keyBean
     *            an instance of <tt>IrnAtualizaSnemBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> findSingleIrnAtualizaSnem_PK(boolean includeChildren, IrnAtualizaSnemBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        ServiceReturn<IrnAtualizaSnemBean> ret = null;

        if (includeChildren) {
            // search using default method by primary key (includes all children)
            ret = findSingleIrnAtualizaSnem_PK(keyBean);
        }
        else if (keyBean != null && keyBean.getIdMsgAtualiza() != null) {
            // search using list method to avoid unwanted children
            IrnAtualizaSnemCrit critBean = new IrnAtualizaSnemCrit();
            critBean.setIdMsgAtualiza(keyBean.getIdMsgAtualiza());
            BeanDetailSpec newDetSpec = BeanDetailSpec.includeChildrenNone().importExclusions4Parents(keyBean.getDetailSpec());
            critBean.setDetailSpec(newDetSpec);
            ServiceReturn<Collection<IrnAtualizaSnemBean>> lstRet = findListIrnAtualizaSnem_Crit(false, critBean);

            Collection<IrnAtualizaSnemBean> lstVal = lstRet.getValue();
            ret = new ServiceReturn<IrnAtualizaSnemBean>(lstRet.getMessage());
            if (lstVal != null && !lstVal.isEmpty()) {
                // returns the first record found, if any
                ret.setValue(lstVal.iterator().next());
            }
        }

        return ret;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnAtualizaSnemBean} from table <tt>IRN_ATUALIZA_SNEM</tt> using, as criteria,
     * the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numMsgRecebida, numRegSnem, numRegMar, nomEmba, txtConjuntoIdent, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSnemCrit</tt>.
     * @return <tt>ServiceReturn<Collection<IrnAtualizaSnemBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnAtualizaSnemBean>> findListIrnAtualizaSnem_Crit(boolean includeChildren,
                                                                                       IrnAtualizaSnemCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnAtualizaSnem_Crit(includeChildren, critBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnAtualizaSnemBean} from table <tt>IRN_ATUALIZA_SNEM</tt> using, as criteria,
     * the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numMsgRecebida, numRegSnem, numRegMar, nomEmba, txtConjuntoIdent, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSnemCrit</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnAtualizaSnemBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnAtualizaSnemBean>> findListIrnAtualizaSnem_Crit(boolean includeChildren,
                                                                                       IrnAtualizaSnemCrit critBean, int startRec,
                                                                                       int maxRecs, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnAtualizaSnemBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(IrnAtualizaSnemBean.class, dc);
            Criteria crit = myDao.createCriteria();

            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            junct = buildCriteria4IrnAtualizaSnem(junct, critBean);

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren, critBean.getDetailSpec());
            crit = applyOrdering4IrnAtualizaSnem(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : maxRecs;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, !includeChildren, critBean.getDetailSpec());
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnAtualizaSnemBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Builds search restrictions into the given {@link Criteria} object for table <tt>IRN_ATUALIZA_SNEM</tt> using, as criteria,
     * the criteria properties
     * <tt>[idMsgAtualiza, datMsgAtualiza, datMsgAtualizaMinv, datMsgAtualizaMaxv, numMsgRecebida, numRegSnem, numRegMar, nomEmba, txtConjuntoIdent, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes]</tt>.<br>
     * <br>
     * This method returns an instance of Junction, that may, or not, be the received one.<br>
     * 
     * @param objCrit
     *            The Junction to which the restrictions must be added, the object will be modified internally.
     * @param critBean
     *            an instance of <tt>IrnAtualizaSnemCrit</tt>.
     * @return <tt>Junction</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Junction buildCriteria4IrnAtualizaSnem(Junction objCrit, IrnAtualizaSnemCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        addToCriteria(Op.EQ, objCrit, IrnAtualizaSnemBean.FLD_ID_MSG_ATUALIZA, critBean.getIdMsgAtualiza());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSnemBean.FLD_DAT_MSG_ATUALIZA, critBean.getDatMsgAtualiza());
        addRangeToCriteria(objCrit, IrnAtualizaSnemBean.FLD_DAT_MSG_ATUALIZA, false, critBean.getDatMsgAtualizaMinv(),
                critBean.getDatMsgAtualizaMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_NUM_MSG_RECEBIDA, critBean.getNumMsgRecebida());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_NUM_REG_SNEM, critBean.getNumRegSnem());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_NUM_REG_MAR, critBean.getNumRegMar());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_NOM_EMBA, critBean.getNomEmba());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_TXT_CONJUNTO_IDENT, critBean.getTxtConjuntoIdent());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsg());
        addToCriteria(Op.IN, objCrit, IrnAtualizaSnemBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsgList());
        addToCriteria(Op.EQ, objCrit, IrnAtualizaSnemBean.FLD_DAT_ESTADO_MSG, critBean.getDatEstadoMsg());
        addRangeToCriteria(objCrit, IrnAtualizaSnemBean.FLD_DAT_ESTADO_MSG, false, critBean.getDatEstadoMsgMinv(),
                critBean.getDatEstadoMsgMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnAtualizaSnemBean.FLD_TXT_OBSERVACOES, critBean.getTxtObservacoes());
        return objCrit;
    }

    /**
     * Adapts the {@link Criteria} object for table <tt>IRN_ATUALIZA_SNEM</tt>, the object will be modified internally using to
     * use the given Ordering Info object.<br>
     * 
     * @param objCrit
     *            The object to which the ordering must be added, the object will be modified internally.
     * @param order
     *            The ordering info to be applied. If null or empty, default ordering will be used.
     * @return <tt>Criteria</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Criteria applyOrdering4IrnAtualizaSnem(Criteria objCrit, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Add additional criteria to not fetch child beans
        if (order == null || order.isEmpty()) {
            order = new OrderInfo();
            order.placeEnd(IrnAtualizaSnemBean.FLD_ID_MSG_ATUALIZA, OrderInfo.DESC);
        }

        objCrit = applyOrdering(objCrit, order);
        return objCrit;
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> insertIrnAtualizaSnem(IrnAtualizaSnemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertIrnAtualizaSnem(dataBean, true);
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insert.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> insertIrnAtualizaSnem(IrnAtualizaSnemBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSnem(OperationMode.CREATE, dataBean);

        IrnAtualizaSnemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSnemBean.class, dc);
            myDao.insert(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.CREATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, null, null);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> updateIrnAtualizaSnem(IrnAtualizaSnemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return updateIrnAtualizaSnem(dataBean, true);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the update.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> updateIrnAtualizaSnem(IrnAtualizaSnemBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSnem(OperationMode.UPDATE, dataBean);

        IrnAtualizaSnemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSnemBean.class, dc);
            myDao.update(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, null, null);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> insertOrUpdateIrnAtualizaSnem(IrnAtualizaSnemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertOrUpdateIrnAtualizaSnem(dataBean, true);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, on the table
     * <tt>IRN_ATUALIZA_SNEM</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insertOrUpdate.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> insertOrUpdateIrnAtualizaSnem(IrnAtualizaSnemBean dataBean,
                                                                            boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSnem(OperationMode.UPDATE, dataBean);

        IrnAtualizaSnemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnAtualizaSnemBean.class, dc);
            myDao.insertOrUpdate(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, null, null);
    }

    /**
     * <u>Deletes</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants, from the table
     * <tt>IRN_ATUALIZA_SNEM</tt>.<br>
     * <br>
     * Obviously this method's result will not contain any child beans.<br>
     * 
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnemBean</tt> to be removed from database.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> deleteIrnAtualizaSnem(IrnAtualizaSnemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnAtualizaSnem(OperationMode.DELETE, dataBean);

        IrnAtualizaSnemBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            HibernateDAO<IrnAtualizaSnemBean> myDao = HibernateDAO.instance(IrnAtualizaSnemBean.class, dc);
            myDao.delete(dataBean);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.DELETE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, null, null);
    }

    /**
     * <u>Creates</u> a bean of type {@link IrnAtualizaSnemBean}, returning the new data.<br>
     * If some defaults are to be assumed, an override method must be created on the subclass.<br>
     * 
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> createIrnAtualizaSnem()
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnAtualizaSnemBean ret = new IrnAtualizaSnemBean().fillWithDefaults();

        return new ServiceReturn<IrnAtualizaSnemBean>(ret, null, null);
    }

    /**
     * <u>Validates</u> a bean of type {@link IrnAtualizaSnemBean}, and all its descendants.<br>
     * Returns the given data, updated during the performed validations.<br>
     * 
     * @param mode
     *            The operation mode for which the data must validated.
     * @param dataBean
     *            an instance of <tt>IrnAtualizaSnem</tt> validated.
     * @return <tt>ServiceReturn<IrnAtualizaSnemBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnAtualizaSnemBean> validateIrnAtualizaSnem(OperationMode mode, IrnAtualizaSnemBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        AgregateBusinessException agrex = new AgregateBusinessException();

        // Validate the data structure by using the recursive mechanism
        List<BusinessException> lstBex = new ArrayList<BusinessException>();
        obtainValidationTW().validateTree(mode, dataBean, lstBex);
        agrex.addExceptions(lstBex);
        if (agrex != null && !agrex.isEmpty()) {
            throw agrex;
        }

        return new ServiceReturn<IrnAtualizaSnemBean>(dataBean, null, null);
    }

    // ---------------------------------------------------------------------
    // Standard service methods for table 'IRN_CONS_FACTOS_JUR'
    // ---------------------------------------------------------------------

    /**
     * Obtain a <u>single bean</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> using, as
     * criteria, the field properties <tt>[idMsgConsulta]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * This method's result will always contain all the child beans, regardless of the contents of the list of included child
     * beans specified on the <tt>keyBean</tt>.<br>
     * 
     * @param keyBean
     *            an instance of <tt>IrnConsFactosJurBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> findSingleIrnConsFactosJur_PK(IrnConsFactosJurBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnConsFactosJurBean ret = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(IrnConsFactosJurBean.class, dc);
            ret = myDao.retrieveSingleByPK(keyBean.getIdMsgConsulta());

            // Detach lists, including all children, propagate that all children are included
            detachDataBeanListValues(ret, false, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnConsFactosJurBean>(ret, (ret == null ? 0l : 1l), null);
    }

    /**
     * Obtain a <u>single bean</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> using, as
     * criteria, the field properties <tt>[idMsgConsulta]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param keyBean
     *            an instance of <tt>IrnConsFactosJurBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> findSingleIrnConsFactosJur_PK(boolean includeChildren,
                                                                             IrnConsFactosJurBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        ServiceReturn<IrnConsFactosJurBean> ret = null;

        if (includeChildren) {
            // search using default method by primary key (includes all children)
            ret = findSingleIrnConsFactosJur_PK(keyBean);
        }
        else if (keyBean != null && keyBean.getIdMsgConsulta() != null) {
            // search using list method to avoid unwanted children
            IrnConsFactosJurCrit critBean = new IrnConsFactosJurCrit();
            critBean.setIdMsgConsulta(keyBean.getIdMsgConsulta());
            BeanDetailSpec newDetSpec = BeanDetailSpec.includeChildrenNone().importExclusions4Parents(keyBean.getDetailSpec());
            critBean.setDetailSpec(newDetSpec);
            ServiceReturn<Collection<IrnConsFactosJurBean>> lstRet = findListIrnConsFactosJur_Crit(false, critBean);

            Collection<IrnConsFactosJurBean> lstVal = lstRet.getValue();
            ret = new ServiceReturn<IrnConsFactosJurBean>(lstRet.getMessage());
            if (lstVal != null && !lstVal.isEmpty()) {
                // returns the first record found, if any
                ret.setValue(lstVal.iterator().next());
            }
        }

        return ret;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgConsulta, datMsgConsulta, datMsgConsultaMinv, datMsgConsultaMaxv, codAreaRegisto, xfkCapitania, xfkCapitaniaList, numRegSnem, txtIndChamada, numImo, txtConjuntoIdent, txtConjIdentAnt, nomEmba, codTpAtividade, codTpAtividadeList, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes, flgExistemFactos, flgExistemFactosList]</tt>.<br>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnConsFactosJurCrit</tt>.
     * @return <tt>ServiceReturn<Collection<IrnConsFactosJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnConsFactosJurBean>> findListIrnConsFactosJur_Crit(boolean includeChildren,
                                                                                         IrnConsFactosJurCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnConsFactosJur_Crit(includeChildren, critBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgConsulta, datMsgConsulta, datMsgConsultaMinv, datMsgConsultaMaxv, codAreaRegisto, xfkCapitania, xfkCapitaniaList, numRegSnem, txtIndChamada, numImo, txtConjuntoIdent, txtConjIdentAnt, nomEmba, codTpAtividade, codTpAtividadeList, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes, flgExistemFactos, flgExistemFactosList]</tt>.<br>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnConsFactosJurCrit</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnConsFactosJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnConsFactosJurBean>> findListIrnConsFactosJur_Crit(boolean includeChildren,
                                                                                         IrnConsFactosJurCrit critBean,
                                                                                         int startRec, int maxRecs,
                                                                                         OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnConsFactosJurBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(IrnConsFactosJurBean.class, dc);
            Criteria crit = myDao.createCriteria();

            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            junct = buildCriteria4IrnConsFactosJur(junct, critBean);

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren, critBean.getDetailSpec());
            crit = applyOrdering4IrnConsFactosJur(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : maxRecs;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, !includeChildren, critBean.getDetailSpec());
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnConsFactosJurBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Builds search restrictions into the given {@link Criteria} object for table <tt>IRN_CONS_FACTOS_JUR</tt> using, as
     * criteria, the criteria properties
     * <tt>[idMsgConsulta, datMsgConsulta, datMsgConsultaMinv, datMsgConsultaMaxv, codAreaRegisto, xfkCapitania, xfkCapitaniaList, numRegSnem, txtIndChamada, numImo, txtConjuntoIdent, txtConjIdentAnt, nomEmba, codTpAtividade, codTpAtividadeList, codEstadoMsg, codEstadoMsgList, datEstadoMsg, datEstadoMsgMinv, datEstadoMsgMaxv, txtObservacoes, flgExistemFactos, flgExistemFactosList]</tt>.<br>
     * <br>
     * This method returns an instance of Junction, that may, or not, be the received one.<br>
     * 
     * @param objCrit
     *            The Junction to which the restrictions must be added, the object will be modified internally.
     * @param critBean
     *            an instance of <tt>IrnConsFactosJurCrit</tt>.
     * @return <tt>Junction</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Junction buildCriteria4IrnConsFactosJur(Junction objCrit, IrnConsFactosJurCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        addToCriteria(Op.EQ, objCrit, IrnConsFactosJurBean.FLD_ID_MSG_CONSULTA, critBean.getIdMsgConsulta());
        addToCriteria(Op.EQ, objCrit, IrnConsFactosJurBean.FLD_DAT_MSG_CONSULTA, critBean.getDatMsgConsulta());
        addRangeToCriteria(objCrit, IrnConsFactosJurBean.FLD_DAT_MSG_CONSULTA, false, critBean.getDatMsgConsultaMinv(),
                critBean.getDatMsgConsultaMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_COD_AREA_REGISTO, critBean.getCodAreaRegisto());
        addToCriteria(Op.EQ, objCrit, IrnConsFactosJurBean.FLD_XFK_CAPITANIA, critBean.getXfkCapitania());
        addToCriteria(Op.IN, objCrit, IrnConsFactosJurBean.FLD_XFK_CAPITANIA, critBean.getXfkCapitaniaList());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_NUM_REG_SNEM, critBean.getNumRegSnem());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_TXT_IND_CHAMADA, critBean.getTxtIndChamada());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_NUM_IMO, critBean.getNumImo());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_TXT_CONJUNTO_IDENT, critBean.getTxtConjuntoIdent());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_TXT_CONJ_IDENT_ANT, critBean.getTxtConjIdentAnt());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_NOM_EMBA, critBean.getNomEmba());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_COD_TP_ATIVIDADE, critBean.getCodTpAtividade());
        addToCriteria(Op.IN, objCrit, IrnConsFactosJurBean.FLD_COD_TP_ATIVIDADE, critBean.getCodTpAtividadeList());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsg());
        addToCriteria(Op.IN, objCrit, IrnConsFactosJurBean.FLD_COD_ESTADO_MSG, critBean.getCodEstadoMsgList());
        addToCriteria(Op.EQ, objCrit, IrnConsFactosJurBean.FLD_DAT_ESTADO_MSG, critBean.getDatEstadoMsg());
        addRangeToCriteria(objCrit, IrnConsFactosJurBean.FLD_DAT_ESTADO_MSG, false, critBean.getDatEstadoMsgMinv(),
                critBean.getDatEstadoMsgMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_TXT_OBSERVACOES, critBean.getTxtObservacoes());
        addToCriteria(Op.ILIKE, objCrit, IrnConsFactosJurBean.FLD_FLG_EXISTEM_FACTOS, critBean.getFlgExistemFactos());
        addToCriteria(Op.IN, objCrit, IrnConsFactosJurBean.FLD_FLG_EXISTEM_FACTOS, critBean.getFlgExistemFactosList());
        return objCrit;
    }

    /**
     * Adapts the {@link Criteria} object for table <tt>IRN_CONS_FACTOS_JUR</tt>, the object will be modified internally using to
     * use the given Ordering Info object.<br>
     * 
     * @param objCrit
     *            The object to which the ordering must be added, the object will be modified internally.
     * @param order
     *            The ordering info to be applied. If null or empty, default ordering will be used.
     * @return <tt>Criteria</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Criteria applyOrdering4IrnConsFactosJur(Criteria objCrit, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Add additional criteria to not fetch child beans
        if (order == null || order.isEmpty()) {
            order = new OrderInfo();
            order.placeEnd(IrnConsFactosJurBean.FLD_ID_MSG_CONSULTA, OrderInfo.DESC);
        }

        objCrit = applyOrdering(objCrit, order);
        return objCrit;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> based on the
     * foreign key <tt>FK_IRN_CONS_FACTOS_JUR_01</tt> to table <tt>ENTIDADE</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.xfkCapitania -> parent.idEntidade</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>EntidadeBean</tt>.
     * @return <tt>ServiceReturn<Collection<IrnConsFactosJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnConsFactosJurBean>> findListIrnConsFactosJur_Capitania(boolean includeChildren,
                                                                                              EntidadeBean parentBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnConsFactosJur_Capitania(includeChildren, parentBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnConsFactosJurBean} from table <tt>IRN_CONS_FACTOS_JUR</tt> based on the
     * foreign key <tt>FK_IRN_CONS_FACTOS_JUR_01</tt> to table <tt>ENTIDADE</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.xfkCapitania -> parent.idEntidade</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>EntidadeBean</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnConsFactosJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnConsFactosJurBean>> findListIrnConsFactosJur_Capitania(boolean includeChildren,
                                                                                              EntidadeBean parentBean,
                                                                                              int startRec, int maxRecs,
                                                                                              OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnConsFactosJurBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(IrnConsFactosJurBean.class, dc);
            Criteria crit = myDao.createCriteria();
            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            addToCriteria(Op.EQ, junct, "xfkCapitania", parentBean.getIdEntidade());

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren);
            crit = applyOrdering4IrnConsFactosJur(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : startRec;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach child lists, inclusion of the child lists depends of includeChildren)
            detachDataBeanListValues(ret, !includeChildren, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnConsFactosJurBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> insertIrnConsFactosJur(IrnConsFactosJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertIrnConsFactosJur(dataBean, true);
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insert.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> insertIrnConsFactosJur(IrnConsFactosJurBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnConsFactosJur(OperationMode.CREATE, dataBean);

        IrnConsFactosJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnConsFactosJurBean.class, dc);
            myDao.insert(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.CREATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnConsFactosJurBean>(ret, null, null);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> updateIrnConsFactosJur(IrnConsFactosJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return updateIrnConsFactosJur(dataBean, true);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the update.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> updateIrnConsFactosJur(IrnConsFactosJurBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnConsFactosJur(OperationMode.UPDATE, dataBean);

        IrnConsFactosJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnConsFactosJurBean.class, dc);
            myDao.update(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnConsFactosJurBean>(ret, null, null);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> insertOrUpdateIrnConsFactosJur(IrnConsFactosJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertOrUpdateIrnConsFactosJur(dataBean, true);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, on the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insertOrUpdate.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> insertOrUpdateIrnConsFactosJur(IrnConsFactosJurBean dataBean,
                                                                              boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnConsFactosJur(OperationMode.UPDATE, dataBean);

        IrnConsFactosJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnConsFactosJurBean.class, dc);
            myDao.insertOrUpdate(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnConsFactosJurBean>(ret, null, null);
    }

    /**
     * <u>Deletes</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants, from the table
     * <tt>IRN_CONS_FACTOS_JUR</tt>.<br>
     * <br>
     * Obviously this method's result will not contain any child beans.<br>
     * 
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJurBean</tt> to be removed from database.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> deleteIrnConsFactosJur(IrnConsFactosJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnConsFactosJur(OperationMode.DELETE, dataBean);

        IrnConsFactosJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            HibernateDAO<IrnConsFactosJurBean> myDao = HibernateDAO.instance(IrnConsFactosJurBean.class, dc);
            myDao.delete(dataBean);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.DELETE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        return new ServiceReturn<IrnConsFactosJurBean>(ret, null, null);
    }

    /**
     * <u>Creates</u> a bean of type {@link IrnConsFactosJurBean}, returning the new data.<br>
     * If some defaults are to be assumed, an override method must be created on the subclass.<br>
     * 
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> createIrnConsFactosJur()
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnConsFactosJurBean ret = new IrnConsFactosJurBean().fillWithDefaults();

        return new ServiceReturn<IrnConsFactosJurBean>(ret, null, null);
    }

    /**
     * <u>Validates</u> a bean of type {@link IrnConsFactosJurBean}, and all its descendants.<br>
     * Returns the given data, updated during the performed validations.<br>
     * 
     * @param mode
     *            The operation mode for which the data must validated.
     * @param dataBean
     *            an instance of <tt>IrnConsFactosJur</tt> validated.
     * @return <tt>ServiceReturn<IrnConsFactosJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnConsFactosJurBean> validateIrnConsFactosJur(OperationMode mode, IrnConsFactosJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        AgregateBusinessException agrex = new AgregateBusinessException();

        // Validate the data structure by using the recursive mechanism
        List<BusinessException> lstBex = new ArrayList<BusinessException>();
        obtainValidationTW().validateTree(mode, dataBean, lstBex);
        agrex.addExceptions(lstBex);
        if (agrex != null && !agrex.isEmpty()) {
            throw agrex;
        }

        return new ServiceReturn<IrnConsFactosJurBean>(dataBean, null, null);
    }

    // ---------------------------------------------------------------------
    // Standard service methods for table 'IRN_FACTO_JUR'
    // ---------------------------------------------------------------------

    /**
     * Obtain a <u>single bean</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> using, as criteria, the field
     * properties <tt>[idFacto]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * This method's result will always contain all the child beans, regardless of the contents of the list of included child
     * beans specified on the <tt>keyBean</tt>.<br>
     * 
     * @param keyBean
     *            an instance of <tt>IrnFactoJurBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> findSingleIrnFactoJur_PK(IrnFactoJurBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnFactoJurBean ret = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(IrnFactoJurBean.class, dc);
            ret = myDao.retrieveSingleByPK(keyBean.getIdFacto());

            // Detach lists, including all children, propagate that all children are included
            detachDataBeanListValues(ret, false, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurBean>(ret, (ret == null ? 0l : 1l), null);
    }

    /**
     * Obtain a <u>single bean</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> using, as criteria, the field
     * properties <tt>[idFacto]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param keyBean
     *            an instance of <tt>IrnFactoJurBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> findSingleIrnFactoJur_PK(boolean includeChildren, IrnFactoJurBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        ServiceReturn<IrnFactoJurBean> ret = null;

        if (includeChildren) {
            // search using default method by primary key (includes all children)
            ret = findSingleIrnFactoJur_PK(keyBean);
        }
        else if (keyBean != null && keyBean.getIdFacto() != null) {
            // search using list method to avoid unwanted children
            IrnFactoJurCrit critBean = new IrnFactoJurCrit();
            critBean.setIdFacto(keyBean.getIdFacto());
            BeanDetailSpec newDetSpec = BeanDetailSpec.includeChildrenNone().importExclusions4Parents(keyBean.getDetailSpec());
            critBean.setDetailSpec(newDetSpec);
            ServiceReturn<Collection<IrnFactoJurBean>> lstRet = findListIrnFactoJur_Crit(false, critBean);

            Collection<IrnFactoJurBean> lstVal = lstRet.getValue();
            ret = new ServiceReturn<IrnFactoJurBean>(lstRet.getMessage());
            if (lstVal != null && !lstVal.isEmpty()) {
                // returns the first record found, if any
                ret.setValue(lstVal.iterator().next());
            }
        }

        return ret;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> using, as criteria, the
     * criteria properties
     * <tt>[idFacto, fkMsgConsulta, fkMsgConsultaList, fkMsgAtualiza, fkMsgAtualizaList, codIdFactoOrig, codTpFacto, codTpFactoList, datRegisto, datRegistoMinv, datRegistoMaxv, codEstado, datEstado, datEstadoMinv, datEstadoMaxv, nomConservatoria, txtDescricao]</tt>.<br>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnFactoJurCrit</tt>.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_Crit(boolean includeChildren, IrnFactoJurCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnFactoJur_Crit(includeChildren, critBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> using, as criteria, the
     * criteria properties
     * <tt>[idFacto, fkMsgConsulta, fkMsgConsultaList, fkMsgAtualiza, fkMsgAtualizaList, codIdFactoOrig, codTpFacto, codTpFactoList, datRegisto, datRegistoMinv, datRegistoMaxv, codEstado, datEstado, datEstadoMinv, datEstadoMaxv, nomConservatoria, txtDescricao]</tt>.<br>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnFactoJurCrit</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_Crit(boolean includeChildren, IrnFactoJurCrit critBean,
                                                                               int startRec, int maxRecs, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnFactoJurBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(IrnFactoJurBean.class, dc);
            Criteria crit = myDao.createCriteria();

            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            junct = buildCriteria4IrnFactoJur(junct, critBean);

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren, critBean.getDetailSpec());
            crit = applyOrdering4IrnFactoJur(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : maxRecs;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, !includeChildren, critBean.getDetailSpec());
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnFactoJurBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Builds search restrictions into the given {@link Criteria} object for table <tt>IRN_FACTO_JUR</tt> using, as criteria, the
     * criteria properties
     * <tt>[idFacto, fkMsgConsulta, fkMsgConsultaList, fkMsgAtualiza, fkMsgAtualizaList, codIdFactoOrig, codTpFacto, codTpFactoList, datRegisto, datRegistoMinv, datRegistoMaxv, codEstado, datEstado, datEstadoMinv, datEstadoMaxv, nomConservatoria, txtDescricao]</tt>.<br>
     * <br>
     * This method returns an instance of Junction, that may, or not, be the received one.<br>
     * 
     * @param objCrit
     *            The Junction to which the restrictions must be added, the object will be modified internally.
     * @param critBean
     *            an instance of <tt>IrnFactoJurCrit</tt>.
     * @return <tt>Junction</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Junction buildCriteria4IrnFactoJur(Junction objCrit, IrnFactoJurCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        addToCriteria(Op.EQ, objCrit, IrnFactoJurBean.FLD_ID_FACTO, critBean.getIdFacto());
        addToCriteria(Op.EQ, objCrit, IrnFactoJurBean.FLD_FK_MSG_CONSULTA, critBean.getFkMsgConsulta());
        addToCriteria(Op.IN, objCrit, IrnFactoJurBean.FLD_FK_MSG_CONSULTA, critBean.getFkMsgConsultaList());
        addToCriteria(Op.EQ, objCrit, IrnFactoJurBean.FLD_FK_MSG_ATUALIZA, critBean.getFkMsgAtualiza());
        addToCriteria(Op.IN, objCrit, IrnFactoJurBean.FLD_FK_MSG_ATUALIZA, critBean.getFkMsgAtualizaList());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurBean.FLD_COD_ID_FACTO_ORIG, critBean.getCodIdFactoOrig());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurBean.FLD_COD_TP_FACTO, critBean.getCodTpFacto());
        addToCriteria(Op.IN, objCrit, IrnFactoJurBean.FLD_COD_TP_FACTO, critBean.getCodTpFactoList());
        addToCriteria(Op.EQ, objCrit, IrnFactoJurBean.FLD_DAT_REGISTO, critBean.getDatRegisto());
        addRangeToCriteria(objCrit, IrnFactoJurBean.FLD_DAT_REGISTO, false, critBean.getDatRegistoMinv(),
                critBean.getDatRegistoMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurBean.FLD_COD_ESTADO, critBean.getCodEstado());
        addToCriteria(Op.EQ, objCrit, IrnFactoJurBean.FLD_DAT_ESTADO, critBean.getDatEstado());
        addRangeToCriteria(objCrit, IrnFactoJurBean.FLD_DAT_ESTADO, false, critBean.getDatEstadoMinv(),
                critBean.getDatEstadoMaxv());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurBean.FLD_NOM_CONSERVATORIA, critBean.getNomConservatoria());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurBean.FLD_TXT_DESCRICAO, critBean.getTxtDescricao());
        return objCrit;
    }

    /**
     * Adapts the {@link Criteria} object for table <tt>IRN_FACTO_JUR</tt>, the object will be modified internally using to use
     * the given Ordering Info object.<br>
     * 
     * @param objCrit
     *            The object to which the ordering must be added, the object will be modified internally.
     * @param order
     *            The ordering info to be applied. If null or empty, default ordering will be used.
     * @return <tt>Criteria</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Criteria applyOrdering4IrnFactoJur(Criteria objCrit, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Add additional criteria to not fetch child beans
        if (order == null || order.isEmpty()) {
            order = new OrderInfo();
            order.placeEnd(IrnFactoJurBean.FLD_ID_FACTO, OrderInfo.DESC);
        }

        objCrit = applyOrdering(objCrit, order);
        return objCrit;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> based on the foreign key
     * <tt>FK_IRN_FACTO_JUR_01</tt> to table <tt>IRN_CONS_FACTOS_JUR</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkMsgConsulta -> parent.idMsgConsulta</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnConsFactosJurBean</tt>.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_IrnConsFactosJur(boolean includeChildren,
                                                                                           IrnConsFactosJurBean parentBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnFactoJur_IrnConsFactosJur(includeChildren, parentBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> based on the foreign key
     * <tt>FK_IRN_FACTO_JUR_01</tt> to table <tt>IRN_CONS_FACTOS_JUR</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkMsgConsulta -> parent.idMsgConsulta</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnConsFactosJurBean</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_IrnConsFactosJur(boolean includeChildren,
                                                                                           IrnConsFactosJurBean parentBean,
                                                                                           int startRec, int maxRecs,
                                                                                           OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnFactoJurBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(IrnFactoJurBean.class, dc);
            Criteria crit = myDao.createCriteria();
            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            addToCriteria(Op.EQ, junct, "fkMsgConsulta", parentBean.getIdMsgConsulta());

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren);
            crit = applyOrdering4IrnFactoJur(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : startRec;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach child lists, inclusion of the child lists depends of includeChildren)
            detachDataBeanListValues(ret, !includeChildren, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnFactoJurBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> based on the foreign key
     * <tt>FK_IRN_FACTO_JUR_02</tt> to table <tt>IRN_ATUALIZA_SNEM</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkMsgAtualiza -> parent.idMsgAtualiza</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnAtualizaSnemBean</tt>.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_IrnAtualizaSnem(boolean includeChildren,
                                                                                          IrnAtualizaSnemBean parentBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnFactoJur_IrnAtualizaSnem(includeChildren, parentBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurBean} from table <tt>IRN_FACTO_JUR</tt> based on the foreign key
     * <tt>FK_IRN_FACTO_JUR_02</tt> to table <tt>IRN_ATUALIZA_SNEM</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkMsgAtualiza -> parent.idMsgAtualiza</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnAtualizaSnemBean</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurBean>> findListIrnFactoJur_IrnAtualizaSnem(boolean includeChildren,
                                                                                          IrnAtualizaSnemBean parentBean,
                                                                                          int startRec, int maxRecs,
                                                                                          OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnFactoJurBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(IrnFactoJurBean.class, dc);
            Criteria crit = myDao.createCriteria();
            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            addToCriteria(Op.EQ, junct, "fkMsgAtualiza", parentBean.getIdMsgAtualiza());

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren);
            crit = applyOrdering4IrnFactoJur(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : startRec;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach child lists, inclusion of the child lists depends of includeChildren)
            detachDataBeanListValues(ret, !includeChildren, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnFactoJurBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> insertIrnFactoJur(IrnFactoJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertIrnFactoJur(dataBean, true);
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insert.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> insertIrnFactoJur(IrnFactoJurBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJur(OperationMode.CREATE, dataBean);

        IrnFactoJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurBean.class, dc);
            myDao.insert(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.CREATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurBean>(ret, null, null);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> updateIrnFactoJur(IrnFactoJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return updateIrnFactoJur(dataBean, true);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the update.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> updateIrnFactoJur(IrnFactoJurBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJur(OperationMode.UPDATE, dataBean);

        IrnFactoJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurBean.class, dc);
            myDao.update(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurBean>(ret, null, null);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> insertOrUpdateIrnFactoJur(IrnFactoJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertOrUpdateIrnFactoJur(dataBean, true);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insertOrUpdate.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> insertOrUpdateIrnFactoJur(IrnFactoJurBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJur(OperationMode.UPDATE, dataBean);

        IrnFactoJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurBean.class, dc);
            myDao.insertOrUpdate(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurBean>(ret, null, null);
    }

    /**
     * <u>Deletes</u> a bean of type {@link IrnFactoJurBean}, and all its descendants, from the table <tt>IRN_FACTO_JUR</tt>.<br>
     * <br>
     * Obviously this method's result will not contain any child beans.<br>
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurBean</tt> to be removed from database.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> deleteIrnFactoJur(IrnFactoJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJur(OperationMode.DELETE, dataBean);

        IrnFactoJurBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            HibernateDAO<IrnFactoJurBean> myDao = HibernateDAO.instance(IrnFactoJurBean.class, dc);
            myDao.delete(dataBean);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.DELETE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        return new ServiceReturn<IrnFactoJurBean>(ret, null, null);
    }

    /**
     * <u>Creates</u> a bean of type {@link IrnFactoJurBean}, returning the new data.<br>
     * If some defaults are to be assumed, an override method must be created on the subclass.<br>
     * 
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> createIrnFactoJur()
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnFactoJurBean ret = new IrnFactoJurBean().fillWithDefaults();

        return new ServiceReturn<IrnFactoJurBean>(ret, null, null);
    }

    /**
     * <u>Validates</u> a bean of type {@link IrnFactoJurBean}, and all its descendants.<br>
     * Returns the given data, updated during the performed validations.<br>
     * 
     * @param mode
     *            The operation mode for which the data must validated.
     * @param dataBean
     *            an instance of <tt>IrnFactoJur</tt> validated.
     * @return <tt>ServiceReturn<IrnFactoJurBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurBean> validateIrnFactoJur(OperationMode mode, IrnFactoJurBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        AgregateBusinessException agrex = new AgregateBusinessException();

        // Validate the data structure by using the recursive mechanism
        List<BusinessException> lstBex = new ArrayList<BusinessException>();
        obtainValidationTW().validateTree(mode, dataBean, lstBex);
        agrex.addExceptions(lstBex);
        if (agrex != null && !agrex.isEmpty()) {
            throw agrex;
        }

        return new ServiceReturn<IrnFactoJurBean>(dataBean, null, null);
    }

    // ---------------------------------------------------------------------
    // Standard service methods for table 'IRN_FACTO_JUR_INTER'
    // ---------------------------------------------------------------------

    /**
     * Obtain a <u>single bean</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> using, as
     * criteria, the field properties <tt>[idInterveniente]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * This method's result will always contain all the child beans, regardless of the contents of the list of included child
     * beans specified on the <tt>keyBean</tt>.<br>
     * 
     * @param keyBean
     *            an instance of <tt>IrnFactoJurInterBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> findSingleIrnFactoJurInter_PK(IrnFactoJurInterBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnFactoJurInterBean ret = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(IrnFactoJurInterBean.class, dc);
            ret = myDao.retrieveSingleByPK(keyBean.getIdInterveniente());

            // Detach lists, including all children, propagate that all children are included
            detachDataBeanListValues(ret, false, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurInterBean>(ret, (ret == null ? 0l : 1l), null);
    }

    /**
     * Obtain a <u>single bean</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> using, as
     * criteria, the field properties <tt>[idInterveniente]</tt>.<br>
     * If not found, returns <tt>null</tt>.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param keyBean
     *            an instance of <tt>IrnFactoJurInterBean</tt> with all the key fields set.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> findSingleIrnFactoJurInter_PK(boolean includeChildren,
                                                                             IrnFactoJurInterBean keyBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        ServiceReturn<IrnFactoJurInterBean> ret = null;

        if (includeChildren) {
            // search using default method by primary key (includes all children)
            ret = findSingleIrnFactoJurInter_PK(keyBean);
        }
        else if (keyBean != null && keyBean.getIdInterveniente() != null) {
            // search using list method to avoid unwanted children
            IrnFactoJurInterCrit critBean = new IrnFactoJurInterCrit();
            critBean.setIdInterveniente(keyBean.getIdInterveniente());
            BeanDetailSpec newDetSpec = BeanDetailSpec.includeChildrenNone().importExclusions4Parents(keyBean.getDetailSpec());
            critBean.setDetailSpec(newDetSpec);
            ServiceReturn<Collection<IrnFactoJurInterBean>> lstRet = findListIrnFactoJurInter_Crit(false, critBean);

            Collection<IrnFactoJurInterBean> lstVal = lstRet.getValue();
            ret = new ServiceReturn<IrnFactoJurInterBean>(lstRet.getMessage());
            if (lstVal != null && !lstVal.isEmpty()) {
                // returns the first record found, if any
                ret.setValue(lstVal.iterator().next());
            }
        }

        return ret;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> using, as
     * criteria, the criteria properties
     * <tt>[idInterveniente, fkFacto, fkFactoList, codTpInterveniente, codTpIntervenienteList, codTpPessoa, nomInterveniente, codOrigemNif, codOrigemNifList, numNif, codTpDocIdent, codTpDocIdentList, numDocIdent, txtEmail, numTelefone, txtMorada]</tt>.<br>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnFactoJurInterCrit</tt>.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurInterBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurInterBean>> findListIrnFactoJurInter_Crit(boolean includeChildren,
                                                                                         IrnFactoJurInterCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnFactoJurInter_Crit(includeChildren, critBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> using, as
     * criteria, the criteria properties
     * <tt>[idInterveniente, fkFacto, fkFactoList, codTpInterveniente, codTpIntervenienteList, codTpPessoa, nomInterveniente, codOrigemNif, codOrigemNifList, numNif, codTpDocIdent, codTpDocIdentList, numDocIdent, txtEmail, numTelefone, txtMorada]</tt>.<br>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will contain the child beans according to the
     * list of included child beans specified on the <tt>keyBean</tt>. When set to <tt>false</tt>, no child beans will be
     * returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param critBean
     *            an instance of <tt>IrnFactoJurInterCrit</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurInterBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurInterBean>> findListIrnFactoJurInter_Crit(boolean includeChildren,
                                                                                         IrnFactoJurInterCrit critBean,
                                                                                         int startRec, int maxRecs,
                                                                                         OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnFactoJurInterBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(IrnFactoJurInterBean.class, dc);
            Criteria crit = myDao.createCriteria();

            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            junct = buildCriteria4IrnFactoJurInter(junct, critBean);

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren, critBean.getDetailSpec());
            crit = applyOrdering4IrnFactoJurInter(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : maxRecs;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, !includeChildren, critBean.getDetailSpec());
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnFactoJurInterBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * Builds search restrictions into the given {@link Criteria} object for table <tt>IRN_FACTO_JUR_INTER</tt> using, as
     * criteria, the criteria properties
     * <tt>[idInterveniente, fkFacto, fkFactoList, codTpInterveniente, codTpIntervenienteList, codTpPessoa, nomInterveniente, codOrigemNif, codOrigemNifList, numNif, codTpDocIdent, codTpDocIdentList, numDocIdent, txtEmail, numTelefone, txtMorada]</tt>.<br>
     * <br>
     * This method returns an instance of Junction, that may, or not, be the received one.<br>
     * 
     * @param objCrit
     *            The Junction to which the restrictions must be added, the object will be modified internally.
     * @param critBean
     *            an instance of <tt>IrnFactoJurInterCrit</tt>.
     * @return <tt>Junction</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Junction buildCriteria4IrnFactoJurInter(Junction objCrit, IrnFactoJurInterCrit critBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        addToCriteria(Op.EQ, objCrit, IrnFactoJurInterBean.FLD_ID_INTERVENIENTE, critBean.getIdInterveniente());
        addToCriteria(Op.EQ, objCrit, IrnFactoJurInterBean.FLD_FK_FACTO, critBean.getFkFacto());
        addToCriteria(Op.IN, objCrit, IrnFactoJurInterBean.FLD_FK_FACTO, critBean.getFkFactoList());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_COD_TP_INTERVENIENTE, critBean.getCodTpInterveniente());
        addToCriteria(Op.IN, objCrit, IrnFactoJurInterBean.FLD_COD_TP_INTERVENIENTE, critBean.getCodTpIntervenienteList());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_COD_TP_PESSOA, critBean.getCodTpPessoa());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_NOM_INTERVENIENTE, critBean.getNomInterveniente());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_COD_ORIGEM_NIF, critBean.getCodOrigemNif());
        addToCriteria(Op.IN, objCrit, IrnFactoJurInterBean.FLD_COD_ORIGEM_NIF, critBean.getCodOrigemNifList());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_NUM_NIF, critBean.getNumNif());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_COD_TP_DOC_IDENT, critBean.getCodTpDocIdent());
        addToCriteria(Op.IN, objCrit, IrnFactoJurInterBean.FLD_COD_TP_DOC_IDENT, critBean.getCodTpDocIdentList());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_NUM_DOC_IDENT, critBean.getNumDocIdent());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_TXT_EMAIL, critBean.getTxtEmail());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_NUM_TELEFONE, critBean.getNumTelefone());
        addToCriteria(Op.ILIKE, objCrit, IrnFactoJurInterBean.FLD_TXT_MORADA, critBean.getTxtMorada());
        return objCrit;
    }

    /**
     * Adapts the {@link Criteria} object for table <tt>IRN_FACTO_JUR_INTER</tt>, the object will be modified internally using to
     * use the given Ordering Info object.<br>
     * 
     * @param objCrit
     *            The object to which the ordering must be added, the object will be modified internally.
     * @param order
     *            The ordering info to be applied. If null or empty, default ordering will be used.
     * @return <tt>Criteria</tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    protected Criteria applyOrdering4IrnFactoJurInter(Criteria objCrit, OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Add additional criteria to not fetch child beans
        if (order == null || order.isEmpty()) {
            order = new OrderInfo();
            order.placeEnd(IrnFactoJurInterBean.FLD_ID_INTERVENIENTE, OrderInfo.DESC);
        }

        objCrit = applyOrdering(objCrit, order);
        return objCrit;
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> based on the
     * foreign key <tt>FK_IRN_FACTO_JUR_INTER_01</tt> to table <tt>IRN_FACTO_JUR</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkFacto -> parent.idFacto</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnFactoJurBean</tt>.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurInterBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurInterBean>> findListIrnFactoJurInter_IrnFactoJur(boolean includeChildren,
                                                                                                IrnFactoJurBean parentBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return findListIrnFactoJurInter_IrnFactoJur(includeChildren, parentBean, 1, -1, null);
    }

    /**
     * Obtain a <u>list of beans</u> of type {@link IrnFactoJurInterBean} from table <tt>IRN_FACTO_JUR_INTER</tt> based on the
     * foreign key <tt>FK_IRN_FACTO_JUR_INTER_01</tt> to table <tt>IRN_FACTO_JUR</tt>.<br>
     * Criteria fields are:
     * <ol>
     * <li><tt>child.fkFacto -> parent.idFacto</tt></li>
     * </ol>
     * If not found, returns an empty list.<br>
     * This method allows obtaining partial records sets for pagination as well as ordering info.<br>
     * <br>
     * When <tt>includeChildren</tt> is set to <tt>true</tt>, this method's result will always contain all the child beans,
     * regardless of he contents of the list of included child beans specified on the <tt>parent</tt>. When set to <tt>false</tt>,
     * no child beans will be returned.<br>
     * 
     * @param includeChildren
     *            This flag specifies if children beans should be included.
     * @param parentBean
     *            an instance of <tt>IrnFactoJurBean</tt>.
     * @param startRec
     *            The position of the first record, starting from 1.
     * @param maxRecs
     *            The maximum number of records to be obtained.
     * @param order
     *            The ordering criteria, if null or empty a default shall be assumed.
     * @return <tt>ServiceReturn<Collection<IrnFactoJurInterBean>></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<Collection<IrnFactoJurInterBean>> findListIrnFactoJurInter_IrnFactoJur(boolean includeChildren,
                                                                                                IrnFactoJurBean parentBean,
                                                                                                int startRec, int maxRecs,
                                                                                                OrderInfo order)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Collection<IrnFactoJurInterBean> ret = null;
        Long totalRowcount = null;

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(IrnFactoJurInterBean.class, dc);
            Criteria crit = myDao.createCriteria();
            // Criteria is based on AND
            Junction junct = obtainJunction(Conjunction.class, crit);
            addToCriteria(Op.EQ, junct, "fkFacto", parentBean.getIdFacto());

            totalRowcount = myDao.countByCriteria(crit);

            crit = myDao.defineListColumns(crit, !includeChildren);
            crit = applyOrdering4IrnFactoJurInter(crit, order);

            startRec = (startRec < 1) ? 1 : startRec;
            // hibernate record positions start at 0
            crit.setFirstResult(startRec - 1);
            maxRecs = (maxRecs < 1) ? DEFAULT_QUERY_RECORDS : startRec;
            crit.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(crit);

            // Detach child lists, inclusion of the child lists depends of includeChildren)
            detachDataBeanListValues(ret, !includeChildren, null);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, null);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        translateData(dc.getLocale(), ret);

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<IrnFactoJurInterBean>>(ret, totalRowcount, checkRecordCount(totalRowcount, ret));
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> insertIrnFactoJurInter(IrnFactoJurInterBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertIrnFactoJurInter(dataBean, true);
    }

    /**
     * <u>Inserts</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insert.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> insertIrnFactoJurInter(IrnFactoJurInterBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJurInter(OperationMode.CREATE, dataBean);

        IrnFactoJurInterBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurInterBean.class, dc);
            myDao.insert(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.CREATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurInterBean>(ret, null, null);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> updateIrnFactoJurInter(IrnFactoJurInterBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return updateIrnFactoJurInter(dataBean, true);
    }

    /**
     * <u>Updates</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the update.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> updateIrnFactoJurInter(IrnFactoJurInterBean dataBean, boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJurInter(OperationMode.UPDATE, dataBean);

        IrnFactoJurInterBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurInterBean.class, dc);
            myDao.update(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurInterBean>(ret, null, null);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> insertOrUpdateIrnFactoJurInter(IrnFactoJurInterBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return insertOrUpdateIrnFactoJurInter(dataBean, true);
    }

    /**
     * <u>Inserts or Updates</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, on the table
     * <tt>IRN_FACTO_JUR_INTER</tt>. <br>
     * Returns the given data, updated according to the performed operation.<br>
     * <br>
     * This method's result will contain all received child beans, according to the list of included child beans specified on the
     * <tt>dataBean</tt>.
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> to be stored on the database.
     * @param refreshAfterUpdate
     *            flag to determine if the dataBean shall be refreshed after the insertOrUpdate.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> insertOrUpdateIrnFactoJurInter(IrnFactoJurInterBean dataBean,
                                                                              boolean refreshAfterUpdate)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJurInter(OperationMode.UPDATE, dataBean);

        IrnFactoJurInterBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            BeanDetailSpec beanDetailSpec = dataBean.getDetailSpec();
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(refreshAfterUpdate, IrnFactoJurInterBean.class, dc);
            myDao.insertOrUpdate(dataBean);
            ret = dataBean;

            // flush anything that may need to be... better safe than sorry :-)
            myDao.getSession().flush();
            // we dont want anything more to be flushed
            myDao.getSession().setFlushMode(FlushMode.MANUAL);

            // Detach lists, remove unwanted lists, propagate the children inclusion information
            detachDataBeanListValues(ret, false, beanDetailSpec);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.UPDATE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<IrnFactoJurInterBean>(ret, null, null);
    }

    /**
     * <u>Deletes</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants, from the table
     * <tt>IRN_FACTO_JUR_INTER</tt>.<br>
     * <br>
     * Obviously this method's result will not contain any child beans.<br>
     * 
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInterBean</tt> to be removed from database.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> deleteIrnFactoJurInter(IrnFactoJurInterBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        // Validate before performing the operation.
        // If the validation find errors, a BusinessException will be thrown
        validateIrnFactoJurInter(OperationMode.DELETE, dataBean);

        IrnFactoJurInterBean ret = null;

        DataContext dc = super.theContext();
        Transaction transaction = null;
        boolean success = false;
        try {
            transaction = beginTransaction(dc);

            // -- Transaction Implementation Code --------------------
            HibernateDAO<IrnFactoJurInterBean> myDao = HibernateDAO.instance(IrnFactoJurInterBean.class, dc);
            myDao.delete(dataBean);
            // -------------------------------------------------------

            success = true;
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.DELETE);
        }
        finally {
            finalizeTransaction(dc, transaction, success);
        }

        return new ServiceReturn<IrnFactoJurInterBean>(ret, null, null);
    }

    /**
     * <u>Creates</u> a bean of type {@link IrnFactoJurInterBean}, returning the new data.<br>
     * If some defaults are to be assumed, an override method must be created on the subclass.<br>
     * 
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> createIrnFactoJurInter()
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        IrnFactoJurInterBean ret = new IrnFactoJurInterBean().fillWithDefaults();

        return new ServiceReturn<IrnFactoJurInterBean>(ret, null, null);
    }

    /**
     * <u>Validates</u> a bean of type {@link IrnFactoJurInterBean}, and all its descendants.<br>
     * Returns the given data, updated during the performed validations.<br>
     * 
     * @param mode
     *            The operation mode for which the data must validated.
     * @param dataBean
     *            an instance of <tt>IrnFactoJurInter</tt> validated.
     * @return <tt>ServiceReturn<IrnFactoJurInterBean></tt>
     * @throws IllegalArgumentException
     * @throws BusinessException
     * @throws ServiceException
     * @throws ServiceRuntimeException
     */
    public ServiceReturn<IrnFactoJurInterBean> validateIrnFactoJurInter(OperationMode mode, IrnFactoJurInterBean dataBean)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        AgregateBusinessException agrex = new AgregateBusinessException();

        // Validate the data structure by using the recursive mechanism
        List<BusinessException> lstBex = new ArrayList<BusinessException>();
        obtainValidationTW().validateTree(mode, dataBean, lstBex);
        agrex.addExceptions(lstBex);
        if (agrex != null && !agrex.isEmpty()) {
            throw agrex;
        }

        return new ServiceReturn<IrnFactoJurInterBean>(dataBean, null, null);
    }

    /**
     * <u>Creates</u> an instance of {@link ValidationTreewalker}, to be used for performing validations.<br>
     * 
     * @return <tt>local.bai.basis.validation.ValidationTreewalker</tt>
     */
    protected ValidationTreewalker obtainValidationTW() {

        return new ValidationTreewalker(theContext(), BeanValidatorRegistrar.getRegistry());
    }

} // end class
