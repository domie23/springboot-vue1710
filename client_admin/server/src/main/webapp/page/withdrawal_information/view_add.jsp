<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 新增/Add -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <link rel="stylesheet" href="../../css/diy.css">
    <script src="../../js/axios.min.js"></script>

    <style>
        img {
            width: 200px;
        }
    </style>
</head>

<body>
<article class="sign_in">
    <div class="warp">
        <div class="layui-container">
            <div class="layui-row">
                <form class="layui-form" action="">
                                                                                                        <div class="layui-form-item" id="course_name_box">
                                            <label class="layui-form-label">课程名称</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入课程名称"
                                                       class="layui-input" id="course_name">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="lecturer_box">
                                            <label class="layui-form-label">授课教师</label>
                                            <div class="layui-input-block">
                                                <select name="interest" lay-filter="lecturer" id="lecturer">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="student_users_box">
                                            <label class="layui-form-label">学生用户</label>
                                            <div class="layui-input-block">
                                                <select name="interest" lay-filter="student_users" id="student_users">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="student_name_box">
                                            <label class="layui-form-label">学生姓名</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入学生姓名"
                                                       class="layui-input" id="student_name">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="number_of_participants_box">
                                            <label class="layui-form-label">选课人数</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入选课人数"
                                                       class="layui-input" id="number_of_participants">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item layui-form-text" id="reason_for_withdrawal_box">
                                        <label class="layui-form-label">退课原因</label>
                                        <div class="layui-input-block">
                                            <textarea placeholder="请输入退课原因" class="layui-textarea"
                                                      id="reason_for_withdrawal"></textarea>
                                        </div>
                                    </div>
                                                                                                                        <div class="layui-form-item" id="course_no_box">
                                            <label class="layui-form-label">选课编号</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入选课编号"
                                                       class="layui-input" id="course_no">
                                            </div>
                                        </div>
                                                                
        
    
    
    
                    </form>
                <div class="layui-btn-container">
                    <a href="#" type="button" class="layui-btn layui-btn-normal login" id="submit" >确认/Confirm</a>
                    <a href="./table.jsp" target="main_self_frame" type="button"
                       class="layui-btn layui-btn-normal login">取消/Cancel</a>
                </div>
            </div>
        </div>
    </div>
