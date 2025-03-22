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
                                                                                                                                        <div class="layui-form-item" id="final_exam_box">
                                            <label class="layui-form-label">期末成绩</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入期末成绩"
                                                       class="layui-input" id="final_exam">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="peacetime_performance_box">
                                            <label class="layui-form-label">平时成绩</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入平时成绩"
                                                       class="layui-input" id="peacetime_performance">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="total_score_box">
                                            <label class="layui-form-label">总成绩</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入总成绩"
                                                       class="layui-input" id="total_score">
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
    let achievement_information_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/achievement_information/view', 'add') || $check_action('/achievement_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "achievement_information_id";
            let url_add = "achievement_information";
            let url_set = "achievement_information";
            let url_get_obj = "achievement_information";
            let url_upload = "achievement_information"
            let query = {
                "achievement_information_id": 0,
            }

            let form_data2 = {
                                        "course_name":  '', // 课程名称
                                "lecturer": 0, // 授课教师
                                "student_users": 0, // 学生用户
                            "student_name":  '', // 学生姓名
                            "final_exam":  '', // 期末成绩
                            "peacetime_performance":  '', // 平时成绩
                            "total_score":  '', // 总成绩
                                    "achievement_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/achievement_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/achievement_information/table") {
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
                var o = $get_power("/achievement_information/view");
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
                    $("#final_exam_box").show()
                } else {
                    if ($check_field('add', 'final_exam')){
                        $("#final_exam_box").show()
                    }else {
                        $("#final_exam_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#peacetime_performance_box").show()
                } else {
                    if ($check_field('add', 'peacetime_performance')){
                        $("#peacetime_performance_box").show()
                    }else {
                        $("#peacetime_performance_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#total_score_box").show()
                } else {
                    if ($check_field('add', 'total_score')){
                        $("#total_score_box").show()
                    }else {
                        $("#total_score_box").hide()
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
                    let final_exam = document.querySelector("#final_exam")
                        final_exam.onkeyup = function (event) {
                        form_data2.final_exam = event.target.value
                    }
                    //文本
                                                                                //文本
                    let peacetime_performance = document.querySelector("#peacetime_performance")
                        peacetime_performance.onkeyup = function (event) {
                        form_data2.peacetime_performance = event.target.value
                    }
                    //文本
                                                                                //文本
                    let total_score = document.querySelector("#total_score")
                        total_score.onkeyup = function (event) {
                        form_data2.total_score = event.target.value
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
                                                                                                                                            

            if (achievement_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/achievement_information/get_obj', {
                        params: {
                                achievement_information_id: achievement_information_id
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
                            $("#final_exam_box").show()
                        } else {
                            if ($check_field('set', 'final_exam') || $check_field('get', 'final_exam')){
                                $("#final_exam_box").show()
                            }else {
                                $("#final_exam_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#peacetime_performance_box").show()
                        } else {
                            if ($check_field('set', 'peacetime_performance') || $check_field('get', 'peacetime_performance')){
                                $("#peacetime_performance_box").show()
                            }else {
                                $("#peacetime_performance_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#total_score_box").show()
                        } else {
                            if ($check_field('set', 'total_score') || $check_field('get', 'total_score')){
                                $("#total_score_box").show()
                            }else {
                                $("#total_score_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                course_name.value = form_data2.course_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'course_name')) || (!form_data2['achievement_information_id'] && $check_field('add', 'course_name'))) {
                            }else {
                                $("#course_name").attr("disabled", true);
                                $("#course_name > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'lecturer')) || (!form_data2['achievement_information_id'] && $check_field('add', 'lecturer'))) {
                            }else {
                                $("#lecturer").attr("disabled", true);
                                $("#lecturer > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'student_users')) || (!form_data2['achievement_information_id'] && $check_field('add', 'student_users'))) {
                            }else {
                                $("#student_users").attr("disabled", true);
                                $("#student_users > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                student_name.value = form_data2.student_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'student_name')) || (!form_data2['achievement_information_id'] && $check_field('add', 'student_name'))) {
                            }else {
                                $("#student_name").attr("disabled", true);
                                $("#student_name > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                final_exam.value = form_data2.final_exam
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'final_exam')) || (!form_data2['achievement_information_id'] && $check_field('add', 'final_exam'))) {
                            }else {
                                $("#final_exam").attr("disabled", true);
                                $("#final_exam > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                peacetime_performance.value = form_data2.peacetime_performance
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'peacetime_performance')) || (!form_data2['achievement_information_id'] && $check_field('add', 'peacetime_performance'))) {
                            }else {
                                $("#peacetime_performance").attr("disabled", true);
                                $("#peacetime_performance > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                total_score.value = form_data2.total_score
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['achievement_information_id'] && $check_field('set', 'total_score')) || (!form_data2['achievement_information_id'] && $check_field('add', 'total_score'))) {
                            }else {
                                $("#total_score").attr("disabled", true);
                                $("#total_score > input[name='file']").attr('disabled', true);
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
                            form_data2.final_exam = final_exam.value
                            //文本
                                                                    //文本
                            form_data2.peacetime_performance = peacetime_performance.value
                            //文本
                                                                    //文本
                            form_data2.total_score = total_score.value
                            //文本
                                    } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "课程名称", "field_value": form_data2.course_name});
                                                customize_field.push({"field_name": "授课教师", "field_value": form_data2.lecturer});
                                                customize_field.push({"field_name": "学生用户", "field_value": form_data2.student_users});
                                                customize_field.push({"field_name": "学生姓名", "field_value": form_data2.student_name});
                                                customize_field.push({"field_name": "期末成绩", "field_value": form_data2.final_exam});
                                                customize_field.push({"field_name": "平时成绩", "field_value": form_data2.peacetime_performance});
                                                customize_field.push({"field_name": "总成绩", "field_value": form_data2.total_score});
                    
    
                if (achievement_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/achievement_information/add?',
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
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/achievement_information/set?achievement_information_id=' + achievement_information_id,
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
