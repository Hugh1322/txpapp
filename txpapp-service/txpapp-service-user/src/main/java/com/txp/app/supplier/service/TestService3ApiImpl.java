package com.txp.app.supplier.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


/**
 * th
 *
 */
@Slf4j
@Service("testService3Api")
public class TestService3ApiImpl implements TestServiceApi {

    @Override
    public Long test(Long id) {
        log.info("TestService3ApiImpl ..test skuId:{}",id);
        return 333l;
    }

    @Override
    public boolean updateDealInfoWithBankReturn(Long skuId) {
        log.info("testService3Api .. updateDealInfoWithBankReturn  3333333333");
        return true;
    }
}
