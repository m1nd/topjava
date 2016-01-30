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

                <h2><a href="">Home</a></h2>

                <h3><fmt:message key="meals.edit"/></h3>
                <hr>
                <jsp:useBean id="meal" type="ru.javawebinar.topjava.model.UserMeal" scope="request"/>
                <form method="post" action="meals">
                    <fieldset class="form-group">

                    <input type="hidden" name="id" value="${meal.id}">
                    <dl>
                        <dt>DateTime:</dt>
                        <dd><input type="datetime-local" class="form-control" value="${meal.dateTime}" name="dateTime"></dd>
                    </dl>
                    <dl>
                        <dt>Description:</dt>
                        <dd><input type="text" class="form-control" value="${meal.description}" size=40 name="description"></dd>
                    </dl>
                    <dl>
                        <dt>Calories:</dt>
                        <dd><input type="number" class="form-control" value="${meal.calories}" name="calories"></dd>
                    </dl>
                    <button type="submit" class="btn btn-primary">Save</button>
                    <button class="btn btn-danger" onclick="window.history.back()">Cancel</button>

                    </fieldset>
                </form>

            </div>
        </div>
    </div>
</section>
<jsp:include page="fragments/footer.jsp"/>
</body>
</html>
