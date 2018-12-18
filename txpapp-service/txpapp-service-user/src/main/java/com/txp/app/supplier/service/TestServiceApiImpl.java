package com.txp.app.supplier.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


/**
 * th
 * 供应商管理
 */
@Slf4j
@Service("testServiceApi")
public class TestServiceApiImpl implements TestServiceApi {


    @Override
    public Long test(Long id) {
        log.info("TestServiceApiImpl .. test");
        return 111l;
    }

    @Override
    public boolean updateDealInfoWithBankReturn(Long skuId) {
        log.info("testServiceApi .. updateDealInfoWithBankReturn  111111111111111111");
        return true;
    }
}
