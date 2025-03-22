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
                                                                                                                    <div class="layui-upload" id="cover_photo_box">
                                        <button type="button" class="layui-btn" id="cover_photo">上传图片</button>
                                        <div class="layui-upload-list">
                                            <img class="layui-upload-img" id="cover_photo_img">
                                            <p id="demoText"></p>
                                        </div>
                                        <div style="width: 95px;">
                                            <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                                 lay-filter="cover_photo">
                                                <div class="layui-progress-bar" lay-percent=""></div>
                                            </div>
                                        </div>
                                    </div>
                                                                                                                        <div class="layui-form-item" id="course_type_box">
                                            <label class="layui-form-label">课程类型</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入课程类型"
                                                       class="layui-input" id="course_type">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="class_location_box">
                                            <label class="layui-form-label">上课地点</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入上课地点"
                                                       class="layui-input" id="class_location">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="class_time_box">
                                            <label class="layui-form-label">上课时间</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入上课时间"
                                                       class="layui-input" id="class_time">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="number_of_courses_box">
                                            <label class="layui-form-label">课程人数</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入课程人数"
                                                       class="layui-input" id="number_of_courses">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="number_of_people_available_box">
                                            <label class="layui-form-label">可选人数</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入可选人数"
                                                       class="layui-input" id="number_of_people_available">
                                            </div>
                                        </div>
                                                                                                                                                                <div class="layui-form-item" id="lecturer_box">
                                                <label class="layui-form-label">授课教师</label>
                                                <div class="layui-input-block">
                                                    <select name="interest" lay-filter="lecturer"
                                                            id="lecturer">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                                                                                                        <div class="layui-form-item">
                                    <label class="layui-form-label">详情介绍</label>
                                    <div class="layui-input-block">
                                        <textarea id="demo" style="display: none;"></textarea>
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
    let course_information_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/course_information/view', 'add') || $check_action('/course_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "course_information_id";
            let url_add = "course_information";
            let url_set = "course_information";
            let url_get_obj = "course_information";
            let url_upload = "course_information"
            let query = {
                "course_information_id": 0,
            }

            let form_data2 = {
                                        "course_name":  '', // 课程名称
                            "cover_photo":  '', // 封面图片
                            "course_type":  '', // 课程类型
                            "class_location":  '', // 上课地点
                            "class_time":  '', // 上课时间
                            "number_of_courses":  '', // 课程人数
                            "number_of_people_available":  0, // 可选人数
                                "lecturer": 0, // 授课教师
                            "details":  '', // 详情介绍
                                    "course_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/course_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/course_information/table") {
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
                var o = $get_power("/course_information/view");
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
                    $("#cover_photo_box").show()
                } else {
                    if ($check_field('add', 'cover_photo')){
                        $("#cover_photo_box").show()
                    }else {
                        $("#cover_photo_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#course_type_box").show()
                } else {
                    if ($check_field('add', 'course_type')){
                        $("#course_type_box").show()
                    }else {
                        $("#course_type_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#class_location_box").show()
                } else {
                    if ($check_field('add', 'class_location')){
                        $("#class_location_box").show()
                    }else {
                        $("#class_location_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#class_time_box").show()
                } else {
                    if ($check_field('add', 'class_time')){
                        $("#class_time_box").show()
                    }else {
                        $("#class_time_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#number_of_courses_box").show()
                } else {
                    if ($check_field('add', 'number_of_courses')){
                        $("#number_of_courses_box").show()
                    }else {
                        $("#number_of_courses_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#number_of_people_available_box").show()
                } else {
                    if ($check_field('add', 'number_of_people_available')){
                        $("#number_of_people_available_box").show()
                    }else {
                        $("#number_of_people_available_box").hide()
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
                    $("#details_box").show()
                } else {
                    if ($check_field('add', 'details')){
                        $("#details_box").show()
                    }else {
                        $("#details_box").hide()
                    }
                }
            
                                                                                //常规使用 - 普通图片上传
                        var uploadInst = upload.render({
                            elem: '#cover_photo'
                            , url: BaseUrl + '/api/course_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                            , headers: {
                                'x-auth-token': token
                            }, before: function (obj) {
                                //预读本地文件示例，不支持ie8
                                obj.preview(function (index, file, result) {
                                    $('#cover_photo_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                                });

                                element.progress('cover_photo', '0%'); //进度条复位
                                layer.msg('上传中', {icon: 16, time: 0});
                            }
                            , done: function (res) {
                                //如果上传失败
                                if (res.code > 0) {
                                    return layer.msg('上传失败');
                                }
                                //上传成功的一些操作
                                //……
                                form_data2.cover_photo = res.result.url
                                $('#demoText').html(''); //置空上传失败的状态
                            }
                            , error: function () {
                                //演示失败状态，并实现重传
                                var demoText = $('#demoText');
                                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                                demoText.find('.demo-reload').on('click', function () {
                                    uploadInst.upload();
                                });
                            }
                            //进度条
                            , progress: function (n, elem, e) {
                                element.progress('cover_photo', n + '%'); //可配合 layui 进度条元素使用
                                if (n == 100) {
                                    layer.msg('上传完毕', {icon: 1});
                                }
                            }
                        });
                                                                                                                                                                                                                                                                        var demo = layedit.build('demo', {
                        tool: [
                            'strong' //加粗
                            , 'italic' //斜体
                            , 'underline' //下划线
                            , 'del' //删除/Del线

                            , '|' //分割线

                            , 'left' //左对齐
                            , 'center' //居中对齐
                            , 'right' //右对齐
                            , 'link' //超链接
                            , 'unlink' //清除链接
                            , 'face' //表情
                            , 'image' //插入图片
                            , 'help' //帮助
                        ]
                    });
                        
            
            
            
            
            
            
            
            
            
    
                                                                                                                                
                            
                            
                            
                            
                            
                            
                            
                            
                    
    
                    
                            
                            
                            
                            
                            
                            
                            
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
                                    
                    
                                //文本
                    let course_name = document.querySelector("#course_name")
                        course_name.onkeyup = function (event) {
                        form_data2.course_name = event.target.value
                    }
                    //文本
                                                                                                                            //文本
                    let course_type = document.querySelector("#course_type")
                        course_type.onkeyup = function (event) {
                        form_data2.course_type = event.target.value
                    }
                    //文本
                                                                                //文本
                    let class_location = document.querySelector("#class_location")
                        class_location.onkeyup = function (event) {
                        form_data2.class_location = event.target.value
                    }
                    //文本
                                                                                //文本
                    let class_time = document.querySelector("#class_time")
                        class_time.onkeyup = function (event) {
                        form_data2.class_time = event.target.value
                    }
                    //文本
                                                                                //文本
                    let number_of_courses = document.querySelector("#number_of_courses")
                        number_of_courses.onkeyup = function (event) {
                        form_data2.number_of_courses = event.target.value
                    }
                    //文本
                                                                                                //数字
                    let number_of_people_available = document.querySelector("#number_of_people_available")
                        number_of_people_available.onkeyup = function (event) {
                        form_data2.number_of_people_available = Number(event.target.value)
                    }
                    //数字
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
                                
    
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                                                                                                                                                async function axios_get_4() {
                            if(user_group !='管理员'){
                                const {data: rese} = await axios.get(BaseUrl + '/api/user/get_list?user_group=' + user_group)
                                let data = rese.result.list

                                const {data: ress} = await axios.get(BaseUrl + '/api/user_group/get_obj?name=' + user_group)
                                const {data: res} = await axios.get(BaseUrl + '/api/' + ress.result.obj.source_table + '/get_obj?user_id=' + use_id)
                                Object.keys(form_data2).forEach(key => {
                                    Object.keys(res.result.obj).forEach(dbKey => {
                                        if (key === dbKey) {
                                            $('#' + key).val(res.result.obj[key])
                                            $('#' + key).attr('disabled', 'disabled')
                                        }
                                    })
                                })

                                for (let key in res.result.obj) {
                                    if (key == 'user_id') {
                                        let alls = document.querySelector('#lecturer').querySelectorAll('option')
                                        let test = res.result.obj.user_id
                                        for (let i = 0; i < alls.length; i++) {
                                            if (alls[i].value == test) {
                                                alls[i].selected = true
                                                $('#lecturer').attr('disabled', 'disabled')
                                                form_data2.lecturer = alls[i].value
                                                layui.form.render("select");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        axios_get_4()
                                            

            if (course_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/course_information/get_obj', {
                        params: {
                                course_information_id: course_information_id
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
                            $("#cover_photo_box").show()
                        } else {
                            if ($check_field('set', 'cover_photo') || $check_field('get', 'cover_photo')){
                                $("#cover_photo_box").show()
                            }else {
                                $("#cover_photo_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#course_type_box").show()
                        } else {
                            if ($check_field('set', 'course_type') || $check_field('get', 'course_type')){
                                $("#course_type_box").show()
                            }else {
                                $("#course_type_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#class_location_box").show()
                        } else {
                            if ($check_field('set', 'class_location') || $check_field('get', 'class_location')){
                                $("#class_location_box").show()
                            }else {
                                $("#class_location_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#class_time_box").show()
                        } else {
                            if ($check_field('set', 'class_time') || $check_field('get', 'class_time')){
                                $("#class_time_box").show()
                            }else {
                                $("#class_time_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#number_of_courses_box").show()
                        } else {
                            if ($check_field('set', 'number_of_courses') || $check_field('get', 'number_of_courses')){
                                $("#number_of_courses_box").show()
                            }else {
                                $("#number_of_courses_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#number_of_people_available_box").show()
                        } else {
                            if ($check_field('set', 'number_of_people_available') || $check_field('get', 'number_of_people_available')){
                                $("#number_of_people_available_box").show()
                            }else {
                                $("#number_of_people_available_box").hide()
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
                            $("#details_box").show()
                        } else {
                            if ($check_field('set', 'details') || $check_field('get', 'details')){
                                $("#details_box").show()
                            }else {
                                $("#details_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                course_name.value = form_data2.course_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'course_name')) || (!form_data2['course_information_id'] && $check_field('add', 'course_name'))) {
                            }else {
                                $("#course_name").attr("disabled", true);
                                $("#course_name > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'cover_photo')) || (!form_data2['course_information_id'] && $check_field('add', 'cover_photo'))) {
                            }else {
                                $("#cover_photo").attr("disabled", true);
                                $("#cover_photo > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                course_type.value = form_data2.course_type
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'course_type')) || (!form_data2['course_information_id'] && $check_field('add', 'course_type'))) {
                            }else {
                                $("#course_type").attr("disabled", true);
                                $("#course_type > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                class_location.value = form_data2.class_location
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'class_location')) || (!form_data2['course_information_id'] && $check_field('add', 'class_location'))) {
                            }else {
                                $("#class_location").attr("disabled", true);
                                $("#class_location > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                class_time.value = form_data2.class_time
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'class_time')) || (!form_data2['course_information_id'] && $check_field('add', 'class_time'))) {
                            }else {
                                $("#class_time").attr("disabled", true);
                                $("#class_time > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                number_of_courses.value = form_data2.number_of_courses
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'number_of_courses')) || (!form_data2['course_information_id'] && $check_field('add', 'number_of_courses'))) {
                            }else {
                                $("#number_of_courses").attr("disabled", true);
                                $("#number_of_courses > input[name='file']").attr('disabled', true);
                            }
                                                            //数字
                                number_of_people_available.value = form_data2.number_of_people_available
                            //数字
                            
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'number_of_people_available')) || (!form_data2['course_information_id'] && $check_field('add', 'number_of_people_available'))) {
                            }else {
                                $("#number_of_people_available").attr("disabled", true);
                                $("#number_of_people_available > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'lecturer')) || (!form_data2['course_information_id'] && $check_field('add', 'lecturer'))) {
                            }else {
                                $("#lecturer").attr("disabled", true);
                                $("#lecturer > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['course_information_id'] && $check_field('set', 'details')) || (!form_data2['course_information_id'] && $check_field('add', 'details'))) {
                            }else {
                                $("#details").attr("disabled", true);
                                $("#details > input[name='file']").attr('disabled', true);
                            }
                                                                                                                            let cover_photo_img = document.querySelector("#cover_photo_img")
                                    cover_photo_img.src = fullUrl(BaseUrl,form_data2.cover_photo)
                                                                                                                                                                                                                                                                                        layedit.setContent(demo, form_data2.details)
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
                            form_data2.course_type = course_type.value
                            //文本
                                                                    //文本
                            form_data2.class_location = class_location.value
                            //文本
                                                                    //文本
                            form_data2.class_time = class_time.value
                            //文本
                                                                    //文本
                            form_data2.number_of_courses = number_of_courses.value
                            //文本
                                                                    //数字
                            form_data2.number_of_people_available = Number(number_of_people_available.value)
                            //数字
                                                                                    form_data2.details = layedit.getContent(demo)
                                            } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "课程名称", "field_value": form_data2.course_name});
                                                customize_field.push({
                            "field_name": "封面图片",
                            "field_value": form_data2.cover_photo,
                            "type": "image"
                        });
                                                customize_field.push({"field_name": "课程类型", "field_value": form_data2.course_type});
                                                customize_field.push({"field_name": "上课地点", "field_value": form_data2.class_location});
                                                customize_field.push({"field_name": "上课时间", "field_value": form_data2.class_time});
                                                customize_field.push({"field_name": "课程人数", "field_value": form_data2.number_of_courses});
                                                customize_field.push({"field_name": "可选人数", "field_value": form_data2.number_of_people_available});
                                                customize_field.push({"field_name": "授课教师", "field_value": form_data2.lecturer});
                                                customize_field.push({"field_name": "详情介绍", "field_value": form_data2.details});
                    
    
                if (course_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/course_information/add?',
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
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/course_information/set?course_information_id=' + course_information_id,
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
