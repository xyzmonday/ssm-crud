<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--页面标题-->
    <title>员工信息</title>
    <%--去除head的favicon.ico--%>
    <link rel="shortcut icon" href="">
    <!--引入bootstrap样式-->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<!-- 员工增加模态框 -->
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="input_emp_name" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="input_emp_name" name="empName"
                                   placeholder="员工姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_emp_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="input_emp_email" name="email"
                                   placeholder="email@126.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="select_dept" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--提交部门id--%>
                            <select id="select_dept" class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_emp_save">保存</button>
            </div>
        </div>
    </div>
</div>


<!-- 员工修改模态框 -->
<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工编辑</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="update_emp_name" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="update_emp_name" name="empName"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_emp_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_emp_email" name="email"
                                   placeholder="email@126.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="男" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="女"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="select_dept" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--提交部门id--%>
                            <select id="select_update_dept" class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_emp_update">更新</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--新增删除按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn-primary" id="btn_add_emp">新增</button>
            <button class="btn-danger" id="btn_delete_all_emp">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 10px;">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <td>
                        <input type="checkbox" id="check_all"/>
                    </td>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
            <%--当前<b>${pageInfo.pageNum}</b>页，总<b>${pageInfo.pages}</b>页，总记录数<b>${pageInfo.total}</b>--%>
        </div>
        <%--分页条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<!--引入jquery-->
<script src="static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
<!--引入bootstrap-->
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>


