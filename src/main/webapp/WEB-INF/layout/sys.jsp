<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title /></title>
    <!-- 设置根路径 -->
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <%@ include file="/WEB-INF/common/common-js-style.jsp"%>
    <%@ include file="/WEB-INF/common/table-js-style.jsp"%>
    <%@ include file="/WEB-INF/common/less-common-js-style.jsp"%>
    <%@ include file="/WEB-INF/common/tree-js-style.jsp"%>
    <%@ include file="/WEB-INF/common/custom-js-style.jsp"%>
    <%@ include file="/WEB-INF/common/backtop.jsp"%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta http-equiv="Cache-Control" content="no-store" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <link rel="stylesheet" href="${ctx}/static/bootstrap/3.3.0/css/main-style.css" type="text/css" />
    <link rel="stylesheet" href="${ctx}/static/jquery/css/jquery.alerts.css" type="text/css" />
    <script type="text/javascript" src="${ctx}/static/jquery/js/jquery.alerts.js"></script>
    <sitemesh:head />
</head>
<body>
<div id="screenWidth" class="container">

    <div  id="fixTopDiv" class="bs-navbar-fixed-top" >
        <div class="topPic topPicportal">
        </div>
        <div id="wrap"  style="background:#FFFFFF;">
            <div id="topnavbar">
                <div id="topnanv">
                    <nav style="margin:0 auto;max-width:1350px;">
                        <div id="dynamicMenu">
                            <ul class="left-posbox"><li class="dropdown">
                                <a href="${ctx}/index" class="" data-toggle="" style="background-color:#00036a;">首页</a></li></ul>
                        </div>
                        <ul class="nav navbar-nav pull-right right-posbox">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-color:#00036a;">
                                    <i class="glyphicon glyphicon-user"></i>
                                    <shiro:principal property="name" />
                                    <b class="caret"></b>
                                </a>
                                <ul class="dropdown-menu" style="margin:15px 0px;min-width:100px;">
                                    <li><a href="javascript:{}" onclick="goTo('${ctx}/logout');">退出系统</a></li>
                                </ul>
                            </li>
                        </ul>

                        <ul class="nav navbar-nav pull-right right-posbox">
                            <li class="dropdown">
                                <a href="#" style="background-color:#00036a;" onclick="goTo('${ctx}/index');">返回</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <br style="clear: both;" />
            </div>
    </div>

        <div style="background:#fff;height:2px">&nbsp;</div>
        <div id="header" style="margin-top: 5px">
            <figure > <!-- class="header-logo" -->
                <a href="${ctx}/login"> <img src="${ctx}/static/banshion/images/main.jpg" width="98%" height="150px"  /></a>
            </figure>
        </div>

        <div id="clearFixTop" class="row" style="margin:0px 15px;min-height:1410px;">
            <div id="main-content">
                <ul class="breadcrumb" id="breadcrumb" style="display: none;"></ul> <!-- 导航路径 -->
                <sitemesh:body />
            </div>
        </div>
    <footer class="footer" style="text-align: center;clear:both;">
        Copyright © 2016-2017.  Banshion.  All rights reserved
    </footer>
</div>
</div>
</body>
<script type="text/javascript">

    //定义全局的变量
    var publicPath = "${ctx}";

    $(document).ready(function(){
        var timebak = new Date().getTime();
        $.getJSON(
            '<c:url value="/sys/menu/menuTree?time='+timebak +'"/>',
            {
                param : "sanic"
            },
            function(data) {
                var downItem = new Array();
                var menu = $("#dynamicMenu");

                //此处返回的data已经是json对象   循环 记录 构建
                $.each(
                    data,
                    function(idx, item) {
                        var parentId = item['parentId'] ;
                        var mu_name = item['name'];
                        var mu_id = item['id'];
                        var mu_target = item['url'];
                        //如果是模块    则显示到横排菜单中
                        if (parentId == '0') {

                            this.data = new Object();

                            var ul = $("<ul class='left-posbox'></ul>");
                            var li = $(" <li class='dropdown'></li>");

                            var hrefStr = "<a href='#' class='dropdown-toggle' data-toggle='dropdown' style='background-color:#00036a;'>"
                                + mu_name
                                + "<b class='caret'></b></a>";
                            var href = $(hrefStr);

                            var subulstr = "<ul class='dropdown-menu' style='margin:15px 0px;z-index:1000' id='menu_"+ mu_id +"'></ul>";
                            var ul_sub = $(subulstr);

                            ul.append(li.append(href).append(href).append(ul_sub));

                            menu.append(ul);
                            return true;//同countinue，返回false同break
                        }
                        var menu_it = new Object();

                        var clickStr = mu_target==null?"onclick='dis(this);'":"onclick='goTo(\"${ctx}"+ mu_target+"\");'";
                        var menuItem = "<li id='menu_item"  + mu_id +  "' ><a href='javascript:{}' "+clickStr+">"
                            + mu_name
                            + "</a></li>";

                        menu_it["li"] = menuItem;
                        menu_it["pid"] = parentId;

                        downItem.push(menu_it);

                    });

                $.each(downItem,
                    function(idx, item) {
                        var pid = item.pid;
                        var findStr = "#menu_"
                            + pid;
                        var e_li = $(item.li);
                        menu.find(findStr)
                            .append(e_li);

                        // 三级菜单
                        $.each(
                            data,
                            function(idx, item) {
                                var pId = item['parentId'];
                                var m_name = item['name'];
                                var m_id = item['id'];
                                var m_target = item['url'];
                                if ( e_li.attr("id").replace('menu_item','') == pId && pId != '0'){
                                    e_li.addClass("dropdown-submenu");
                                    if ( $('#level3_' + pId)  && $('#level3_' + pId).length > 0 ){
                                        //alert(1);
                                    }else{
                                        //alert(2);
                                        e_li.append( '<ul id="level3_'+pId+'" class="dropdown-menu"></ul>' );
                                    }

                                    $('#level3_' + pId ).append('<li id="sub_item'+ m_id
                                        + '"><a href="javascript:{}"  onclick="goTo(\'${ctx}'+ m_target+ '\');">'
                                        + m_name
                                        + '</a></li>');
                                }

                            }
                        );
                    });
            });


        var u = window.location.href ;
        u = u.substr( u.indexOf(publicPath) + publicPath.length , u.length);
        $.ajax({
            type: "post",
            url:'${ctx}/sys/menu/menuFullName',
            dataType: "json",
            data:{url:u},
            cache:false,
            async:false,
            success: function(ret){
                if(ret && ret.success && ret.content){
                    $('.breadcrumb').html(ret.content);
                    $('.breadcrumb').show();
                }else{
                    $('.breadcrumb').hide();
                }
            },
            failure:function (result) {
                $('.breadcrumb').show();
            }
        });

    });

    // 停止事件冒泡
    function dis(e){
        window.event.stopPropagation();
        return false;
    }

</script>
</html>