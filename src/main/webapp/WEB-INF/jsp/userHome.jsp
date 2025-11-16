<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет | Парикмахерская "Элегант"</title>
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

        /* Сайдбар */
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

        /* Профиль пользователя */
        .profile-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 30px;
            border: 5px solid var(--accent-color);
        }

        .profile-info h2 {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .profile-info p {
            color: #666;
            margin-bottom: 8px;
        }

        .profile-info .email {
            font-weight: 500;
            color: var(--secondary-color);
        }

        .edit-profile-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 15px;
            display: inline-flex;
            align-items: center;
        }

        .edit-profile-btn:hover {
            background: #5a3d7d;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(106, 76, 147, 0.3);
        }

        .edit-profile-btn i {
            margin-right: 8px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .close-btn {
            float: right;
            font-size: 24px;
            cursor: pointer;
            color: #aaa;
        }

        .close-btn:hover {
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .save-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .save-btn:hover {
            background-color: var(--primary-color);
        }

        .cancel-btn {
            background: none;
            border: none;
            color: var(--error-color);
            cursor: pointer;
            font-size: 0.9rem;
        }

        .cancel-btn:hover {
            text-decoration: underline;
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

            .profile-card {
                flex-direction: column;
                text-align: center;
            }

            .profile-avatar {
                margin-right: 0;
                margin-bottom: 20px;
            }
        }

        /* Стили для карусели баннеров */
        .banner-carousel {
            position: relative;
            max-width: 1200px;
            width: 100%;
            height: 300px; /* Фиксированная высота */
            margin: 20px auto 30px;
            overflow: hidden;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .banner-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .banner-slide.active {
            opacity: 1;
            z-index: 1;
        }

        .banner-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .banner-text {
            position: absolute;
            bottom: 30px;
            left: 30px;
            color: white;
            font-size: 28px;
            font-weight: 600;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            background-color: rgba(0, 0, 0, 0.6);
            padding: 12px 25px;
            border-radius: 8px;
            max-width: 80%;
        }

        .carousel-prev, .carousel-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(255, 255, 255, 0.3);
            color: white;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 24px;
            z-index: 10;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .carousel-prev:hover, .carousel-next:hover {
            background-color: rgba(255, 255, 255, 0.5);
        }

        .carousel-prev {
            left: 20px;
        }

        .carousel-next {
            right: 20px;
        }

        .carousel-dots {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
            z-index: 10;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s;
        }

        .dot.active, .dot:hover {
            background-color: white;
            transform: scale(1.2);
        }

        /* Адаптивность для карусели */
        @media (max-width: 768px) {
            .banner-carousel {
                height: 200px;
                border-radius: 8px;
            }

            .banner-text {
                font-size: 18px;
                bottom: 15px;
                left: 15px;
                padding: 8px 15px;
            }

            .carousel-prev, .carousel-next {
                width: 40px;
                height: 40px;
                font-size: 20px;
            }
        }

        @media (max-width: 480px) {
            .banner-carousel {
                height: 150px;
            }

            .banner-text {
                font-size: 14px;
                bottom: 10px;
                left: 10px;
                padding: 5px 10px;
            }
        }

        /* Анимации */
        @keyframes fadeIn {
            from {opacity: 0.4}
            to {opacity: 1}
        }

        .profile-card, .info-card, .appointments-table {
            animation: fadeIn 0.6s ease-out;
        }
        .info {
            margin-left: 340px;
            margin-bottom: 70px;
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
                <a href="/serviceUser" class="nav-link">
                    <i class="fas fa-cut nav-icon"></i>
                    <span class="nav-text">Услуги</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="/userMaster" class="nav-link">
                    <i class="fas fa-user-tie nav-icon"></i>
                    <span class="nav-text">Мастера</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="/booking" class="nav-link">
                    <i class="fas fa-calendar-check nav-icon"></i>
                    <span class="nav-text">Запись</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/video" class="nav-link">
                    <i class="fas fa-spa nav-icon"></i>
                    <span class="nav-text">Уход за волосами</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="/reviews" class="nav-link">
                    <i class="fas fa-star nav-icon"></i>
                    <span class="nav-text">Отзывы</span>
                </a>
            </li>
            <li class="nav-item" style="margin-top: 30px;">
                <a href="/profile" class="nav-link active">
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

    <!-- Основное содержимое -->
    <div class="main-content">
        <div class="header">
            <h1 class="page-title">Личный кабинет</h1>
        </div>

        <!-- Карточка профиля -->
        <div class="profile-card">
            <img src="https://yt3.ggpht.com/ytc/AKedOLTN8rWKo0IWth4023uuLP2iPNUKeKHdnz9nilOdvQ=s900-c-k-c0x00ffffff-no-rj"
                 alt="Аватар" class="profile-avatar">
            <div class="profile-info" th:if="${user != null}">
                <h2 th:text="${user.username}"></h2>
                <p class="email" th:text="${user.email}"></p>
                <button class="edit-profile-btn" onclick="editProfile()">
                    <i class="fas fa-edit"></i> Редактировать профиль
                </button>
            </div>
            <div class="info">
                <p><strong>Полное имя:</strong> <span class="full-name"></span></p>
                <p><strong>Телефон:</strong> <span class="phone-number"></span></p>
            </div>
        </div>

        <!-- Карусель баннеров -->
        <div class="banner-carousel">
            <div class="banner-slide active">
                <img src="https://sun9-25.userapi.com/impf/X7jGvos6Yl2CyFtzRjjvjvkKqVCucxXr28zp_A/vUcKzVPmP2I.jpg?size=1818x606&quality=95&crop=270,0,1200,400&sign=3ddf30b412768c244391465f50068219&type=cover_group" alt="Новые стили">
            </div>
            <div class="banner-slide">
                <img src="https://sun9-10.userapi.com/impf/T74zRYbGFA2Fn-RdSNrwOHoMMXpYycBZNrdqGA/ZqBEeJ5DZ_U.jpg?size=1818x606&quality=95&crop=0,0,1590,530&sign=45400adf44a9ca28d042cd57dcf8e58c&type=cover_group" alt="Скидки">
            </div>
            <div class="banner-slide">
                <img src="https://sun9-41.userapi.com/c841124/v841124579/23b75/tKQLZWl-y4w.jpg" alt="Мастер-классы">
            </div>
            <button class="carousel-prev" onclick="moveSlide(-1)">&#10094;</button>
            <button class="carousel-next" onclick="moveSlide(1)">&#10095;</button>
            <div class="carousel-dots">
                <span class="dot active" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
            </div>
        </div>

        <!-- Форма для редактирования -->
        <div id="profileModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal()">&times;</span>
                <h3>Редактировать профиль</h3>
                <form id="editForm" action="/profile/update" method="post">
                    <div class="form-group">
                        <label for="fullName">Полное имя:</label>
                        <input type="text" id="fullName" name="fullName" th:value="${user.fullName}" required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Телефон:</label>
                        <input type="text" id="phoneNumber" name="phoneNumber" th:value="${user.phoneNumber}" required>
                    </div>
                    <button type="submit" class="save-btn" id="saveProfileBtn">
                        <i class="fas fa-save"></i> Сохранить
                    </button>
                </form>
            </div>
        </div>

    </div>

    <script>
        // Переключение боковой панели
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        }

        function logout() {
            // Удаляем токен из localStorage (или sessionStorage, cookies)
            localStorage.removeItem("jwtToken");
            sessionStorage.removeItem("jwtToken");
            document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
            window.location.href = "/home";
        }

        // Мобильное меню
        function toggleMobileMenu() {
            const sidebar = document.querySelector('.sidebar');
            if (sidebar.style.width === '0px' || !sidebar.style.width) {
                sidebar.style.width = '280px';
            } else {
                sidebar.style.width = '0';
            }
        }

        // Закрытие меню при клике вне его области
        document.addEventListener('click', function (event) {
            const sidebar = document.querySelector('.sidebar');
            const mobileBtn = document.querySelector('.mobile-menu-btn');

            if (window.innerWidth <= 768 &&
                !sidebar.contains(event.target) &&
                event.target !== mobileBtn &&
                !mobileBtn.contains(event.target)) {
                sidebar.style.width = '0';
            }
        });

        // Карусель баннеров
        let slideIndex = 1;
        showSlides(slideIndex);

        let slideInterval = setInterval(() => {
            moveSlide(1);
        }, 5000);

        function moveSlide(n) {
            showSlides(slideIndex += n);
            clearInterval(slideInterval);
            slideInterval = setInterval(() => {
                moveSlide(1);
            }, 5000);
        }

        function currentSlide(n) {
            showSlides(slideIndex = n);
            clearInterval(slideInterval);
            slideInterval = setInterval(() => {
                moveSlide(1);
            }, 5000);
        }

        function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("banner-slide");
            let dots = document.getElementsByClassName("dot");

            if (n > slides.length) {slideIndex = 1;}
            if (n < 1) {slideIndex = slides.length;}

            for (i = 0; i < slides.length; i++) {
                slides[i].classList.remove("active");
            }

            for (i = 0; i < dots.length; i++) {
                dots[i].classList.remove("active");
            }

            slides[slideIndex - 1].classList.add("active");
            dots[slideIndex - 1].classList.add("active");
        }

        function editProfile() {
            const modal = document.getElementById("profileModal");
            modal.style.display = "block";

            const fullName = document.querySelector(".info .full-name").innerText;
            const phoneNumber = document.querySelector(".info .phone-number").innerText;

            if (fullName && phoneNumber) {
                document.getElementById("fullName").value = fullName;
                document.getElementById("phoneNumber").value = phoneNumber;
            }
        }

        function closeModal() {
            document.getElementById("profileModal").style.display = "none";
        }

        window.onclick = function(event) {
            const modal = document.getElementById("profileModal");
            if (event.target === modal) {
                closeModal();
            }
        };

        document.addEventListener("DOMContentLoaded", function () {
            // Загрузка профиля
            const token = localStorage.getItem("jwtToken");
            console.log("Токен JWT:", token);

            fetch("/api/profile", {
                headers: {
                    "Authorization": "Bearer " + token
                }
            })
                .then(response => {
                    if (!response.ok) throw new Error('Ошибка HTTP: ' + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log("Данные профиля:", data);

                    // Отображение данных
                    if (data.username) {
                        document.querySelector(".profile-info h2").innerText = data.username;
                    }
                    if (data.email) {
                        document.querySelector(".profile-info .email").innerText = data.email;
                    }

                    document.querySelector(".info .full-name").innerText = data.fullName || "Не указано";
                    document.querySelector(".info .phone-number").innerText = data.phoneNumber || "Не указан";
                })
                .catch(error => {
                    console.error("Ошибка загрузки профиля:", error);
                    document.querySelector(".profile-info h2").innerText = "Гость";
                    document.querySelector(".profile-info .email").innerText = "Нет данных";
                });
            // Обработчик события для формы редактирования профиля
            document.getElementById("editForm").addEventListener("submit", function(event) {
                event.preventDefault();

                const token = localStorage.getItem("jwtToken");
                const fullName = document.getElementById("fullName").value;
                const phoneNumber = document.getElementById("phoneNumber").value;

                const updatedInfo = {
                    fullName: fullName,
                    phoneNumber: phoneNumber
                };

                const saveBtn = this.querySelector('.save-btn');
                saveBtn.disabled = true;
                saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Сохранение...';

                fetch("/api/profileUpdate", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + token
                    },
                    body: JSON.stringify(updatedInfo)
                })
                    .then(response => {
                        if (!response.ok) throw new Error("Ошибка сервера: " + response.status);
                        return response.json();
                    })
                    .then(data => {
                        document.querySelector(".info .full-name").textContent = data.fullName;
                        document.querySelector(".info .phone-number").textContent = data.phoneNumber;

                        alert("Данные успешно сохранены!");
                        closeModal();
                    })
                    .catch(error => {
                        console.error("Ошибка:", error);
                        alert("Ошибка при сохранении: " + error.message);
                    })
                    .finally(() => {
                        saveBtn.disabled = false;
                        saveBtn.innerHTML = 'Сохранить';
                    });
            });
        });
    </script>

</body>
</html>