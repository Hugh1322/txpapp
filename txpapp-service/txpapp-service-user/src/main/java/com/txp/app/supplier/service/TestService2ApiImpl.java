package com.txp.app.supplier.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 * th
 *
 */
@Slf4j
@Service("testService2Api")
public class TestService2ApiImpl implements TestServiceApi {

    @Override
    public Long test(Long id) {
        log.info("TestService2ApiImpl ..test skuId:{}",id);
        return 222l;
    }

    @Override
    public boolean updateDealInfoWithBankReturn(Long skuId) {
        log.info("testService2Api .. updateDealInfoWithBankReturn  222222222222");
        return false;
    }
}
