package com.txp.app.contants;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;


/**财务结算
 * @author zengzhiming
 *
 */
public class FinanceAccountsTbl {


	/**保留小数长度	 */
	public static final Integer length = 2;
	/**默认输出值	 */
	public static final BigDecimal defaultNum = new BigDecimal(0.00).setScale(length, BigDecimal.ROUND_HALF_UP);
	
	protected Integer accountsId;//	主键	int		
	protected Integer userId;//	商家id	int			
	protected Date accountsStartTime;//	结算开始时间	timestamp		
	protected Date accountsEndTime;//	结算结束时间	timestamp		
	protected Date createTime;//	创建时间	timestamp		
	protected Date updateTime;//	更新时间	timestamp		
	protected Integer status;//	结算状态(0待审核,1代付款,2已取消,3审核不通过)	int		
	protected Integer sellerAccountsId;//	商家结算对应id	int	
	protected String accountTime;//结算时间
	protected String userName;//	商家姓名	varchar(50)	50	
	protected Integer salesQuantity;//	商品销售数量	int		
	protected BigDecimal salesMoney;//	商品销售收入	decimal	
	protected BigDecimal reimburse;//	退款	decimal		
	protected BigDecimal salesReturn;//	退货	decimal	
	protected BigDecimal unReturnSales;//	退货退款之后的收入	decimal	
	protected BigDecimal freight;//	运费	decimal
	protected BigDecimal serverTariffing;//	服务费率	decimal	
	protected BigDecimal serverCharge;//	服务费	decimal	
	protected BigDecimal otherCharge;//	应收其它费用	decimal	
	protected BigDecimal salesIncentive;//	应付销售激励	decimal	
	protected BigDecimal creditTotal;//应付账款合计	decimal	
	protected BigDecimal creditTotaled;//	已结算账单	decimal		
	protected BigDecimal dealHanding;//	手续费	decimal
	protected BigDecimal gross;//	净收入	decimal		

	
	
	
	
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
	public String getAccountTime() {
		return accountTime;
	}
	public void setAccountTime(String accountTime) {
		this.accountTime = accountTime;
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
	public BigDecimal getReimburse() {
		return reimburse;
	}
	public void setReimburse(BigDecimal reimburse) {
		this.reimburse = reimburse;
	}
	public BigDecimal getSalesReturn() {
		return salesReturn;
	}
	public void setSalesReturn(BigDecimal salesReturn) {
		this.salesReturn = salesReturn;
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
	public BigDecimal getServerTariffing() {
		return serverTariffing;
	}
	public void setServerTariffing(BigDecimal serverTariffing) {
		this.serverTariffing = serverTariffing;
	}
	public BigDecimal getServerCharge() {
		return serverCharge;
	}
	public void setServerCharge(BigDecimal serverCharge) {
		this.serverCharge = serverCharge;
	}
	public BigDecimal getOtherCharge() {
		return otherCharge;
	}
	public void setOtherCharge(BigDecimal otherCharge) {
		this.otherCharge = otherCharge;
	}
	public BigDecimal getSalesIncentive() {
		return salesIncentive;
	}
	public void setSalesIncentive(BigDecimal salesIncentive) {
		this.salesIncentive = salesIncentive;
	}
	public BigDecimal getCreditTotal() {
		return creditTotal;
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
	public BigDecimal getDealHanding() {
		return dealHanding;
	}
	public void setDealHanding(BigDecimal dealHanding) {
		this.dealHanding = dealHanding;
	}
	public BigDecimal getGross() {
		return gross;
	}
	public void setGross(BigDecimal gross) {
		this.gross = gross;
	}
	
	
	
	
}
