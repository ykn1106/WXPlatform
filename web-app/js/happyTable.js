var HappyTable = function(){
    this.selrow = null;
};
var self = this.HappyTable.prototype;
HappyTable.prototype.init = function () {

    $("#list").bootstrapTable({
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        pagination: true,                   //是否显示分页（*）
        strictSearch: true,
        sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber:1,                       //初始化加载第一页，默认第一页
        pageSize: 13,                       //每页的记录行数（*）
        pageList: [13, 20, 25, 50, 100],        //可供选择的每页的行数（*）
        showColumns: true,                  //是否显示所有的列
        // showRefresh: true,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        clickToSelect: true,                //是否启用点击选中行
        height: 730,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
        uniqueId: "id",                     //每一行的唯一标识，一般为主键列
        columns:columns,
        // onEditableSave: function (field,row,oldValue,$el) {
        //     $("#list").bootstrapTable("resetView");
        //     //editTable(editUrl,row);
        // }
    });
};
HappyTable.prototype.refresh = function(){
    $("#list").bootstrapTable("resetView");
};

HappyTable.prototype.loadDta = function(data){
    $("#list").bootstrapTable("load",data);
};

HappyTable.prototype.addRecord = function(){
    $("#modal-container").modal("show");
    $("#name").removeAttr("disabled");
    $("#account").removeAttr("disabled");
    $("#password").removeAttr("disabled");
    $("#type").removeAttr("disabled");
    $("#isAuth").removeAttr("disabled");
    $("#appId").removeAttr("disabled");
    $("#appIdSecret").removeAttr("disabled");
    $("#admin").removeAttr("disabled");
    $("#wxPlatForm input,#wxPlatForm select").val("");
}

HappyTable.prototype.editRecord = function () {
    var selrow = this.getSelectedRow();
    if(selrow!=null && selrow.length == 1){
        $("#modal-container").modal("show");
        $("#name").val(selrow[0].name).attr("disabled","disabled");
        $("#account").val(selrow[0].account).attr("disabled","disabled");
        $("#password").val(selrow[0].password).attr("disabled","disabled");
        $("#type").val(selrow[0].type).attr("disabled","disabled");
        $("#isAuth").val(selrow[0].isAuth).attr("disabled","disabled");
        $("#appId").val(selrow[0].appId).attr("disabled","disabled");
        $("#appIdSecret").val(selrow[0].appIdSecret).attr("disabled","disabled");
        $("#admin").val(selrow[0].admin).attr("disabled","disabled");
        $("#purpose").val(selrow[0].purpose);
        $("#status").val(selrow[0].status);
        $("#id").val(selrow[0].id);
    }else{
        bootbox.alert("请选择一条记录");
    }
}

HappyTable.prototype.delRecord = function () {
    var selrow = this.getSelectedRow();
    if(selrow != null && selrow.length == 1){
        bootbox.confirm({
            message: "确定删除该记录吗?",
            callback:function (result) {
                if(result){
                    $.ajax({
                        type : "post",
                        url:"/WXPlatform/record/doDel",
                        data:{id: selrow[0].id, delOne:true},
                        success:function (data) {
                            if(data.success) {
                                self.loadDta(data.item);
                            }else{
                                bootbox.alert(data.message);
                            }
                        }
                    })
                }
            }
        })
    }else{
        bootbox.alert("请选择一条记录");
    }
}

HappyTable.prototype.saveRecord = function () {
    //validate

    //save
    $("#wxPlatForm").ajaxSubmit({
        type: 'post',
        success: function (data) {
            if (!(data.success)) {
                bootbox.alert(data.message);
            } else {
                // $("#list").bootstrapTable("refresh", {url: '/WXPlatform/record/index'});
                self.loadDta(data.item);
                $("#modal-container").modal("hide");
            }
        }
    });
}

HappyTable.prototype.getSelectedRow = function(){
    this.selrow = $("#list").bootstrapTable("getSelections");//获取选中行
    return this.selrow;
}

//table columns
var columns = [
    {
        radio: true
    }, {
        field: "name",
        title: "名称",
        editable:{
            emptytext:""
        }
    },
    {
        field: "purpose",
        title: "当前用途",
        editable:{
            emptytext:""
        }
    },{
        field: "account",
        title: "帐号",
        editable:{
            emptytext:""
        }
    },{
        field: "password",
        title: "密码",
        editable:{
            emptytext:""
        }
    },{
        field: "type",
        title: "类型",
        editable:{
            emptytext:""
        },
        sortable: true
    },{
        field: "isAuth",
        title: "是否认证",
        formatter:function (value,row,index) {
            var val;
            if(value == "0"){
                val = '<div style="text-align: center">' +
                    '<span>&nbsp;未认证</span>'+
                    '</div>';
            }else if(value == "1"){
                val = '<div style="text-align: center">' +
                    '<span>&nbsp;已认证</span>'+
                    '</div>';
            }
            return val;
        },
        sortable: true
    },{
        field: "appId",
        title: "应用ID",
        editable:{
            emptytext:""
        }
    },{
        field: "appIdSecret",
        title: "加密应用ID",
        editable:{
            emptytext:""
        }
    },{
        field: "admin",
        title: "管理员",
        editable:{
            emptytext:""
        },
        sortable: true
    },
    // {
    //     field: "testing",
    //     title: "对应测试号",
    //     editable:{
    //         emptytext:""
    //     }
    // },
    // {
    //     field: "status",
    //     title: "当前状态",
    //     formatter:function (value,row,index) {
    //         var val;
    //         if(value == "0"){
    //             val = '<div style="text-align: center">' +
    //                 '<img src="../images/orbino_icon_pack_red.png" alt="离线"/>'+
    //                 '<span>&nbsp;离线</span>'+
    //                 '</div>';
    //         }else if(value == "1"){
    //             val = '<div style="text-align: center">' +
    //                 '<img src="../images/orbino_icon_pack_green.png" alt="在线"/>'+
    //                 '<span>&nbsp;在线</span>'+
    //                 '</div>';
    //         }else{
    //             val = '<div style="text-align: center">' +
    //                 '<img src="../images/orbino_icon_pack_yellow.png" alt="未知"/>'+
    //                 '<span>&nbsp;未知</span>'+
    //                 '</div>';
    //         }
    //         return val;
    //     },
    //     sortable: true
    // },
    {
        field: "lastUpdated",
        title: "更新时间",
        editable:{
            emptytext:""
        },
        sortable: true,
        formatter:function (value, row, index) {
            var date = new Date(value);
            var val = date.getFullYear()+"-"+(date.getMonth().toString().length == 1 ?"0"+(date.getMonth()+1):(date.getMonth()+1))+"-"+(date.getDate().toString().length==1?"0"+date.getDate():date.getDate())+" "+(date.getHours().toString().length==1?"0"+date.getHours():date.getHours())+":"+(date.getMinutes().toString().length==1?"0"+date.getMinutes():date.getMinutes())+":"+(date.getSeconds().toString().length==1?"0"+date.getSeconds():date.getSeconds());
            return val;
        }
    }
    // ,{
    //     field:"id",
    //     title:"操作",
    //     formatter:function (value,row,index) {
    //         var val = '<button type="button" class="btn btn-default btn_edit" onclick="self.editRecord('+row.id+');">修改</button>'+
    //             '<button type="button" class="btn btn-default btn_del" onclick="self.delRecord('+row.id+');">删除</button>';
    //         return val;
    //     }
    // }
];


