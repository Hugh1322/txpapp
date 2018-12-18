package com.txp.app.util;


/**
 * 分页工具类
 *
 * @author th
 */
public class BasePagination<T> extends  com.ytoxl.module.core.common.pagination.BasePagination<T>{

    public String aname;

    public String getAname() {
        return aname;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }
}