</article>
</body>
<script src="../../layui/layui.js"></script>
<script src="../../js/base.js"></script>
<script src="../../js/index.js"></script>
<script>
    var BaseUrl = baseUrl()
    let withdrawal_information_id = location.search.substring(1)
    layui.use(['upload', 'element', 'layer', 'laydate', 'layedit'], function () {
        var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer
                , laydate = layui.laydate
                , layedit = layui.layedit
                , form = layui.form;

        let url

        let token = sessionStorage.token || null
        let personInfo = JSON.parse(sessionStorage.personInfo)
        let user_group = personInfo.user_group
        let use_id = personInfo.user_id

        function  $get_stamp() {
            return new Date().getTime();
        }

        function  $get_rand(len) {
            var rand = Math.random();
            return Math.ceil(rand * 10 ** len);
        }

        
            // 权限判断
            /**
             * 获取路径对应操作权限 鉴权
             * @param {String} action 操作名
             */
            function $check_action(path1, action = "get") {
                var o = $get_power(path1);
                if (o && o[action] != 0 && o[action] != false) {
                    return true;
                }
                return false;
            }

            /**
             * 获取权限
             * @param {String} path 路由路径
             */
            function $get_power(path) {
                var list_data = JSON.parse(sessionStorage.list_data)
                var list = list_data;
                var obj;
                for (var i = 0; i < list.length; i++) {
                    var o = list[i];
                    if (o.path === path) {
                        obj = o;
                        break;
                    }
                }
                return obj;
            }

        let submit = document.querySelector('#submit')
        // 提交按钮校验权限
        // if (   user_group == "管理员" ||$check_action('/withdrawal_information/view', 'add') || $check_action('/withdrawal_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "withdrawal_information_id";
            let url_add = "withdrawal_information";
            let url_set = "withdrawal_information";
            let url_get_obj = "withdrawal_information";
            let url_upload = "withdrawal_information"
            let query = {
                "withdrawal_information_id": 0,
            }

            let form_data2 = {
                                        "course_name":  '', // 课程名称
                                "lecturer": 0, // 授课教师
                                "student_users": 0, // 学生用户
                            "student_name":  '', // 学生姓名
                            "number_of_participants":  '', // 选课人数
                            "reason_for_withdrawal":  '', // 退课原因
                            "course_no":  '', // 选课编号
                                    "withdrawal_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/withdrawal_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/withdrawal_information/table") {
                        path1 = o.path
                            $get_power(o.path)
                    }
                }
            }

            getpath()

            /**
             * 注册时是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             * @param {String} path 路径
             */
            function $check_register_field(action, field, path1) {
                var o = $get_power(path1);
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             */
            function $check_field(action, field) {
                var o = $get_power("/withdrawal_information/view");
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 获取路径对应操作权限 鉴权
             * @param {String} action 操作名
             */
            function $check_exam(path1, action = "get") {
                var o = $get_power(path1);
                if (o) {
                    var option = JSON.parse(o.option);
                    if (option[action])
                        return true
                }
                return false;
            }

            /**
             * 是否有审核字段的权限
             */
            function $check_examine() {
                var url = window.location.href;
                var url_ = url.split("/")
                var pg_url = url_[url_.length - 2]
                let path = "/"+ pg_url + "/table"
                var o = $get_power(path);
                if (o){
                    var option = JSON.parse(o.option);
                    if (option.examine)
                        return true
                }
                return false;
            }

                            if (user_group === '管理员') {
                    $("#course_name_box").show()
                } else {
                    if ($check_field('add', 'course_name')){
                        $("#course_name_box").show()
                    }else {
                        $("#course_name_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#lecturer_box").show()
                } else {
                    if ($check_field('add', 'lecturer')){
                        $("#lecturer_box").show()
                    }else {
                        $("#lecturer_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#student_users_box").show()
                } else {
                    if ($check_field('add', 'student_users')){
                        $("#student_users_box").show()
                    }else {
                        $("#student_users_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#student_name_box").show()
                } else {
                    if ($check_field('add', 'student_name')){
                        $("#student_name_box").show()
                    }else {
                        $("#student_name_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#number_of_participants_box").show()
                } else {
                    if ($check_field('add', 'number_of_participants')){
                        $("#number_of_participants_box").show()
                    }else {
                        $("#number_of_participants_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#reason_for_withdrawal_box").show()
                } else {
                    if ($check_field('add', 'reason_for_withdrawal')){
                        $("#reason_for_withdrawal_box").show()
                    }else {
                        $("#reason_for_withdrawal_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#course_no_box").show()
                } else {
                    if ($check_field('add', 'course_no')){
                        $("#course_no_box").show()
                    }else {
                        $("#course_no_box").hide()
                    }
                }
            
                                                                                                                                                                                                                                                                
            
            
            
            
            
            
            
    
                                                                                                        
                            
                            
                            
                            
                            
                            
                    
    
                    
                            
                            async function list_lecturer() {
                        var lecturer = document.querySelector("#lecturer")
                        var op1 = document.createElement("option");
                        op1.value = '0'
                            lecturer.appendChild(op1)
                        // 收集数据 长度
                        var count
                        // 收集数据 数组
                        var arr = []
                        $.ajax({
                            url: BaseUrl + '/api/user/get_list?user_group=老师用户',
                            type: 'GET',
                            contentType: 'application/json; charset=UTF-8',
                            async: false,
                            dataType: 'json',
                            success: function (response) {
                                count = response.result.count
                                arr = response.result.list
                            }
                        })
                        for (var i = 0; i < arr.length; i++) {
                            var op = document.createElement("option");
                            // 给节点赋值
                            op.innerHTML = arr[i].username + "--" + arr[i].nickname
                            op.value = arr[i].user_id
                            // 新增/Add节点
                            lecturer.appendChild(op)
                            if (form_data2.lecturer==arr[i].lecturer){
                                op.selected = true
                            }
                            layui.form.render("select");
                        }
                    }

                    layui.form.on('select(lecturer)', function (data) {
                        form_data2.lecturer = Number(data.elem[data.elem.selectedIndex].value);
                    })
                    list_lecturer()
                                    
                            async function list_student_users() {
                        var student_users = document.querySelector("#student_users")
                        var op1 = document.createElement("option");
                        op1.value = '0'
                            student_users.appendChild(op1)
                        // 收集数据 长度
                        var count
                        // 收集数据 数组
                        var arr = []
                        $.ajax({
                            url: BaseUrl + '/api/user/get_list?user_group=学生用户',
                            type: 'GET',
                            contentType: 'application/json; charset=UTF-8',
                            async: false,
                            dataType: 'json',
                            success: function (response) {
                                count = response.result.count
                                arr = response.result.list
                            }
                        })
                        for (var i = 0; i < arr.length; i++) {
                            var op = document.createElement("option");
                            // 给节点赋值
                            op.innerHTML = arr[i].username + "--" + arr[i].nickname
                            op.value = arr[i].user_id
                            // 新增/Add节点
                            student_users.appendChild(op)
                            if (form_data2.student_users==arr[i].student_users){
                                op.selected = true
                            }
                            layui.form.render("select");
                        }
                    }

                    layui.form.on('select(student_users)', function (data) {
                        form_data2.student_users = Number(data.elem[data.elem.selectedIndex].value);
                    })
                    list_student_users()
                                    
                            
                            
                            
                    
                                //文本
                    let course_name = document.querySelector("#course_name")
                        course_name.onkeyup = function (event) {
                        form_data2.course_name = event.target.value
                    }
                    //文本
                                                                                                                                                                        //文本
                    let student_name = document.querySelector("#student_name")
                        student_name.onkeyup = function (event) {
                        form_data2.student_name = event.target.value
                    }
                    //文本
                                                                                //文本
                    let number_of_participants = document.querySelector("#number_of_participants")
                        number_of_participants.onkeyup = function (event) {
                        form_data2.number_of_participants = event.target.value
                    }
                    //文本
                                                                                                        //多文本
                    let reason_for_withdrawal = document.querySelector("#reason_for_withdrawal")
                    //多文本
                                                        //文本
                    let course_no = document.querySelector("#course_no")
                        course_no.onkeyup = function (event) {
                        form_data2.course_no = event.target.value
                    }
                    //文本
                                                                                                                                                                                                                                                                            var data = sessionStorage.data || ''
            if (data !== '') {
                var data2 = JSON.parse(data)
                Object.keys(form_data2).forEach(key => {
                    Object.keys(data2).forEach(dbKey => {
                        if (key === dbKey) {
                            $('#' + key).val(data2[key])
                            form_data2[key] = data2[key]
                            $('#' + key).attr('disabled', 'disabled')
                                
                                        for (let key in form_data2) {
                                        if (key == 'lecturer') {
                                            let alls = document.querySelector('#lecturer').querySelectorAll('option')
                                            let test = form_data2[key]
                                            for (let i = 0; i < alls.length; i++) {
                                                layui.form.render("select");
                                                if (alls[i].value == test) {
                                                    alls[i].selected = true
                                                    form_data2.lecturer = alls[i].value
                                                    layui.form.render("select");
                                                }
                                            }
                                        }
                                    }
                                
                                        for (let key in form_data2) {
                                        if (key == 'student_users') {
                                            let alls = document.querySelector('#student_users').querySelectorAll('option')
                                            let test = form_data2[key]
                                            for (let i = 0; i < alls.length; i++) {
                                                layui.form.render("select");
                                                if (alls[i].value == test) {
                                                    alls[i].selected = true
                                                    form_data2.student_users = alls[i].value
                                                    layui.form.render("select");
                                                }
                                            }
                                        }
                                    }
                                
    
    
    
    
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                                                                                                                                            

            if (withdrawal_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/withdrawal_information/get_obj', {
                        params: {
                                withdrawal_information_id: withdrawal_information_id
                        }, headers: {
                            'x-auth-token': token
                        }
                    })

                    let data = rese.result.obj
                    Object.keys(form_data2).forEach((key) => {
                        form_data2[key] = data[key];
                        $("#"+key).val(form_data2[key])
                    });

                    

            
                                        for (let key in data) {
                                if (key == 'lecturer') {
                                    let alls = document.querySelector('#lecturer').querySelectorAll('option')
                                    let test = data[key]
                                    for (let i = 0; i < alls.length; i++) {
                                        layui.form.render("select");
                                        if (alls[i].value == test) {
                                            alls[i].selected = true
                                            form_data2.lecturer = alls[i].value
                                            layui.form.render("select");
                                        }
                                    }
                                }
                            }
                        
                                        for (let key in data) {
                                if (key == 'student_users') {
                                    let alls = document.querySelector('#student_users').querySelectorAll('option')
                                    let test = data[key]
                                    for (let i = 0; i < alls.length; i++) {
                                        layui.form.render("select");
                                        if (alls[i].value == test) {
                                            alls[i].selected = true
                                            form_data2.student_users = alls[i].value
                                            layui.form.render("select");
                                        }
                                    }
                                }
                            }
                        
            
            
            
            
                                    if (user_group === '管理员') {
                            $("#course_name_box").show()
                        } else {
                            if ($check_field('set', 'course_name') || $check_field('get', 'course_name')){
                                $("#course_name_box").show()
                            }else {
                                $("#course_name_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#lecturer_box").show()
                        } else {
                            if ($check_field('set', 'lecturer') || $check_field('get', 'lecturer')){
                                $("#lecturer_box").show()
                            }else {
                                $("#lecturer_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#student_users_box").show()
                        } else {
                            if ($check_field('set', 'student_users') || $check_field('get', 'student_users')){
                                $("#student_users_box").show()
                            }else {
                                $("#student_users_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#student_name_box").show()
                        } else {
                            if ($check_field('set', 'student_name') || $check_field('get', 'student_name')){
                                $("#student_name_box").show()
                            }else {
                                $("#student_name_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#number_of_participants_box").show()
                        } else {
                            if ($check_field('set', 'number_of_participants') || $check_field('get', 'number_of_participants')){
                                $("#number_of_participants_box").show()
                            }else {
                                $("#number_of_participants_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#reason_for_withdrawal_box").show()
                        } else {
                            if ($check_field('set', 'reason_for_withdrawal') || $check_field('get', 'reason_for_withdrawal')){
                                $("#reason_for_withdrawal_box").show()
                            }else {
                                $("#reason_for_withdrawal_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#course_no_box").show()
                        } else {
                            if ($check_field('set', 'course_no') || $check_field('get', 'course_no')){
                                $("#course_no_box").show()
                            }else {
                                $("#course_no_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                course_name.value = form_data2.course_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'course_name')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'course_name'))) {
                            }else {
                                $("#course_name").attr("disabled", true);
                                $("#course_name > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'lecturer')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'lecturer'))) {
                            }else {
                                $("#lecturer").attr("disabled", true);
                                $("#lecturer > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'student_users')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'student_users'))) {
                            }else {
                                $("#student_users").attr("disabled", true);
                                $("#student_users > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                student_name.value = form_data2.student_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'student_name')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'student_name'))) {
                            }else {
                                $("#student_name").attr("disabled", true);
                                $("#student_name > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                number_of_participants.value = form_data2.number_of_participants
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'number_of_participants')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'number_of_participants'))) {
                            }else {
                                $("#number_of_participants").attr("disabled", true);
                                $("#number_of_participants > input[name='file']").attr('disabled', true);
                            }
                                                                //多文本
                                reason_for_withdrawal.value = form_data2.reason_for_withdrawal
                            //多文本
                        
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'reason_for_withdrawal')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'reason_for_withdrawal'))) {
                            }else {
                                $("#reason_for_withdrawal").attr("disabled", true);
                                $("#reason_for_withdrawal > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                course_no.value = form_data2.course_no
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['withdrawal_information_id'] && $check_field('set', 'course_no')) || (!form_data2['withdrawal_information_id'] && $check_field('add', 'course_no'))) {
                            }else {
                                $("#course_no").attr("disabled", true);
                                $("#course_no > input[name='file']").attr('disabled', true);
                            }
                                                                                                                                                                                                                                                                                                                    layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                    //文本
                            form_data2.course_name = course_name.value
                            //文本
                                                                                                                            //文本
                            form_data2.student_name = student_name.value
                            //文本
                                                                    //文本
                            form_data2.number_of_participants = number_of_participants.value
                            //文本
                                                                    //多文本
                            form_data2.reason_for_withdrawal = reason_for_withdrawal.value
                            //多文本
                                                                            //文本
                            form_data2.course_no = course_no.value
                            //文本
                                    } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "课程名称", "field_value": form_data2.course_name});
                                                customize_field.push({"field_name": "授课教师", "field_value": form_data2.lecturer});
                                                customize_field.push({"field_name": "学生用户", "field_value": form_data2.student_users});
                                                customize_field.push({"field_name": "学生姓名", "field_value": form_data2.student_name});
                                                customize_field.push({"field_name": "选课人数", "field_value": form_data2.number_of_participants});
                                                customize_field.push({"field_name": "退课原因", "field_value": form_data2.reason_for_withdrawal});
                                                customize_field.push({"field_name": "选课编号", "field_value": form_data2.course_no});
                    
    
                if (withdrawal_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/withdrawal_information/add?',
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                                        if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                                    } else {
                                        console.log("详情/Details")
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/withdrawal_information/set?withdrawal_information_id=' + withdrawal_information_id,
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                    if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                }
            }
        
    })
    ;
</script>

</html>
