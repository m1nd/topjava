<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Meal list</title>
</head>
<body>
<h2>Meal list</h2>

<table border="1" >

    <caption>Список еды</caption>

    <c:forEach var="num" items="${mealList}">
                <c:choose>

                    <c:when test="${num.isExceed()}">

                        <tr style="color: red; ">
                            <td>${num.getDateTime()}</td>
                            <td>${num.getDescription()}</td>
                            <td>${num.getCalories()}</td>
                        </tr>

                    </c:when>

                    <c:otherwise>

                        <tr style="color: black; ">
                            <td>${num.getDateTime()}</td>
                            <td>${num.getDescription()}</td>
                            <td>${num.getCalories()}</td>
                        </tr>

                    </c:otherwise>


                </c:choose>
    </c:forEach>

</table>

</body>
</html>
