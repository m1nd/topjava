<%@ page import="ru.javawebinar.topjava.util.TimeUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<jsp:include page="fragments/headTag.jsp"/>
<link rel="stylesheet" href="webjars/datatables/1.10.9/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="webjars/datetimepicker/2.3.4/jquery.datetimepicker.css">

<body>
<jsp:include page="fragments/bodyHeader.jsp"/>


<section>
    <div class="jumbotron">
        <div class="container">
            <div class="shadow">
                <%--http://stackoverflow.com/questions/10327390/how-should-i-get-root-folder-path-in-jsp-page--%>
                <h3><a href="${pageContext.request.contextPath}">Home</a></h3>

                <h3><fmt:message key="meals.title"/></h3>

                <div class="view-box">

                    <form method="post" action="meals/filter">
                        <fieldset class="form-group">

                            <dl>
                                <dt>From Date:</dt>
                                <dd><input type="date" class="form-control" name="startDate" value="${startDate}"></dd>
                            </dl>
                            <dl>
                                <dt>To Date:</dt>
                                <dd><input type="date" class="form-control" name="endDate" value="${endDate}"></dd>
                            </dl>
                            <dl>
                                <dt>From Time:</dt>
                                <dd><input type="time" class="form-control" name="startTime" value="${startTime}"></dd>
                            </dl>
                            <dl>
                                <dt>To Time:</dt>
                                <dd><input type="time" class="form-control" name="endTime" value="${endTime}"></dd>
                            </dl>
                            <%--<button type="submit">Filter</button>--%>
                            <button type="submit" class="btn btn-primary">Filter</button>
                        </fieldset>
                    </form>

                    <hr>
                    <a href="meals/create"class="btn btn-info btn-xs" role="button">Add Meal</a>
                    <hr>
                    <%--<table border="1" cellpadding="8" cellspacing="0">--%>
                    <table class="table table-striped display" id="datatable">
                        <thead>
                        <tr>
                            <th>Date</th>
                            <th>Description</th>
                            <th>Calories</th>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <c:forEach items="${mealList}" var="meal">
                            <jsp:useBean id="meal" scope="page" type="ru.javawebinar.topjava.to.UserMealWithExceed"/>
                            <tr class="${meal.exceed ? 'exceeded' : 'normal'}">
                                <td>
                                        <%--<fmt:parseDate value="${meal.dateTime}" pattern="y-M-dd'T'H:m" var="parsedDate"/>--%>
                                        <%--<fmt:formatDate value="${parsedDate}" pattern="yyyy.MM.dd HH:mm" />--%>
                                    <%=TimeUtil.toString(meal.getDateTime())%>
                                </td>
                                    <%--<td>${meal.description}</td>--%>
                                    <%--<td>${meal.calories}</td>--%>
                                    <%--<td><a href="meals/update?id=${meal.id}">Update</a></td>--%>
                                    <%--<td><a href="meals/delete?id=${meal.id}">Delete</a></td>--%>
                                <td>${meal.description}</td>
                                <td>${meal.calories}</td>
                                <td><a class="btn btn-xs btn-primary update" id="${meal.id}">Update</a></td>
                                <td><a class="btn btn-xs btn-danger delete" id="${meal.id}">Delete</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="fragments/footer.jsp"/>


</body>

<script type="text/javascript" src="webjars/jquery/2.1.4/jquery.min.js"></script>
<script type="text/javascript" src="webjars/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="webjars/datetimepicker/2.3.4/jquery.datetimepicker.js"></script>
<script type="text/javascript" src="webjars/datatables/1.10.9/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="webjars/noty/2.2.4/jquery.noty.packaged.min.js"></script>
<script type="text/javascript" src="resources/js/datatablesUtil.js"></script>
<script type="text/javascript">

    var ajaxUrl = '/ajax/meals';
    var oTable_datatable;
    var oTable_datatable_params;

    //            $(document).ready(function () {
    $(function () {
        oTable_datatable = $('#datatable');
        oTable_datatable_params = {
            "bPaginate": false,
            "bInfo": false,
            "aoColumns": [
                {
                    "mData": "date"
                },
                {
                    "mData": "description"
                },
                {
                    "mData": "calories"
                },
                {
                    "sDefaultContent": "",
                    "bSortable": false
                },
                {
                    "sDefaultContent": "",
                    "bSortable": false
                }
            ],
            "aaSorting": [
                [
                    0,
                    "asc"
                ]
            ]
        };

        oTable_datatable.dataTable(oTable_datatable_params);
        makeEditable();
    });
</script>

</html>