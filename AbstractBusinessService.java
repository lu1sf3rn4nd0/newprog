package local.bai.servhibern;

import static local.bai.basis.utils.Assertions.assertParameter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.PropertyUtilsBean;
import org.hibernate.Criteria;
import org.hibernate.Transaction;
import org.hibernate.criterion.Junction;

import local.bai.basis.CodedMsg;
import local.bai.basis.OperationMode;
import local.bai.basis.context.PortableContext;
import local.bai.basis.databeans.AbstractBean;
import local.bai.basis.databeans.AbstractDataBean;
import local.bai.basis.databeans.BeanDetailSpec;
import local.bai.basis.databeans.DataBeanUtils;
import local.bai.basis.exceptions.BusinessException;
import local.bai.basis.exceptions.ServiceException;
import local.bai.basis.exceptions.ServiceRuntimeException;
import local.bai.basis.logging.LogWrapper;
import local.bai.basis.services.OrderInfo;
import local.bai.basis.services.ServiceReturn;
import local.bai.basis.translate.DataBeanTranslator;
import local.bai.basis.translate.DataBeanTranslatorFactory;
import local.bai.servhibern.context.DataContext;
import local.bai.servhibern.context.NestableTransaction;
import local.bai.servhibern.dataaccess.HibernateDAO;
import local.bai.servhibern.dataaccess.HibernateDAO.CritOperator;

/**
 * Abstract class for Business Services.<br>
 * Base class for data access services.
 * 
 * @author cardosojo
 */
public abstract class AbstractBusinessService {

    /**
     * Class: AbstractBusinessService<br>
     * Operators for building Criteria.<br>
     * 
     * @see HibernateDAO.CritOperator.
     */
    protected static interface Op {

        HibernateDAO.CritOperator NULL     = HibernateDAO.CritOperator.NULL;
        HibernateDAO.CritOperator NOT_NULL = HibernateDAO.CritOperator.NOT_NULL;
        HibernateDAO.CritOperator EQ       = HibernateDAO.CritOperator.EQ;
        HibernateDAO.CritOperator ILIKE    = HibernateDAO.CritOperator.ILIKE;
        HibernateDAO.CritOperator LE       = HibernateDAO.CritOperator.LE;
        HibernateDAO.CritOperator LT       = HibernateDAO.CritOperator.LT;
        HibernateDAO.CritOperator GE       = HibernateDAO.CritOperator.GE;
        HibernateDAO.CritOperator GT       = HibernateDAO.CritOperator.GT;
        HibernateDAO.CritOperator IN       = HibernateDAO.CritOperator.IN;
        HibernateDAO.CritOperator NOT_IN   = HibernateDAO.CritOperator.NOT_IN;

        static HibernateDAO.CritOperator[] or(HibernateDAO.CritOperator... crits) {

            return crits;
        }

    }

    /**
     * Maximum number of records that may be fetched in user queries (Search screens)
     */
    public static final int    MAX_USERQUERY_RECORDS = 2000;
    /**
     * Maximum number of records that may be fetched in flexible queries (LOVs)
     */
    public static final int    MAX_FLEXQUERY_RECORDS = 500;
    /**
     * Default number of records to be returned when no required number of records is specified
     */
    public static final int    DEFAULT_QUERY_RECORDS = 10000;

    protected final LogWrapper log                   = LogWrapper.getInstance(this.getClass(), 0);

    private final DataContext  context;
    // private final boolean flagRootTransaction;

    private DataBeanTranslator translator            = null;

    /**
     * Constructor for class AbstractBusinessService.<br>
     * <br>
     * Service instances created using this method will be running on a isolated transaction. However, all methods called for the a
     * single instance will be executed on the same transaction.<br>
     * To obtain an instance that will use the same DataContext (including session and transaction) from a master Business Service
     * class, use constructor {@link #AbstractBusinessService(DataContext, boolean)}, passing <code>true</code> to the second
     * parameter.<br>
     * 
     * @param callerContext
     *            A portable context, that shall be used for creating an internal data context object.
     */
    public AbstractBusinessService(PortableContext callerContext) {

        assertParameter("callerContext", callerContext);

        this.context = DataContext.create(callerContext);
        // this.flagRootTransaction = true;
    }

