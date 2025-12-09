<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Контакты | ЖД-Портал</title>
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

        .contact-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .contact-card {
            background: #FFF;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
            transition: transform 0.3s ease;
        }

        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .contact-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            font-size: 1.3rem;
        }

        .contact-icon {
            font-size: 1.8rem;
            margin-right: 15px;
            color: var(--purple);
        }

        .contact-info {
            margin-bottom: 15px;
            line-height: 1.8;
            color: var(--charcoal);
        }

        .contact-info strong {
            color: var(--charcoal);
            font-weight: 600;
        }

        .contact-info a {
            color: var(--purple);
            text-decoration: none;
            transition: color 0.3s;
        }

        .contact-info a:hover {
            color: var(--dark-purple);
            text-decoration: underline;
        }

        .map-container {
            height: 400px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 40px;
            border-top: 3px solid var(--purple);
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        .feedback-form {
            background: #FFF;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--charcoal);
            margin-bottom: 25px;
            position: relative;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--purple);
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
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 4px;
            font-size: 16px;
            font-family: 'Montserrat', sans-serif;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .submit-btn {
            background: var(--purple);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

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
            color: var(--purple);
            font-weight: 600;
        }

        .social-links {
            margin-top: 10px;
            font-size: 1.5rem;
        }

        .social-links a {
            color: var(--purple);
            margin-right: 15px;
            transition: color 0.3s;
        }

        .social-links a:hover {
            color: var(--dark-purple);
        }

        .social-links a.instagram {
            color: #e4405f;
        }

        .social-links a.telegram {
            color: #57b0ea;
        }

        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }
            .admin-sidebar {
                display: none;
            }
            .contact-section {
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
                <h1>ЖД-Портал</h1>
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/" class="nav-link">
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
                    <i class="fas fa-sign-in-alt nav-icon"></i>
                    <span class="nav-text">Вход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Контакты</h2>
        </div>

        <div class="contact-section">
            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-headset contact-icon"></i>
                    <h3>Центр поддержки</h3>
                </div>
                <div class="contact-info">
                    <strong>Центральный офис ЖД-Портал</strong><br>
                    г. Минск, ул. Ленина, д. 15<br>
                    Бизнес-центр "Магистраль", 5 этаж
                </div>
                <div class="contact-info">
                    <strong>Обработка запросов:</strong> Круглосуточно
                </div>
            </div>

            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-clock contact-icon"></i>
                    <h3>Часы работы операторов</h3>
                </div>
                <table class="hours-table">
                    <tr>
                        <th>День</th>
                        <th>Часы работы операторов</th>
                    </tr>
                    <tr>
                        <td>Понедельник - Пятница</td>
                        <td>8:00 - 22:00</td>
                    </tr>
                    <tr>
                        <td>Суббота, Воскресенье</td>
                        <td>9:00 - 21:00</td>
                    </tr>
                </table>
            </div>

            <div class="contact-card">
                <div class="contact-title">
                    <i class="fas fa-phone-alt contact-icon"></i>
                    <h3>Контактная информация</h3>
                </div>
                <div class="contact-info">
                    <strong>Телефон:</strong> <a href="tel:+375298267773">+375 (29) 826-77-73</a>
                </div>
                <div class="contact-info">
                    <strong>Email:</strong> <a href="mailto:kkrahotko@gmail.com">kkrahotko@gmail.com</a>
                </div>
                <div class="contact-info">
                    <strong>Социальные сети:</strong>
                    <div class="social-links">
                        <a href="https://www.instagram.com/jzd.portal" target="_blank" class="instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="https://t.me/ks_krakhotko" target="_blank" class="telegram">
                            <i class="fab fa-telegram"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="map-container">
            <iframe
                    src="https://maps.google.com/maps?width=100%25&height=600&hl=ru&q=%D0%93.%D0%9C%D0%B8%D0%BD%D1%81%D0%BA,%20%D1%83%D0%BB.%20%D0%9B%D0%B5%D0%BD%D0%B8%D0%BD%D0%B0,%20%D0%B4.%2015&t=&z=14&ie=UTF8&iwloc=B&output=embed"
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
                    <textarea id="message" name="message" class="form-control" placeholder="Введите сообщение" required></textarea>
                </div>

                <button type="submit" class="submit-btn">Отправить</button>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#contactForm').on('submit', function(e) {
            e.preventDefault();
            alert('Спасибо за ваше сообщение! Мы свяжемся с вами в ближайшее время.');
            this.reset();
        });
    });
</script>
</body>
</html>
