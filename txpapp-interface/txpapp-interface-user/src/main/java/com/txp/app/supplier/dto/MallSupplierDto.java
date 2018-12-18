package com.txp.app.supplier.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class MallSupplierDto implements Serializable {
    /**
     *

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Long id;

    /**
     * 姓名/公司名称

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String companyName;

    /**
     * 供应商编码

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String code;

    /**
     * 联系方式

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String phone;

    /**
     * 联系地址

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String addr;

    /**
     * 发贷地

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String sendRegionName;

    /**
     * 状态：0待审核，1审核通过，2审核失败，3注销

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Byte status;

    /**
     * 供应商等级:0请选择,1厂商,2总代理,3一级代理,4二级代理

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Byte supplierType;

    /**
     * 邮箱

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String email;

    /**
     * 排序

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Integer sort;

    /**
     * 是否删除：0：正常，1：删除

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Byte isDelete;

    /**
     * 操作人

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private String operator;

    /**
     * 创建时间

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Date createTime;

    /**
     * 修改时间

     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    private Date updateTime;
    /**
     * 用户的级别 1：超级管理员
     */
    private Integer ruleType;

    /**
     * 备注，暂时使用为是否被选中
     */
    private Integer rmk;
}