    /**
     * Constructor for class AbstractBusinessService.<br>
     * 
     * @param sharedDataContext
     *            The data context to be used inside the new instance.<br>
     * @param flagSameTransaction
     *            Specifies whether this new instance's calls will be performed inside the same connection and transaction,
     *            specified in the given data context.
     *            <ul>
     *            <li>If <code>true</code>, the given data context (including session and transaction) will be used.</li>
     *            <li>Otherwise, a new isolated, data context will be created. This is equivalent to constructor
     *            {@link #AbstractBusinessService(PortableContext)}.</li>
     *            </ul>
     */
    public AbstractBusinessService(DataContext sharedDataContext, boolean flagSameTransaction) {

        assertParameter("sharedDataContext", sharedDataContext);

        if (flagSameTransaction) {
            // shared transaction, use the same data context.
            this.context = DataContext.createNested(sharedDataContext);
            // this.flagRootTransaction = false;
        }
        else {
            // isolated transaction, create another data context
            this.context = DataContext.create(sharedDataContext.portable());
            // this.flagRootTransaction = true;
        }
    }

    /**
     * Overriden method.<br>
     * 
     * @see java.lang.Object#finalize()
     */
    @Override
    protected void finalize()
        throws Throwable {

        if (context != null) {
            context.close();
        }
        super.finalize();
    }

    /**
     * @return Returns the data context for this business service instance. This is equivalent to method This is a synonym to
     *         method @{link #getContext()}.
     */
    public final DataContext theContext() {

        return getContext();
    }

    /**
     * @return Returns the data context for this business service instance.<br>
     *         This is a synonym to method @{link #theContext()}, the naming of that method seems to be somewhat confusing.<br>
     */
    public final DataContext getContext() {

        return this.context;
    }

    /**
     * Build a List of Maps containing only the required properties from the given list of {@link AbstractDataBean}. Duplicated
     * property names are removed. <br>
     * 
     * @param lstBeans
     *            The list of beans
     * @param idPropnames
     *            A comma-separated list of property names, corresponding to id fields (don't have to be table key fields).
     * @param otherPropnames
     *            A comma-separated list of property names.
     * @return
     */
    protected Collection<Map<String, Object>> buildFlexList(Collection<? extends AbstractDataBean> lstBeans, String idPropnames,
            String otherPropnames) {

        Collection<Map<String, Object>> ret;
        if (lstBeans.isEmpty()) {
            ret = Collections.emptyList();
        }
        else {

            // using instances instead of static methods to improve performance
            PropertyUtilsBean pu = BeanUtilsBean.getInstance().getPropertyUtils();

            ret = new ArrayList<Map<String, Object>>(lstBeans.size());
            String[] arrIdProps = idPropnames.split(",");
            String[] arrOtherProps = otherPropnames.split(",");

            List<String> lstProps = new ArrayList<String>(arrIdProps.length + arrOtherProps.length);
            for (String prop : arrIdProps) {
                if (!lstProps.contains(prop)) {
                    lstProps.add(prop);
                }
            }
            for (String prop : arrOtherProps) {
                if (!lstProps.contains(prop)) {
                    lstProps.add(prop);
                }
            }

            for (AbstractBean bean : lstBeans) {
                Map<String, Object> newMap = new HashMap<String, Object>();

                for (String prop : lstProps) {
                    try {
                        newMap.put(prop, pu.getProperty(bean, prop));
                    }
                    catch (Exception e) {
                        // cannot access the property
                        continue;
                    }
                }
                try {
                    newMap.put("beanDescription", pu.getProperty(bean, "beanDescription"));
                }
                catch (Exception e) {
                    // cannot access the property
                    continue;
                }

                ret.add(newMap);
            }
        }
        return ret;
    }

    /**
     * Checks if the total records is more than the number of retrieved records. <br>
     * 
     * @param totalRecords
     * @param lstRecords
     *            Collection of records to be counted
     * @return Returns a {@link CodedMsg} or null if the check return false.
     */
    public static CodedMsg checkRecordCount(Long totalRecords, Collection<?> lstRecords) {

        return ServiceReturn.checkRecordCount(totalRecords, lstRecords);
    }

    /**
     * This method provides the logic necessary to load ExternalBeans that are referenced inside the data structure rooted in the
     * given bean.<br>
     * <b>Note: </b> this may be heavily dependent on business logic, and MUST be implemented by derived classes. Default
     * implementation.
     * 
     * @param theBean
     *            The bean to be processed.
     * @return The given bean, after performing the operations.
     * @throws ServiceException
     */
    protected abstract <B extends AbstractDataBean> B loadExternalBeanRefsImpl(B theBean)
        throws ServiceException;

