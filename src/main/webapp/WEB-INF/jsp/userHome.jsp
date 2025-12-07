<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет | Железнодорожные перевозки</title>
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

        .profile-card {
            background: #FFF;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 40px;
            border-top: 4px solid var(--purple);
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid var(--light-purple);
        }

        .profile-info {
            flex: 1;
        }

        .profile-info h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: var(--charcoal);
        }

        .profile-info p {
            color: var(--slate);
            margin-bottom: 8px;
        }

        .profile-info .email {
            font-weight: 500;
            color: var(--purple);
        }

        .info {
            flex: 1;
        }

        .info p {
            margin-bottom: 10px;
            color: var(--slate);
        }

        .info strong {
            color: var(--charcoal);
        }

        .edit-profile-btn {
            background: var(--purple);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 15px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .edit-profile-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
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
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .close-btn {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 28px;
            cursor: pointer;
            color: var(--slate);
            transition: color 0.3s;
        }

        .close-btn:hover {
            color: var(--charcoal);
        }

        .modal-content h3 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--charcoal);
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .save-btn {
            background: var(--purple);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .save-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
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

            .profile-card {
                flex-direction: column;
                text-align: center;
            }

            .profile-avatar {
                margin: 0 auto 20px;
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
                <a href="${pageContext.request.contextPath}/userHome" class="nav-link active">
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
                <a href="${pageContext.request.contextPath}/booking" class="nav-link">
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
            <h2 class="page-title">Личный кабинет</h2>
        </div>

        <div class="profile-card">
            <img src="https://via.placeholder.com/120" alt="Аватар" class="profile-avatar">
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
            </div>
        </div>

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

    <script>
        function logout() {
            localStorage.removeItem("jwtToken");
            sessionStorage.removeItem("jwtToken");
            document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
            window.location.href = "/home";
        }

        function editProfile() {
            const modal = document.getElementById("profileModal");
        modal.style.display = "flex";

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
                    saveBtn.innerHTML = '<i class="fas fa-save"></i> Сохранить';
                    });
            });
        });
    </script>
</body>
</html>
