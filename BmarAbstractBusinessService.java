// ---------------------------------------------------------
// Project: BMAR_Commons
// Main class: BmarAbstractBusService
// Created at 02/07/2018 by cardosojo
// ---------------------------------------------------------

package dgrm.bmar.common.business;

import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.tuple.Pair;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Transaction;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Junction;

import dgrm.bmar.common.business.ext.ForeignBeanCacheManager;
import dgrm.bmar.common.business.ext.ForeignBeanCacheManager.CachePrefix;
import dgrm.bmar.common.business.ext.ForeignBeanHandler;
import dgrm.bmar.common.business.ext.ForeignBeanHandlerManager;
import dgrm.bmar.common.business.validation.CorrectScrambledcharsValidatorPlugin;
import dgrm.bmar.common.business.validation.NormLinebreaksValidatorPlugin;
import dgrm.bmar.common.shared.constants.ConstantsCommon;
import dgrm.bmar.common.shared.enums.EnumsCommon.Desativado;
import dgrm.bmar.common.shared.ext.ScopeHelper;
import dgrm.bmar.common.shared.ext.SyncFilterMode;
import dgrm.bmar.common.wserv.struct.JWSStatusData.Code;
import local.bai.basis.CodedMsg;
import local.bai.basis.OperationMode;
import local.bai.basis.context.EnvironmentContext;
import local.bai.basis.context.PortableContext;
import local.bai.basis.databeans.AbstractDataBean;
import local.bai.basis.databeans.BeanDetailSpec;
import local.bai.basis.databeans.DataBeanIntrospector;
import local.bai.basis.databeans.DataBeanUtils;
import local.bai.basis.databeans.ModelField;
import local.bai.basis.exceptions.BusinessException;
import local.bai.basis.exceptions.ServiceException;
import local.bai.basis.exceptions.ServiceRuntimeException;
import local.bai.basis.services.OrderInfo;
import local.bai.basis.services.ServiceReturn;
import local.bai.basis.utils.Assertions;
import local.bai.basis.utils.Checks;
import local.bai.basis.validation.ValidationTreewalker;
import local.bai.servhibern.AbstractBusinessService;
import local.bai.servhibern.context.DataContext;
import local.bai.servhibern.dataaccess.HibernateDAO;

/**
 * Class: BmarAbstractBusService<br>
 * Abstract Business Service Class for BMar Projects.<br>
 * This class' purpose to implement common mechanisms for all BMAR Business Services.<br>
 * <br>
 * 
 * @author cardosojo
 * @version 1.0 - cardosojo 02/07/2018
 */

