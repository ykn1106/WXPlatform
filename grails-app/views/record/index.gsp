<%--
  Created by IntelliJ IDEA.
  User: ykn
  Date: 17-9-20
  Time: 下午2:07
--%>

<%@ page contentType="text/html;charset=UTF-8" expressionCodec="none"%>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>公众号页面</title>
    <g:javascript src="jquery.form.min.js"></g:javascript>
    <g:javascript src="common.js"></g:javascript>
    <g:javascript src="happyTable.js"></g:javascript>
    <g:javascript src="bootbox.min.js"></g:javascript>
    <g:javascript src="lodash.js"></g:javascript>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

    <style>
        .table > tbody > tr > td {
            vertical-align: middle;
        }
        #spinner{
            display: none !important;
        }
        .fixed-table-container{
            height: 525px !important;
        }
    </style>
</head>
<body>
    <!--toolbar-->
    <div id="toolbarC" class="btn-group" style="margin-top: 5px;position: absolute">
        <button id="btn_add" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>
        <button id="btn_edit" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
        </button>
        <button id="btn_del" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
        </button>
        <button id="btn_exit" type="button" class="btn btn-default">
            <span aria-hidden="true"></span>退出登录
        </button>
        <button id="btn_login" type="button" class="btn btn-primary"　style="position:absolute;display:none;">
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>&nbsp;我是管理员
        </button>
        <!--seach box-->
        <input type="text" placeholder="关键字(名称/管理员/用途)" id="searchBox" style="margin-left: 10px;margin-top: 3px;width: 200px"/>
        <button class="button" type="button" id="btn_search">查询</button>
    </div>
    <!--table list-->
    <div  style="margin-top: 15px">
        <div id="templist" style="display: none"></div>
        <table id="list" class="table table-hover table-striped"></table>
    </div>
    <!--declare-->
    %{--<span class="declare" style="position:absolute;margin-top: 18px;margin-left: 30%;color:red">*注意:&nbsp;为防止误操作,新增记录后,只可修改<b style="color: black">"当前用途"</b>、<b style="color: black">当前状态"</b>字段值,如需修改其他字段值,需删除该记录后重新添加</span>--}%
    <!--log-box-->
    <span>操作日志</span>
    <div id="logbox"  style="width: auto;height:240px;border-top:1px solid #000;overflow: auto"></div>
    <div id="templogbox" style="display: none"></div>
    <!--modal-->
    <div class="modal fade" id="modal-container" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4>公众号记录</h4>
                </div>
                <div class="modal-body">
                    <g:form name="wxPlatForm" controller="record" action="doSave" class="form-horizontal" role="form" method="post">
                        <div class="form-group">
                            <label for="name" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="name" id="name"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="account" class="col-sm-2 control-label">账号</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="account" id="account"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="password" id="password"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="type" class="col-sm-2 control-label">公众号类型</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="type" id="type"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="isAuth" class="col-sm-2 control-label">是否认证</label>
                            <div class="col-sm-10">
                                %{--<input class="form-control" type="text"  name="isAuth" id="isAuth"/>--}%
                                <select name="isAuth" id="isAuth" class=" form-control">
                                    <option value="0">未认证</option>
                                    <option value="1">已认证</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="appId" class="col-sm-2 control-label">appId</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="appId" id="appId"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="appIdSecret" class="col-sm-2 control-label">appIdSecret</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="appIdSecret" id="appIdSecret"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="admin" class="col-sm-2 control-label">管理员</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="admin" id="admin"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="purpose" class="col-sm-2 control-label">当前用途</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text"  name="purpose" id="purpose"/>
                            </div>
                        </div>
                        %{--<div class="form-group">--}%
                            %{--<label for="testing" class="col-sm-2 control-label">对应测试号</label>--}%
                            %{--<div class="col-sm-10">--}%
                                %{--<input class="form-control" type="text"  name="testing" id="testing"/>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                        <div class="form-group">
                            <label for="status" class="col-sm-2 control-label">当前状态</label>
                            <div class="col-sm-10">
                                %{--<input class="form-control" type="text"  name="status" id="status"/>--}%
                                <select name="status" id="status" class=" form-control">
                                    <option value="0">离线</option>
                                    <option value="1">在线</option>
                                    <option value="2">未知</option>
                                </select>
                            </div>
                        </div>
                        <g:hiddenField name="id"/>
                    </g:form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" id="btn_save" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var oTable = new HappyTable();
        //init
        oTable.init();
        //load data
        var data = ${records};
        oTable.loadDta(data);
        //check if admin
        if("${flag}" == "true"){
            //add Record
            $("#btn_add").off("click").on('click', function () {
                oTable.addRecord();
            });
            //edit Record
            $("#btn_edit").off("click").on('click', function () {
                oTable.editRecord();
            });
            //del Record
            $("#btn_del").off("click").on('click', function () {
                oTable.delRecord();
            });
            $("#btn_login").remove();
        }else if("${flag}" == "false"){
            $("#btn_add").remove();
            $("#btn_edit").remove();
            $("#btn_del").remove();
            $("#btn_exit").remove();
            $("#btn_login").attr("display", "block");
//            $(".declare").css("display","none");
        }
        //save Record
        $("#btn_save").off("click").on('click', function () {
            oTable.saveRecord();
        });
        //exit
        $("#btn_exit").off("click").on('click', function () {
            location.href="/WXPlatform/user/login";
        });
        //login
        $("#btn_login").off("click").on('click', function () {
            location.href="/WXPlatform/user/login";
        });
        //search Record
        $("#btn_search").off("click").on('click', function () {
            search();
        });
        $("#searchBox").keydown(function (e) {
            if(e.keyCode == 13){
                search();
            }
        });
        var last_op = new Object();
        var interval = setInterval(function () {
            $("#templogbox").load("${createLink(controller: 'oplog', action: 'list')}", null, function(data){
                var op = JSON.parse(data);
                //更新日志
                if(!_.isEqual(last_op, op)){
                    last_op = op;
                    $("#logbox").empty();
                    for(i in op){
                        $("#logbox").append(op[i].log)
                    }
                    document.getElementById("logbox").scrollTop = document.getElementById("logbox").scrollHeight;
                    search();
                }
            });
        },1000);

        function search() {
            $("#templist").load("${createLink(controller: 'record', action: 'search')}", {key: $("#searchBox").val()}, function(data){
                var rec = JSON.parse(data);
                if(rec == "[]") rec=[{}];
                oTable.loadDta(rec);
            });
        }

    </script>
</body>
</html>