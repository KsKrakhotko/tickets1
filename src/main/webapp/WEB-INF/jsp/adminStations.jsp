<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ-центр | Управление станциями</title>
    <!-- ФОНТЫ И СТИЛИ - ПОВТОРЯЮТ ГЛАВНУЮ ПАНЕЛЬ -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* CSS ОПРЕДЕЛЕНИЯ ПАЛИТРЫ И БАЗОВОГО МАКЕТА */
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
            --border-color: rgba(138, 43, 226, 0.15);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

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
            flex-shrink: 0;
        }

        /* Заголовок боковой панели */
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
        .nav-links { list-style: none; padding: 0; }
        .nav-item { margin-bottom: 5px; }

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

        /* Контент */
        .admin-content {
            padding: 40px;
            background-color: #FFF;
            overflow-y: auto;
        }

        .page-header {
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

        /* --- Стили Карточек и Форм --- */
        .card {
            background-color: #FFF;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            border: 1px solid var(--border-color);
            transition: box-shadow 0.3s;
        }
        .card:hover {
            box-shadow: 0 8px 20px rgba(138, 43, 226, 0.1);
        }

        h3.card-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.35rem;
            font-weight: 600;
            color: var(--dark-purple);
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 1px dashed var(--border-color);
        }

        .form-group { margin-bottom: 20px; }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            color: var(--charcoal);
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid rgba(138, 43, 226, 0.3);
            border-radius: 8px;
            transition: border-color 0.3s, box-shadow 0.3s;
            background-color: #FFF;
            font-size: 1rem;
        }

        .form-group input[type="text"]:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
            background-color: #FFF;
        }

        /* --- Стили Кнопок --- */
        .button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background-color 0.3s, transform 0.1s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .button i { margin-right: 8px; }

        .button-primary {
            background-color: var(--purple);
            color: white;
        }
        .button-primary:hover {
            background-color: var(--dark-purple);
            transform: translateY(-1px);
        }

        .button-info {
            background-color: var(--slate);
            color: white;
            padding: 8px 14px;
            margin-right: 8px;
        }
        .button-info:hover { background-color: #5A6978; }

        .button-danger {
            background-color: var(--danger);
            color: white;
            padding: 8px 14px;
        }
        .button-danger:hover { background-color: #C62828; }

        /* --- Стили Таблицы --- */
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        th {
            background-color: var(--purple);
            color: white;
            text-transform: uppercase;
            font-size: 0.8rem;
            font-weight: 700;
        }
        tr:last-child td { border-bottom: none; }
        tr:nth-child(even) { background-color: var(--light-purple); }
        tr:hover { background-color: rgba(138, 43, 226, 0.1); }

        /* Загрузка/Пустое состояние */
        #stationsContainer {
            min-height: 100px;
        }
        .text-muted {
            color: var(--slate);
        }

        /* --- Стили Модальных Окон --- */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 30px;
            border: 2px solid var(--purple);
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid var(--light-purple);
        }
        .modal-header h3 {
            font-family: 'Playfair Display', serif;
            color: var(--purple);
            margin: 0;
        }
        .close {
            color: var(--slate);
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover { color: var(--danger); }
        .modal-body { margin-bottom: 20px; }
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        /* --- Адаптивность --- */
        @media (max-width: 1024px) {
            .admin-layout {
                grid-template-columns: 240px 1fr;
            }
        }

        @media (max-width: 768px) {
            .admin-layout {
                display: flex;
                flex-direction: column;
            }
            .admin-sidebar {
                width: 100%;
                height: auto;
                padding: 10px 0;
                border-right: none;
                border-bottom: 1px solid rgba(138, 43, 226, 0.3);
            }
            .admin-header {
                display: none;
            }
            .nav-links {
                display: flex;
                flex-wrap: nowrap;
                justify-content: space-between;
                overflow-x: auto;
            }
            .nav-item {
                flex: 0 0 auto;
                margin-bottom: 0;
            }
            .nav-link {
                padding: 10px 15px;
                white-space: nowrap;
                border-radius: 0;
            }
            .nav-link span { display: none; }
            .nav-link i { margin-right: 0; }
            .nav-link.active {
                border-left: none;
                border-bottom: 3px solid var(--purple);
            }

            .admin-content {
                padding: 20px;
            }

            .card {
                padding: 20px;
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
                <a href="${pageContext.request.contextPath}/adminStations" class="nav-link active">
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
            <h2 class="page-title">Управление станциями</h2>
        </div>

        <div class="card">
            <h3 class="card-title">
                <i class="fas fa-plus-circle" style="color: var(--purple); margin-right: 10px;"></i>
                Добавить новую станцию
            </h3>
            <form id="stationForm">
                <div class="form-group">
                    <label for="name">Название станции:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="city">Город:</label>
                    <input type="text" id="city" name="city" required>
                </div>
                <div class="form-group">
                    <label for="region">Регион:</label>
                    <input type="text" id="region" name="region">
                </div>
                <button type="submit" class="button button-primary">
                    <i class="fas fa-save"></i> Сохранить станцию
                </button>
            </form>
        </div>

        <div class="card">
            <h3 class="card-title">
                <i class="fas fa-list-alt" style="color: var(--purple); margin-right: 10px;"></i>
                Список всех станций
            </h3>
            <div id="stationsContainer" class="table-container">
                <p class="text-muted" style="text-align: center; padding: 20px;">Загрузка станций...</p>
            </div>
        </div>
    </div>
</div>

<!-- Модальное окно для редактирования -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-edit"></i> Редактировать станцию</h3>
            <span class="close" onclick="closeEditModal()">&times;</span>
        </div>
        <div class="modal-body">
            <form id="editStationForm">
                <input type="hidden" id="editStationId">
                <div class="form-group">
                    <label for="editName">Название станции:</label>
                    <input type="text" id="editName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="editCity">Город:</label>
                    <input type="text" id="editCity" name="city" required>
                </div>
                <div class="form-group">
                    <label for="editRegion">Регион:</label>
                    <input type="text" id="editRegion" name="region">
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="button button-info" onclick="closeEditModal()">Отмена</button>
            <button type="button" class="button button-primary" onclick="saveStationChanges()">Сохранить изменения</button>
        </div>
    </div>
</div>

<script>
(function() {
    'use strict';
    
    // Функция для безопасного экранирования HTML
    function escapeHtml(text) {
        if (text == null || text === undefined) return '';
        const div = document.createElement('div');
        div.textContent = String(text);
        return div.innerHTML;
    }

    // Функция для безопасной подготовки строки для JavaScript
    function escapeJsString(text) {
        if (text == null || text === undefined) return '';
        return String(text).replace(/\\/g, '\\\\')
                          .replace(/'/g, "\\'")
                          .replace(/"/g, '\\"')
                          .replace(/\n/g, '\\n')
                          .replace(/\r/g, '\\r');
    }

    // Загрузка списка станций
    function loadStations() {
        const container = document.getElementById('stationsContainer');
        container.innerHTML = '<p class="text-muted" style="text-align: center; padding: 20px;">Загрузка станций...</p>';

        fetch('${pageContext.request.contextPath}/api/stations')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Ошибка загрузки: ' + response.status);
                }
                return response.json();
            })
            .then(stations => {
                if (!Array.isArray(stations)) {
                    container.innerHTML = '<p style="color: red;">Ошибка: неверный формат данных</p>';
                    return;
                }

                if (stations.length === 0) {
                    container.innerHTML = '<p style="padding: 20px; text-align: center; color: var(--slate);">Станций пока нет. Добавьте первую станцию выше.</p>';
                    return;
                }

                let html = '<table><thead><tr><th>ID</th><th>Название</th><th>Город</th><th>Регион</th><th>Действия</th></tr></thead><tbody>';

                stations.forEach(station => {
                    const id = station && station.id != null ? String(station.id) : '';
                    const name = station && station.name != null ? String(station.name) : '';
                    const city = station && station.city != null ? String(station.city) : '';
                    const region = station && station.region != null ? String(station.region) : '';
                    
                    const nameEscaped = escapeHtml(name);
                    const cityEscaped = escapeHtml(city);
                    const regionEscaped = escapeHtml(region);
                    const nameForJs = escapeJsString(name);
                    
                    html += '<tr>' +
                        '<td>' + id + '</td>' +
                        '<td>' + nameEscaped + '</td>' +
                        '<td>' + cityEscaped + '</td>' +
                        '<td>' + regionEscaped + '</td>' +
                        '<td>' +
                        '<button class="button button-info" onclick="editStation(' + id + ')"><i class="fas fa-edit"></i> Редактировать</button> ' +
                        '<button class="button button-danger" onclick="deleteStationPrompt(' + id + ', \'' + nameForJs + '\')"><i class="fas fa-trash-alt"></i> Удалить</button>' +
                        '</td>' +
                        '</tr>';
                });

                html += '</tbody></table>';
                container.innerHTML = html;
            })
            .catch(error => {
                console.error('Ошибка загрузки станций:', error);
                container.innerHTML = '<p style="color: var(--danger); text-align: center; padding: 20px;">Ошибка загрузки станций. Проверьте консоль браузера.</p>';
            });
    }

    // Добавление новой станции
    const form = document.getElementById('stationForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = {
                name: document.getElementById('name').value,
                city: document.getElementById('city').value,
                region: document.getElementById('region').value
            };

            fetch('${pageContext.request.contextPath}/api/stations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => {
                if (response.ok) {
                    alert('Станция успешно добавлена!');
                    form.reset();
                    loadStations();
                } else {
                    return response.text().then(text => {
                        throw new Error(text || 'Ошибка при добавлении станции');
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Ошибка при добавлении станции: ' + error.message);
            });
        });
    }

    // Функция-обертка для вызова подтверждения
    window.deleteStationPrompt = function(id, name) {
        if (!confirm('Удалить станцию "' + name + '" (ID: ' + id + ')?')) {
            return;
        }
        deleteStation(id);
    };

    // Удаление станции
    function deleteStation(id) {
        if (!id || id === 0) {
            alert('Неверный ID станции');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/api/stations/' + id, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
                alert('Станция успешно удалена!');
                loadStations();
            } else {
                alert('Ошибка при удалении станции');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Ошибка при удалении станции');
        });
    }

    // Открытие модального окна для редактирования
    window.editStation = function(id) {
        if (!id || id === 0) {
            alert('Неверный ID станции');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/api/stations/' + id)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Ошибка загрузки станции');
                }
                return response.json();
            })
            .then(station => {
                document.getElementById('editStationId').value = station.id;
                document.getElementById('editName').value = station.name || '';
                document.getElementById('editCity').value = station.city || '';
                document.getElementById('editRegion').value = station.region || '';
                document.getElementById('editModal').style.display = 'block';
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Ошибка при загрузке данных станции: ' + error.message);
            });
    };

    // Закрытие модального окна
    window.closeEditModal = function() {
        document.getElementById('editModal').style.display = 'none';
        document.getElementById('editStationForm').reset();
    };

    // Сохранение изменений станции
    window.saveStationChanges = function() {
        const id = document.getElementById('editStationId').value;
        if (!id || id === 0) {
            alert('Неверный ID станции');
            return;
        }
        
        const formData = {
            name: document.getElementById('editName').value,
            city: document.getElementById('editCity').value,
            region: document.getElementById('editRegion').value
        };
        
        if (!formData.name || !formData.city) {
            alert('Пожалуйста, заполните все обязательные поля (Название и Город)');
            return;
        }
        
        fetch('${pageContext.request.contextPath}/api/stations/' + id, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
        .then(response => {
            if (response.ok) {
                alert('Станция успешно обновлена!');
                closeEditModal();
                loadStations();
            } else {
                return response.text().then(text => {
                    throw new Error(text || 'Ошибка при обновлении станции');
                });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Ошибка при обновлении станции: ' + error.message);
        });
    };

    // Закрытие модального окна при клике вне его
    window.onclick = function(event) {
        const modal = document.getElementById('editModal');
        if (event.target === modal) {
            closeEditModal();
        }
    };

    // Логика выхода
    function logout() {
        window.location.href = "/home";
    }
    window.logout = logout;

    // Загружаем станции при загрузке страницы
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', loadStations);
    } else {
        loadStations();
    }
})();
</script>
</body>
</html>
