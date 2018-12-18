package com.txp.app.supplier.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import java.util.*;


/**
 * th
 *
 */
@Slf4j
@Service("testCheckServiceApi")
public class TestCheckServiceApiImpl implements TestCheckServiceApi,ApplicationContextAware {

    private ApplicationContext springContext;

    @Override
    public void check(Long id) {
        log.info("TestCheckServiceApiImpl ..check skuId:{}",id);
//        testServiceApi.test(id);

        List<TestServiceApi> returnServices = new ArrayList<>();
        for (TestServiceApi actService : getReturnServices()) {
            if(actService.updateDealInfoWithBankReturn(id)) {
                returnServices.add(actService);
            }
        }

    }

    private Collection<TestServiceApi> getReturnServices() {
        Collection<TestServiceApi> returnServices = null;
        if (returnServices == null) {
            Map<String, TestServiceApi> allser = springContext.getBeansOfType(TestServiceApi.class);
            if (allser != null) {
                returnServices = allser.values();
            }
        }

        return returnServices;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.springContext = applicationContext;
    }
}
