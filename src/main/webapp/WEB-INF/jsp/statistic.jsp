<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ-центр | Парикмахерская "Элегант"</title>
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

        .charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .chart-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .chart-card h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: var(--charcoal);
            display: flex;
            align-items: center;
        }

        .chart-card h3 i {
            margin-right: 10px;
            color: var(--purple);
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        /* Кнопки */
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
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

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
                    <i class="fas fa-tachometer-alt nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link">
                    <i class="fas fa-calendar-check nav-icon"></i>
                    <span class="nav-text">Записи</span>
                    <span class="badge">${pendingAppointments}</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users nav-icon"></i>
                    <span class="nav-text">Клиенты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/master" class="nav-link">
                    <i class="fas fa-user-tie nav-icon"></i>
                    <span class="nav-text">Персонал</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceAdmin" class="nav-link">
                    <i class="fas fa-cut nav-icon"></i>
                    <span class="nav-text">Услуги</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link active">
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
            <h2 class="page-title">Статистика и отчеты</h2>
            <button id="generatePdfButton" style="padding: 10px 20px; background-color: #8A2BE2; color: white; border: none; border-radius: 5px; cursor: pointer;">
                Сгенерировать PDF
            </button>
        </div>

        <!-- Статистика -->
        <div class="charts-container">
            <div class="chart-card">
                <h3><i class="fas fa-chart-pie"></i> Популярность мастеров</h3>
                <div class="chart-container">
                    <canvas id="mastersChart"></canvas>
                </div>
            </div>
            <div class="chart-card">
                <h3><i class="fas fa-chart-line"></i> Планируемый доход</h3>
                <div class="chart-container">
                    <canvas id="incomeChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Получаем данные о популярности мастеров
        fetch('${pageContext.request.contextPath}/statistics/masters-popularity')
            .then(response => response.json())
            .then(data => {
                // Обновляем график популярности мастеров
                const mastersNames = Object.keys(data); // Имена мастеров
                const mastersCounts = Object.values(data); // Количество записей для каждого мастера

                // Создаем график
                const mastersCtx = document.getElementById('mastersChart').getContext('2d');
                new Chart(mastersCtx, {
                    type: 'doughnut',
                    data: {
                        labels: mastersNames,
                        datasets: [{
                            data: mastersCounts,
                            backgroundColor: [
                                '#8A2BE2', '#6A1B9A', '#E6E6FA', '#9370DB', '#D8BFD8'
                            ], // Цвета для сегментов
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'right', // Позиция легенды
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        const label = context.label || '';
                                        const value = context.raw || 0;
                                        const total = context.dataset.data.reduce((a, b) => a + b, 0); // Сумма всех записей
                                        const percentage = Math.round((value / total) * 100); // Процент
                                        return `${label}: ${value} записей (${percentage}%)`;
                                    }
                                }
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Ошибка при загрузке данных о мастерах:', error)); // Логирование ошибок


        // Получаем данные о планируемом доходе
        fetch('${pageContext.request.contextPath}/statistics/income')
            .then(response => response.json())
            .then(data => {
                // Даты и доходы для графика
                const dates = Object.keys(data); // Даты
                const incomeData = Object.values(data); // Доходы по датам

                // Создаем график доходов
                const incomeCtx = document.getElementById('incomeChart').getContext('2d');
                new Chart(incomeCtx, {
                    type: 'line',
                    data: {
                        labels: dates, // Даты
                        datasets: [{
                            label: 'Планируемый доход (BYN)',
                            data: incomeData, // Доходы по датам
                            backgroundColor: 'rgba(138, 43, 226, 0.1)',
                            borderColor: '#8A2BE2',
                            borderWidth: 2,
                            tension: 0.4,
                            fill: true,
                            pointBackgroundColor: '#8A2BE2',
                            pointRadius: 4,
                            pointHoverRadius: 6
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value.toLocaleString('ru-RU') + ' BYN';
                                    }
                                }
                            }
                        },
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        return context.parsed.y.toLocaleString('ru-RU') + ' BYN';
                                    }
                                }
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Ошибка при загрузке данных о доходах:', error)); // Логирование ошибок

        document.getElementById('generatePdfButton').addEventListener('click', function() {
            const { jsPDF } = window.jspdf;

            // Create PDF
            const doc = new jsPDF();

            console.log("Starting PDF generation...");

            // 1. Check if jsPDF is loaded
            if (!jsPDF) {
                console.error("Error: jsPDF not loaded");
                alert("PDF library not loaded");
                return;
            }

            // Translation dictionary for letters
            const translationMap = {
                "А": "A",
                "Б": "B",
                "В": "V",
                "Г": "G",
                "Д": "D",
                "Е": "E",
                "Ё": "Yo",
                "Ж": "Zh",
                "З": "Z",
                "И": "I",
                "Й": "Y",
                "К": "K",
                "Л": "L",
                "М": "M",
                "Н": "N",
                "О": "O",
                "П": "P",
                "Р": "R",
                "С": "S",
                "Т": "T",
                "У": "U",
                "Ф": "F",
                "Х": "Kh",
                "Ц": "Ts",
                "Ч": "Ch",
                "Ш": "Sh",
                "Щ": "Shch",
                "Ы": "Y",
                "Э": "E",
                "Ю": "Yu",
                "Я": "Ya"
            };

            // Function to translate text by replacing each letter
            function translateName(name) {
                let translatedName = '';
                for (let i = 0; i < name.length; i++) {
                    const letter = name[i];
                    translatedName += translationMap[letter.toUpperCase()] || letter;
                }
                return translatedName;
            }

            // 2. Fetch data
            fetch('${pageContext.request.contextPath}/statistics/masters-popularity')
                .then(response => {
                    if (!response.ok) throw new Error("HTTP error! status: " + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log("Data retrieved from server:", data);

                    // 3. Validate data structure
                    if (!data || typeof data !== 'object') {
                        throw new Error("Invalid data format");
                    }

                    const mastersNames = Object.keys(data);
                    const mastersCounts = Object.values(data);

                    console.log("Masters:", mastersNames);
                    console.log("Appointment counts:", mastersCounts);

                    // Add font for English text
                    doc.setFont('Helvetica');

                    // Add title
                    doc.text(20, 20, "Masters' Appointment Statistics:");

                    let yPosition = 30;

                    // Add master data
                    mastersNames.forEach((name, index) => {
                        const translatedName = translateName(name); // Translate name by letter
                        const text = translatedName + ": " + mastersCounts[index] + " appointments";
                        console.log("Adding to PDF:", text);
                        doc.text(20, yPosition, text);
                        yPosition += 10;
                    });

                    // Save PDF
                    console.log("Saving PDF...");
                    doc.save("masters_report.pdf");
                })
                .catch(error => {
                    console.error("Full error:", error);
                    alert(`Error generating report: ${error.message}`);
                });
        });

        function logout() {
            // Удаляем токен из localStorage (или sessionStorage, cookies)
            localStorage.removeItem("jwtToken");  // Для localStorage
            sessionStorage.removeItem("jwtToken");  // Для sessionStorage

            // Также можно удалить cookie (если хранится в cookies)
            document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";

            // Перенаправляем пользователя на страницу входа
            window.location.href = "/home";  // Замените "/login" на нужный URL
        }
    });
</script>
</body>
</html>