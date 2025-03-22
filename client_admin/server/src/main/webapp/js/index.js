function fun(id, url, parameter, obj, reset2, resetSelect, goods, goods_a, is_user_table) {
  layui.use(["element", "layer", "util"], function () {
    var element = layui.element,
      layer = layui.layer,
      util = layui.util,
      table = layui.table,
      $ = layui.$;

    let item = document
      .querySelector(".layui-form-item")
      .querySelectorAll(".block");
    // 表单查询/Query
    console.log(item.length);
    var inputBox = [];
    for (let i = 0;i<item.length;i++){
      inputBox[i] = item[i].children[0];
    }
    let inquire = document.querySelector("#inquire");
    if (inquire){
      inquire.addEventListener("click", function () {
        try {
          for (let i = 0;i<item.length;i++){
            obj[Object.keys(obj)[i+3]] = inputBox[i].value;
          }
          console.log(Object.keys(obj))
          var str = Object.assign({}, obj);
        } catch (err) {
          console.log(err);
        } finally {
          console.log(str);
          // 删除/Del没有输入的参数
          Object.keys(str).forEach((item) => {
            if (str[item] === "" || str[item] === null || str[item] === undefined)
              delete str[item];
          });
          table.reload(id, {
            where: str,
          });
        }
      });
    }

    // 表单重置/Reset
    let reset = document.querySelector("#reset");
    if (reset){
      reset.addEventListener("click", function () {
        try {
          for (let i = 0;i<item.length;i++){
            inputBox[i].value = ""
          }
        } catch (err) {
          console.log(err);
        } finally {
          location.reload();
          if (resetSelect) {
            //  循环清除下拉框里面的值
            for (let value of resetSelect) {
              $("#" + value).val("");
              var select = "dd[lay-value=" + "0" + "]";
              $("#" + value)
                  .siblings("div.layui-form-select")
                  .find("dl")
                  .find(select)
                  .click();
              //重新渲染下拉框
              layui.use("form", function () {
                var form = layui.form;
                form.render("select");
              });
            }
          }
        }
        table.reload(id, {
          where: reset2,
        });
      });
    }

    // 删除/Del按钮
    let deleteBtn = document.querySelector("#delete");
    if (deleteBtn){
      deleteBtn.onclick = function () {
        let checkStatus = table.checkStatus(id).data;
        if (checkStatus.length >= 1) {
          layer.confirm(
              "此操作将永远删除/Del该文件，是否继续",
              {
                btn: ["确定", "取消/Cancel"], //按钮
              },
              async function () {
                for (let i = 0; i < checkStatus.length; i++) {
                  let { data: res } = await axios.get(url, {
                    params: {
                      [parameter]: checkStatus[i][parameter],
                    },
                  });
                  if (is_user_table && res.result){
                    await axios.get(BaseUrl + '/api/user/del', {
                      params: {
                        user_id: checkStatus[i]['user_id'],
                      },
                    });
                  }
                  if (
                      checkStatus[i].user_id &&
                      checkStatus[i].comment_id !== undefined
                  ) {
                    let { data: res } = await axios.get(
                        BaseUrl + "/api/comment/del",
                        {
                          params: {
                            comment_id: checkStatus[i].comment_id,
                          },
                        }
                    );
                  }
                  if (checkStatus[i][goods]) {
                    let { data: res } = await axios.get(
                        BaseUrl + "/api/goods/del",
                        {
                          params: {
                            source_table: goods_a,
                            source_field: goods_a + "_id",
                            source_id: checkStatus[i][goods],
                          },
                        }
                    );
                  }
                }
                // 重新渲染表格
                table.reload(id, {
                  where: reset2,
                });
                // 重置/Reset
                try {
                  for (let i = 0;i<item.length;i++){
                    inputBox[i].value = ""
                  }
                } catch (err) {
                  console.log(err);
                } finally {
                  if (resetSelect) {
                    //  循环清除下拉框里面的值
                    for (let value of resetSelect) {
                      $("#" + value).val("");
                      var select = "dd[lay-value=" + "0" + "]";
                      $("#" + value)
                          .siblings("div.layui-form-select")
                          .find("dl")
                          .find(select)
                          .click();
                      //重新渲染下拉框
                      layui.use("form", function () {
                        var form = layui.form;
                        form.render("select");
                      });
                    }
                  }
                }
                table.reload(id, {
                  where: reset2,
                });
                layer.msg("删除/Del成功", { icon: 1 });
              },
              function () {
                layer.msg("已取消/Cancel删除/Del");
              }
          );
        }
      };
    }
  });
}

