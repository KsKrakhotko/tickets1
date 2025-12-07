<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Добавление Маршрута | ЖД Перевозки</title>
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

        /* Основной лейаут */
        .admin-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        /* Боковая панель - фиолетовый акцент */
        .admin-sidebar {
            background: linear-gradient(to bottom, #FFFFFF, #F8F8F8);
            box-shadow: 5px 0 15px rgba(0,0,0,0.05);
            border-right: 1px solid rgba(138, 43, 226, 0.3);
        }

        /* Логотип и заголовок */
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

        /* Навигация */
        .admin-nav {
            padding: 0 15px;
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

        /* Основное содержимое */
        .admin-content {
            padding: 40px;
            background-color: #FFF;
        }

        /* Заголовок страницы */
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

        /* Форма добавления */
        .add-form-container {
            background: #FFF;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border-top: 4px solid var(--purple);
            max-width: 700px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--charcoal);
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            transition: border 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.15);
        }

        /* Кнопки */
        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 600;
            text-decoration: none;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-purple {
            background: var(--purple);
            color: white;
            width: 100%;
            justify-content: center;
            margin-top: 10px;
        }

        .btn-purple:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

        .btn-back {
            background: var(--slate);
            color: white;
        }

        .btn-back:hover {
            background: var(--charcoal);
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-top: 30px;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            font-weight: 500;
            display: none; /* Скрыто по умолчанию */
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .alert-success {
            background-color: rgba(76, 175, 80, 0.15);
            color: var(--success);
            border: 1px solid var(--success);
        }

        .alert-error {
            background-color: rgba(244, 67, 54, 0.15);
            color: var(--danger);
            border: 1px solid var(--danger);
        }

        .row {
            display: flex;
            gap: 20px;
        }

        .row .form-group {
            flex: 1;
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }

            .row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body data-context-path="${pageContext.request.contextPath}">
<div class="admin-layout">
    <!-- Боковая панель -->
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
            <!-- ССЫЛКА ДОБАВЛЕНИЯ МАРШРУТА АКТИВНА -->
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/routeAdd" class="nav-link active">
                    <i class="fas fa-plus nav-icon"></i>
                    <span class="nav-text">Добавить Маршрут</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users nav-icon"></i>
                    <span class="nav-text">Пассажиры</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/master" class="nav-link">
                    <i class="fas fa-train-subway nav-icon"></i>
                    <span class="nav-text">Поезда</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceAdmin" class="nav-link">
                    <i class="fas fa-city nav-icon"></i>
                    <span class="nav-text">Станции/Тарифы</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Отчеты</span>
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

    <!-- Основное содержимое -->
    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Создание Нового Маршрута</h2>
        </div>

        <div class="add-form-container">
            <!-- Сообщения об успехе/ошибке -->
            <div id="statusMessage" class="alert"></div>

            <form id="routeForm">
                <div class="row">
                    <!-- Поезд ID -->
                    <div class="form-group">
                        <label for="trainId" class="form-label">ID Поезда</label>
                        <!-- В реальном приложении это должен быть <select> или поле с автодополнением -->
                        <input type="number" id="trainId" name="trainId" class="form-control" required placeholder="Например, 101">
                    </div>
                    <!-- Цена -->
                    <div class="form-group">
                        <label for="price" class="form-label">Цена Билета (₽)</label>
                        <input type="number" step="0.01" min="0" id="price" name="price" class="form-control" required placeholder="Например, 2500.50">
                    </div>
                </div>

                <div class="row">
                    <!-- Город Отправления -->
                    <div class="form-group">
                        <label for="departureCity" class="form-label">Город Отправления</label>
                        <!-- В реальном приложении это должен быть <select> или поле с автодополнением -->
                        <input type="text" id="departureCity" name="departureCity" class="form-control" required placeholder="Например, Москва">
                    </div>
                    <!-- Город Прибытия -->
                    <div class="form-group">
                        <label for="arrivalCity" class="form-label">Город Прибытия</label>
                        <!-- В реальном приложении это должен быть <select> или поле с автодополнением -->
                        <input type="text" id="arrivalCity" name="arrivalCity" class="form-control" required placeholder="Например, Санкт-Петербург">
                    </div>
                </div>

                <div class="row">
                    <!-- Время Отправления -->
                    <div class="form-group">
                        <label for="departureTime" class="form-label">Время Отправления</label>
                        <!-- Используем datetime-local для удобного ввода даты и времени -->
                        <input type="datetime-local" id="departureTime" name="departureTime" class="form-control" required>
                    </div>
                    <!-- Время Прибытия -->
                    <div class="form-group">
                        <label for="arrivalTime" class="form-label">Время Прибытия</label>
                        <!-- Используем datetime-local для удобного ввода даты и времени -->
                        <input type="datetime-local" id="arrivalTime" name="arrivalTime" class="form-control" required>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/recordAdmin" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i> Назад к Маршрутам
                    </a>
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-check"></i> Создать Маршрут
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        const contextPath = document.body.getAttribute('data-context-path');
        const statusMessage = $('#statusMessage');
        const routeForm = $('#routeForm');

        /**
         * Показывает сообщение статуса (успех/ошибка).
         */
        function showStatus(message, type) {
            statusMessage.removeClass('alert-success alert-error').text(message);
            statusMessage.addClass('alert-' + type).css('opacity', 1).show();

            // Скрыть сообщение через 5 секунд
            setTimeout(() => {
                statusMessage.css('opacity', 0);
                setTimeout(() => statusMessage.hide(), 500);
            }, 5000);
        }

        /**
         * Преобразует локальное время в формат ISO 8601 (YYYY-MM-DDTHH:MM:SS),
         * который обычно ожидается Spring Boot.
         * Входной формат datetime-local: YYYY-MM-DDTHH:MM
         * Выходной формат: YYYY-MM-DDTHH:MM:00
         */
        function formatDateTimeForBackend(localDateTime) {
            if (!localDateTime) return null;
            // Добавляем секунды :00
            return localDateTime + ':00';
        }

        // Обработчик отправки формы
        routeForm.submit(function(event) {
            event.preventDefault();

            // Собираем данные формы
            const formData = {
                // Предполагаем, что TrainService ожидает trainId
                train: {
                    id: parseInt($('#trainId').val())
                },
                // Предполагаем, что StationService ожидает город для создания/поиска
                departureStation: {
                    city: $('#departureCity').val().trim()
                },
                arrivalStation: {
                    city: $('#arrivalCity').val().trim()
                },
                departureTime: formatDateTimeForBackend($('#departureTime').val()),
                arrivalTime: formatDateTimeForBackend($('#arrivalTime').val()),
                price: parseFloat($('#price').val()),
                // Количество доступных мест. В идеале, это должно браться из поезда
                availableSeats: 50 // Фиксированное значение для примера
            };

            // Простая валидация
            if (formData.departureTime >= formData.arrivalTime) {
                showStatus('Время отправления должно быть раньше времени прибытия!', 'error');
                return;
            }

            if (formData.departureStation.city === formData.arrivalStation.city) {
                showStatus('Города отправления и прибытия не могут совпадать!', 'error');
                return;
            }

            // Отправка AJAX POST запроса
            $.ajax({
                url: contextPath + '/routes', // Endpoint для создания Route
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    showStatus('Маршрут успешно создан! ID: ' + (response.id || 'Н/Д'), 'success');
                    // Очистка формы после успешного создания
                    routeForm[0].reset();
                },
                error: function(xhr, status, error) {
                    let errorMessage = 'Не удалось создать маршрут.';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMessage += ' Причина: ' + xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        // Попытка извлечь текст ошибки из ответа
                        errorMessage += ' Ошибка: ' + xhr.responseText.substring(0, 100) + '...';
                    } else {
                        errorMessage += ' Код ошибки: ' + xhr.status;
                    }
                    showStatus(errorMessage, 'error');
                    console.error('Ошибка создания маршрута:', xhr.responseText);
                }
            });
        });
    });

    // Функция выхода (сохранена)
    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>