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
    <!--引入bootstrap样式-->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>

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
            <button class="btn-primary">新增</button>
            <button class="btn-danger">删除</button>
        </div>
    </div>
    <%--表格数据--%>
    <div class="row" style="margin-top: 10px;">
        <div class="col-md-12">
            <table class="table table-bordered table-hover">
                <thead>
                <tr class="text-center">
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr class="text-center">
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.gender}</td>
                        <td>${emp.email}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm" aria-label="Left Align">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>

                            <button type="button" class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前<b>${pageInfo.pageNum}</b>页，总<b>${pageInfo.pages}</b>页，总记录数<b>${pageInfo.total}</b>
        </div>
        <%--分页条--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li>
                        <a href="${basePath}/emp/list?pageNum=1">首页</a>
                    </li>
                    <%--如果有上一页那么显示上一页--%>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${basePath}/emp/list?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}">
                            <li><a href="${basePath}/emp/list?pageNum=${page_Num}">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <%--如果有下一页--%>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${basePath}/emp/list?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li>
                        <a href="${basePath}/emp/list?pageNum=${pageInfo.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!--引入jquery-->
<script src="static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
<!--引入bootstrap-->
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>
</body>