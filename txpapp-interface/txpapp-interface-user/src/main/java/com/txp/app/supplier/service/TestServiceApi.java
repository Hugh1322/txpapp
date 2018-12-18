package com.txp.app.supplier.service;



/**
 *
 */
public interface TestServiceApi {


    Long test(Long id);

    /**
     * 当匹配到相应的活动的时候
     * @param skuId
     */
    boolean updateDealInfoWithBankReturn(Long skuId);


}
