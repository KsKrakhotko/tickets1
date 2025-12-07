<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мои билеты | Железнодорожные перевозки</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --purple: #8A2BE2;
            --dark-purple: #6A1B9A;
            --light-purple: #E6E6FA;
            --ivory: #FFFFF0;
            --charcoal: #36454F;
            --slate: #708090;
            --success: #4CAF50;
            --warning: #FFC107;
            --danger: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--ivory);
            color: var(--charcoal);
            line-height: 1.6;
        }

        .admin-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        .admin-sidebar {
            background: linear-gradient(to bottom, #FFFFFF, #F8F8F8);
            box-shadow: 5px 0 15px rgba(0,0,0,0.05);
            border-right: 1px solid rgba(138, 43, 226, 0.3);
        }

        .admin-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
            margin-bottom: 20px;
        }

        .admin-title {
            display: flex;
            align-items: center;
            font-family: 'Playfair Display', serif;
        }

        .admin-title i {
            font-size: 2rem;
            margin-right: 15px;
            color: var(--purple);
        }

        .admin-title h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            position: relative;
        }

        .admin-title h1::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--purple);
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: var(--slate);
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-link:hover {
            background: rgba(138, 43, 226, 0.1);
            color: var(--charcoal);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: rgba(138, 43, 226, 0.15);
            color: var(--charcoal);
            border-left: 3px solid var(--purple);
            font-weight: 600;
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            color: var(--purple);
            text-align: center;
        }

        .admin-content {
            padding: 40px;
            background-color: #FFF;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--charcoal);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--purple);
        }

        /* Стили для таблицы */
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .appointments-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.95rem;
        }

        .appointments-table th {
            background-color: var(--purple);
            color: white;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            position: sticky;
            top: 0;
        }

        .appointments-table th:first-child {
            border-top-left-radius: 10px;
        }

        .appointments-table th:last-child {
            border-top-right-radius: 10px;
        }

        .appointments-table td {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            vertical-align: middle;
        }

        .appointments-table tr:last-child td {
            border-bottom: none;
        }

        .appointments-table tr:hover td {
            background-color: rgba(138, 43, 226, 0.1);
        }

        .appointments-table tr:nth-child(even) {
            background-color: rgba(249, 249, 249, 0.5);
        }

        /* Стили для кнопок */
        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 5px;
        }

        .btn-edit {
            background-color: rgba(74, 144, 226, 0.1);
            color: #4a90e2;
        }

        .btn-edit:hover {
            background-color: rgba(74, 144, 226, 0.2);
        }

        .btn-cancel {
            background-color: rgba(226, 74, 74, 0.1);
            color: #e24a4a;
            margin-left: 8px;
        }

        .btn-cancel:hover {
            background-color: rgba(226, 74, 74, 0.2);
        }

        .badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
        }

        .badge-success {
            background-color: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .badge-danger {
            background-color: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .badge-warning {
            background-color: rgba(255, 193, 7, 0.1);
            color: var(--warning);
        }

        .btn-outline-purple {
            background-color: transparent;
            border: 1px solid var(--purple);
            color: var(--purple);
            padding: 8px 16px;
        }

        .btn-outline-purple:hover {
            background-color: rgba(138, 43, 226, 0.1);
        }

        .btn-outline-purple:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Пагинация */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-top: 30px;
        }

        .page-info {
            font-size: 0.9rem;
            color: var(--charcoal);
            min-width: 120px;
            text-align: center;
        }

        /* Сообщение об отсутствии записей */
        .no-records {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 1.1rem;
        }

        .no-records i {
            font-size: 2rem;
            color: #ddd;
            margin-bottom: 15px;
            display: block;
        }

        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .admin-content {
                padding: 20px;
            }

            .appointments-table {
                display: block;
                overflow-x: auto;
            }

            .appointments-table th,
            .appointments-table td {
                white-space: nowrap;
            }
        }
    </style>
</head>
<body>
<div class="admin-layout">
    <div class="admin-sidebar">
        <div class="admin-header">
            <div class="admin-title">
                <i class="fas fa-train"></i>
                <h1>ЖД-Портал</h1>
            </div>
    </div>

    <ul class="nav-links">
        <li class="nav-item">
                <a href="${pageContext.request.contextPath}/userHome" class="nav-link">
                    <i class="fas fa-home nav-icon"></i>
                    <span class="nav-text">Главная</span>
            </a>
        </li>
        <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/booking" class="nav-link active">
                    <i class="fas fa-ticket-alt nav-icon"></i>
                    <span class="nav-text">Мои билеты</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reviews" class="nav-link">
                <i class="fas fa-star nav-icon"></i>
                <span class="nav-text">Отзывы</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/userMaster" class="nav-link">
                <i class="fas fa-user nav-icon"></i>
                <span class="nav-text">Профиль</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                <i class="fas fa-sign-out-alt nav-icon"></i>
                <span class="nav-text">Выход</span>
            </a>
        </li>
    </ul>
