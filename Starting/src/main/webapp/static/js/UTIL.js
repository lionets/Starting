
////////////////////工具方法/////////////////////////

/**
 * syc 同步异步开关,true 同步，false 异步。
 */
function _Ajax(url, call, params, syc) {
	var flag = false;
	var contentLength = params ? params.length : 0;
	var xmlh = getRequest();
	if (/\?/.test(url)) {
		url = url + "&timeStamp=" + new Date().getTime();
	} else {
		url = url + "?timeStamp=" + new Date().getTime();
	}
    
    //打开连接
	xmlh.open("POST", url, false);
    
    //设置头信息
	xmlh.setRequestHeader("Content-Length", contentLength);
	xmlh.setRequestHeader("CONTENT-TYPE", "application/x-www-form-urlencoded");
    
    //设置回调函数
	xmlh.onreadystatechange = function () {
		if (xmlh.readyState == 4) {
			if (xmlh.status == 200) {
				var txt = xmlh.responseText;
				if (call) {
					call(txt);
					flag = true;
				}
			}
		}
	};
	xmlh.send(params);
	if (syc) {
		while (flag) {
			return params;
		}
	}
}
function getRequest() {//创建XMLHttpRequest对象
	var req;
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		if (window.ActiveXObject) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		} else {
			alert("\u4e0d\u80fd\u521b\u5efaXMLHttpRequest\u5bf9\u8c61\uff01");
		}
	}
	return req;
}
/**
 * 判断字符串是否为空字符
 */
function isEmpty(obj) {
	if (obj == null || obj == "" || obj.length < 1 || "undefined" == typeof obj) {
		return true;
	} else {
		return false;
	}
}
String.prototype.Trim = function() 
	{ return this.replace(/(^\s*)|(\s*$)/g, ""); }  
	String.prototype.LTrim = function() 
	{ return this.replace(/(^\s*)/g, ""); }  
	String.prototype.RTrim = function() 
	{ return this.replace(/(\s*$)/g, ""); }
	
	/**
	*check email
	*/
 function checkemail(str)   
	{   
	   var result=str.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);   
	   if(result==null) {
	    return false;   
	   }
	    return true;   
	}
	/**
	*check 手机号
	*/
	function checkphone(str){
		var result=str.match(/^1[0-9][0-9]\d{4,8}$/);   
		   if(result==null) {
		    return false;   
		   }
	    return true;
	}	
	/**
	*check 座机号码
	*/
	function checkPhone(str){
		var phoneRegWithArea = str.match( /^[0][0-9]{2,4}-[0-9]{5,10}$/);
		if(phoneRegWithArea==null){
			return false;
		}
		return true;
	}
	
	
	
	
	
	
	
	
	