    /**
     * This method processes each of the beans in the given array of Beans as described in
     * {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * <br>
     * Specific implementation of {@link AbstractBusinessService#loadExternalBeanRefsImpl(AbstractDataBean)} may allow defining
     * filtering of the classes that will be processed when loading External Beans. This method will apply that filetering.<br>
     * <br>
     * 
     * @param arrBeans
     *            The array of beans to be processed.
     * @return The given array of beans, after performing the operations.
     * @throws ServiceException
     */
    protected final <B extends AbstractDataBean> B loadExternalBeanRefs(B theBean)
        throws ServiceException {

        if (theBean == null) return null;

        loadExternalBeanRefsImpl(theBean);

        return theBean;
    }

    /**
     * This method processes each of the beans in the given array of Beans as described in
     * {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * <br>
     * Specific implementation of {@link AbstractBusinessService#loadExternalBeanRefsImpl(AbstractDataBean)} may allow defining
     * filtering of the classes that will be processed when loading External Beans. This method will apply that filetering.<br>
     * <br>
     * 
     * @param arrBeans
     *            The array of beans to be processed.
     * @return The given array of beans, after performing the operations.
     * @throws ServiceException
     */
    protected final <B extends AbstractDataBean> B[] loadExternalBeanRefs(B[] arrBeans)
        throws ServiceException {

        if (arrBeans == null) return null;

        for (B bean : arrBeans) {
            loadExternalBeanRefsImpl(bean);
        }

        return arrBeans;
    }

    /**
     * This method processes each of the beans in the given collection of Beans as described in
     * {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * <br>
     * Specific implementation of {@link AbstractBusinessService#loadExternalBeanRefsImpl(AbstractDataBean)} may allow defining
     * filtering of the classes that will be processed when loading External Beans. This method will apply that filetering.<br>
     * <br>
     * 
     * @param arrBeans
     *            The collection of beans to be processed.
     * @return The given collection of beans, after performing the operations.
     * @throws ServiceException
     */
    protected final <B extends AbstractDataBean> Collection<B> loadExternalBeanRefs(Collection<B> lstBeans)
        throws ServiceException {

        if (lstBeans == null) return null;

        for (B bean : lstBeans) {
            loadExternalBeanRefsImpl(bean);
        }

        return lstBeans;
    }

    /**
     * Shortcut method to {@link AbstractDataBean#detachListValues(AbstractDataBean, boolean, BeanDetailSpec)}<br>
     */
    public <B extends AbstractDataBean> B detachDataBeanListValues(B theBean, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        BeanDetailSpec myDetailSpec = BeanDetailSpec.rebuildBeanDetailSpec(beanDetailSpec, discardChildren);
        DataBeanUtils.detachChildLists(theBean, myDetailSpec);
        // TODO: DELETE - AbstractDataBean.detachListValues(theBean, discardChildren, beanDetailSpec);
        return theBean;
    }

    /**
     * Shortcut method to {@link AbstractDataBean#detachListValues(AbstractDataBean, boolean, Collection)}<br>
     * Assumes <code>discardChildren</code> as <code>null</code> <br>
     */
    /*- TODO: DELETE (not used)
    @Deprecated
    public <B extends AbstractDataBean> B detachDataBeanListValues(B theBean, boolean discardChildren) {
    
        long startMillis = System.currentTimeMillis();
        try {
            BeanDetailSpec myDetailSpec = BeanDetailSpec.rebuildBeanDetailSpec(beanDetailSpec, discardChildren);
            AbstractDataBean.detachChildLists(theBean, myDetailSpec);
    
            detachDataBeanListValues(theBean, discardChildren, null);
            return theBean;
        }
        finally {
            if (theBean != null) {
                logExecTime("detachListValues:Single", theBean.getClass(), startMillis, 1);
            }
        }
    }
    */

    /**
     * Shortcut method to {@link AbstractDataBean#detachListValues(Collection, boolean, BeanDetailSpec)} <br>
     */
    public <B extends AbstractDataBean> Collection<B> detachDataBeanListValues(Collection<B> lstBeans, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        BeanDetailSpec myDetailSpec = BeanDetailSpec.rebuildBeanDetailSpec(beanDetailSpec, discardChildren);
        DataBeanUtils.detachChildLists(lstBeans, myDetailSpec);
        // TODO: DELETE - AbstractDataBean.detachListValues(lstBeans, discardChildren, beanDetailSpec);
        return lstBeans;
    }

