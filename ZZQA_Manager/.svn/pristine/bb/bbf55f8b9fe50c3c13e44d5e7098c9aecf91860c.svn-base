/***
 * 已弃用
 */
//定时刷新并回到当且滚动位置
var refreshEvent;
$(function () {
	function Trim(strValue) {
		return strValue.replace(/^\s*|\s*/g, "");
	}
	function SetCookie(sName, sValue) {
		document.cookie = sName + "=" + escape(sValue);
	}
	function GetCookie(sName) {
		var aCookie = document.cookie.split(";");
		for (var i = 0; i < aCookie.length; i++) {
			var aCrumb = aCookie[i].split("=");
			if (sName == Trim(aCrumb[0])) {
				return unescape(aCrumb[1]);
			}
		}
		return null;
	}
	function scrollback() {
		if (GetCookie("scroll") != null) {
			document.documentElement.scrollTop = GetCookie("scroll");
			SetCookie("scroll", 0);
		}
	}
	myrefresh=function myrefresh() {
		SetCookie("scroll", document.documentElement.scrollTop);
		//alert(document.documentElement.scrollTop);
		window.location.reload();
	};
	scrollback();
	//不加引号立即执行
	startRefresh();//开始计时刷新
	resetRefresh();
});
function startRefresh(){
	refreshEvent=setTimeout('myrefresh()',30*60*1000);//30分钟
}
function resetRefresh(){
	if(refreshEvent){
		clearTimeout(refreshEvent);
		startRefresh();
	}//重置刷新
}

