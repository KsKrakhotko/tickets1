<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Управление мастерами | Парикмахерская "Элегант"</title>
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

        /* Боковая панель */
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

        /* Форма */
        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--charcoal);
        }

        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            background-color: #f9f9f9;
            transition: border 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 2px rgba(138, 43, 226, 0.2);
        }

        /* Кнопки */
        .btn {
            padding: 12px 24px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
            font-family: 'Montserrat', sans-serif;
        }

        .btn i {
            margin-right: 8px;
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

        .btn-outline {
            background: transparent;
            border: 1px solid var(--purple);
            color: var(--purple);
        }

        .btn-outline:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        /* Таблица */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background: #FFF;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .data-table th {
            background: var(--charcoal);
            color: #FFF;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
        }

        .data-table td {
            padding: 12px 20px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover {
            background: rgba(138, 43, 226, 0.03);
        }

        .action-btns {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            font-size: 0.85rem;
            border-radius: 4px;
            display: inline-flex;
            align-items: center;
        }

        .action-btn i {
            margin-right: 5px;
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="admin-layout">
    <!-- Боковая панель -->
    <div class="admin-sidebar">
        <div class="admin-header">
            <div class="admin-title">
                <i class="fas fa-crown"></i>
                <h1>Элегант Админ</h1>
            </div>
        </div>

        <nav class="admin-nav">
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Главная</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link">
                    <i class="fas fa-calendar-check"></i>
                    <span>Записи</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Клиенты</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/master" class="nav-link active">
                    <i class="fas fa-user-tie"></i>
                    <span>Персонал</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceAdmin" class="nav-link">
                    <i class="fas fa-cut"></i>
                    <span>Услуги</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Отчеты</span>
                </a>
            </div>
            <div class="nav-item">
                <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Выход</span>
                </a>
            </div>
        </nav>
    </div>

    <!-- Основное содержимое -->
    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Управление мастерами</h2>
        </div>

        <!-- Форма для добавления/редактирования мастера -->
        <form onsubmit="submitMaster(event)" style="margin-bottom: 30px; background: #f9f9f9; padding: 25px; border-radius: 6px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
            <input type="hidden" id="masterId" name="id" value="">

            <div class="form-group">
                <label for="name">ФИО мастера:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="specialization">Специализация:</label>
                <select id="specialization" name="specialization">
                    <option value="Парикмахер">Парикмахер</option>
                    <option value="Колорист">Колорист</option>
                    <option value="Барбер">Барбер</option>
                    <option value="Визажист">Визажист</option>
                    <option value="Стилист">Стилист</option>
                </select>
            </div>

            <div class="form-group">
                <label for="experience">Стаж (лет):</label>
                <input type="number" id="experience" name="experience" min="0" max="50" required>
            </div>

            <button type="submit" class="btn btn-purple" id="submitBtn">
                <i class="fas fa-save"></i> Добавить мастера
            </button>
        </form>

        <!-- Таблица с мастерами -->
        <table class="data-table">
            <thead>
            <tr>
                <th>Имя</th>
                <th>Специализация</th>
                <th>Стаж</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody id="mastersTableBody">
            <!-- Данные будут загружены с помощью JavaScript -->
            </tbody>
        </table>
    </div>
</div>
<script>
    async function loadMasters() {
        const response = await fetch('/api/masters');
        const masters = await response.json();

        const tableBody = document.getElementById('mastersTableBody');
        tableBody.innerHTML = ''; // Очищаем таблицу

        masters.forEach(master => {
            const row = document.createElement('tr');
            row.innerHTML =
                '<td>' + master.fullName + '</td>' +
                '<td>' + master.specialization + '</td>' +
                '<td>' + master.experience + '</td>' +
                '<td class="action-btns">' +
                '<button onclick="editMaster(' + master.id + ', \'' + master.fullName + '\', \'' + master.specialization + '\', ' + master.experience + ')" class="btn">Редактировать</button>' +
                '<button onclick="deleteMaster(' + master.id + ')" class="btn btn-danger">Удалить</button>' +
                '</td>';
            tableBody.appendChild(row);
        });
    }

    async function submitMaster(event) {
        event.preventDefault();

        const id = document.getElementById('masterId').value;
        const fullName = document.getElementById('name').value;
        const specialization = document.getElementById('specialization').value;
        const experience = document.getElementById('experience').value;

        const data = { fullName, specialization, experience: parseInt(experience) };
        const method = id ? 'PUT' : 'POST';
        const url = id ? '/api/masters/' + id : '/api/masters';

        console.log('Sending request:', { method, url, data });

        await fetch(url, {
            method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });

        resetForm();
        loadMasters();
    }

    async function deleteMaster(id) {
        if (confirm('Вы уверены, что хотите удалить этого мастера?')) {
            console.log('Deleting master with id:', id);
            await fetch('/api/masters/' + id, { method: 'DELETE' });
            loadMasters();
        }
    }

    function editMaster(id, fullName, specialization, experience) {
        document.getElementById('masterId').value = id;
        document.getElementById('name').value = fullName;
        document.getElementById('specialization').value = specialization;
        document.getElementById('experience').value = experience;
        document.getElementById('submitBtn').textContent = 'Обновить мастера';
    }

    function resetForm() {
        document.getElementById('masterId').value = '';
        document.getElementById('name').value = '';
        document.getElementById('specialization').value = '';
        document.getElementById('experience').value = '';
        document.getElementById('submitBtn').textContent = 'Добавить мастера';
    }

    document.addEventListener('DOMContentLoaded', loadMasters);

    function logout() {
        // Удаляем токен из localStorage (или sessionStorage, cookies)
        localStorage.removeItem("jwtToken");  // Для localStorage
        sessionStorage.removeItem("jwtToken");  // Для sessionStorage

        // Также можно удалить cookie (если хранится в cookies)
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";

        // Перенаправляем пользователя на страницу входа
        window.location.href = "/home";  // Замените "/login" на нужный URL
    }
</script>
</body>
</html>