<script type="text/javascript">

    //总记录数
    var totalRecord = null;
    //当前页
    var currentPageNum = null;

    //发送ajax请求
    $(function () {
        toPage(1);
    });

    //分页获取数据
    function toPage(pageNum) {
        $.ajax({
            url: "${basePath}/emp/list",
            data: {"pageNum": pageNum},
            dataType: "json",
            type: "GET",
            success: function (result) {
                //console.log(result)
                //1.解析并显示员工数据
                build_emp_table(result);
                //2.解析并显示分页数据
                build_page_info(result);
                build_page_nav(result);
            }
        });
    }

    //显示员工数据
    function build_emp_table(result) {
        //清空数据
        $('#emps_table tbody').empty();
        //清空check_all的状态
        $('#check_all').prop('checked',false);
        //获取员工列表
        var emps = result.data.pageInfo.list;
        $.each(emps, function (index, emp) {
            //创建一个tr
            var checkBoxTd = $('<td><input type="checkbox" class="check_item"></td>');
            var empIdTd = $('<td></td>').append(emp.empId);
            var empNameTd = $('<td></td>').append(emp.empName);
            var empGenderTd = $('<td></td>').append(emp.gender);
            var empEmailTd = $('<td></td>').append(emp.email);
            var empDeptNameTd = $('<td></td>').append(emp.department.deptName);

            //btn_edit是用来触发click修改
            var editButton = $('<button></button>').addClass('btn btn-primary btn-sm btn_edit')
                .append($('<span></span>').addClass('glyphicon glyphicon-pencil')).append("编辑");

            //添加指定自定义属性
            editButton.attr('emp_edit_id', emp.empId);

            //btn_delete是用来触发click删除
            var delButton = $('<button></button>').addClass('btn btn-danger btn-sm btn_delete')
                .append($('<span></span>').addClass('glyphicon glyphicon-trash')).append("删除");

            delButton.attr('emp_delete_id', emp.empId);

            var btnTd = $('<td></td>').append(editButton).append(' ').append(delButton);

            $('<tr></tr>')
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptNameTd)
                .append(btnTd)
                .appendTo('#emps_table tbody');

        });

    };

    //显示分页信息
    function build_page_info(result) {
        $('#page_info_area').empty();
        //当前<b>${pageInfo.pageNum}</b>页，总<b>${pageInfo.pages}</b>页，总记录数<b>${pageInfo.total}
        $('#page_info_area').append('当前' + result.data.pageInfo.pageNum + '页，')
            .append('总' + result.data.pageInfo.pages + '页，')
            .append('总记录数' + result.data.pageInfo.total);
        totalRecord = result.data.pageInfo.total;
        currentPageNum = result.data.pageInfo.pageNum;
    }

    //显示分页条
    function build_page_nav(result) {
        $('#page_nav_area').empty();
        //创建nav
        var nav = $('<nav></nav>').addClass('Page navigation');

        //创建ul
        var ul = $('<ul></ul>').addClass('pagination');

        //创建首页以它的图标
        var firstPageLi = $('<li></li>').append($('<a></a>').append('首页'));
        var leftArrowLi = $('<li></li>').append($('<a></a>').append($('<span></span>').append('&laquo;')));

        //如果有前一页才让点击
        if (result.data.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass('disabled');
            leftArrowLi.addClass('disabled');
        } else {
            firstPageLi.click(function () {
                toPage(1);
            });
            leftArrowLi.click(function () {
                toPage(result.data.pageInfo.pageNum - 1);
            });
        }

        ul.append(firstPageLi);
        ul.append(leftArrowLi);

        //遍历页码
        $.each(result.data.pageInfo.navigatepageNums, function (index, item) {
            var li = $('<li></li>').append($('<a></a>').append(item));
            var pageNum = result.data.pageInfo.pageNum;
            if (pageNum == item) {
                li.addClass('active');
            }
            li.click(function () {
                toPage(item);
            });
            ul.append(li);
        });

        //创建末页
        var lastPageLi = $('<li></li>').append($('<a></a>').append('末页'));
        var rightArrowLi = $('<li></li>').append($('<a></a>').append($('<span></span>').append('&raquo;')));

        //如果有下一页
        if (result.data.pageInfo.hasNextPage == false) {
            lastPageLi.addClass('disabled');
            rightArrowLi.addClass('disabled');
        } else {
            lastPageLi.click(function () {
                toPage(result.data.pageInfo.pages);
            });
            rightArrowLi.click(function () {
                toPage(result.data.pageInfo.pageNum + 1);
            });
        }

        ul.append(rightArrowLi);
        ul.append(lastPageLi);

        //添加导航容器nav
        nav.append(ul);
        //添加到div
        $('#page_nav_area').append(nav);
    };

    //点击新增按钮，弹出模态框，增加员工
    $('#btn_add_emp').click(function () {
        //表单重置，清除历史数据
        $('#addEmpModal form')[0].reset();
        //表单重置，清除样式
        $('#addEmpModal form').find('*').removeClass('has-success has-error');
        $('#addEmpModal form').find('.help-block').text('');

        getDepts($('#select_dept'));
        //弹出模态框
        $('#addEmpModal').modal({
            backdrop: 'static'
        });
    });

    //获取部门信息，并将获取到的部门列表显示在select中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "/dept/list",
            type: "GET",
            dataType: 'json',
            success: function (result) {
                var departments = result.data.departments;
                ele.empty();
                $.each(departments, function (index, item) {
                    var option = $('<option></option>')
                        .append(item.deptName)
                        .attr('name', 'deptId').attr('value', item.deptId);
                    ele.append(option);
                });
            }
        });
    }

    //查询员工信息
    function getEmp(empId) {
        $.ajax({
            url: '/emp/' + empId,
            dataType: 'json',
            type: 'GET',
            success: function (result) {
                var emp = result.data.emp;
                //显示员工姓名
                $('#update_emp_name').text(emp.empName);
                //邮箱
                $('#update_emp_email').val(emp.email);
                //单选
                $("#updateEmpModal input[name='gender']").val([emp.gender]);
                //下拉列表选中
                $("#updateEmpModal select").val([emp.deptId]);
            }
        });
    }

    //点击保存按钮，保存新增员工信息
    $('#btn_emp_save').click(function () {
        //1.对提交的数据进行校验
        if (!validate_add_form()) {
            return;
        }

        //2.拿到当前按钮的ajax_validate属性值
        if ($(this).attr('ajax_validate') == 'error') {
            return;
        }
        //3.将模态框填写的数据给服务器
        var data = $('#addEmpModal form').serialize();
        $.ajax({
            url: "/emp/save",
            type: "POST",
            dataType: "json",
            data: data,
            success: function (result) {
                if (result.code == 100) {
                    //关闭对话框
                    $('#addEmpModal').modal('hide');
                    //来到最后一页，显示刚刚保存的数据。利用PageHelper的性质，传入的页数大于实际页数时都是显示最后一页
                    toPage(totalRecord);
                } else {
                    //有那个字段的错误信息，那么就显示那个字段的错误信息
                    if (result.data.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#input_emp_email", "error", result.data.errorFields.email);
                    }
                    if (result.data.errorFields.empName) {
                        show_validate_msg("#input_emp_name", "error", result.data.errorFields.empName);
                    }
                }
            }
        });
    });

    //校验新增员工提交的数据
    function validate_add_form() {
        //校验员工姓名
        var empName = $('#input_emp_name').val();
        var empNameReg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!empNameReg.test(empName)) {
            show_validate_msg("#input_emp_name", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#input_emp_name", "success", "");
        }
        //校验邮箱
        var empEmail = $('#input_emp_email').val();
        var empEmailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!empEmailReg.test(empEmail)) {
            //应该清空这个元素之前的样式
            show_validate_msg("#input_emp_email", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#input_emp_email", "success", "");
        }
        return true;
    }

    //校验员工保存时是否可用
    $("#input_emp_name").change(function () {
        var empName = this.value;
        $.ajax({
            url: '/emp/checkUser',
            dataType: 'json',
            data: {empName: empName},
            type: 'GET',
            success: function (result) {
                var msg = result.data.msg_emp_name_validate;
                if (result.code == 100) {
                    show_validate_msg($('#input_emp_name'), 'success', msg);
                    //如果校验可用
                    $("#btn_emp_save").attr('ajax_validate', 'success');
                } else {
                    show_validate_msg($('#input_emp_name'), 'error', msg);
                    $("#btn_emp_save").attr('ajax_validate', 'error');
                }
            }
        });
    });

    //提示校验失败对话框
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass('has-success has-error');
        $(ele).next("span").text("");
        if (status == 'success') {
            //校验成功
            $(ele).parent().addClass('has-success');
            $(ele).next('span').text(msg);
        } else if (status == 'error') {
            $(ele).parent().addClass('has-error');
            $(ele).next('span').text(msg);
        }
    }

    //延迟绑定每一行里面的修改和删除点击事件，因为按钮是数据熏染之后才有的，所以需要使用延迟
    $(document).on("click", ".btn_edit", function () {
        //1.查询部门信息
        getDepts($('#select_update_dept'));
        //2.查询员工信息
        var empId = $(this).attr('emp_edit_id');
        getEmp(empId);
        //3.弹出对话框
        //将员工id传递到更新按钮
        $('#btn_emp_update').attr('emp_edit_id', empId);
        $("#updateEmpModal").modal({
            backdrop: 'static'
        });
    });


    $('#btn_emp_update').click(function () {
        //1.校验邮箱信息
        var empEmail = $('#update_emp_email').val();
        var empEmailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!empEmailReg.test(empEmail)) {
            //应该清空这个元素之前的样式
            show_validate_msg("#update_emp_name", "error", "邮箱格式不正确");
            alert("邮箱有误");
            return false;
        } else {
            show_validate_msg("#update_emp_email", "success", "");
        }
        //2.更新员工数据
        var empId = $(this).attr('emp_edit_id');
        var data = $('#updateEmpModal form').serialize();
        $.ajax({
            url: "/emp/" + empId,
            dataType: 'json',
            type: 'PUT',
            data: data,
            success: function (result) {
                //关闭对话框
                $('#updateEmpModal').modal('hide');
                //回到本页
                toPage(currentPageNum);
            },
            error: function (result) {
                alert(result);
            }
        });
    });

    //删除某条员工
    $(document).on('click', '.btn_delete', function () {
        //获取员工名字
        var empName = $(this).parents('tr').find('td:eq(2)').text();
        //获取empId
        var empId = $(this).attr('emp_delete_id');
        if (confirm("确认删除[" + empName + "]吗?")) {
            $.ajax({
                url: "emp/" + empId,
                dataType: 'json',
                type: 'DELETE',
                success: function (result) {
                    alert(result.message);
                    //刷新
                    toPage(currentPageNum)
                }
            });
        }
    });

    //批量删除
    $('#btn_delete_all_emp').click(function () {
        var empNames = "";
        var empIds = "";
        $('.check_item:checked').each(function () {
            empNames += $(this).parents('tr').find('td:eq(2)').text() + ",";
            empIds += $(this).parents('tr').find('td:eq(1)').text() + "-";
        });

        //去除最后一个，
        empNames.substring(0, empNames.length - 1);
        empIds.substring(0, empIds.length - 1);
        if (confirm("确认删除[" + empNames + "]吗?")) {
            $.ajax({
                url: '/emp/' + empIds,
                type: 'DELETE',
                dataType: 'json',
                success: function (result) {
                    alert(result.message);
                    toPage(currentPageNum);
                }
            });
        }
    });

    //全选
    $('#check_all').click(function () {
        //attr获取checked是undefined,使用prop获取dom原生的属性
        if ($(this).prop('checked')) {
            $(".check_item").prop('checked', $(this).prop('checked'));
        }
    });

    //单个checkbox的单击事件
    $(document).on('click', '.check_item', function () {
        //当前选中的checkbox是否是选满了
        var flag = $('.check_item:checked').length == $('.check_item').length;
        $('#check_all').prop('checked', flag);
    });

</script>
</body>