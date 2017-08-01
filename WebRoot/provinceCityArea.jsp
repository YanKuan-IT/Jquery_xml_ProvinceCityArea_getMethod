<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>jQuery解析xml</title>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
  </head>
  <body>
	
	<select id="province">
		<option>请选择省份</option>
	</select>
	<select id="city">
		<option>请选择城市</option>
	</select>
	<select id="area">
		<option>请选择县区</option>
	</select>
	
	<!-- 
		自动加载省份 
	-->
	<script type="text/javascript">
		$(function(){
			var url ="${pageContext.request.contextPath}/provinceCityArea.xml?time="+new Date().getTime();
			var sendData = null;
			$.get(url,sendData,function(xml){
				var $xml = $(xml).find("province");
				$xml.each(function(){
					var province = $(this).attr("name")
					var $option = $("<option>"+province+"</option>")
					$("#province").append($option)
				})
			})
		})
	</script>
	<!-- 
		加载城市
	-->
	<script type="text/javascript">
		$("#province").change(function(){
			$("#city option:gt(0)").remove();
			$("#area option:gt(0)").remove();
			var province = $("#province option:selected").text();
			if("请选择省份"!=province){
				var url ="${pageContext.request.contextPath}/provinceCityArea.xml?time="+new Date().getTime();
				var sendData = null;
				$.get(url,sendData,function(xml){
					var $xml = $(xml).find("province[name='"+province+"']").find("city");
					$xml.each(function(){
						var city = $(this).attr("name")
						var $option = $("<option>"+city+"</option>")
						$("#city").append($option)
					})
				})
			}
		})
	</script>
	<!-- 
		加载县区 
	-->
	<script type="text/javascript">
		$("#city").change(function(){
			$("#area option:gt(0)").remove();
			var province = $("#province option:selected").text();
			var city = $("#city option:selected").text();
			if("请选择城市"!=city){
				var url ="${pageContext.request.contextPath}/provinceCityArea.xml?time="+new Date().getTime();
				var sendData = null;
				$.get(url,sendData,function(xml){
					var $xml = $(xml).find("province[name='"+province+"']").find("city[name='"+city+"']").find("area");
					$xml.each(function(){
						var area = $(this).attr("name");
						var $option = $("<option>"+area+"</option>")
						$("#area").append($option)
					})
				})
			}
		})
	</script>
  </body>
</html>
  