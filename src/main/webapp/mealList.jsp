<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Meal list</title>
</head>
<body>
<h2>Meal list</h2>
<c:forEach var="num" items="${mealList}">
    <tr>
        <c:choose>
            <c:when test="${num.isExceed()}"><span style="color: red; "/></c:when>
            <c:otherwise><span style="color: black; "/></c:otherwise>
        </c:choose>

        <p>${num}</p>
    </tr>
</c:forEach>

</body>
</html>
