<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Контакты | Парикмахерская "Элегант"</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a4c93;
            --secondary-color: #8a5a44;
            --accent-color: #f8bbd0;
            --light-color: #f9f9f9;
            --dark-color: #333;
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 80px;
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f5f7fa;
            color: var(--dark-color);
            overflow-x: hidden;
            transition: all var(--transition-speed) ease;
        }

        /* Сайдбар (как на главной) */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--primary-color) 0%, #5a3d7d 100%);
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.1);
            transition: width var(--transition-speed) ease;
            z-index: 1000;
            overflow: hidden;
        }

        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            height: 80px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .logo-icon {
            font-size: 2rem;
            margin-right: 15px;
            color: var(--accent-color);
        }

        .logo-text {
            opacity: 1;
            transition: opacity var(--transition-speed);
        }

        .sidebar.collapsed .logo-text {
            opacity: 0;
        }

        .toggle-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            transition: transform var(--transition-speed);
        }

        .sidebar.collapsed .toggle-btn {
            transform: rotate(180deg);
        }

        .nav-links {
            padding: 20px 0;
            height: calc(100vh - 80px);
            overflow-y: auto;
        }

        .nav-item {
            list-style: none;
            margin-bottom: 5px;
            padding: 0 15px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: var(--primary-color);
            font-weight: 500;
        }

        .nav-icon {
            font-size: 1.3rem;
            margin-right: 20px;
            min-width: 24px;
            text-align: center;
        }

        .nav-text {
            opacity: 1;
            transition: opacity var(--transition-speed);
        }

        .sidebar.collapsed .nav-text {
            opacity: 0;
        }

        /* Основное содержимое */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            min-height: 100vh;
            transition: margin-left var(--transition-speed);
        }

        .sidebar.collapsed ~ .main-content {
            margin-left: var(--sidebar-collapsed-width);
        }

        /* Заголовок */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            font-size: 2rem;
            color: var(--primary-color);
        }

        /* Контактная информация */
        .contact-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .contact-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .contact-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            color: var(--primary-color);
            font-size: 1.4rem;
        }

        .contact-icon {
            font-size: 1.8rem;
            margin-right: 15px;
            color: var(--secondary-color);
        }

        .contact-info {
            margin-bottom: 15px;
            line-height: 1.6;
        }

        .contact-info strong {
            color: var(--dark-color);
        }

        /* Карта */
        .map-container {
            height: 400px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        /* Форма обратной связи */
        .feedback-form {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .form-title {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(106, 76, 147, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .submit-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 14px 25px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: #5a3d7d;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(106, 76, 147, 0.3);
        }

        /* Часы работы */
        .hours-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .hours-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .hours-table th, .hours-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .hours-table th {
            color: var(--primary-color);
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .sidebar {
                width: var(--sidebar-collapsed-width);
            }

            .sidebar .logo-text,
            .sidebar .nav-text {
                opacity: 0;
            }

            .main-content {
                margin-left: var(--sidebar-collapsed-width);
            }

            .sidebar:hover {
                width: var(--sidebar-width);
            }

            .sidebar:hover .logo-text,
            .sidebar:hover .nav-text {
                opacity: 1;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .mobile-menu-btn {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1100;
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
                cursor: pointer;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

            .contact-section {
                grid-template-columns: 1fr;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .contact-card, .map-container, .feedback-form {
            animation: fadeIn 0.6s ease-out;
        }
    </style>
</head>
<body>
    <!-- Боковая панель -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="/" class="logo">
                <i class="fas fa-scissors logo-icon"></i>
                <span class="logo-text">Элегант</span>
            </a>
            <button class="toggle-btn" onclick="toggleSidebar()">
                <i class="fas fa-angle-left"></i>
            </button>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/home" class="nav-link">
                    <i class="fas fa-home nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/contact" class="nav-link active">
                    <i class="fas fa-map-marker-alt nav-icon"></i>
                    <span class="nav-text">Контакты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/signin" class="nav-link">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Вход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <h1 class="page-title">Контакты</h1>
            <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div class="contact-section">
            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-map-marker-alt contact-icon"></i>
                    <h3>Адрес</h3>
                </div>
                <div class="contact-info">
                    <strong>Парикмахерская "Элегант"</strong><br>
                    г. Минск, пр-т Независимости, д. 32А<br>
                    Вход со стороны двора, 2 этаж
                </div>
                <div class="contact-info">
                    <strong>Ближайшее метро:</strong> Площадь Победы, Октябрьская, Купаловская
                </div>
            </div>

            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-clock contact-icon"></i>
                    <h3>Часы работы</h3>
                </div>
                <table class="hours-table">
                    <tr>
                        <th>День</th>
                        <th>Часы</th>
                    </tr>
                    <tr>
                        <td>Понедельник - Пятница</td>
                        <td>9:00 - 21:00</td>
                    </tr>
                    <tr>
                        <td>Суббота</td>
                        <td>10:00 - 20:00</td>
                    </tr>
                    <tr>
                        <td>Воскресенье</td>
                        <td>10:00 - 18:00</td>
                    </tr>
                </table>
            </div>


            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-phone-alt contact-icon"></i>
                    <h3>Контакты</h3>
                </div>
                <div class="contact-info">
                    <strong>Телефон:</strong> <a href="tel:+375333331771">+375 (33) 333-17-71</a>
                </div>
                <div class="contact-info">
                    <strong>WhatsApp:</strong> <a href="https://wa.me/375333331771">+375 (33) 333-17-71</a>
                </div>
                <div class="contact-info">
                    <strong>Email:</strong> <a href="mailto:info@elegant.ru">info@elegant.ru</a>
                </div>
                <div class="contact-info">
                    <strong>Социальные сети:</strong>
                    <div style="margin-top: 10px; font-size: 1.5rem;">
                        <a href="#" target="_blank" style="color: #6b3b98; margin-right: 15px;"><i class="fab fa-viber"></i></a>
                        <a href="https://www.instagram.com/zzzzkkkkk.k?igsh=MW9heHQ5dTRrcjBvbw==" style="color: #e4405f; margin-right: 15px;"><i class="fab fa-instagram"></i></a>
                        <a href="#" style="color: #57b0ea;"><i class="fab fa-telegram"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="map-container">
            <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2349.978645871203!2d27.576598276847953!3d53.91167803332539!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x46dbcfbd0194ad21%3A0x8749e629c5fba7b8!2z0JzQsNC90YLRgCDQmtCw0LfRhtC60LjQuSDQnNC-0YHQv9C-0L3QsNGPINC-0LHQu9Cw0YHRgtGMLCAzMkEsINCb0LDRgdC60L7Qs9C-0LrQsCDQmtCw0LfRhtC60YHRgtGMLCDQmtCw0LfRhtC60L7Qs9C-0LrQsCDQmtCw0LfRhtC60L7Qs9C-0LrQsCAyMDIwNQ!5e0!3m2!1sru!2sby!4v1712039475632!5m2!1sru!2sby"
                    allowfullscreen=""
                    loading="lazy">
            </iframe>
        </div>

        <div class="feedback-form">
            <h2 class="form-title">Обратная связь</h2>
            <form id="contactForm">
                <div class="form-group">
                    <label for="name" class="form-label">Ваше имя</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Введите имя" required>
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">Ваш Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Введите email" required>
                </div>

                <div class="form-group">
                    <label for="message" class="form-label">Ваше сообщение</label>
                    <input id="message" name="message" class="form-control" placeholder="Введите сообщение" required>
                </div>

                <button type="submit" class="submit-btn">Отправить</button>
            </form>
        </div>
    </div>

    <script>
        // Переключение боковой панели
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        }

        // Закрытие меню при клике вне его области
        document.addEventListener('click', function(event) {
            const sidebar = document.querySelector('.sidebar');
            const mobileBtn = document.querySelector('.mobile-menu-btn');

            if (window.innerWidth <= 768 &&
                !sidebar.contains(event.target) &&
                event.target !== mobileBtn &&
                !mobileBtn.contains(event.target)) {
                sidebar.style.width = '0';
            }
        });

        document.getElementById('contactForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const btn = this.querySelector('button[type="submit"]');
            const originalText = btn.innerHTML;

            // Добавляем индикатор загрузки
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Отправка...';
            btn.disabled = true;

            const formData = new FormData(this);

            console.log("Отправляемые данные:", Object.fromEntries(formData));

            fetch('/contact/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams(formData) // Конвертируем в строку запроса
            }).then(response => {
                if (response.ok) {
                    alert('Ваше сообщение успешно отправлено!');
                    document.getElementById('contactForm').reset();
                } else {
                    alert('Произошла ошибка при отправке!');
                }
            }).catch(error => {
                alert('Ошибка сети!');
            }).finally(() => {
                btn.innerHTML = originalText;
                btn.disabled = false;
            });
        });
    </script>
</body>
</html>