
%{--<thead>--}%
%{--<tr>--}%
%{--<th scope="row">#</th>--}%
%{--<th>名称</th>--}%
%{--<th>账号</th>--}%
%{--<th>密码</th>--}%
%{--<th>类型</th>--}%
%{--<th>是否认证</th>--}%
%{--<th>appId</th>--}%
%{--<th>appIdSecret</th>--}%
%{--<th>管理员</th>--}%
%{--<th>当前用途</th>--}%
%{--<th>当前状态</th>--}%
%{--<th>操作</th>--}%
%{--</tr>--}%
%{--</thead>--}%
%{--<tbody>--}%
%{--<g:render template="/record/record" model="[records: records]"></g:render>--}%
%{--</tbody>--}%

<g:each in="${records}" var="record" status="index">
    <tr data-index=${index} data-uniqueid=${record.id}>
        <td class="bs-checkbox">
            <input data-index=${index} name="btSelectItem" type="radio">
        </td>
        <td>${record.name}</td>
        <td>${record.account}</td>
        <td>${record.passowrd}</td>
        <td>${record.type}</td>
        <td>${record.isAuth}</td>
        <td>${record.appId}</td>
        <td>${record.appIdSecret}</td>
        <td>${record.admin}</td>
        <td>${record.purpose}</td>
        <td>${record.status}</td>
        <td style="">
            <button type="button" class="btn btn-default btn_edit" onclick="edit(${record.id});">修改</button>
            <button type="button" class="btn btn-default btn_del" onclick="del(${record.id});">删除</button>
        </td>
    </tr>
</g:each>

