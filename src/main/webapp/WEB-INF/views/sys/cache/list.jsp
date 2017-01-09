<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
    <title>缓存管理</title>
</head>
<body>
<div id="alert" class="alert alert-danger" hidden>
    <strong>Oh snap!</strong>
</div>
<div id="message" class="alert alert-success" hidden>
    <button data-dismiss="alert" class="close">&times;</button>
    <span id="messageSpanId"></span>
</div>

<div id="jqgrid">
    <table id="grid"></table>
    <div id="pager"></div>
</div>

<div id='dialog-delete' class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">删除</h4>
            </div>
            <div class="modal-body">
                <p>此操作会影响系统性能，是否确定清空？</p>
            </div>
            <div class="modal-footer">
                <button type="button" id ='cancel2' class="btn btn-default btn-sm" tabindex="1001">取消</button>
                <button type="button" id ='do_delete' class="btn btn-primary btn-sm" tabindex="1000">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    $(function(){
        var option = {
            url : '${ctx}/sys/cache/list',
            datatype : 'json',
            mtype : 'POST',
            colNames : [ '名字','缓存使用数量','缓存利用次数'],
            colModel : [
                {name : 'name',  index : 'name', align:'left',sortable : false},
                {name : 'use', index : 'use', align:'left',sortable : false},
                {name : 'hit', index : 'hit', align:'left',sortable : false}
            ],

            height : "100%",
            autowidth : true,
            pager : '#pager',
            altRows:true,
            hidegrid : false,
            viewrecords : true,
            recordpos : 'left',
            sortorder : "desc",
            emptyrecords : "没有可显示记录",
            loadonce : false,
            multiselect:true,
            loadComplete : function() {},
            jsonReader : {
                root : "rows",
                page : "page",
                total : "total",
                records : "records",
                repeatitems : false,
                cell : "cell",
                id : "id"
            }
        };
        $("#grid").jqGrid(option);
        $("#grid").jqGrid('navGrid', '#pager', {edit : false, add : false, del : false, search : false,	position : 'right'})
//         .navButtonAdd('#pager',{caption:"新增",buttonicon:"ui-icon-plus",onClickButton: function(){toAdd()},position:"last"})
//         .navButtonAdd('#pager',{caption:"修改",buttonicon:"ui-icon-pencil",onClickButton: function(){toModify()},position:"last"})
         .navButtonAdd('#pager',{caption:"清空选中",buttonicon:"ui-icon-trash",onClickButton: function(){toDelete()},position:"last"});
        //自适应
        jqgridResponsive("grid",false);
        //取消按钮操作
        $('#cancel').click(function(){
            $('#dialog-confirm').modal('hide');
        });

        $('#cancel2').click(function(){
            $('#dialog-delete').modal('hide');
        });


        //删除一条记录操作
        $('#do_delete').click(function(){
            var _ids = $("#grid").jqGrid('getGridParam','selarrrow');
            if($.isEmptyObject(_ids)) {
                openError('请选择一条数据',2000);
                return;
            }

            $("#do_delete").attr("disabled",true);
            var str='';
            for(var i=0; i<_ids.length; i++ ){
                var name = $("#grid").getCell( _ids[i] , 'name' );

                if(str!=''){str +=','+name;
                }else{str +=name;}
            }
            //开始执行删除动作
            $.post("${ctx}/sys/cache/cleanByName",
                {Names :str },
                function(data){
                    $("#grid").trigger("reloadGrid", {page:1 });

                    $('#dialog-delete').modal('hide');
                    var message = "删除失败！";
                    if(data){
                        message = "删除成功！";
                    }
                    showResult(data,message);
                },
                "json");
        });

        //弹出删除对话框
        function toDelete(){
            var ids = $("#grid").jqGrid('getGridParam','selarrrow');
            if($.isEmptyObject(ids)) {
                openError('请选择要删除的数据',2000);
                return;
            }
            $("#do_delete").attr("disabled",false);
            $( "#dialog-delete").modal({
                keyboard: false
            });
        }

        //弹出对话框
        function openDialog(url,data){
            $( "#dialog-confirm" ).modal({
                backdrop: 'static'
            });
            //使用此方法防止js缓存不加载
            $("#do_save").attr("disabled",false);
            $("#dialog-confirm p" ).load(url);
        }

        function openError(message,delay){
            $('#alert').show().find('strong').text(message);
            window.setTimeout(function() {
                $('#alert').slideUp("slow");
                //window.top.location.reload();
            }, delay);
        }

        function showResult(result,message,delay){
            $("#messageSpanId").text(message);

            if (!delay || typeof(delay)=="undefined" || typeof(delay)!='number'){
                delay = 2000;
            }
            if(result){
                $("#message").addClass('alert-success').removeClass('alert-danger').slideToggle(1000);
            }else{
                $("#message").addClass('alert-danger').removeClass('alert-success').slideToggle(1000);
            }
            window.setTimeout(function() {
                $('#message').slideToggle(1000);
            }, delay);
        }

        function hideError(){
            $('#alert').hide();
        }

        $(document).click(function(){
            hideError();
        });
    });
</script>
</body>
</html>
