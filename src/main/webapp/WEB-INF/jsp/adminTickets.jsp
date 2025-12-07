<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление билетами | Железнодорожный Администратор</title>
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

        .admin-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-purple {
            background: var(--purple);
            color: white;
        }

        .btn-purple:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        .btn-outline-purple {
            background: transparent;
            border: 1px solid var(--purple);
            color: var(--purple);
        }

        .btn-outline-purple:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .tickets-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .tickets-table th {
            background: var(--purple);
            color: #fff;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
        }

        .tickets-table td {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-size: 0.9rem;
        }

        .tickets-table tr:last-child td {
            border-bottom: none;
        }

        .tickets-table tr:hover td {
            background: rgba(138, 43, 226, 0.1);
            transition: background-color 0.3s ease;
        }

        .tickets-table tr:nth-child(even) td {
            background: #f9f9f9;
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

        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            margin-bottom: 5px;
            font-weight: 500;
            color: var(--charcoal);
            font-size: 0.9rem;
        }

        .form-control {
            padding: 10px 12px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .no-records {
            text-align: center;
            padding: 50px;
            color: var(--slate);
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

            .tickets-table {
                display: block;
                overflow-x: auto;
            }

            .filter-row {
                grid-template-columns: 1fr;
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
                <h1>ЖД Админ</h1>
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
                    <i class="fas fa-tachometer-alt nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminStations" class="nav-link">
                    <i class="fas fa-building nav-icon"></i>
                    <span class="nav-text">Станции</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTrains" class="nav-link">
                    <i class="fas fa-train-subway nav-icon"></i>
                    <span class="nav-text">Поезда</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTickets" class="nav-link active">
                    <i class="fas fa-ticket-alt nav-icon"></i>
                    <span class="nav-text">Билеты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users nav-icon"></i>
                    <span class="nav-text">Клиенты/Пассажиры</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Отчёты</span>
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
            <h2 class="page-title">Управление билетами</h2>
            <div class="admin-actions">
                <button id="exportExcelBtn" class="btn btn-purple">
                    <i class="fas fa-file-excel"></i> Экспорт в Excel
                </button>
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-row">
                <div class="form-group">
                    <label class="form-label">Фильтр по статусу</label>
                    <select id="statusFilter" class="form-control">
                        <option value="">Все статусы</option>
                        <option value="active">Активные</option>
                        <option value="cancelled">Отмененные</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Поиск по PNR коду</label>
                    <input type="text" id="pnrSearch" class="form-control" placeholder="Введите PNR код">
                </div>
                <div class="form-group">
                    <button id="clearFilter" class="btn btn-outline-purple" style="margin-top: 24px;">
                        <i class="fas fa-times"></i> Сбросить фильтры
                    </button>
                </div>
            </div>
        </div>

        <table class="tickets-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>PNR код</th>
                <th>Пользователь</th>
                <th>Маршрут</th>
                <th>Дата отправления</th>
                <th>Время отправления</th>
                <th>Место</th>
                <th>Тип вагона</th>
                <th>Цена</th>
                <th>Статус</th>
                <th>Дата покупки</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody id="ticketsTableBody">
            <tr>
                <td colspan="12" style="text-align: center; padding: 30px; color: var(--slate);">Загрузка билетов...</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
    let allTickets = [];

    $(document).ready(function() {
        loadTickets();

        $('#statusFilter, #pnrSearch').on('change keyup', function() {
            filterTickets();
        });

        $('#clearFilter').on('click', function() {
            $('#statusFilter').val('');
            $('#pnrSearch').val('');
            filterTickets();
        });

        $('#exportExcelBtn').on('click', function() {
            exportToExcel();
        });

        $(document).on('click', '.delete-ticket', function() {
            const ticketId = $(this).data('id');
            deleteTicket(ticketId);
        });

        $(document).on('click', '.change-status', function() {
            const ticketId = $(this).data('id');
            const currentStatus = $(this).data('status');
            const newStatus = currentStatus === 'active' ? 'cancelled' : 'active';
            changeTicketStatus(ticketId, newStatus);
        });
    });

    function loadTickets() {
        $.ajax({
            url: '/tickets',
            type: 'GET',
            dataType: 'json',
            success: function(tickets) {
                console.log('Полученные билеты:', tickets);
                allTickets = tickets || [];
                filterTickets();
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при загрузке билетов:', error);
                $('#ticketsTableBody').html(
                    '<tr><td colspan="12" class="no-records">' +
                    '<i class="fas fa-exclamation-triangle"></i>' +
                    '<p>Ошибка загрузки билетов</p>' +
                    '</td></tr>'
                );
            }
        });
    }

    function filterTickets() {
        const statusFilter = $('#statusFilter').val();
        const pnrSearch = $('#pnrSearch').val().toLowerCase();

        let filteredTickets = allTickets;

        if (statusFilter) {
            filteredTickets = filteredTickets.filter(ticket => ticket.status === statusFilter);
        }

        if (pnrSearch) {
            filteredTickets = filteredTickets.filter(ticket => 
                ticket.pnrCode && ticket.pnrCode.toLowerCase().includes(pnrSearch)
            );
        }

        displayTickets(filteredTickets);
    }

    function displayTickets(tickets) {
        const tableBody = $('#ticketsTableBody');
        tableBody.empty();

        if (tickets.length === 0) {
            tableBody.html(
                '<tr><td colspan="12" class="no-records">' +
                '<i class="far fa-ticket-alt"></i>' +
                '<p>Билеты не найдены</p>' +
                '</td></tr>'
            );
            return;
        }

        tickets.forEach(function(ticket) {
            const user = ticket.user || {};
            const route = ticket.route || {};
            const departureStation = route.departureStation || {};
            const arrivalStation = route.arrivalStation || {};
            const routeName = (departureStation.name || 'Н/Д') + ' → ' + (arrivalStation.name || 'Н/Д');

            const departureDate = route.departureTime ? new Date(route.departureTime) : null;
            const purchaseDate = ticket.purchaseTime ? new Date(ticket.purchaseTime) : null;

            const formattedDepartureDate = departureDate ? departureDate.toLocaleDateString('ru-RU', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            }) : 'Н/Д';

            const formattedDepartureTime = departureDate ? departureDate.toLocaleTimeString('ru-RU', {
                hour: '2-digit',
                minute: '2-digit'
            }) : 'Н/Д';

            const formattedPurchaseDate = purchaseDate ? purchaseDate.toLocaleDateString('ru-RU', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            }) : 'Н/Д';

            const status = ticket.status || 'active';
            const statusClass = status === 'active' ? 'success' : status === 'cancelled' ? 'danger' : 'warning';
            const statusText = status === 'active' ? 'Активен' : status === 'cancelled' ? 'Отменен' : status;

            const row = $('<tr>');
            row.html(
                '<td>' + (ticket.id || 'Н/Д') + '</td>' +
                '<td><strong>' + (ticket.pnrCode || 'Н/Д') + '</strong></td>' +
                '<td>' + (user.username || 'Н/Д') + '</td>' +
                '<td>' + routeName + '</td>' +
                '<td>' + formattedDepartureDate + '</td>' +
                '<td>' + formattedDepartureTime + '</td>' +
                '<td>' + (ticket.seatNumber || 'Н/Д') + '</td>' +
                '<td>' + (ticket.carriageType || 'Стандарт') + '</td>' +
                '<td><strong>' + (ticket.price || route.price || 0) + ' BYN</strong></td>' +
                '<td><span class="badge badge-' + statusClass + '">' + statusText + '</span></td>' +
                '<td>' + formattedPurchaseDate + '</td>' +
                '<td>' +
                '<button class="btn btn-outline-purple change-status" data-id="' + ticket.id + '" data-status="' + status + '" style="margin-right: 5px; padding: 5px 10px; font-size: 0.8rem;">' +
                '<i class="fas fa-exchange-alt"></i> ' + (status === 'active' ? 'Отменить' : 'Активировать') +
                '</button>' +
                '<button class="btn btn-danger delete-ticket" data-id="' + ticket.id + '" style="padding: 5px 10px; font-size: 0.8rem;">' +
                '<i class="fas fa-trash"></i> Удалить' +
                '</button>' +
                '</td>'
            );
            tableBody.append(row);
        });
    }

    function deleteTicket(ticketId) {
        if (!confirm('Вы действительно хотите удалить этот билет? Это действие нельзя отменить.')) {
            return;
        }

        $.ajax({
            url: '/tickets/' + ticketId,
            type: 'DELETE',
            success: function() {
                alert('Билет успешно удален');
                loadTickets();
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при удалении билета:', error);
                alert('Ошибка при удалении билета: ' + (xhr.responseJSON?.message || error));
            }
        });
    }

    function changeTicketStatus(ticketId, newStatus) {
        $.ajax({
            url: '/tickets/' + ticketId + '/status',
            type: 'PATCH',
            contentType: 'application/json',
            data: '"' + newStatus + '"', // Отправляем строку в кавычках как JSON
            success: function() {
                alert('Статус билета успешно изменен');
                loadTickets();
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при изменении статуса:', error);
                console.error('Ответ сервера:', xhr.responseText);
                alert('Ошибка при изменении статуса: ' + (xhr.responseJSON?.message || xhr.responseText || error));
            }
        });
    }

    function exportToExcel() {
        // Подготовка данных для экспорта
        const data = [
            ['ID', 'PNR код', 'Пользователь', 'Маршрут', 'Дата отправления', 'Время отправления', 'Место', 'Тип вагона', 'Цена', 'Статус', 'Дата покупки']
        ];
        
        allTickets.forEach(function(ticket) {
            const user = ticket.user || {};
            const route = ticket.route || {};
            const departureStation = route.departureStation || {};
            const arrivalStation = route.arrivalStation || {};
            const routeName = (departureStation.name || 'Н/Д') + ' → ' + (arrivalStation.name || 'Н/Д');
            
            const departureDate = route.departureTime ? new Date(route.departureTime) : null;
            const purchaseDate = ticket.purchaseTime ? new Date(ticket.purchaseTime) : null;
            
            data.push([
                ticket.id || '',
                ticket.pnrCode || '',
                user.username || '',
                routeName,
                departureDate ? departureDate.toLocaleDateString('ru-RU') : '',
                departureDate ? departureDate.toLocaleTimeString('ru-RU') : '',
                ticket.seatNumber || '',
                ticket.carriageType || '',
                ticket.price || route.price || 0,
                ticket.status || '',
                purchaseDate ? purchaseDate.toLocaleString('ru-RU') : ''
            ]);
        });

        // Создание рабочего листа
        const ws = XLSX.utils.aoa_to_sheet(data);
        
        // Установка ширины колонок
        const colWidths = [
            { wch: 8 },   // ID
            { wch: 15 },  // PNR код
            { wch: 20 },  // Пользователь
            { wch: 30 },  // Маршрут
            { wch: 15 },  // Дата отправления
            { wch: 15 },  // Время отправления
            { wch: 10 },  // Место
            { wch: 15 },  // Тип вагона
            { wch: 12 },  // Цена
            { wch: 12 },  // Статус
            { wch: 20 }   // Дата покупки
        ];
        ws['!cols'] = colWidths;

        // Создание рабочей книги
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, 'Билеты');

        // Экспорт в файл
        const fileName = 'tickets_' + new Date().toISOString().split('T')[0] + '.xlsx';
        XLSX.writeFile(wb, fileName);
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


