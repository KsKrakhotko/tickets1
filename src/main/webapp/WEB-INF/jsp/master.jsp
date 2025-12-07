<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Администрирование станций</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f7f6;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="text"] {
            width: calc(100% - 24px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .button-primary {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .button-danger {
            background-color: #dc3545;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .button-info {
            background-color: #17a2b8;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Панель администратора: Управление станциями</h1>

    <!-- Форма для добавления новой станции -->
    <h2>Добавить новую станцию</h2>
    <!--
        Предполагаем, что этот action отправляет POST-запрос на контроллер.
        В Spring MVC это может быть @PostMapping("/stations/add")
        или вы можете использовать Thymeleaf/другой шаблонизатор для более удобной привязки.
    -->
    <form action="${pageContext.request.contextPath}/stations/add" method="post">
        <div class="form-group">
            <label for="name">Название станции:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="city">Город:</label>
            <input type="text" id="city" name="city" required>
        </div>
        <div class="form-group">
            <label for="region">Регион (Область/Край):</label>
            <input type="text" id="region" name="region">
        </div>
        <button type="submit" class="button-primary">Сохранить станцию</button>
    </form>

    <hr style="margin: 40px 0;">

    <!-- Список существующих станций -->
    <h2>Список станций</h2>

    <c:choose>
        <c:when test="${empty stations}">
            <p>В системе пока нет зарегистрированных станций.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Название</th>
                    <th>Город</th>
                    <th>Регион</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody>
                <!-- Итерируем по списку станций, переданному из контроллера (например, List<Station> stations) -->
                <c:forEach var="station" items="${stations}">
                    <tr>
                        <td><c:out value="${station.id}"/></td>
                        <td><c:out value="${station.name}"/></td>
                        <td><c:out value="${station.city}"/></td>
                        <td><c:out value="${station.region}"/></td>
                        <td>
                            <!-- Ссылка на форму редактирования -->
                            <a href="${pageContext.request.contextPath}/stations/edit/${station.id}" class="button-info">Редактировать</a>

                            <!--
                                Форма для удаления.
                                Использование POST-запроса для удаления лучше, чем GET.
                            -->
                            <form action="${pageContext.request.contextPath}/stations/delete/${station.id}" method="post" style="display: inline;">
                                <button type="submit" class="button-danger"
                                        onclick="return confirm('Вы уверены, что хотите удалить станцию &quot;${station.name}&quot;?');">
                                    Удалить
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

</div>


</body>
</html>