    /**
     * Shortcut method to {@link AbstractDataBean#detachListValues(AbstractDataBean[], boolean, BeanDetailSpec) <br>
     */
    public <B extends AbstractDataBean> B[] detachDataBeanListValues(B[] arrBeans, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        BeanDetailSpec myDetailSpec = BeanDetailSpec.rebuildBeanDetailSpec(beanDetailSpec, discardChildren);
        DataBeanUtils.detachChildLists(arrBeans, myDetailSpec);
        // TODO: DELETE - AbstractDataBean.detachListValues(arrBeans, discardChildren, beanDetailSpec);
        return arrBeans;
    }

    /**
     * Add a new condition the the given {@link Criteria} object.<br>
     * Shortcut method to {@link HibernateDAO#addToCriteria(CritOperator, Junction, String, Object)}
     */
    public final Junction addToCriteria(CritOperator operator, Junction junction, String critField, Object critVal) {

        return HibernateDAO.addToCriteria(operator, junction, critField, critVal);
    }

    /**
     * Add a new condition the the given {@link Criteria} object.<br>
     * Shortcut method to {@link HibernateDAO#addToCriteria(CritOperator[], Junction, String, Object)}
     */
    public final Junction addToCriteria(CritOperator[] arrOperators, Junction junction, String critField, Object critVal) {

        return HibernateDAO.addToCriteria(arrOperators, junction, critField, critVal);
    }

    /**
     * Add a new condition the the given {@link Criteria} object.<br>
     * Shortcut method to {@link HibernateDAO#addToCriteria(String, Junction, String, Object)}
     */
    public final Junction addToCriteria(String strOperator, Junction junction, String critField, Object critVal) {

        return HibernateDAO.addToCriteria(strOperator, junction, critField, critVal);
    }

    /**
     * Add new conditions the the given {@link Criteria} object, based on a range of values or dates.<br>
     * After applying range rules calls method {@link HibernateDAO#addToCriteria(String, Junction, String, Object)}
     *
     * @param junction
     *            an Hibernate junction
     * @param critField
     *            the field name (in java notation)
     * @param allowNulls
     *            if <code>true</code> the criteria is evaluated allowing null values on the field as acceptable.<br>
     *            This is needed to ensure that records with null end date are found when wanted (reference data, etc.).
     * @param critValMin
     *            the minimum value for the range
     * @param critValMax
     *            the maximum value for the range
     * @return The modified criteria for chained calls
     */
    public final Junction addRangeToCriteria(Junction junction, String critField, boolean allowNulls, Object critValMin,
            Object critValMax) {

        final CritOperator[] opGE, opLE;
        if (allowNulls) {
            addToCriteria(Op.or(Op.GE, Op.NULL), junction, critField, critValMin);
            addToCriteria(Op.or(Op.LE, Op.NULL), junction, critField, critValMax);
        }
        else {
            addToCriteria(Op.GE, junction, critField, critValMin);
            addToCriteria(Op.LE, junction, critField, critValMax);
        }

        return junction;
    }

    /**
     * Obtain a {@link Junction} from the given argument.<br>
     * Shortcut method to {@link HibernateDAO#obtainJunction(Class, Criteria).
     */
    public final Junction obtainJunction(Class<? extends Junction> classJunction, Criteria objCrit)
        throws IllegalArgumentException {

        return HibernateDAO.obtainJunction(classJunction, objCrit);
    }

    /**
     * Applies the ordering in the given {@link OrderInfo} argument into de given {@link Criteria}.<br>
     * Shortcut method to {@link HibernateDAO#applyOrdering(Criteria, OrderInfo).<br>
     */
    protected Criteria applyOrdering(Criteria crit, OrderInfo orderinfo) {

        return HibernateDAO.applyOrdering(crit, orderinfo);
    }

    /**
     * Analyze the given throwable, trying to determine if it corresponds to some Business Error. If that is the case return a
     * String containing the message to be reported to the user, otherwise throws an exception..<br>
     * 
     * @param th
     *            The exception to be analyzed.
     * @param mode
     *            The operation mode, this used to provide more accurate error messages
     * @return The error message, if it corresponds to a business error.
     * @throws RuntimeException
     */
    public void analyzeException(Throwable th, OperationMode mode)
        throws RuntimeException, ServiceException, BusinessException, ServiceRuntimeException {

        BusinessServiceErrorUtils.analyzeException(getContext(), th, mode);
    }

