package com.txp.app.interceptor;

import com.txp.app.util.SystemConstant;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 登录拦截器
 *
 * @author tianhu
 */
@Slf4j
public class SecurityInterceptor implements HandlerInterceptor {
	@Value("${web_page_login_url}")
	private String web_page_login_url;

	/**
	 * 预处理
	 */
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		String uri = request.getRequestURI();
//		// 如果请求路径中包含appCheckLogin说明此接口需要验证登录
//		HttpSession session = request.getSession();
//		if (uri.indexOf("/checkLoginBEnd") > 0) {
//			String loginToken = request.getParameter("loginToken");
//			AppResult<MerchantBEndDto> appResult = merchantBEndService.getBorrowerByToken(loginToken);
//			if (appResult.isSuccess()) {
//				MerchantBEndDto merchantBEndDto = appResult.getResult();
//				if (merchantBEndDto != null) {
//					session.setAttribute(SessionVarsConstantsBEnd.CUR_USER_TOKEN, loginToken);
//					session.setAttribute(SessionVarsConstantsBEnd.CUR_USER_ID, merchantBEndDto.getMerchantId());
//					session.setAttribute(SessionVarsConstantsBEnd.CUR_USER, merchantBEndDto);
//					return true;
//				}
//			}
//			Long merchantId = (Long)session.getAttribute(SessionVarsConstantsBEnd.CUR_USER_ID);
//			boolean needLogin = checkLoginBEndService.checkLogin(merchantId, session.getId());
//			if (needLogin){
//				needLogin(request, response);
//				return false;
//			}
//			String token = (String) session.getAttribute(SessionVarsConstantsBEnd.CUR_USER_TOKEN);
//			if (StringUtil.isNotEmpty(token)) {
//				return true;
//			}
//
//			log.info("【商户】传递的loginToken：" + loginToken + ",session中的appToken：" + token);
//			log.info("【商户】request：" + request + ",session中：" + session);
//			needLogin(request, response);
//			return false;
//		}
//		return true;
//	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		// 如果请求路径中包含appCheckLogin说明此接口需要验证登录
		HttpSession session = request.getSession();
		log.info("SecurityInterceptor.. preHandle.. start");
		if (uri.indexOf("test/user/login.do") < 0 && uri.indexOf("system/user/index.do") < 0
				&& uri.indexOf("system/user/getVerifyCode.do") < 0) {
			if(session.getAttribute(SystemConstant.SESSION_USER)==null) {
				response.sendRedirect(web_page_login_url);
				return false;
			}
		}
		return true;
	}

//	private void needLogin(HttpServletRequest request, HttpServletResponse response) throws IOException{
//		String requestURI = request.getRequestURI();
//		if (!isToLogin(requestURI)) {// 登录失效返回json
//			response.setContentType("application/json");
//			response.setCharacterEncoding("UTF-8");
//			// 如果回话中没有登录的信息那么直接返回。
//			AppResult<Object> result = new AppResult<Object>();
//			AppResultUtil.setResult(result, AppResultConstant.NOT_LOGIN);
//			JSONObject jsonObject = JSONObject.fromObject(result);
//			response.getWriter().write(jsonObject.toString());
//		} else {// 登录失效重定向登录页
//			response.sendRedirect(web_page_login_url);
//		}
//	}

	/**
	 * 返回处理
	 */
	@Override
	public void postHandle(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, ModelAndView mav)
			throws Exception {
	}

	/**
	 * 后处理
	 */
	@Override
	public void afterCompletion(HttpServletRequest hsr, HttpServletResponse hsr1, Object o, Exception excptn)
			throws Exception {
	}

	/**
	 * 登录失效是否跳转登录页面，否则返回json数据
	 *
	 * @param url
	 * @return
	 */
	private boolean isToLogin(String url) {
		boolean toLoginBool = false;
		if (StringUtils.isNotEmpty(url)) {
			List<String> toLoginUrlList = getToLoginUrl();
			if (toLoginUrlList != null) {
				for (String toLoginUrl : toLoginUrlList) {
					if (url.contains(toLoginUrl)) {
						toLoginBool = true;
					}
				}
			}
		}
		return toLoginBool;
	}

	private List<String> getToLoginUrl() {
		List<String> toLoginUrlList = new ArrayList<>();
		toLoginUrlList.add("/appCheckLogin/toLianlianSignPage");
		return toLoginUrlList;
	}
}
