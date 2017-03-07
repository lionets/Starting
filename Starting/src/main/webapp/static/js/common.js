

var tatongMethod = {
		partsJson:'',
		isChecked:function(){
			$(".apendhtml").remove();
			var isCheck = true;
			var errorMsg = "";
			var patrn="";
			//非法字符
/*			$("input").each(function(){
				patrn=/[#\$%\^&\~￥]+/g;
				if(patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"非法字符": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})*/
			//验证必输项
			$("[required='true']").each(function(){
				if($(this).val().trim()==""){
					errorMsg = $(this).attr("errorMsg")==undefined?"该项为必输项":$(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//手机号
			$("[vtype='phone']").each(function(){
				patrn=/1[1-9]\d{9}/; 
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"手机格式不正确(1*********)": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//email
			$("[vtype='email']").each(function(){
				patrn=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"email格式不正确(cc@**.com)": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//fax传真
			$("[vtype='fax']").each(function(){
				patrn=/^((0\d{2,3})-?)(\d{6,8})(-(\d{3,}))?$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"传真格式不正确(021-66666666)": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//telPhone
			$("[vtype='telPhone']").each(function(){
				patrn=/^((0\d{2,3})-?)(\d{7,8})(-(\d{3,}))?$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"电话格式不正确(021-66666666)": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//身份证
			$("[vtype='cardNum']").each(function(){
				patrn=/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"请输入18位身份证号": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//网址
			$("[vtype='site']").each(function(){
		         var strRegex = "^((https|http|ftp|rtsp|mms)?://)"  
		             + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@  
		             + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184  
		             + "|" // 允许IP和DOMAIN（域名） 
		             + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.  
		             + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名  
		            + "[a-z]{2,6})" // first level domain- .com or .museum  
		            + "(:[0-9]{1,4})?" // 端口- :80  
		            + "((/?)|" // a slash isn't required if there is no file name  
		            + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";  
		       patrn=new RegExp(strRegex); 
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"网址格式不正确": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//整数
			$("[vtype='integer']").each(function(){
				patrn=/^[0-9]*[1-9][0-9]*$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"请输入正整数": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			
			//邮政编码
			$("[vtype='post']").each(function(){
				patrn=/^[0-9]{6}$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"邮政编码不正确": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//英文字母
			$("[vtype='english']").each(function(){
				patrn=/^[A-Za-z][A-Za-z0-9]*$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"必须是字母": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//全中文或者数字组成
			$("[vtype='chinese']").each(function(){
				patrn=/^[\u4E00-\u9FA5][\u4E00-\u9FA5|0-9]*$/;
				if(!patrn.test($(this).val()) && $(this).val() != ""){
					errorMsg = $(this).attr("errorMsg")==undefined?"必须是中文": $(this).attr("errorMsg");
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
					isCheck = false;
				}
			})
			//
			//限制输入字符长度默认最大20个
			$("[vtype='limit']").each(function(){
					var min = $(this).attr("minLength")==undefined?0:$(this).attr("minLength");
					var max = $(this).attr("maxLength")==undefined?20:$(this).attr("maxLength");
					if($(this).val().length == 0){
						return;
					}
					if($(this).val().length<min || $(this).val().length>max){
							if($(this).next().attr("class")=="apendhtml"){
								$(this).next().remove();
							};
							patrn=/^[A-Za-z0-9]{min,max}/;
							var msg = "输入长度应在"+min+"-"+max+"位之间";
							errorMsg = $(this).attr("errorMsg")==undefined?msg: $(this).attr("errorMsg");
							$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>"+errorMsg+"</span>");
							isCheck = false;
					} 
			})
			//验证重新输入的密码是否和原始密码相同
			$("[vtype='passwordAgain']").each(function(){
				var id = $(this).attr("id");
				var pid = id.substring(0,id.length-5);
				if($(this).val() != $("#"+pid).val() && $("#"+pid)){
					$(this).after("<span class='apendhtml' style='color: red;margin-left: 5px;'>重复密码不正确</span>");
					isCheck = false;
				}
			})
			return isCheck;
		},

	//confirm确定、取消选择框,输入参数表示消息窗口title，content提示详细信息，okExecute确定时要执行的内容,取消时要执行的内容
	confirm:function(tile,content,okExecute,cancelExecute){
	    using(['messager'],function(){
	        $.messager.confirm(tile, content, function(r){
	            if(r){
	            	if(okExecute){
	            		okExecute();
	            	}
	            }else{
	            	if(cancelExecute){
	            		cancelExecute();
	            	}
	            }
	        });
	    });
	},
	alert:function(title,content,info,fn){
    	using(['messager'],function(){
    	    $.messager.alert(title,content,info,fn);
    	});
	},
	isContain:function(arr, val){
	    for(var i=0; i<arr.length; i++){
	        if(arr[i] == val)
	            return true;
	        }
	        return false;
	    }
};