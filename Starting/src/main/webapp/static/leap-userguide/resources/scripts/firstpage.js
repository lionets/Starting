/* 代码整理：懒人之家 www.lanrenzhijia.com */


$(function () {
	
 $('#expandZone0').css('height', '46px');

  $('#wai_box').on('click', '.images', function(event) {
	$("#wai_box div ul li").siblings().find("span").slideDown("normal"); // Slide up all sub menus except the one clicked
 //  $("#wai_box div ul li").siblings().find("p").animate({backgroundColor: 'none'}); // Slide up all sub menus except the one clicked
 //  $(this).find("p").animate({backgroundColor: 'none'}); 
	$(this).find("span").slideUp("normal"); 
	

   
  var curIndex = $(this).val();
 mlValue = '-' + ( curIndex - 1 ) * 46  + 'px';
		 
    if( $('#expandZone').hasClass('active')  ){
      $('#expandZone .download').animate({marginTop: mlValue});
    }
    else{
      $('#expandZone .download').css({marginTop: mlValue });
    }
    var device = $(this).data('device');
    $(this).addClass('btn-active').siblings().removeClass('btn-active');
    $(device).addClass('item-active').siblings().removeClass('item-active');
    $('#expandZone').animate({height: '46px'}).addClass('active');
     $('#expandZone0').animate({height: '0px'}, function () {
      $('#expandZone0').removeClass('active');})
	 $('#expandZone1').animate({height: '0px'}, function () {
      $('#expandZone1').removeClass('active');})
    return false;
  });

  $('#expandZone #closeBtn').on('click', function() {
    $('#expandZone').animate({height: '0px'}, function () {
      $(this).removeClass('active');

      $('#navList .btn-active').removeClass('btn-active');
    });
    return false;
  });
});



$(document).ready(function(){
		
		
		//显示子模块
		$show.find("#asset").hover(function(){
			$(this).find("#stock").fadeIn();								  
			},function(){
				$(this).find("#stock").fadeOut();
				})
		function nav(){
			if(page==1){
				$("#firstpage").find(".pre").hide().siblings(".next").show();
			}else if(page==page_count){
				$("#firstpage").find(".next").hide().siblings(".pre").show();
			}else{
				$("#firstpage").find(".pre").show().siblings(".next").show();
			}
		}
		$("#firstpage").find(".next").click(function(){
			//首先判断展示区域是否处于动画
			if(!$show.is(":animated")){
				$show.animate({left:'-='+$width_box},"normal");
				page++;
				nav();
				$number=page-1;
				$("#firstpage").find(".nav a:eq("+$number+")").addClass("now").siblings("a").removeClass("now");
				return false;
			}
		})
		$("#firstpage").find(".pre").click(function(){
		if(!$show.is(":animated")){
			$show.animate({left:'+='+$width_box},"normal");
			page--;
			nav();
			$number=page-1;
			$("#firstpage").find(".nav a:eq("+$number+")").addClass("now").siblings("a").removeClass("now");
			}
			return false;
		})
		$("#firstpage").find(".nav a").click(function(){
				$index=$(this).index();
				page=$index+1;
				nav();
				$show.animate({left:-($width_box*$index)},"normal");	
				$(this).addClass("now").siblings("a").removeClass("now");
				return false;
		})
						   
});
//expandZone