    /**
     * Begins a new transaction for use within this Business Service.<br>
     * A special purpose nested transaction wrapper is used that is able to emulate nested sub-transactions, as described in
     * {@link NestableTransaction}.<br>
     * 
     * @param dataContext
     *            The data context responsible for the session for the required transaction.
     * @return An active transaction.<br>
     *         In case no active transaction already exists in the session, one will be created and returned. Otherwise the existing
     *         transaction will be returned.
     */
    protected Transaction beginTransaction(DataContext dataContext) {

        assertParameter("dataContext", dataContext);

        Transaction transaction = new NestableTransaction(dataContext.getSession(), dataContext.isNested());
        if (!transaction.isActive()) {
            transaction.begin();
        }

        return transaction;
    }

    /**
     * This method finalizes a transaction and closes the data context.<br>
     * 
     * @param dataContext
     *            The data context that is responsible for the session related to the given transaction.
     * @param transaction
     *            the transaction to be finalized.
     * @param success
     *            if <code>true</code> the transaction will be commited, otherwise the {@link Transaction} will be rolled back.<br>
     */
    protected void finalizeTransaction(DataContext dataContext, Transaction transaction, boolean success) {

        assertParameter("dataContext", dataContext);

        /*- Why this warning? Check that and if needed, uncomment
        if (transaction != null && !(transaction instanceof NestableTransaction)) {
            log.warn("The transaction is not a " + NestableTransaction.class.getSimpleName()
                    + ". Should use a transaction obtained via method (busServ).beginTransaction(...)");
        }
        */

        try {
            if (transaction != null && dataContext.isOpen()) {
                if (success) {
                    try {
                        transaction.commit();
                    }
                    catch (Exception e) {
                        throw new ServiceRuntimeException("Failed COMMIT: " + e.getMessage(), e);
                    }
                }
                else {
                    try {
                        transaction.rollback();
                    }
                    catch (Exception e) {
                        // Don't throw an Exception, it would hide the error that has caused the rollback
                        log.error("Failed ROLLBACK: " + e.getMessage(), e);
                    }
                }
            }
        }
        finally {
            dataContext.close();
        }
    }

    /**
     * @return The {@link DataBeanTranslator} to be used. Or <code>null</code> if none was defined.
     */
    protected final DataBeanTranslator getTranslator() {

        return translator;
    }

    /**
     * Define the translator to be used by means of a {@link DataBeanTranslatorFactory}.<br>
     * 
     * @param factory
     *            the factory to be used, may be null.
     * @throws IllegalStateException
     *             if a {@link DataBeanTranslator} ia alrease assigned.
     */
    protected final void assignTranslator(DataBeanTranslatorFactory factory) {

        DataBeanTranslator newTranslator = factory != null ? factory.getTranslator() : null;
        if (translator != null && translator != newTranslator) {
            String msg = String.format("Translator has already been defined (%s), this new one (%s) will be ignored!",
                    translator.getClass().getName(), newTranslator.getClass().getName());
            throw new IllegalStateException(msg);
        }
        else {
            translator = newTranslator;
        }
    }

    /**
     * Translate the given bean to the given target locale.<br>
     * The given objects will be modified.<br>
     * 
     * @param targetLocale
     *            The target locale, if <code>null</code> the context locale will be assumed.
     * @param bean
     *            The bean to be translated, if <code>null</code> no translation will be performed.
     * @return The data after being translated
     */
    public <B extends AbstractDataBean> B translateData(Locale targetLocale, B bean) {

        if (targetLocale == null) {
            targetLocale = getContext().getLocale();
        }
        if (bean != null && getTranslator() != null) {
            getTranslator().translate(targetLocale, bean);
        }

        return bean;
    }

    /**
     * Translate the given list of beans to the given target locale.<br>
     * The given objects will be modified.<br>
     * 
     * @param targetLocale
     *            The target locale, if <code>null</code> the context locale will be assumed.
     * @param lstBeans
     *            The list of beans to be translated, if <code>null</code> or empty, no translation will be performed.
     * @return The data after being translated
     */
    public <LB extends Collection<? extends AbstractDataBean>> LB translateData(Locale targetLocale, LB lstBeans) {

        if (targetLocale == null) {
            targetLocale = getContext().getLocale();
        }
        if (lstBeans != null && !lstBeans.isEmpty() && getTranslator() != null) {
            getTranslator().translate(targetLocale, lstBeans);
        }

        return lstBeans;
    }

}
