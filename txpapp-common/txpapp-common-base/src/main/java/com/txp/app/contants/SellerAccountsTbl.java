package com.txp.app.contants;

import java.math.BigDecimal;

import java.util.Date;

/** 商家结算
 * @author zengzhiming
 *
 */
public class SellerAccountsTbl {
	
	protected Integer accountsId;//主键	int		
	protected Date clearingStartTime;//结算开始时间	decimal		
	protected Date clearingEndTime;//结算结束时间	decimal		
	protected Integer salesQuantity;//销售数量	decimal		
	protected BigDecimal salesMoney;//销售收入	decimal		
	protected BigDecimal returnSales;//退款	decimal		
	protected BigDecimal returnPro;//退货	decimal		
	protected BigDecimal unReturnSales;//退款退货后总收入	decimal		
	protected BigDecimal freight;//运费	decimal		
	protected BigDecimal serverRate;//服务费率	decimal		
	protected BigDecimal serverMoney;//服务费用	decimal		
	protected BigDecimal otherMoney;//其它费用	decimal		
	protected BigDecimal stimulate;//销售激励	decimal		
	protected BigDecimal accountsTotal;//帐目合计	decimal		
	protected BigDecimal lastUnsettled;//上期未结	decimal		
	protected BigDecimal receivable;//	本期应收	decimal		
	protected BigDecimal creditTotaled;//往期已结
	protected Integer status;//	结算状态(0申请结算,1待审核,2待付款,3以收入,4已取消)	int		
	protected Date finishTime;//结算完成时间	timestamp		
	protected Date createTime;//创建时间	timestamp		
	protected Date updateTime;//更新时间	timestamp		
	protected Integer userId;//	商家id	int			
	protected String userName;//商家姓名	varchar(50)	50	
	/**保留小数长度	 */
	public static final Integer length = 2;
	/**默认输出值	 */
	public static final BigDecimal defaultNum = new BigDecimal(0.00).setScale(length, BigDecimal.ROUND_HALF_UP);
	
	public Integer getAccountsId() {
		return accountsId;
	}
	public void setAccountsId(Integer accountsId) {
		this.accountsId = accountsId;
	}
	public Date getClearingStartTime() {
		return clearingStartTime;
	}
	public void setClearingStartTime(Date clearingStartTime) {
		this.clearingStartTime = clearingStartTime;
	}
	public Date getClearingEndTime() {
		return clearingEndTime;
	}
	public void setClearingEndTime(Date clearingEndTime) {
		this.clearingEndTime = clearingEndTime;
	}
	public Integer getSalesQuantity() {
		return salesQuantity;
	}
	public void setSalesQuantity(Integer salesQuantity) {
		this.salesQuantity = salesQuantity;
	}
	public BigDecimal getSalesMoney() {
		return salesMoney;
	}
	public void setSalesMoney(BigDecimal salesMoney) {
		this.salesMoney = salesMoney;
	}
	public BigDecimal getReturnSales() {
		return returnSales;
	}
	public void setReturnSales(BigDecimal returnSales) {
		this.returnSales = returnSales;
	}
	public BigDecimal getReturnPro() {
		return returnPro;
	}
	public void setReturnPro(BigDecimal returnPro) {
		this.returnPro = returnPro;
	}
	public BigDecimal getUnReturnSales() {
		return unReturnSales;
	}
	public void setUnReturnSales(BigDecimal unReturnSales) {
		this.unReturnSales = unReturnSales;
	}
	public BigDecimal getFreight() {
		return freight;
	}
	public void setFreight(BigDecimal freight) {
		this.freight = freight;
	}
	public BigDecimal getServerRate() {
		return serverRate;
	}
	public void setServerRate(BigDecimal serverRate) {
		this.serverRate = serverRate;
	}
	public BigDecimal getServerMoney() {
		return serverMoney;
	}
	public void setServerMoney(BigDecimal serverMoney) {
		this.serverMoney = serverMoney;
	}
	public BigDecimal getOtherMoney() {
		return otherMoney;
	}
	public void setOtherMoney(BigDecimal otherMoney) {
		this.otherMoney = otherMoney;
	}
	public BigDecimal getStimulate() {
		return stimulate;
	}
	public void setStimulate(BigDecimal stimulate) {
		this.stimulate = stimulate;
	}
	public BigDecimal getAccountsTotal() {
		return accountsTotal;
	}
	public void setAccountsTotal(BigDecimal accountsTotal) {
		this.accountsTotal = accountsTotal;
	}
	public BigDecimal getLastUnsettled() {
		return lastUnsettled;
	}
	public void setLastUnsettled(BigDecimal lastUnsettled) {
		this.lastUnsettled = lastUnsettled;
	}
	public BigDecimal getReceivable() {
		return receivable;
	}
	public void setReceivable(BigDecimal receivable) {
		this.receivable = receivable;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getFinishTime() {
		return finishTime;
	}
	public void setFinishTime(Date finishTime) {
		this.finishTime = finishTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public BigDecimal getCreditTotaled() {
		if(creditTotaled == null)
			creditTotaled = BigDecimal.valueOf(0);
		return creditTotaled;
	}
	public void setCreditTotaled(BigDecimal creditTotaled) {
		this.creditTotaled = creditTotaled;
	}
	
}