// 下拉框函数的封装
async function init(url, id) {
  // 拿到单选框的父级节点
  var select = document.querySelector("#" + id);
  var op1 = document.createElement("option");
  op1.value = "0";
  select.appendChild(op1);
  // 收集数据 长度
  var count;
  // 收集数据 数组
  var arr = [];
  let { data: res } = await axios.get(url);
  count = res.result.count;
  arr = res.result.list;
  for (var i = 0; i < arr.length; i++) {
    // 创建节点
    var op = document.createElement("option");
    // 给节点赋值
    op.innerHTML = arr[i].name;
    op.value = arr[i].name;
    // 新增/Add节点
    select.appendChild(op);
    layui.form.render("select");
  }
}

// 下拉框函数的封装
async function inits(url, id, ff) {
  // 拿到单选框的父级节点
  var select = document.querySelector("#" + id);
  var op1 = document.createElement("option");
  op1.value = "0";
  select.appendChild(op1);
  // 收集数据 长度
  var count;
  // 收集数据 数组
  var arr = [];
  let { data: res } = await axios.get(url);
  count = res.result.count;
  arr = res.result.list;
  for (var i = 0; i < arr.length; i++) {
    // 创建节点
    var op = document.createElement("option");
    // 给节点赋值
    op.innerHTML = arr[i][ff];
    op.value = arr[i][ff];
    // 新增/Add节点
    select.appendChild(op);
    layui.form.render("select");
  }
}

// test c
function fell(arr, id) {
  // 拿到单选框的父级节点
  var select = document.querySelector("#" + id);
  var op1 = document.createElement("option");
  op1.value = "0";
  select.appendChild(op1);
  for (var i = 0; i < arr.length; i++) {
    // 创建节点
    var op = document.createElement("option");
    // 给节点赋值
    op.innerHTML = arr[i];
    op.value = arr[i];
    // 新增/Add节点
    select.appendChild(op);
    layui.form.render("select");
  }
}

// 商家账号和卖家账号下拉框的封装

async function local(id, request, number) {
  // 拿到单选框的父级节点
  var select = document.querySelector("#" + id);
  console.log(select);
  var op1 = document.createElement("option");
  op1.value = "0";
  select.appendChild(op1);
  // 收集数据 长度
  var count;
  // 收集数据 数组
  var arr = [];
  let { data: res } = await axios.get(BaseUrl + "/api/user/get_list", {
    params: {
      user_group: request,
    },
  });
  count = res.result.count;
  arr = res.result.list;
  for (var i = 0; i < arr.length; i++) {
    // 创建节点
    var op = document.createElement("option");
    // 自定义属性的操作
    op.setAttribute(number, arr[i].user_id);
    // 给节点赋值
    op.innerHTML = arr[i].nickname + "-" + arr[i].username;
    op.value = arr[i].user_id;
    // console.log(op);
    // 新增/Add节点
    select.appendChild(op);
    layui.form.render("select");
  }
}

function get_power(path, lists) {
  var list = lists;
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

function page_title(path, id, lists) {
  let test = document.querySelector("#" + id);
  var o = get_power(path, lists);
  if (o) {
    test.innerHTML = o.page_title || o.mod_name;
  }
  return "";
}

function fullUrl(baseUrl, url) {
  let host = baseUrl + "/";
  let url_new = "";
  if (url) {
    if (url.indexOf("~/") === 0) {
      url_new = url.replace("~/", host);
    } else if (url.indexOf("/http://") === 0) {
      url_new = url.replace("/http://", "http://");
    } else if (url.indexOf("/") === 0) {
      url_new = url.replace("/", host);
    } else {
      url_new = url;
    }
  }
  return url_new;
}