public abstract class BmarAbstractBusinessService
        extends AbstractBusinessService {

    private ForeignBeanHandlerManager                                    foreignBeanHandlerManager = null;
    private ForeignBeanCacheManager                                      foreignBeanCache          = null;

    private Pair<SyncFilterMode, Set<Class<? extends AbstractDataBean>>> pairSyncFilter;

    static {
        // install needed Validator Plugins
        NormLinebreaksValidatorPlugin.install();
        CorrectScrambledcharsValidatorPlugin.install();
    }

    /**
     * Constructor for class BmarAbstractBusService.<br>
     * 
     * @param callerContext
     */
    public BmarAbstractBusinessService(PortableContext callerContext) {

        super(callerContext);
        assignTranslator(dgrm.bmar.common.business.translate.TranslatorFactory.FACTORY);
    }

    /**
     * <u>Constructor for class <tt>AbstractAdministracao_Bus<\tt>.<br>
     * <b>Not yet supported</b>
     * 
     * @param sharedDataCntx
     *            The data context to be used inside the new instance.
     * @param sameTransaction
     *            Specifies whether this new instance's calls will be performed inside the same connection and transaction,
     *            specified in the given data context.
     */
    public BmarAbstractBusinessService(DataContext sharedDataCntx, boolean sameTransaction) {

        super(sharedDataCntx, sameTransaction);
        assignTranslator(dgrm.bmar.common.business.translate.TranslatorFactory.FACTORY);
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
            targetLocale = theContext().getLocale();
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
     * @param beanlist
     *            The list of beans to be translated, if <code>null</code> or empty, no translation will be performed.
     * @return The data after being translated
     */
    public <LB extends Collection<? extends AbstractDataBean>> LB translateData(Locale targetLocale, LB beanlist) {

        if (targetLocale == null) {
            targetLocale = theContext().getLocale();
        }
        if (beanlist != null && !beanlist.isEmpty() && getTranslator() != null) {
            getTranslator().translate(targetLocale, beanlist);
        }

        return beanlist;
    }

    /**
     * <u>Obtains</u> an instance of {@link ValidationTreewalker}, to be used for performing validations.<br>
     * This definition is needed here because of {@link #putValueIntoValidCtx(String, String)}<br>
     * 
     * @return <tt>local.bai.basis.validation.ValidationTreewalker</tt>
     */
    protected abstract ValidationTreewalker obtainValidationTW();

    /**
     * Stores a value into validation context.<br>
     * This may be used before performing validations to influence application-specific validation behavior.<br>
     * <br>
     * TODO: replace these with calls to context.updateActionStep(...). NOTE: calls to
     * <tt>context.getValue(ConstantsCommon.ACAO_UTILIZADOR)<tt> should be replaced by <tt>context.getActionStep()<tt>.
     * 
     * @param name
     *            The value name
     * @param value
     *            the value itself
     */
    /* final */ public void putValueIntoValidCtx(String name, String value) {

        obtainValidationTW().theContext().putValue(name, value);
    }

    // -- BEGIN_ Workaround for wrong behaviour when detaching with a null detailSpec -----------------------------

    /**
     * Overridden method.<br>
     * 
     * @see local.bai.servhibern.AbstractBusinessService#detachDataBeanListValues(local.bai.basis.databeans.AbstractDataBean,
     *      boolean, local.bai.basis.databeans.BeanDetailSpec)
     */
    @Override
    public <B extends AbstractDataBean> B detachDataBeanListValues(B theBean, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        if (null == beanDetailSpec) beanDetailSpec = BeanDetailSpec.INCLUDE_ALL;
        return super.detachDataBeanListValues(theBean, discardChildren, beanDetailSpec);
    }

    /**
     * Overridden method.<br>
     * Assume default beanDetailSpec as {@link BeanDetailSpec#INCLUDE_ALL}.<br>
     * 
     * @see local.bai.servhibern.AbstractBusinessService#detachDataBeanListValues(java.util.Collection, boolean,
     *      local.bai.basis.databeans.BeanDetailSpec)
     */
    @Override
    public <B extends AbstractDataBean> Collection<B> detachDataBeanListValues(Collection<B> lstBeans, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        if (null == beanDetailSpec) beanDetailSpec = BeanDetailSpec.INCLUDE_ALL;
        return super.detachDataBeanListValues(lstBeans, discardChildren, beanDetailSpec);
    }

    /**
     * Overridden method.<br>
     * Assume default beanDetailSpec as {@link BeanDetailSpec#INCLUDE_ALL}.<br>
     * 
     * @see local.bai.servhibern.AbstractBusinessService#detachDataBeanListValues(local.bai.basis.databeans.AbstractDataBean[],
     *      boolean, local.bai.basis.databeans.BeanDetailSpec)
     */
    @Override
    public <B extends AbstractDataBean> B[] detachDataBeanListValues(B[] arrBeans, boolean discardChildren,
            BeanDetailSpec beanDetailSpec) {

        if (null == beanDetailSpec) beanDetailSpec = BeanDetailSpec.INCLUDE_ALL;
        return super.detachDataBeanListValues(arrBeans, discardChildren, beanDetailSpec);
    }

    // -- END: Workaround for wrong behavior when detaching with a null detailSpec --------------------------------

    // -- Methods Related to Foreign Bean Management -------------------------------------------------------------

    /**
     * Shortcut method to get the Foreign Bean Handler Manager to expose its interface.<br>
     * 
     * @return
     */
    final protected ForeignBeanHandlerManager getForeignBeanHandlerManager() {

        if (null == this.foreignBeanHandlerManager) {
            synchronized (this) {
                if (null == this.foreignBeanHandlerManager) {
                    this.foreignBeanHandlerManager = ForeignBeanHandlerManager.instance();
                }
            }
        }
        return this.foreignBeanHandlerManager;
    }

    /**
     * Shortcut method to get the Foreign Bean Handler Manager to expose its interface.<br>
     * 
     * @return
     */
    final private ForeignBeanCacheManager getForeignBeanCache() {

        if (null == this.foreignBeanCache) {
            synchronized (this) {
                if (null == this.foreignBeanCache) {
                    this.foreignBeanCache = ScopeHelper.retrieveManagedBean(ForeignBeanCacheManager.MBEAN_NAME,
                            ForeignBeanCacheManager.class, ScopeHelper.APPLICATION);
                }
            }
        }
        return this.foreignBeanCache;
    }

    /**
     * Performs a flexible search comparing a given field name with a given search value.<br>
     * This method allows specifying the list of the fields to be read from the database.<br>
     * <br>
     * 
     * @param beanClass
     *            The class of the desired bean
     * @param includeMissingParents
     *            Specifies if parent beans not specified should be included.
     * @param searchFieldName
     *            The name d the search field, to bean compared against the list of values.
     * @param searchValues
     *            The value to be searched<br>
     *            The id fields and the criteria field will be added to tthis list.
     * @param resultFieldNames
     *            The name of the desired fields.
     * @return The list of found beans, with only the required fields.
     */
    public <DATABEAN extends AbstractDataBean> ServiceReturn<Collection<DATABEAN>> listFieldsFrom(Class<DATABEAN> beanClass,
            boolean includeMissingParents, String searchFieldName, Object searchValue, String... resultFieldNames)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        return listFieldsFrom(beanClass, includeMissingParents, searchFieldName, Arrays.asList(searchValue), resultFieldNames);
    }

    /**
     * Helper/Shortcut method to synchronize all externals bean, by using its handlers.<br>
     * 
     * @param theBean
     * @throws BusinessException
     * @throws ServiceRuntimeException
     * @throws ServiceException
     * @deprecated Use {@link #loadExternalBeanRefs(AbstractDataBean)}
     */
    @Deprecated
    final public void syncAllExternalReferences(AbstractDataBean theBean)
        throws BusinessException, ServiceRuntimeException, ServiceException {

        loadExternalBeanRefs(theBean);
    }

    /**
     * This method defines that External/Foreign bean synchronization must not be performed for <b>any</b> classes.<br>
     * This setting affects all future uses of the instance, and cannot be reverted nor modified.<br>
     * <br>
     * <b>Do not use it on instances of business services that may be cached or shared</b>, unless you are really sure you want to
     * do that.<br>
     * See also {@link #noSynchFBForClasses(Class...)} or {@link #noSynchFBForClasses(Collection)} or
     * {@link #onlySynchFBForClasses(Class...)} or {@link #onlySynchFBForClasses(Collection)}<b>
     */
    @SuppressWarnings("unchecked")
    public synchronized <CHILD extends BmarAbstractBusinessService> CHILD noSynchFB() {

        Set<Class<? extends AbstractDataBean>> lstBeanClasses = Collections.emptySet();

        assertAssignSyncFilter(SyncFilterMode.NONE, lstBeanClasses);

        pairSyncFilter = Pair.of(SyncFilterMode.NONE, lstBeanClasses);

        return (CHILD) this;
    }

    /**
     * This method defines that External/Foreign bean synchronization <b>will not</b> be performed for the classes passed as
     * parameter or their subclasses.<br>
     * This setting affects all future uses of the instance, and cannot be reverted nor modified.<br>
     * <br>
     * If it s required that no synchronization is never performed for method of a Bus Service, use method {@link #noSynchFB()}.<br>
     * This method affects all future uses of the instances, and cannot be reverted - <b>Do not use it on instances of business
     * services that may be cached or shared</b> , unless you are really sure you want to do that.<br>
     * 
     * @param lstBeanClasses
     *            The list of classes.
     * @throws IllegalStateException
     *             if {@link #defineNotSynchExternalAllClasses()} has been called.
     */
    @SuppressWarnings("unchecked")
    final public synchronized <CHILD extends BmarAbstractBusinessService> CHILD noSynchFBForClasses(
            Collection<Class<? extends AbstractDataBean>> lstBeanClasses)
        throws IllegalStateException {

        Assertions.assertParameterByPredicate("lstBeanClasses", lstBeanClasses, //
                (l) -> !Checks.nullempty(l), "an non-empty list must be provided");

        assertAssignSyncFilter(SyncFilterMode.EXCEPT_SUBCLASS, lstBeanClasses);

        pairSyncFilter = Pair.of(SyncFilterMode.EXCEPT_SUBCLASS, //
                Collections.unmodifiableSet(new HashSet<>(lstBeanClasses)));

        return (CHILD) this;
    }

    /**
     * This method defines that External/Foreign bean synchronization <b>will not</b> be performed for the classes passed as
     * parameter or their subclasses.<br>
     * This setting affects all future uses of the instance, and cannot be reverted nor modified.<br>
     * <br>
     * If it is required that no synchronization is never performed for method of a Bus Service, use method
     * {@link #noSynchFB()}.<br>
     * This method affects all future uses of the instances, and cannot be reverted - <b>Do not use it on instances of business
     * services that may be cached or shared</b> , unless you are really sure you want to do that.<br>
     * 
     * @param lstBeanClasses
     *            The classes.
     * @throws IllegalStateException
     *             if {@link #defineNotSynchExternalAllClasses()} has been called.
     */
    @SuppressWarnings("unchecked")
    @SafeVarargs
    final public synchronized <CHILD extends BmarAbstractBusinessService> CHILD noSynchFBForClasses(
            Class<? extends AbstractDataBean>... beanClasses)
        throws IllegalStateException {

        Assertions.assertParameter("lstBeanClasses", beanClasses);

        List<Class<? extends AbstractDataBean>> lstBeanClasses = Arrays.asList(beanClasses);
        assertAssignSyncFilter(SyncFilterMode.EXCEPT_SUBCLASS, lstBeanClasses);

        pairSyncFilter = Pair.of(SyncFilterMode.EXCEPT_SUBCLASS, //
                Collections.unmodifiableSet(new HashSet<>(lstBeanClasses)));

        return (CHILD) this;
    }

    /**
     * This method defines that External/Foreign bean synchronization will be performed <b<>only</b> for the classes passed as
     * parameter or their subclasses.<br>
     * This setting affects all future uses of the instance, and cannot be reverted nor modified.<br>
     * <br>
     * If it s required that no synchronization is never performed for method of a Bus Service, use method {@link #noSynchFB()}.<br>
     * This method affects all future uses of the instances, and cannot be reverted - <b>Do not use it on instances of business
     * services that may be cached or shared</b> , unless you are really sure you want to do that.<br>
     * 
     * @param lstBeanClasses
     *            The list of classes.
     * @throws IllegalStateException
     *             if {@link #defineNotSynchExternalAllClasses()} has been called.
     */
    @SuppressWarnings("unchecked")
    final public synchronized <CHILD extends BmarAbstractBusinessService> CHILD onlySynchFBForClasses(
            Collection<Class<? extends AbstractDataBean>> lstBeanClasses)
        throws IllegalStateException {

        Assertions.assertParameterByPredicate("lstBeanClasses", lstBeanClasses, //
                (l) -> !Checks.nullempty(l), "an non-empty list must be provided");

        assertAssignSyncFilter(SyncFilterMode.ONLY_SUBCLASS, lstBeanClasses);

        pairSyncFilter = Pair.of(SyncFilterMode.ONLY_SUBCLASS, //
                Collections.unmodifiableSet(new HashSet<>(lstBeanClasses)));

        return (CHILD) this;
    }

    /**
     * This method defines that External/Foreign bean synchronization will be performed <b<>only</b> for the classes passed as
     * parameter or their subclasses.<br>
     * This setting affects all future uses of the instance, and cannot be reverted nor modified.<br>
     * <br>
     * If it s required that no synchronization is never performed for method of a Bus Service, use method {@link #noSynchFB()}.<br>
     * This method affects all future uses of the instances, and cannot be reverted - <b>Do not use it on instances of business
     * services that may be cached or shared</b> , unless you are really sure you want to do that.<br>
     * 
     * @param lstBeanClasses
     *            The classes.
     * @throws IllegalStateException
     *             if {@link #defineNotSynchExternalAllClasses()} has been called.
     */
    @SuppressWarnings("unchecked")
    @SafeVarargs
    final public synchronized <CHILD extends BmarAbstractBusinessService> CHILD onlySynchFBForClasses(
            Class<? extends AbstractDataBean>... beanClasses)
        throws IllegalStateException {

        Assertions.assertParameter("lstBeanClasses", beanClasses);

        List<Class<? extends AbstractDataBean>> lstBeanClasses = Arrays.asList(beanClasses);
        assertAssignSyncFilter(SyncFilterMode.ONLY_SUBCLASS, lstBeanClasses);

        if (pairSyncFilter != null) {
            throw new IllegalStateException("Default Sync Fiter already exists: " + pairSyncFilter.getLeft());
        }

        pairSyncFilter = Pair.of(SyncFilterMode.ONLY_SUBCLASS, //
                Collections.unmodifiableSet(new HashSet<>(lstBeanClasses)));

        return (CHILD) this;
    }

    /**
     * Checks if new filtering parameters may be assigned
     * 
     * @param filterMode
     * @param lstBeanClasses
     * @throws IllegalStateException
     */
    protected void assertAssignSyncFilter(SyncFilterMode filterMode, Collection<Class<? extends AbstractDataBean>> lstBeanClasses)
        throws IllegalStateException {

        if (pairSyncFilter == null) {
            // nothing to check
            return;
        }

        boolean consistent;
        if (pairSyncFilter.getLeft() != filterMode) {
            consistent = false;
        }
        else {
            Set<Class<? extends AbstractDataBean>> newSet = new HashSet<>(lstBeanClasses);
            consistent = (CollectionUtils.isEqualCollection(pairSyncFilter.getRight(), newSet));
        }

        if (!consistent) {
            String strFilter = pairSyncFilter.getLeft().name();
            String strNames = pairSyncFilter.getRight().stream().map((cl) -> cl.getSimpleName()).collect(Collectors.joining(","));
            throw new IllegalStateException(String.format("Default Sync Fiter already exists: %s [%s].", strFilter, strNames));
        }

    }

    /**
     * Helper method to store an object on cache.<br>
     * For more details see {@link ForeignBeanCacheManager#putValue(String, Object)}.<br>
     * 
     * @param cachePrefix
     * @param key
     *            The object's key
     * @param value
     *            The object to store
     * @return The object itself
     */
    final protected <T> T storeDataOnCache(CachePrefix cachePrefix, Object key, T value) {

        ForeignBeanCacheManager cache = getForeignBeanCache();
        if (null == cache) {
            return value;
        }

        String keyString = ForeignBeanHandlerManager.keyString(getContext().getLocale(), cachePrefix, key);
        return cache.putValue(keyString, value);
    }

    /**
     * Helper method to store an object on cache.<br>
     * For more details see {@link ForeignBeanCacheManager#putValue(String, Object, long)}.<br>
     * 
     * @param cachePrefix
     * @param key
     *            The object's key
     * @param value
     *            The object to store
     * @param prfx
     * @return The object itself
     */
    final protected <T> T storeDataOnCache(CachePrefix cachePrefix, Object key, T value, long ttlMillis) {

        ForeignBeanCacheManager cache = getForeignBeanCache();
        if (null == cache) {
            return value;
        }

        String keyString = ForeignBeanHandlerManager.keyString(getContext().getLocale(), cachePrefix, key);
        return cache.putValue(keyString, value, ttlMillis);
    }

    /**
     * Helper method to retrieve on object from cache.<br>
     * 
     * @param dataClass
     *            Type
     * @param cachePrefix
     * @param key
     *            Object key
     * @return The respective {@linkplain ServiceReturn} or null
     */
    final protected <B> ServiceReturn<B> retrieveFromCache(Class<B> dataClass, CachePrefix cachePrefix, Object key) {

        ForeignBeanCacheManager cache = getForeignBeanCache();
        if (null != cache) {
            String keyString = ForeignBeanHandlerManager.keyString(getContext().getLocale(), cachePrefix, key);
            B data = cache.getValue(dataClass, keyString);
            if (null != data) {
                return new ServiceReturn<B>(new CodedMsg(Code.OK.defaultMessage())).setTotalRowCount(1).setValue(data);
            }
        }
        return null;
    }

    /**
     * Helper method to remove object from cache.<br>
     * This is a shortcut to {@link ForeignBeanHandlerManager#evictOne(EnvironmentContext, Class, Object)}
     * 
     * @param dataClass
     *            Type
     * @param cachePrefix
     *            One of the prefixes defined in {@linkplain ForeignBeanCacheManager}
     * @param key
     *            The key for the object to remove
     */
    final protected <B extends AbstractDataBean> void removeFromCache(Class<B> dataClass, Object key) {

        ForeignBeanHandlerManager manager = getForeignBeanHandlerManager();
        if (null != manager) {
            manager.evictOne(getContext(), dataClass, key);
        }
    }

    /**
     * Helper method to remove object from cache.<br>
     * This is a shortcut to {@link ForeignBeanHandlerManager#evictOne(EnvironmentContext, AbstractDataBean)}
     * 
     * @param dataClass
     *            Type
     * @param cachePrefix
     *            One of the prefixes defined in {@linkplain ForeignBeanCacheManager}
     * @param key
     *            The key for the object to remove
     */
    final protected <B extends AbstractDataBean> void removeFromCache(AbstractDataBean bean) {

        if (bean == null) return;
        ForeignBeanHandlerManager manager = getForeignBeanHandlerManager();
        if (null != manager) {
            manager.evictOne(getContext(), bean.getClass(), bean);
        }
    }

    /**
     * Overridden method.<br>
     * 
     * @see local.bai.servhibern.AbstractService#loadExternalBeanRefs(local.bai.basis.databeans.AbstractDataBean)
     */
    @Override
    final protected <B extends AbstractDataBean> B loadExternalBeanRefsImpl(B theBean)
        throws ServiceException {

        if (theBean == null) return null;

        if (!ForeignBeanHandler.checkBeanclassNeedsSynch(theBean.getClass())) return theBean;

        if (null != pairSyncFilter) {
            this.getForeignBeanHandlerManager().syncForeignBeans(//
                    (EnvironmentContext) getContext(), //
                    theBean, pairSyncFilter.getLeft(), pairSyncFilter.getRight());
        }
        else {
            this.getForeignBeanHandlerManager().syncAllForeignBeans(getContext(), theBean);
        }

        return theBean;
    }

    /**
     * This method processes the provided bean similar to described in {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * It takes into account method {@link #noSynchFB()}, {@link #noSynchFBForClasses(Class...)},
     * {@link #onlySynchFBForClasses(Class...)}, etc.<br>
     * To force processing all types of beans, despite the the methods mentioned above, consider using the following call:<br>
     * {@code loadExternalBeanRefs(context, theBean, SyncFilterMode.ONLY_SUBCLASS, AbstractDataBean.class)}
     * 
     * @param bean
     *            The local bean
     * @param filterMode
     *            The mode of filtering
     * @param filterClasses
     *            Types that will be synchronized or excluded, depending on chosen {@code filterMode}
     */
    final public <B extends AbstractDataBean> B loadExternalBeanRefsDefault(B theBean)
        throws ServiceException {

        return loadExternalBeanRefs(theBean);
    }

    /**
     * This method processes the provided bean similar to described in {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * This method is limited by the provided parameters {@code filterMode} and {@code filterClasses}. <br>
     * It does not take into account method {@link #noSynchFB()}, {@link #noSynchFBForClasses(Class...)},
     * {@link #onlySynchFBForClasses(Class...)}, etc.<br>
     * To force processing all types of beans, despite the the methods mentioned above, consider using the following call:<br>
     * {@code loadExternalBeanRefs(context, theBean, SyncFilterMode.ONLY_SUBCLASS, AbstractDataBean.class)}
     * 
     * @param bean
     *            The local bean
     * @param filterMode
     *            The mode of filtering
     * @param filterClasses
     *            Types that will be synchronized or excluded, depending on chosen {@code filterMode}
     */
    @SafeVarargs
    final public <B extends AbstractDataBean> B loadExternalBeanRefs(B theBean, SyncFilterMode filterMode,
            Class<? extends AbstractDataBean>... filterClasses)
        throws ServiceException {

        Assertions.assertParameter("theBean", theBean);
        Assertions.assertParameter("filterMode", filterMode);
        Assertions.assertParameter("filterClasses", filterClasses);

        if (theBean == null) return null;

        if (!ForeignBeanHandler.checkBeanclassNeedsSynch(theBean.getClass())) return theBean;

        this.getForeignBeanHandlerManager().syncForeignBeans((EnvironmentContext) getContext(), //
                theBean, //
                filterMode, Arrays.asList(filterClasses));

        return theBean;
    }

    /**
     * This method processes the provided bean similar to described in {@link #loadExternalBeanRefs(AbstractDataBean)}.<br>
     * This method is limited by the provided parameters {@code filterMode} and {@code filterClasses}. <br>
     * It does not take into account method {@link #noSynchFB()}, {@link #noSynchFBForClasses(Class...)},
     * {@link #onlySynchFBForClasses(Class...)}, etc.<br>
     * To force processing all types of beans, despite the the methods mentioned above, consider using the following call:<br>
     * {@code loadExternalBeanRefs(context, theBean, SyncFilterMode.ONLY_SUBCLASS, AbstractDataBean.class)}
     * 
     * @param bean
     *            The local bean
     * @param filterMode
     *            The mode of filtering
     * @param filterClasses
     *            Types that will be synchronized or excluded, depending on chosen {@code filterMode}
     */
    final public <B extends AbstractDataBean> B loadExternalBeanRefs(B theBean, SyncFilterMode filterMode,
            Collection<Class<? extends AbstractDataBean>> filterClasses)
        throws ServiceException {

        Assertions.assertParameter("theBean", theBean);
        Assertions.assertParameter("filterMode", filterMode);
        Assertions.assertParameterByPredicate("filterClasses", filterClasses, (l) -> !Checks.nullempty(l),
                "an non-empty list must be provided");;

        if (theBean == null) return null;

        if (!ForeignBeanHandler.checkBeanclassNeedsSynch(theBean.getClass())) return theBean;

        this.getForeignBeanHandlerManager().syncForeignBeans((EnvironmentContext) getContext(), //
                theBean, //
                filterMode, filterClasses);

        return theBean;
    }

    /**
     * Overridden method.<br>
     * This method exists because some code is not handling {@link ServiceException} (other than {@link BusinessException})
     * properly. Such exceptions are disguised as {@link ServiceRuntimeException}.<br>
     * 
     * @see local.bai.servhibern.AbstractBusinessService#analyzeException(java.lang.Throwable, local.bai.basis.OperationMode)
     */
    @Override
    public void analyzeException(Throwable th, OperationMode mode)
        throws RuntimeException, /* ServiceException, */ BusinessException, ServiceRuntimeException {

        try {
            super.analyzeException(th, mode);
        }
        catch (ServiceException ex) {
            if (ex instanceof BusinessException) throw (BusinessException) ex;

            // all other ServiceExcpetions will be disguised as ServiceRuntimeExceptions
            ServiceRuntimeException newex = new ServiceRuntimeException(ex.getCodedMessage(), ex.getCause());
            newex.setStackTrace(ex.getStackTrace());
        }

    }

    /**
     * Performs a flexible search comparing a given fields name with a given list of search values (using a IN comparison).<br>
     * This method allows specifying the list of the fields to be read from the database.<br>
     * <br>
     * TODO: consider moving this to the BAI's superclass,<br>
     * 
     * @param beanClass
     *            The class of the desired bean
     * @param includeMissingParents
     *            Specifies if parent beans not specified should be included.
     * @param searchFieldName
     *            The name of the search field, to bean compared against the list of values.
     * @param lstSearchValues
     *            The list of values to be searched
     * @param resultFieldNames
     *            The name of the desired fields.
     * @return The list of found beans, with only the required fields.
     */
    public <DATABEAN extends AbstractDataBean> ServiceReturn<Collection<DATABEAN>> listFieldsFrom(Class<DATABEAN> beanClass,
            boolean includeMissingParents, String searchFieldName, Collection<?> lstSearchValues, String... resultFieldNames)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Assertions.assertParameter("beanClass", beanClass);
        Assertions.assertParameter("searchFieldName", searchFieldName);
        Assertions.assertParameter("lstSearchValues", lstSearchValues);
        Assertions.assertParameter("resultFieldNames", resultFieldNames);

        if (lstSearchValues.isEmpty()) {
            // search list values is empty, don't even bother
            // return an empty list
            return new ServiceReturn<Collection<DATABEAN>>(new ArrayList<>(), 0L, null);
        }

        // define the list of columns (forcing the search field and the id fields)
        ArrayList<String> wrkResFieldNames = new ArrayList<String>(Arrays.asList(resultFieldNames));
        {
            if (!wrkResFieldNames.contains(searchFieldName)) {
                wrkResFieldNames.add(searchFieldName);
            }
            Set<String> fieldIds = DataBeanIntrospector.findAnnotatedProps(beanClass, Id.class).keySet();
            for (String fld : fieldIds) {
                if (!wrkResFieldNames.contains(fld)) {
                    wrkResFieldNames.add(fld);
                }
            }
        }

        DataContext dc = super.theContext();

        try {
            // -- Query Code -------------------------------
            Criteria criteria = dc.getSession().createCriteria(beanClass);

            Junction junct = HibernateDAO.obtainJunction(Conjunction.class, criteria); // AND
            HibernateDAO.addToCriteria("IN", junct, searchFieldName, lstSearchValues);

            // allow for the double of elements in the list of serach values
            int maxRecs = lstSearchValues.size() * 2;
            maxRecs = (maxRecs < DEFAULT_QUERY_RECORDS) ? DEFAULT_QUERY_RECORDS : maxRecs;

            return listFieldsFrom(beanClass, includeMissingParents, criteria, true, 1, maxRecs, resultFieldNames);
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.SEARCH);
            return null; // never arrive here
        }
        finally {
            dc.close();
        }
    }

    /**
     * Performs a flexible search comparing a given fields name with a given {@link Criteria}.<br>
     * This method allows specifying the list of the fields to be read from the database.<br>
     * <br>
     * TODO: consider moving this to the BAI's superclass,<br>
     * 
     * @param beanClass
     *            The class of the desired bean
     * @param includeMissingParents
     *            Specifies if parent beans not specified should be included.
     * @param criteria
     *            A {@link CriteriaSpecification} instance, may be a {@link Criteria} or a {@link DetachedCriteria}.
     * @param doTranslate
     *            Specifies if the beans translation mechanism should be invoked
     * @param startRec
     *            The first recorded to be retrieved (starting at 1). If {@code null} or < 0, assumes 1.
     * @param maxRecs
     *            Max number of records to be obtained. If {@code null} or < 0, assumes the value in {@link #DEFAULT_QUERY_RECORDS}.
     * @param resultFieldNames
     *            The name of the desired fields.
     * @return The list of found beans, with only the required fields.
     */
    public <DATABEAN extends AbstractDataBean> ServiceReturn<Collection<DATABEAN>> listFieldsFrom(Class<DATABEAN> beanClass,
            boolean includeMissingParents, CriteriaSpecification criteria, boolean doTranslate, Integer startRec, Integer maxRecs,
            String... resultFieldNames)
        throws IllegalArgumentException, BusinessException, ServiceException, ServiceRuntimeException {

        Assertions.assertParameter("beanClass", beanClass);
        Assertions.assertParameter("criteria", criteria);
        Assertions.assertParameterByPredicate("criteria", criteria.getClass(),
                cl -> Criteria.class.isAssignableFrom(cl) || DetachedCriteria.class.isAssignableFrom(cl), //
                "invalida criteria class");
        Assertions.assertParameter("resultFieldNames", resultFieldNames);

        startRec = (startRec == null || startRec < 1) ? 1 : startRec;;
        maxRecs = (maxRecs == null || maxRecs < 0) ? DEFAULT_QUERY_RECORDS : maxRecs;

        Collection<DATABEAN> ret = null;
        Long totalRowcount = null;

        {
            // redefine the list of columns (forcing the search field and the id fields)
            boolean modified = false;
            ArrayList<String> wrkResFieldNames = new ArrayList<String>(Arrays.asList(resultFieldNames));
            Set<String> lstFieldsTransient = DataBeanIntrospector.findAnnotatedProps(beanClass, Transient.class).keySet();
            modified |= wrkResFieldNames.removeAll(lstFieldsTransient);

            Set<String> lstFieldsId = DataBeanIntrospector.findAnnotatedProps(beanClass, Id.class).keySet();
            for (String fld : lstFieldsId) {
                if (!wrkResFieldNames.contains(fld)) {
                    modified |= wrkResFieldNames.add(fld);
                }
            }

            if (modified) {
                resultFieldNames = wrkResFieldNames.stream().toArray(String[]::new);
            }
        }

        DataContext dc = super.theContext();
        try {
            // -- Query Code -------------------------------
            HibernateDAO<DATABEAN> myDao = HibernateDAO.instance(beanClass, dc);

            Criteria wrkCriteria;
            if (criteria instanceof Criteria) {
                wrkCriteria = (Criteria) criteria;
            }
            else {
                // criteria type was valoidates at an assertions at he beginning of the method
                wrkCriteria = ((DetachedCriteria) criteria).getExecutableCriteria(dc.getSession());
            }

            wrkCriteria = myDao.defineListColumns(wrkCriteria, includeMissingParents, resultFieldNames);

            totalRowcount = myDao.countByCriteria(wrkCriteria);

            // Orders ascending by the given field names
            OrderInfo order = new OrderInfo();
            for (String ff : resultFieldNames) {
                Collection<Annotation> aas = DataBeanIntrospector.obtainAnnotations(beanClass, ff);
                if (DataBeanIntrospector.checkAnnotation(aas, Id.class)
                        || DataBeanIntrospector.checkAnnotation(aas, Column.class)) {

                    // Excluding
                    ModelField modelAnnot = DataBeanIntrospector.findAnnotation(aas, ModelField.class);
                    if (modelAnnot != null && (modelAnnot.datatype().isLarge)) continue;

                    order.placeEnd(ff, OrderInfo.ASC);
                }
            }
            wrkCriteria = HibernateDAO.applyOrdering(wrkCriteria, order);

            // hibernate record positions start at 0
            wrkCriteria.setFirstResult(startRec - 1);
            wrkCriteria.setMaxResults(maxRecs);

            ret = myDao.retrieveListByCriteria(wrkCriteria);

            // Detach lists, propagate the children inclusion information (if requested with child data)
            detachDataBeanListValues(ret, false, BeanDetailSpec.includeChildren(resultFieldNames));
            // ---------------------------------------------
        }
        catch (Exception e) {
            analyzeException(e, OperationMode.SEARCH);
        }
        finally {
            dc.close();
        }

        // Translate the return value
        // This ply works if the translation key field was included in the search.
        if (doTranslate && (ret != null && getTranslator() != null)) {
            getTranslator().translate(dc.getLocale(), ret);
        }

        // Load external bean references
        loadExternalBeanRefs(ret);

        return new ServiceReturn<Collection<DATABEAN>>(ret, totalRowcount, null);
    }

    /**
     * Marks the the record on database corresponding to the given dataBean, as active / inactive, all data in the beans and
     * existing children is also stored<br>
     * <b>No validations are performed whatsoever</b>.<br>
     * 
     * @param <B>
     * @param dataBean
     *            the bean to be marked.
     * @param flagInactive
     *            if <b>true</b> records
     * @return
     * @throws BusinessException
     */
    public <B extends AbstractDataBean> ServiceReturn<B> markRecordInactive(B dataBean, boolean flagInactive)
        throws BusinessException, ServiceRuntimeException, RuntimeException {

        Assertions.assertParameter("dataBeen", dataBean);

        if (!dataBean.isStored()) {
            throw new BusinessException("err.cannot_mark_inactive_new_record");
        }

        @SuppressWarnings("unchecked")
        Class<B> dataClass = (Class<B>) dataBean.getClass();

        String tableName;
        final String dataClassName = dataClass.getName();
        {
            Table anTable = DataBeanIntrospector.findFirstAnnotation(dataClass, Table.class);
            if (anTable == null) {
                throw new IllegalArgumentException(String.format("Bean %s is not an entity bean", dataClassName));
            }
            tableName = anTable.name();
        }

        // Define (possibly supports several possibilities) field for deactivate fiedls: defoning a name ande the finctiona that
        // maps the boolean value into the corresponding value to be stored on database
        List<Pair<String, Function<Boolean, Object>>> arrInactiveFlagSpecs = Arrays.asList(//
                Pair.of(Desativado.PROP_NAME, flag -> flag ? ConstantsCommon.SIM : ConstantsCommon.NAO)//
        );

        // Search the property on the bean that natches on of the defined above
        // and modify its value, stop at the first find
        Pair<String, Object> pairFieldModified = null;
        for (Pair<String, Function<Boolean, Object>> flagSpec : arrInactiveFlagSpecs) {
            final String propName = flagSpec.getLeft();
            final Object newValue = flagSpec.getRight().apply(flagInactive);
            Column anColumn = DataBeanIntrospector.findFirstAnnotation(dataClass, propName, Column.class);
            if (anColumn != null && PropertyUtils.isWriteable(dataBean, propName)) {
                try {
                    PropertyUtils.setProperty(dataBean, propName, newValue);
                    pairFieldModified = Pair.of(anColumn.name(), newValue);
                    break; // should be a single flag on a bean
                }
                catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
                    throw new RuntimeException(String.format("Failed setting field %s.%s to '%s': %s",
                            dataBean.getClass().getName(), propName, newValue, e.getMessage()));
                }
            }
        }

        if (pairFieldModified == null) {
            log.warn("No fields correspoding to 'Deactivate Flag' where updated for bean of class " + dataClassName);
        }
        else {
            // perform the update
            DataContext dc = super.theContext();
            Transaction transaction = null;
            boolean success = false;
            try {
                transaction = beginTransaction(dc);

                // -- Transaction Implementation Code --------------------
                // .. collect bean/tabçe metadata to build the update command
                String fieldId;
                Object valueId;
                {
                    Collection<String> lstFldIds = DataBeanUtils.obtainKeyFields(dataClass);
                    // in BMAR, all tables have a single Id field
                    if (lstFldIds.isEmpty()) {
                        throw new IllegalArgumentException(String.format("Bean %s has no @Id field", dataClassName));
                    }
                    String propId = lstFldIds.iterator().next();
                    Column anColId = DataBeanIntrospector.findFirstAnnotation(dataClass, propId, Column.class);
                    fieldId = anColId != null ? anColId.name() : null;
                    try {
                        valueId = PropertyUtils.getProperty(dataBean, propId);
                    }
                    catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
                        throw new RuntimeException(String.format("Failed reading ID field %s.%s: %s", dataBean.getClass().getName(),
                                propId, e.getMessage()));
                    }
                }

                // Construct the query
                String strQuery = "update " + tableName;
                strQuery += " set " + pairFieldModified.getLeft() + "=" + ":_flag";
                strQuery += " where " + fieldId + "=" + ":_id";

                SQLQuery sqlQuery = dc.getSession().createSQLQuery(strQuery);
                sqlQuery.setParameter("_flag", pairFieldModified.getRight());
                sqlQuery.setParameter("_id", valueId);

                sqlQuery.executeUpdate();
                success = true;
            }
            catch (Exception e) {
                analyzeException(e, OperationMode.UPDATE);
            }
            finally {
                finalizeTransaction(dc, transaction, success);
            }
        }

        return new ServiceReturn<B>(dataBean, null, null);
    }
    

}
