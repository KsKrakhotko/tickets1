<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление поездами | ЖД Администратор</title>
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

        .trains-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .train-card {
            background: #FFF;
            display: block;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 3px solid var(--purple);
            color: black !important;
        }

        .train-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .train-image {
            height: 100px;
            background-color: #f6f6f6;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--purple);
            font-size: 2.5rem;
        }

        .train-body {
            padding: 20px;
        }

        .train-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            margin-bottom: 10px;
            color: var(--charcoal);
        }

        .train-meta {
            display: flex;
            flex-direction: column;
            gap: 5px;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .train-detail {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px dotted #e0e0e0;
            padding-bottom: 5px;
        }

        .train-label {
            font-weight: 500;
            color: var(--slate);
        }

        .train-value {
            font-weight: 600;
            color: var(--charcoal);
        }

        .train-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
        }

        .btn i {
            margin-right: 6px;
        }

        .btn-purple {
            background: var(--purple);
            color: white;
        }

        .btn-purple:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

        .btn-outline-purple {
            background: transparent;
            color: var(--purple);
            border: 1px solid var(--purple);
        }

        .btn-outline-purple:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }

        .train-form {
            background: #FFF;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            border-top: 3px solid var(--purple);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--charcoal);
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            transition: border 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: #FFF;
            width: 500px;
            max-width: 90%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 30px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s ease;
        }

        .modal-header {
            padding: 20px;
            background: var(--purple);
            color: white;
            font-family: 'Playfair Display', serif;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            background: #f9f9f9;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
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
                    <span class="badge" id="activeRoutesBadge">...</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminStations" class="nav-link">
                    <i class="fas fa-building nav-icon"></i>
                    <span class="nav-text">Станции</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTrains" class="nav-link active">
                    <i class="fas fa-train-subway nav-icon"></i>
                    <span class="nav-text">Поезда</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTickets" class="nav-link">
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
                    <span class="nav-text">Отчеты/Статистика</span>
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
            <h2 class="page-title">Управление поездами</h2>
            <div class="admin-actions">
                <button id="addTrainBtn" class="btn btn-purple">
                    <i class="fas fa-plus"></i> Добавить поезд
                </button>
                <button id="exportExcelBtn" class="btn btn-purple">
                    <i class="fas fa-file-excel"></i> Экспорт в Excel
                </button>
            </div>
        </div>

        <div id="trainForm" class="train-form" style="display: none;">
            <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif;" id="formTitle">Добавить новый поезд</h3>
            <form id="trainFormElement">
                <input type="hidden" id="trainId">

                <div class="form-group">
                    <label for="trainNumber" class="form-label">Номер поезда</label>
                    <input type="text" id="trainNumber" class="form-control" required>
                </div>

                <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="trainName" class="form-label">Название / Марка</label>
                        <input type="text" id="trainName" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="trainType" class="form-label">Тип поезда</label>
                        <select id="trainType" class="form-control">
                            <option value="">Выберите тип</option>
                            <option value="Пассажирский">Пассажирский</option>
                            <option value="Скоростной">Скоростной</option>
                            <option value="Экспресс">Экспресс</option>
                            <option value="Местный">Местный</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="totalSeats" class="form-label">Общее количество мест</label>
                    <input type="number" id="totalSeats" class="form-control" required min="1" step="1">
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
                    <button type="button" id="cancelFormBtn" class="btn btn-outline-purple">Отмена</button>
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-save"></i> Сохранить
                    </button>
                </div>
            </form>
        </div>

        <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-list" style="color: var(--purple); margin-right: 10px;"></i>
            Список поездов
        </h3>

        <div class="trains-grid">
        </div>

        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Подтверждение удаления</h3>
                </div>
                <div class="modal-body">
                    <p>Вы уверены, что хотите удалить этот поезд? Это действие нельзя отменить.</p>
                </div>
                <div class="modal-footer">
                    <button id="cancelDeleteBtn" class="btn btn-outline-purple">Отмена</button>
                    <button id="confirmDeleteBtn" class="btn btn-danger">Удалить</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let trainsData = [];

    $(document).ready(function() {

        // --- Обработчики формы ---

        // Показать форму добавления поезда
        $('#addTrainBtn').click(function() {
            $('#formTitle').text('Добавить новый поезд');
            $('#trainForm').show();
            $('#trainFormElement')[0].reset();
            $('#trainId').val('');
            $('html, body').animate({
                scrollTop: $('#trainForm').offset().top - 20
            }, 300);
        });

        // Скрыть форму
        $('#cancelFormBtn').click(function() {
            $('#trainForm').hide();
        });

        // Обработка отправки формы (Добавление/Редактирование)
        $('#trainFormElement').submit(function(e) {
            e.preventDefault();

            const isNew = !$('#trainId').val();
            const url = isNew ? '${pageContext.request.contextPath}/api/trains' : '${pageContext.request.contextPath}/api/trains/' + $('#trainId').val();
            const type = isNew ? 'POST' : 'PUT';

            const formData = {
                trainNumber: $('#trainNumber').val(),
                trainName: $('#trainName').val(),
                trainType: $('#trainType').val(),
                totalSeats: parseInt($('#totalSeats').val())
            };

            $.ajax({
                url: url,
                type: type,
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    alert('Поезд успешно сохранен!');
                    $('#trainForm').hide();
                    loadTrains();
                },
                error: function(xhr) {
                    let errorMsg = 'Ошибка при сохранении поезда!';
                    if (xhr.status === 400 && xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = 'Ошибка: ' + xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        try {
                            const error = JSON.parse(xhr.responseText);
                            if (error.message) {
                                errorMsg = 'Ошибка: ' + error.message;
                            }
                        } catch (e) {
                            errorMsg = 'Ошибка: ' + xhr.responseText;
                        }
                    }
                    console.error('Ошибка при сохранении поезда:', errorMsg);
                    alert(errorMsg);
                }
            });
        });

        // --- Редактирование ---

        $(document).on('click', '.edit-train', function() {
            const trainIdStr = $(this).attr('data-id');
            if (!trainIdStr || trainIdStr === '') {
                alert('Ошибка: не удалось получить ID поезда');
                return;
            }
            const trainId = parseInt(trainIdStr, 10);
            if (isNaN(trainId) || trainId <= 0) {
                alert('Ошибка: неверный ID поезда');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/api/trains/' + trainId,
                type: 'GET',
                success: function(train) {
                    $('#formTitle').text('Редактировать поезд');
                    $('#trainId').val(train.id);
                    $('#trainNumber').val(train.trainNumber || '');
                    $('#trainName').val(train.trainName || '');
                    $('#trainType').val(train.trainType || '');
                    $('#totalSeats').val(train.totalSeats || '');

                    // Показать форму редактирования
                    $('#trainForm').show();
                    $('html, body').animate({
                        scrollTop: $('#trainForm').offset().top - 20
                    }, 300);
                },
                error: function(xhr) {
                    let errorMsg = 'Ошибка при загрузке данных поезда.';
                    if (xhr.status === 404) {
                        errorMsg = 'Поезд не найден.';
                    }
                    alert(errorMsg);
                }
            });
        });

        // --- Удаление ---

        let trainToDelete = null;
        $(document).on('click', '.delete-train', function() {
            const idStr = $(this).attr('data-id');
            if (!idStr || idStr === '') {
                alert('Ошибка: не удалось получить ID поезда');
                return;
            }
            const id = parseInt(idStr, 10);
            if (isNaN(id) || id <= 0) {
                alert('Ошибка: неверный ID поезда');
                return;
            }
            trainToDelete = id;
            $('#deleteModal').css('display', 'flex');
        });

        $('#cancelDeleteBtn').click(function() {
            $('#deleteModal').css('display', 'none');
            trainToDelete = null;
        });

        $('#confirmDeleteBtn').click(function() {
            if (trainToDelete) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/api/trains/' + trainToDelete,
                    type: 'DELETE',
                    success: function() {
                        alert('Поезд успешно удален!');
                        $('#deleteModal').css('display', 'none');
                        trainToDelete = null;
                        loadTrains();
                    },
                    error: function(xhr) {
                        let errorMsg = 'Произошла ошибка при удалении поезда.';
                        if (xhr.status === 404) {
                            errorMsg = 'Поезд не найден.';
                        } else if (xhr.responseText) {
                            try {
                                const error = JSON.parse(xhr.responseText);
                                if (error.message) {
                                    errorMsg = 'Ошибка: ' + error.message;
                                }
                            } catch (e) {
                                errorMsg = 'Ошибка: ' + xhr.responseText;
                            }
                        }
                        alert(errorMsg);
                        $('#deleteModal').css('display', 'none');
                        trainToDelete = null;
                    }
                });
            }
        });

        // --- Загрузка списка поездов ---

        function loadTrains() {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/trains',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    $('.trains-grid').empty();
                    trainsData = Array.isArray(response) ? response : [];

                    if (!trainsData || trainsData.length === 0) {
                        $('.trains-grid').html('<p style="padding: 20px; text-align: center; color: var(--slate);">Нет доступных поездов. Добавьте первый поезд.</p>');
                        return;
                    }

                    trainsData.forEach(function(train) {
                        const id = train.id ? train.id : null;
                        if (!id) {
                            console.warn('Поезд без ID пропущен:', train);
                            return;
                        }

                        const trainCard =
                            '<div class="train-card">' +
                            '<div class="train-image">' +
                            '<i class="fas fa-train-subway"></i>' +
                            '</div>' +
                            '<div class="train-body">' +
                            '<h3 class="train-title">Поезд №' + (train.trainNumber || 'Н/Д') + '</h3>' +
                            '<div class="train-meta">' +
                            '<div class="train-detail"><span class="train-label">Название:</span> <span class="train-value">' + (train.trainName || 'Н/Д') + '</span></div>' +
                            '<div class="train-detail"><span class="train-label">Тип:</span> <span class="train-value">' + (train.trainType || 'Н/Д') + '</span></div>' +
                            '<div class="train-detail"><span class="train-label">Места (Всего):</span> <span class="train-value">' + (train.totalSeats || 0) + '</span></div>' +
                            '</div>' +
                            '<div class="train-actions">' +
                            '<button class="btn btn-outline-purple edit-train" data-id="' + id + '">' +
                            '<i class="fas fa-edit"></i> Редактировать' +
                            '</button>' +
                            '<button class="btn btn-danger delete-train" data-id="' + id + '">' +
                            '<i class="fas fa-trash"></i> Удалить' +
                            '</button>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        $('.trains-grid').append(trainCard);
                    });
                },
                error: function(xhr) {
                    console.error('Ошибка загрузки поездов:', xhr);
                    $('.trains-grid').html('<p style="color: var(--danger); text-align: center; padding: 20px;">Ошибка загрузки списка поездов.</p>');
                }
            });
        }

        // --- Экспорт в Excel ---
        $('#exportExcelBtn').click(function () {
            if (!trainsData || trainsData.length === 0) {
                alert('Нет данных для экспорта.');
                return;
            }

            const worksheetData = trainsData.map(train => ({
                ID: train.id,
                'Номер поезда': train.trainNumber || 'Н/Д',
                Название: train.trainName || 'Н/Д',
                Тип: train.trainType || 'Н/Д',
                'Общее кол-во мест': train.totalSeats || 0,
            }));

            const workbook = XLSX.utils.book_new();
            const worksheet = XLSX.utils.json_to_sheet(worksheetData);
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Поезда');
            XLSX.writeFile(workbook, 'trains.xlsx');
        });

        // Загружаем все поезда при загрузке страницы
        loadTrains();
    });

    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>
