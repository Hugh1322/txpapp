package com.txp.app.product;

import com.txp.app.entity.Page;
import com.txp.app.system.dto.SysUser;
import com.txp.app.system.service.SysUserService;
import com.txp.app.util.CommUtils;
import com.txp.app.util.PageUtil;
import com.txp.app.util.SystemConstant;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/product")
@Slf4j
public class ProductController {

	@RequestMapping(value = "listProductSkuDetailOnline.do")
	public String listProductSkuDetailOnline(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String path = request.getContextPath();
		log.info(path);
		modelMap.put("_ctxPath",path);
		modelMap.put("_cssPath",path+"/web-resource/css");
		modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
		modelMap.put("_imagesPath",path+"/web-resource/images");
		modelMap.put("_jsPath",path+"/web-resource/js");
		return "product/searchProductSkuDetail";
	}

}
