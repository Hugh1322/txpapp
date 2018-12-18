package com.txp.app.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author
 *
 */
@Component
@Slf4j
public class PathInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String path = request.getContextPath();
        log.info("preHandle::"+path);
        request.getSession().setAttribute("_ctxPath",path);
        request.getSession().setAttribute("_treePath",path+"/treeview");
        request.getSession().setAttribute("_cssPath",path+"/web-resource/css");
        request.getSession().setAttribute("_cssPagesPath",path+"/web-resource/css/pages");
        request.getSession().setAttribute("_imagesPath",path+"/web-resource/images");
        request.getSession().setAttribute("_jsPath",path+"/web-resource/js");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