</div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Мои билеты</h2>
    </div>

    <div class="table-container">
        <table class="appointments-table">
            <thead>
            <tr>
                    <th>PNR код</th>
                    <th>Маршрут</th>
                    <th>Дата отправления</th>
                    <th>Время отправления</th>
                    <th>Время прибытия</th>
                    <th>Место</th>
                    <th>Тип вагона</th>
                <th>Цена</th>
                    <th>Статус</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody id="appointmentsTableBody">
                <!-- Данные будут загружены динамически -->
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button id="prevPage" class="btn btn-outline-purple" disabled>
            <i class="fas fa-chevron-left"></i> Назад
        </button>
        <span id="pageInfo" class="page-info">Страница 1 из 1</span>
        <button id="nextPage" class="btn btn-outline-purple">
            Вперед <i class="fas fa-chevron-right"></i>
        </button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        const token = localStorage.getItem("jwtToken");

        if (!token) {
            console.error("Токен не найден. Пожалуйста, войдите в систему.");
                $('#appointmentsTableBody').html('<tr><td colspan="10" class="no-records"><i class="far fa-ticket-alt"></i><p>Пожалуйста, войдите в систему</p></td></tr>');
            return;
        }

        try {
            const decodedToken = jwt_decode(token);
            const userId = decodedToken.id;
            console.log("ID пользователя:", userId);

            // Загрузка билетов пользователя
            fetch("/tickets/user/" + userId)
                .then(response => {
                    if (!response.ok) throw new Error('Ошибка загрузки билетов');
                    return response.json();
                })
                .then(data => {
                    console.log("Данные билетов:", data);
                    const tableBody = $('#appointmentsTableBody');
                    tableBody.empty();

                    if (data.length === 0) {
                        tableBody.append(
                            '<tr><td colspan="10" class="no-records">' +
                            '<i class="far fa-ticket-alt"></i>' +
                            '<p>У вас пока нет билетов</p>' +
                            '</td></tr>'
                        );
                        return;
                    }

                    data.forEach(ticket => {
                        const route = ticket.route || {};
                        const departureStation = route.departureStation || {};
                        const arrivalStation = route.arrivalStation || {};
                        const routeName = (departureStation.name || 'Н/Д') + ' → ' + (arrivalStation.name || 'Н/Д');
                        
                        const departureDate = route.departureTime ? new Date(route.departureTime) : new Date();
                        const arrivalDate = route.arrivalTime ? new Date(route.arrivalTime) : new Date();
                        
                        const formattedDate = departureDate.toLocaleDateString('ru-RU', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric',
                        });
                        const formattedDepartureTime = departureDate.toLocaleTimeString('ru-RU', {
                            hour: '2-digit',
                            minute: '2-digit',
                        });
                        const formattedArrivalTime = arrivalDate.toLocaleTimeString('ru-RU', {
                            hour: '2-digit',
                            minute: '2-digit',
                        });

                        const status = ticket.status || 'active';
                        const statusClass = status === 'active' ? 'success' : status === 'cancelled' ? 'danger' : 'warning';
                        const statusText = status === 'active' ? 'Активен' : status === 'cancelled' ? 'Отменен' : status;

                        const row =
                            "<tr>" +
                            "<td><strong>" + (ticket.pnrCode || 'Н/Д') + "</strong></td>" +
                            "<td>" + routeName + "</td>" +
                            "<td>" + formattedDate + "</td>" +
                            "<td>" + formattedDepartureTime + "</td>" +
                            "<td>" + formattedArrivalTime + "</td>" +
                            "<td>" + (ticket.seatNumber || 'Не указано') + "</td>" +
                            "<td>" + (ticket.carriageType || 'Стандарт') + "</td>" +
                            "<td><strong>" + (ticket.price || route.price || 0) + " BYN</strong></td>" +
                            "<td><span class='badge badge-" + statusClass + "'>" + statusText + "</span></td>" +
                            "<td>" +
                            (status === 'active' ? 
                                "<button class='btn btn-cancel' onclick='cancelTicket(" + ticket.id + ")'><i class='fas fa-times'></i> Отменить</button>" :
                                "<span style='color: var(--slate);'>-</span>"
                            ) +
                            "</td>" +
                            "</tr>";
                        tableBody.append(row);
                    });
                })
                .catch(error => {
                    console.error('Ошибка при загрузке билетов:', error);
                    $('#appointmentsTableBody').html('<tr><td colspan="10" class="no-records"><i class="fas fa-exclamation-triangle"></i><p>Ошибка загрузки билетов</p></td></tr>');
                });
        } catch (err) {
            console.error("Ошибка при декодировании токена:", err);
        }
    });

    function cancelTicket(id) {
        if (confirm("Вы действительно хотите отменить этот билет?")) {
            fetch('/tickets/' + id, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
                .then(response => {
                    if (response.ok) {
                        alert("Билет успешно отменен");
                        location.reload();
                    } else {
                        return response.json().then(err => {
                            throw new Error(err.message || 'Ошибка при отмене билета');
                        });
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert("Не удалось отменить билет: " + error.message);
                });
        }
    }




    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>