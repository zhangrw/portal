<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@ include file="/WEB-INF/common/chart-js-style.jsp"%>
</head>
<body>
<h2>Hello World1!</h2>

<div class="row">
    <div class="col-lg-6">
        欢迎,${user.getName()}：
        </br>
        这是首页面！

        <form id="upload" class="form-horizontal" enctype="multipart/form-data">
            <div class="form-group">
                <label class="col-lg-3 col-md-1  control-label" for="uploadify">Uploadify插件:</label>
                <div class="col-lg-7 col-md-8">
                    <input type="file" id="uploadify" name="file"  class="form-control">
                    <div id="fileQueue"></div>
                </div>
            </div>
            <input id="id" name="id" value="123" type="hidden" />
        </form>

        <div id="alertForUpload" class="alert alert-danger" hidden>
            <strong>Warning!</strong>
        </div>

    </div>

    <div class="col-lg-6">
        <div id="highcharts" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $('#highcharts').highcharts({
            title: {
                text: '我就是个demo'
            },
            xAxis: {
                categories: ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
            },
            labels: {
                items: [{
                    html: 'Total fruit consumption',
                    style: {
                        left: '50px',
                        top: '18px',
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                    }
                }]
            },
            series: [{
                type: 'column',
                name: 'Jane',
                data: [3, 2, 1, 3, 4]
            }, {
                type: 'column',
                name: 'John',
                data: [2, 3, 5, 7, 6]
            }, {
                type: 'column',
                name: 'Joe',
                data: [4, 3, 3, 9, 0]
            }, {
                type: 'spline',
                name: 'Average',
                data: [3, 2.67, 3, 6.33, 3.33],
                marker: {
                    lineWidth: 2,
                    lineColor: Highcharts.getOptions().colors[3],
                    fillColor: 'white'
                }
            }, {
                type: 'pie',
                name: 'Total consumption',
                data: [{
                    name: 'Jane',
                    y: 13,
                    color: Highcharts.getOptions().colors[0] // Jane's color
                }, {
                    name: 'John',
                    y: 23,
                    color: Highcharts.getOptions().colors[1] // John's color
                }, {
                    name: 'Joe',
                    y: 19,
                    color: Highcharts.getOptions().colors[2] // Joe's color
                }],
                center: [100, 80],
                size: 100,
                showInLegend: false,
                dataLabels: {
                    enabled: false
                }
            }]
        });
    });

    $(function(){

        $("#uploadify").uploadify({
            debug			: false,
            swf 			: '${ctx}/static/uploadify/uploadify.swf',
            method			: 'POST',
            uploader		: '${ctx}/upload/uploadtest',
            //auto			: false,
            preventCaching	: true,
            buttonCursor	: 'hand',
            //	buttonImage		: 'img/.....png',
            buttonText		: '批  量  上  传  测  试'	,
            height			: 30	,
            width			: 320	,

            fileObjName		: 'file',
            fileSizeLimit	: 10000,	//10M
            fileTypeDesc	: 'any'	,
            fileTypeExts	: '',
            formData		: {'id':$("#id").val()} ,
            multi			: true ,
            progressData	: 'speed',
            queueID			: 'fileQueue',
            queueSizeLimit	: 10,
            removeCompleted : false,
            removeTimeout	: 10,
            requeueErrors	: true,
            uploadLimit		: 20,
            successTimeout	: 30000,
            overrideEvents : ['onSelectError', 'onUploadError','onDialogClose'],

            onCancel : function(file) { },

            onDialogClose : function (queueData) {},

            onDialogOpen : function () { },

            onFallback : function(){ },
            onSelectError  : function(file, errorCode, errorMsg){
                var msgText = "上传失败\n";
                switch (errorCode) {
                    case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
                        msgText += "每次最多上传 " + this.settings.queueSizeLimit + "个文件";
                        break;
                    case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                        msgText += "文件大小超过限制( " + (this.settings.fileSizeLimit / 1000) + "M )";
                        break;
                    case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                        msgText += "文件大小为0";
                        break;
                    case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                        msgText += "文件格式不正确，仅限 " + this.settings.fileTypeExts;
                        break;
                    default:
                        msgText += "错误代码:" + errorCode + "\n" + errorMsg;
                }
                openErrorForUpload(msgText,2000);
            },
            onUploadError : function(file, errorCode, errorMsg, errorString){
                if (errorCode == SWFUpload.UPLOAD_ERROR.FILE_CANCELLED
                    || errorCode == SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED) {
                    return;
                }
                var msgText = "上传失败\n";
                switch (errorCode) {
                    case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
                        msgText += "HTTP 错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
                        msgText += "上传文件丢失，请重新上传";
                        break;
                    case SWFUpload.UPLOAD_ERROR.IO_ERROR:
                        msgText += "IO错误";
                        break;
                    case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
                        msgText += "安全性错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                        msgText += "每次最多上传 " + this.settings.uploadLimit + "个";
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
                        msgText += errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
                        msgText += "找不到指定文件，请重新操作";
                        break;
                    case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
                        msgText += "参数错误";
                        break;
                    default:
                        msgText += "文件:" + file.name + "\n错误码:" + errorCode + "\n"
                            + errorMsg + "\n" + errorString;
                }
                openErrorForUpload(msgText,2000);
            },

            onUploadStart : function(file){

            },
            onUploadSuccess : function(file, data, response) {
                var obj = eval( "(" + data + ")" );
                var cancel=$("#"+file.id + " .cancel a");
                if (cancel) {
                    cancel.on('click',function () {
                        $.post("${ctx}/upload/deletefile",
                            {fileName:file.name},
                            function(result){
                                if(!result.success){
                                    openErrorForUpload(result.msg,1000);

                                }else{
//                                    $(this).hide();
                                }
                            },
                            'json');
                    });
                }
            }
        });
    });
    function openErrorForUpload(message,delay){
        $('#alertForUpload').show().find('strong').text(message);
        window.setTimeout(function() {
            $('#alertForUpload').slideUp("slow");
        }, delay);
    }
</script>
</body>
</html>
