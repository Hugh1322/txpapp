package com.txp.app.contants;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/** 商家结算实体
 * @author zengzhiming
 *
 */
public class SellerAccounts extends  SellerAccountsTbl{
	/**申请审核	 */
	public static final Short ACCOUNTS_STATUS_AUDITING = 0;
	
	/**待审核	 */
	public static final Short ACCOUNTS_STATUS_CHECKPENDING = 1;
	
	/**待付款	 */
	public static final Short ACCOUNTS_STATUS_PAYING = 2;
	
	/**已完成	 */
	public static final Short ACCOUNTS_STATUS_COMPLETED = 3;
	
	/**已过期	 */
	public static final Short ACCOUNTS_STATUS_CANCLE = 4;
	
	/**未通过	 */
	public static final Short ACCOUNTS_STATUS_NOPASS = 5;
	
	public String serverRateStr; 

	
	protected Integer orderId;
	
	
	public String finishTimeStr; 
	
	/**是否过期
	 * @return
	 */
	public boolean isPastDue(){
		//判断创建时间是周几
		Calendar cal=Calendar.getInstance();
		cal.setTime(this.createTime);
		Calendar now=Calendar.getInstance();
		//判断今天是否是 结算过期时间
		//如果创建时间周四(加5天)周五(加4天) 周六(加3天) 周日(加俩天)  周二过期 
		//如果是周一 周二 周三 周四 都是加俩天
		//然后再与当天比较是否为同一天 是则为过期 不是则忽略
		switch (cal.get(Calendar.DAY_OF_WEEK)) {
			case Calendar.THURSDAY://周四
				cal.add(Calendar.DAY_OF_MONTH, 4);
				break;
			case Calendar.SATURDAY://周六
				cal.add(Calendar.DAY_OF_MONTH, 3);
				break;
			case Calendar.FRIDAY://周五
				cal.add(Calendar.DAY_OF_MONTH, 4);
				break;
			default:
				cal.add(Calendar.DAY_OF_MONTH, 2);
				break;
		}
		return timeEquals(cal,now);
	}
	
	/**判断年月日是否相等
	 * @param cal
	 * @param now
	 * @return
	 */
	public boolean timeEquals(Calendar cal,Calendar now){
		if(cal==null||now==null){
			return false;
		}
		cal.set(Calendar.HOUR,0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 1);
		now.set(Calendar.HOUR,0);
		now.set(Calendar.MINUTE, 0);
		now.set(Calendar.SECOND, 0);
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		//System.out.println(sdf.format(cal.getTime())+"-"+sdf.format(now.getTime())+"===="+cal.before(now));
		return ((cal.get(Calendar.DAY_OF_MONTH)==now.get(Calendar.DAY_OF_MONTH))&&(cal.get(Calendar.YEAR)==now.get(Calendar.YEAR))&&(cal.get(Calendar.MONTH)==now.get(Calendar.MONTH)))||cal.before(now);
	}
	
	
	public FinanceAccounts converToFinanceAccounts(){
		FinanceAccounts financeAccounts = new FinanceAccounts();
		
		financeAccounts.setAccountsStartTime(getClearingStartTime());
		financeAccounts.setAccountsEndTime(getClearingEndTime());
		financeAccounts.setAccountTime(getAccountTime());
		financeAccounts.setCreateTime(new Date());
		financeAccounts.setCreditTotal(getReceivable());
		financeAccounts.setCreditTotaled(getCreditTotaled());
		financeAccounts.setDealHanding(getDealHanding());
		financeAccounts.setFreight(getFreight());
		financeAccounts.setGross(getGross());
		financeAccounts.setOtherCharge(getOtherMoney());
		financeAccounts.setReimburse(getReturnSales());
		financeAccounts.setSalesIncentive(getStimulate());
		financeAccounts.setSalesMoney(salesMoney);
		financeAccounts.setSalesQuantity(getSalesQuantity());
		financeAccounts.setSalesReturn(getReturnPro());
		financeAccounts.setSellerAccountsId(getAccountsId());
		financeAccounts.setServerCharge(getServerMoney());
		financeAccounts.setServerTariffing(getServerRate());
		financeAccounts.setStatus(Integer.valueOf(FinanceAccounts.ACCOUNTS_WATING));
		financeAccounts.setUnReturnSales(getUnReturnSales());
		financeAccounts.setUpdateTime(new Date());
		financeAccounts.setUserId(getUserId());
		financeAccounts.setUserName(getUserName());
		return financeAccounts;
	}
	/** 手续费
	 * @return
	 */
	public BigDecimal getDealHanding() {
		//服务费*1.2
		BigDecimal server =	getServerMoney();
		if(server==null||server.doubleValue()<=0.00){//如果服务费为空
			return defaultNum;
		}
		return server.multiply(new BigDecimal(FinanceAccounts.ALIPAY_TARIFFING)).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	
	public BigDecimal getGross() {
		//服务费减去交易手续费
		BigDecimal server = getServerMoney();//服务费
		BigDecimal hand = getDealHanding();//手续费
		if(server==null||server.doubleValue()<=0.00){
			return defaultNum;
		}
		return server.subtract(hand).setScale(length, BigDecimal.ROUND_HALF_UP);
	}
	
	public String getAccountTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(getClearingStartTime()==null||getClearingEndTime()==null){
			return null;
		}
		return sdf.format(getClearingStartTime())+"至"+sdf.format(getClearingEndTime());
	}
	
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getServerRateStr() {
		serverRate = serverRate.multiply(BigDecimal.valueOf(100));
		serverRateStr = serverRateStr + "";
		return serverRateStr;
	}

	public void setServerRateStr(String serverRateStr) {
		this.serverRateStr = serverRateStr;
	}

	
	public String getFinishTimeStr() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(getFinishTime() == null)
			return "";
		else
			return sdf.format(finishTime);
	}

	public void setFinishTimeStr(String finishTimeStr) {
		this.finishTimeStr = finishTimeStr;
	}

	public static void main(String[] args) {
		BigDecimal a = BigDecimal.valueOf(0.05);
		a = a.multiply(BigDecimal.valueOf(100));
		System.out.println(a.intValue());
	}
	
}
