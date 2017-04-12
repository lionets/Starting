package cn.com.start.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.ExceptionHandlerExceptionResolver;

@Controller
public class BaseController {
	
	private static Logger logger = LoggerFactory.getLogger(BaseController.class);
	
	@RequestMapping("/index")
	public String init(){
		
		return "index";
	}
	
	@RequestMapping(value = "/ajaxMethod")
	public void getAdvertisement(HttpServletRequest request,HttpServletResponse response){
		PrintWriter out = null;
		Map<String, Object> param = null;
		Map<String, Object> result = new HashMap<String, Object>();
		response.setContentType("text/html;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		try {
			out = response.getWriter();
			//200 状态为接口正确调用
			result.put("Status", 200);
			result.put("Info", "Ad data acquisition success");
			result.put("Message", "广告数据获取成功");
			//获取广告数据
			result.put("Result", "1111111");
			logger.error("==== at AppCommonController the getAdvertisement method:123",new ExceptionHandlerExceptionResolver());
		} catch (Exception e) {
			result.put("Status", 300);
			result.put("Info", "System busy, please wait...");
			result.put("Message", "系统忙碌中，请稍候...");
			result.put("Result", null);
			logger.error("==== at AppCommonController the getAdvertisement method:",e);
		}finally{
			out.write(JSONArray.fromObject(result).toString());
			out.flush();
			out.close();
		}
	}
	
	@RequestMapping(value = "/suiNav")
	public String suiNav(HttpServletRequest request){
		
		return "study/index";
	}

}
