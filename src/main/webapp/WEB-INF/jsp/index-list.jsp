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
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName" name="empName" placeholder="员工姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="email" name="email" placeholder="email@126.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="emp_gender_m" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="emp_gender_f" value="女"> 女
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
            <button class="btn-danger">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 10px;">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
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
        //获取员工列表
        var emps = result.data.pageInfo.list;
        $.each(emps, function (index, emp) {
            //创建一个tr
            var empIdTd = $('<td></td>').append(emp.empId);
            var empNameTd = $('<td></td>').append(emp.empName);
            var empGenderTd = $('<td></td>').append(emp.gender);
            var empEmailTd = $('<td></td>').append(emp.email);
            var empDeptNameTd = $('<td></td>').append(emp.department.deptName);

            var editButton = $('<button></button>').addClass('btn btn-primary btn-sm')
                .append($('<span></span>').addClass('glyphicon glyphicon-pencil')).append("编辑");

            var delButton = $('<button></button>').addClass('btn btn-danger btn-sm')
                .append($('<span></span>').addClass('glyphicon glyphicon-trash')).append("删除");

            var btnTd = $('<td></td>').append(editButton).append(' ').append(delButton);

            $('<tr></tr>').append(empIdTd)
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
        $.ajax({
            url: "/dept/list",
            type: "GET",
            dataType: 'json',
            success: function (result) {
                var departments = result.data.departments;
                //console.log(departments);
                $('#select_dept').empty();
                $.each(departments, function (index, item) {
                    var option = $('<option></option>').append(item.deptName).attr('name','deptId').attr('value', item.deptId);
                    $('#select_dept').append(option);
                });

                //弹出模态框
                $('#addEmpModal').modal({
                    backdrop: 'static'
                });
            }
        });

    });

    //保存新增员工信息
    $('#btn_emp_save').click(function () {
        //将模态框填写的数据给服务器
        var data = $('#addEmpModal form').serialize();
        //alert(data);
        $.ajax({
            url: "/emp/save",
            type: "POST",
            dataType: "json",
            data: data,
            success: function (result) {
                //alert(result);
                //保存成功后，关闭对话框
                $('#addEmpModal').modal('hide');
                //来到最后一页，显示刚刚保存的数据。利用PageHelper的性质，传入的页数大于实际页数时都是显示最后一页
                toPage(totalRecord);
            }
        });
    });

</script>
</body>