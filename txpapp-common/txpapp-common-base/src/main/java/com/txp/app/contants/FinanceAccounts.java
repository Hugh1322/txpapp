package com.txp.app.contants;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

/**财务结算实体
 * @author zengzhiming
 *
 */
public class FinanceAccounts extends FinanceAccountsTbl {
	
	/**商家	 */
	private SellerAccounts  sa;
	
	/**服务费率	 */
	public static final Double SERVER_TARIFFING = 0.05;
	
	/**支付宝手续费率	 */
	public static final Double ALIPAY_TARIFFING = 0.012;
	
	//	结算状态(0待审核,1代付款,2已取消,3审核不通过)	int	
	
	/**待审核	 */
	public static final Short ACCOUNTS_WATING = 0;
	/**代付款	 */
	public static final Short ACCOUNTS_PAY = 1;
	/**已取消	 */
	public static final Short ACCOUNTS_CANCLE = 2;
	/**审核不通过	 */
	public static final Short ACCOUNTS_NOPASS = 3;
	/**已经结算	 */
	public static final Short ACCOUNTS_FINISH = 4;
	
	protected String serverChargeStr;
	
	/**总结算	 */
	protected BigDecimal totalPay;
	
	
	
	
	public BigDecimal getTotalPay() {
		return totalPay;
	}
	public void setTotalPay(BigDecimal totalPay) {
		this.totalPay = totalPay;
	}
	public SellerAccounts getSa() {
		return sa;
	}
	public void setSa(SellerAccounts sa) {
		this.sa = sa;
	}
	public String getServerChargeStr() {
		return (0.05*100.00)+"%";
	}
	public void setServerChargeStr(String serverChargeStr) {
		this.serverChargeStr = serverChargeStr;
	}

	/**结算时间
	 * @return
	 */
	public String getAccountTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(accountsStartTime==null||accountsEndTime==null){
			return null;
		}
		return sdf.format(accountsStartTime)+"至"+sdf.format(accountsEndTime);
	}
	public void setAccountTime(String accountTime) {
		this.accountTime = accountTime;
	}
	public Integer getAccountsId() {
		return accountsId;
	}
	public void setAccountsId(Integer accountsId) {
		this.accountsId = accountsId;
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
	/**退款
	 * @return
	 */
	public BigDecimal getReimburse() {
		if(this.reimburse==null||this.reimburse.doubleValue()<=0.00){
			return  defaultNum;
		}
		return reimburse;
	}
	public void setReimburse(BigDecimal reimburse) {
		this.reimburse = reimburse;
	}
	
	/**退货
	 * @return
	 */
	public BigDecimal getSalesReturn() {
		if(this.salesReturn==null||this.salesReturn.doubleValue()<=0.00){
			return  defaultNum;
		}
		return salesReturn;
	}
	
	public void setSalesReturn(BigDecimal salesReturn) {
		this.salesReturn = salesReturn;
	}
	/**退货退款后收入
	 * @return
	 */
	public BigDecimal getUnReturnSales() {
		if(this.salesMoney==null||this.salesMoney.doubleValue()<=0.0){//如果总受收入为null 或为0
			return defaultNum;
		}else{
			//如果不为null 则返回 总收入减去退货退款
			BigDecimal returnM = new BigDecimal(0.00);
			if(this.reimburse !=null){
				returnM = returnM.add(this.reimburse);
			}
			if(this.salesReturn!=null){
				returnM = returnM.add(this.salesReturn);
			}
			return this.salesMoney.subtract(returnM).setScale(length, BigDecimal.ROUND_HALF_UP);
		}
	}
	public void setUnReturnSales(BigDecimal unReturnSales) {
		this.unReturnSales = unReturnSales;
	}
	public BigDecimal getFreight() {
		if(freight==null||freight.doubleValue()<=0.00){
			return defaultNum;
		}
		return freight;
	}
	public void setFreight(BigDecimal freight) {
		this.freight = freight;
	}
	/** 服务费率
	 * @return
	 */
	public BigDecimal getServerTariffing() {
		return new BigDecimal(FinanceAccounts.SERVER_TARIFFING).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	public void setServerTariffing(BigDecimal serverTariffing) {
		this.serverTariffing = serverTariffing;
	}
	/**服务费
	 * @return
	 */
	public BigDecimal getServerCharge() {
		//服务费是通过 退款退货后的实际收入乘以服务费率
		BigDecimal income = getUnReturnSales();
		if(income == null||income.doubleValue()<=0.00){
			return defaultNum;
		}
		return income.multiply(getServerTariffing()).setScale(length, BigDecimal.ROUND_HALF_UP) ;
	}
	public void setServerCharge(BigDecimal serverCharge) {
		this.serverCharge = serverCharge;
	}
	public BigDecimal getOtherCharge() {
		//return otherCharge;
		return defaultNum;
	}
	public void setOtherCharge(BigDecimal otherCharge) {
		this.otherCharge = otherCharge;
	}
	public BigDecimal getSalesIncentive() {
		if(salesIncentive==null||salesIncentive.doubleValue()<=0.00){
			return defaultNum;
		}
		return salesIncentive;
	}
	public void setSalesIncentive(BigDecimal salesIncentive) {
		this.salesIncentive = salesIncentive;
	}
	/**本时间段应付账款合计
	 * @return
	 */
	public BigDecimal getCreditTotal() {
		//退款退货 + 运费 -(销售激励+服务费)
		BigDecimal income = getUnReturnSales();
		if(income==null||income.doubleValue()<=0.00){
			return defaultNum;
		}
		return income.add(getFreight()).subtract(getSalesIncentive().add(getServerCharge())).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	public void setCreditTotal(BigDecimal creditTotal) {
		this.creditTotal = creditTotal;
	}
	public BigDecimal getCreditTotaled() {
		return creditTotaled;
	}
	public void setCreditTotaled(BigDecimal creditTotaled) {
		this.creditTotaled = creditTotaled;
	}
	/** 手续费
	 * @return
	 */
	public BigDecimal getDealHanding() {
		//服务费*1.2
		BigDecimal unReturnSales =	getUnReturnSales();
		if(unReturnSales==null||unReturnSales.doubleValue()<=0.00){//如果服务费为空
			return defaultNum;
		}
		return unReturnSales.multiply(new BigDecimal(FinanceAccounts.ALIPAY_TARIFFING)).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	public void setDealHanding(BigDecimal dealHanding) {
		this.dealHanding = dealHanding;
	}
	/**净收入
	 * @return
	 */
	public BigDecimal getGross() {
		//服务费减去交易手续费
		BigDecimal server = getServerCharge();//服务费
		BigDecimal hand = getDealHanding();//手续费
		if(server==null||server.doubleValue()<=0.00){
			return defaultNum;
		}
		return server.subtract(hand).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	public void setGross(BigDecimal gross) {
		this.gross = gross;
	}
	public Date getAccountsStartTime() {
		return accountsStartTime;
	}
	public void setAccountsStartTime(Date accountsStartTime) {
		this.accountsStartTime = accountsStartTime;
	}
	public Date getAccountsEndTime() {
		return accountsEndTime;
	}
	public void setAccountsEndTime(Date accountsEndTime) {
		this.accountsEndTime = accountsEndTime;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getSellerAccountsId() {
		return sellerAccountsId;
	}
	public void setSellerAccountsId(Integer sellerAccountsId) {
		this.sellerAccountsId = sellerAccountsId;
	}
	
	
	
}
